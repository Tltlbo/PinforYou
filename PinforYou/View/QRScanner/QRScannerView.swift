/* 포함 기능
 * 1. QR Code 스캔
 * 2. QR Code 스캔 시 프레임 단위로 동적으로 QR Code 테두리 캡처
 * 3. 2초 이상 식별되는 QR Code에 한해서만 식별 및 데이터 출력, 팝업 제공
 */

import UIKit
import AVFoundation

class MainViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {

    // 웹뷰 및 QR 코드 스캔 버튼의 아웃렛 정의
    @IBOutlet weak var qrcodeBtn: UIButton!
    
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
        setupCaptureSession()  // 캡처 세션 설정

        // QR 코드 스캔 버튼 스타일 설정
        qrcodeBtn.layer.borderWidth = 3
        qrcodeBtn.layer.borderColor = UIColor.blue.cgColor
        qrcodeBtn.layer.cornerRadius = 10
        qrcodeBtn.addTarget(self, action: #selector(startScanning), for: .touchUpInside)
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
        previewLayer.frame = view.layer.bounds
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

    // 객체 소멸 시 호출
    deinit {
        if captureSession?.isRunning == true {
            captureSession.stopRunning()
        }
    }
}
