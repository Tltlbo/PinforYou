/* 포함 기능

 * 1. QR Code 스캔

 * 2. QR Code 스캔 시 프레임 단위로 동적으로 QR Code 테두리 캡처

 * 3. 2초 이상 식별되는 QR Code에 한해서만 식별 및 데이터 출력, 팝업 제공

 */



import UIKit

import AVFoundation

import SwiftUI

import SnapKit


class ScannerViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    

    // 웹뷰 및 QR 코드 스캔 버튼의 아웃렛 정의

    let qrcodeBtn: UIButton = {

        let qrcodeBtn = UIButton()

        qrcodeBtn.layer.cornerRadius = 10

        qrcodeBtn.backgroundColor = .blue

        qrcodeBtn.setTitle("확인", for: .normal)

        qrcodeBtn.setTitleColor(.white, for: .normal)

        

        qrcodeBtn.addTarget(self, action: #selector(startScanning), for: .touchUpInside)

        // QR 코드 스캔 버튼 스타일 설정

        

        return qrcodeBtn

    }()

    

    let inputMoney : UITextField = {

        let textfield = UITextField()

        textfield.textColor = .black

        textfield.layer.borderColor = UIColor.white.cgColor

        textfield.backgroundColor = .white

        textfield.attributedPlaceholder = NSAttributedString(string: "결제 받을 금액 입력", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])

        textfield.layer.borderWidth = 3

        textfield.layer.cornerRadius = 5

        textfield.clearsOnBeginEditing = true

        textfield.keyboardType = UIKeyboardType.numberPad

        textfield.leftView = UIView(frame: CGRect(x:0,y: 0, width: 5, height: 0))

        textfield.leftViewMode = .always

        

        return textfield

    }()

  

    // AVCaptureSession과 관련된 변수를 선언

    var captureSession: AVCaptureSession!

    var previewLayer: AVCaptureVideoPreviewLayer!

    var qrCodeFrameView: UIView?



    // QR 코드 인식 관련 변수

    var lastQRCodeValue: String?

    var lastDetectionTime: Date?

    var displayAlertTimer: Timer?



    // 뷰가 로드될 때 호출

    override func viewDidLoad() {

        super.viewDidLoad()

        view.backgroundColor = UIColor(Color("BackgroundColor"))

        

        

        setupViews()

        

        self.inputMoney.delegate = self

        

        setupCaptureSession()  // 캡처 세션 설정

        

    }

    





    // 캡처 세션을 설정하는 메소드

    func setupCaptureSession() {

        captureSession = AVCaptureSession()



        // 기본 비디오 캡처 장치 설정

        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }

        let videoInput: AVCaptureDeviceInput



        do {

            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)

        } catch {

            print("Error setting up video input: \(error)")

            return

        }



        // 입력 소스로 비디오 입력 추가

        if captureSession.canAddInput(videoInput) {

            captureSession.addInput(videoInput)

        } else {

            failed()

            return

        }



        // 메타데이터 출력 설정

        let metadataOutput = AVCaptureMetadataOutput()



        if captureSession.canAddOutput(metadataOutput) {

            captureSession.addOutput(metadataOutput)



            metadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)

            metadataOutput.metadataObjectTypes = [.qr]

        } else {

            failed()

            return

        }



        // 프리뷰 레이어 설정 및 뷰에 추가

        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)

        previewLayer.frame = CGRect(x: 0, y: 130, width: UIScreen.main.bounds.width, height: 400)

        previewLayer.videoGravity = .resizeAspectFill

        view.layer.addSublayer(previewLayer)



        // QR 코드를 감지 동적 프레임 뷰 초기화

        qrCodeFrameView = UIView()

        if let qrCodeFrameView = qrCodeFrameView {

            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor

            qrCodeFrameView.layer.borderWidth = 3

            view.addSubview(qrCodeFrameView)

            view.bringSubviewToFront(qrCodeFrameView)

        }



        // QR 코드 버튼은 맨 앞으로

        view.bringSubviewToFront(qrcodeBtn)

    }



    // 스캐닝 시작

    @objc func startScanning() {

        

        view.endEditing(true)

        

        [qrcodeBtn, inputMoney].forEach {$0.isHidden = true}

        

        if !captureSession.isRunning {

            captureSession.startRunning()

        }

    }



    // QR 코드가 감지되었을 때 호출

    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {

        qrCodeFrameView?.frame = CGRect.zero



        // 메타데이터 객체에서 QR 코드 데이터 추출 및 표시

        if let metadataObject = metadataObjects.first as? AVMetadataMachineReadableCodeObject,

           let qrCodeObject = previewLayer.transformedMetadataObject(for: metadataObject) as? AVMetadataMachineReadableCodeObject {
            
            qrCodeFrameView?.frame = qrCodeObject.bounds  // QR 코드 위치에 동적 박스 그리기



            if let stringValue = qrCodeObject.stringValue {

                if stringValue == lastQRCodeValue {

                    if let lastTime = lastDetectionTime, Date().timeIntervalSince(lastTime) < 2 {

                        return  // 2초 이내 동일한 QR 코드가 계속 인식될 경우 팝업 표시하지 않음

                    }

                }
                
                if let money = inputMoney.text?.split(separator: " ")[0] {
                    NotificationCenter.default.post(name: NSNotification.Name("scannedData"), object: money, userInfo: nil)
                    
                    self.captureSession.stopRunning()
                    self.dismiss(animated: true, completion: nil)
                }
                
                
                
                
                


                lastQRCodeValue = stringValue

                lastDetectionTime = Date()



                // 인식된 QR 코드를 2초간 지속 추적

                displayAlertTimer?.invalidate()

                displayAlertTimer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { [weak self] _ in

                    self?.showResultAlert(stringValue)

                }

            }

        }

    }



    // 스캔 결과를 표시 팝업

    func showResultAlert(_ result: String) {

        print("Scanned result: \(result)")  // 출력
        

        // 팝업

        let alertController = UIAlertController(title: "QR Code Result", message: result, preferredStyle: .alert)

        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        present(alertController, animated: true)

    }



    // 스캐닝 실패 시 호출

    func failed() {

        let ac = UIAlertController(title: "Scanning not supported", message: "Your device does not support scanning QR codes.", preferredStyle: .alert)

        ac.addAction(UIAlertAction(title: "OK", style: .default))

        present(ac, animated: true)

        captureSession = nil

    }



    // 뷰가 사라질 때 호출

    override func viewWillDisappear(_ animated: Bool) {

        super.viewWillDisappear(animated)

        if captureSession?.isRunning == true {

            captureSession.stopRunning()

        }

    }

    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        view.endEditing(true)

    }



    // 객체 소멸 시 호출

    deinit {

        if captureSession?.isRunning == true {

            captureSession.stopRunning()

        }

    }
      
    
}



extension ScannerViewController : UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {

        textField.becomeFirstResponder()

    }

    

    func textFieldDidEndEditing(_ textField: UITextField) {

        

        

        if ((textField.text?.isEmpty) != nil) {

            textField.text = (textField.text ?? "") + " 원"

        }

    }

    

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        //숫자 입력만 허용

        let charset : CharacterSet = {

            var cs = CharacterSet.lowercaseLetters

            cs.insert(charactersIn: "0123456789")

            return cs.inverted

        }()

        

        if string.count > 0 {

            guard string.rangeOfCharacter(from: charset) == nil else {

                return false

            }

        }

        

        return true

    }

}



private extension ScannerViewController {

    func setupViews() {

  

        [qrcodeBtn, inputMoney].forEach {

            self.view.addSubview($0)

        }

        inputMoney.snp.makeConstraints {
            $0.width.equalTo(inputMoney.intrinsicContentSize.width + 200)

            $0.height.equalTo(45.0)

            $0.centerY.equalToSuperview()

            $0.centerX.equalToSuperview()

            

        }

        

        qrcodeBtn.snp.makeConstraints {
            $0.width.equalTo(70)

            $0.height.equalTo(40)

            $0.top.equalTo(inputMoney).offset(60)

            $0.centerX.equalTo(inputMoney)

        }

        

        

    }

}







struct QRScannerView : UIViewControllerRepresentable {
    
    @Binding var scannedData : String
    
    let viewController : ScannerViewController = ScannerViewController()

    func makeUIViewController(context: Context) -> UIViewController {
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
 

}

struct ScannerMainView : View {
    
    @State var scannedData : String = ""
    @StateObject var scannerViewModel : ScannerViewModel
    
    let scannedDataNotification = NotificationCenter.default
        .publisher(for: NSNotification.Name("scannedData"))
    
    var body: some View {
        if scannerViewModel.isFinshed {
            Text("결제되었습니다.")
        }
        else {
            QRScannerView(scannedData: $scannedData)
                .onReceive(scannedDataNotification) { (output) in
                    scannedData = output.object as? String ?? ""
                    scannerViewModel.send(action: .storePayment, amount: Int(scannedData)!)
                }
        }
    }
}



struct Preview : PreviewProvider {

    static var previews: some View {

        //QRScannerView()
        Text("HELLO")

    }

}
