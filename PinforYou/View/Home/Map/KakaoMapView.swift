//
//  KakaoMapView.swift
//  PinforYou
//
//  Created by 박진성 on 5/6/24.
//

import SwiftUI
import UIKit
import KakaoMapsSDK

struct KakaoMapView: UIViewRepresentable {
    @Binding var draw: Bool
    @Binding var isTapped : Bool
    @Binding var tappedPlace : PlaceModel.Place
    @EnvironmentObject var kakaoMapViewModel : KakaoMapViewModel
    
    func makeUIView(context: Self.Context) -> KMViewContainer {
        //need to correct view size
        
        let view: KMViewContainer = KMViewContainer()
        
        context.coordinator.createController(view)
        
        
        return view
        
    }
    
    /// Updates the presented `UIView` (and coordinator) to the latest
    /// configuration.
    func updateUIView(_ uiView: KMViewContainer, context: Self.Context) {
        if draw {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                if context.coordinator.controller?.isEnginePrepared == false {
                    context.coordinator.controller?.prepareEngine()
                }
                
                if context.coordinator.controller?.isEngineActive == false {
                    context.coordinator.controller?.activateEngine()
                }
            }
            
        }
        else {
            context.coordinator.controller?.pauseEngine()
            context.coordinator.controller?.resetEngine()
        }
    }
    
    func makeCoordinator() -> KakaoMapCoordinator {
        return KakaoMapCoordinator(viewModel: kakaoMapViewModel, self)
    }
    
    /// Cleans up the presented `UIView` (and coordinator) in
    /// anticipation of their removal.
    static func dismantleUIView(_ uiView: KMViewContainer, coordinator: KakaoMapCoordinator) {
        
    }
}



class KakaoMapCoordinator: NSObject, MapControllerDelegate, ObservableObject {
    
    init(viewModel : KakaoMapViewModel, _ view : KakaoMapView) {
        first = true
        auth = false
        kakaoMapViewModel = viewModel
        kakaoView = view
        
        super.init()
    }
    
    func createController(_ view: KMViewContainer) {
        container = view
        controller = KMController(viewContainer: view)
        controller?.delegate = self
    }
    
    func addViews() {
        
        let defaultPosition: MapPoint = MapPoint(longitude: kakaoMapViewModel.Location?.longitude ?? 0.0, latitude: kakaoMapViewModel.Location?.latitude ?? 0.0)
        
        let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: defaultPosition)
        
        
        
        
        controller?.addView(mapviewInfo)
        
        
    }
    
    
    func createLabelLayer() {
        let view = controller?.getView("mapview") as! KakaoMap
        let manager = view.getLabelManager()    //LabelManager를 가져온다. LabelLayer는 LabelManger를 통해 추가할 수 있다.
        
        // 추가할 레이어의 옵션을 지정한다. 옵션에는 레이어에 속할 Label(POI)들의 경쟁방식, 레이어의 zOrder등의 속성을 지정할 수 있다.
        // 경쟁의 의미는 라벨이 표출되어야 하는 영역을 두고 다른 라벨과 경쟁을 함을 의미하고, 경쟁이 발생하게 되면 경쟁에서 이긴 라벨만 그려지게 된다.
        // competitionType : 경쟁의 대상을 지정한다.
        //                   예를 들어, none 으로 지정하게 되면 아무런 라벨과도 경쟁하지 않고 항상 그려지게 된다.
        //                   Upper가 있는 경우, 자신의 상위 레이어의 라벨과 경쟁이 발생한다. Lower가 있는 경우, 자신의 하위 레이어의 라벨과 경쟁한다. Same이 있는 경우, 자신과 같은 레이어에 속한 라벨과도 경쟁한다.
        //                   경쟁은 레이어의 zOrder순(오름차순)으로 진행되며, 레이어에 속한 라벨의 rank순(오름차순)으로 배치 및 경쟁을 진행한다.
        //                   경쟁은 레이어 내의 라벨(자신의 competitionType에 Same이 있는 경우)과 competitionType에 Lower가 있는 경우 자신의 하위 레이어(cocompetitionType에 Upper가 있는 레이어)를 대상으로 진행된다.
        //                   경쟁이 발생하면, 상위 레이어에 속한 라벨이 하위 레이어에 속한 라벨을 이기게 되고, 같은 레이어에 속한 라벨인 경우 rank값이 큰 라벨이 이기게 된다.
        // competitionUnit : 경쟁을 할 때의 영역을 처리하는 단위를 지정한다. .poi의 경우 심볼 및 텍스트 영역 모두가 경쟁영역이 되고, symbolFirst 인 경우 symbol 영역으로 경쟁을 처리하고 텍스트는 그려질 수 있는 경우에 한해 그려진다.
        // zOrder : 레이어의 우선 순위를 결정하는 order 값. 값이 클수록 우선순위가 높다.
        let layerOption = LabelLayerOptions(layerID: "PoiLayer-", competitionType: .none, competitionUnit: .poi, orderType: .rank, zOrder: 10001)
        let _ = manager.addLabelLayer(option: layerOption)
    }
    
    func createPoiStyle() {
        let view = controller?.getView("mapview") as! KakaoMap
        let manager = view.getLabelManager()
        // 심볼을 지정.
        // 심볼의 anchor point(심볼이 배치될때의 위치 기준점)를 지정. 심볼의 좌상단을 기준으로 한 % 값.
        let iconStyle = PoiIconStyle(symbol: UIImage(named: "pin.png"), anchorPoint: CGPoint(x: 0.0, y: 0.5))
        let perLevelStyle = PerLevelPoiStyle(iconStyle: iconStyle, level: 0)  // 이 스타일이 적용되기 시작할 레벨.
        let poiStyle = PoiStyle(styleID: "customStyle1", styles: [perLevelStyle])
        manager.addPoiStyle(poiStyle)
    }
    
    // POI를 생성한다.
    func createPois() {
        let view = controller?.getView("mapview") as! KakaoMap
        
        let manager = view.getLabelManager()
        let layer = manager.getLabelLayer(layerID: "PoiLayer-")   // 생성한 POI를 추가할 레이어를 가져온다.
        let poiOption = PoiOptions(styleID: "customStyle1") // 생성할 POI의 Option을 지정하기 위한 자료를 담는 클래스를 생성. 사용할 스타일의 ID를 지정한다.
        poiOption.rank = 0
        poiOption.clickable = true // clickable 옵션을 true로 설정한다. default는 false로 설정되어있다.
        
        //            let poi1 = layer?.addPoi(option: poiOption, at: MapPoint(longitude: 128.752739, latitude: 35.836891), callback: {(_ poi: (Poi?)) -> Void in
        //                print("")
        //            }
        //            )   //레이어에 지정한 옵션 및 위치로 POI를 추가한다.
        //            let _ = poi1?.addPoiTappedEventHandler(target: self, handler: KakaoMapCoordinator.poiTappedHandler) // poi tap event handler를 추가한다.
        
        
        
        guard let templocationList = kakaoMapViewModel.PlaceList else {return}
        
        let locationList = templocationList.map { MapPoint(longitude: Double($0.longitude)!, latitude: Double($0.latitude)!) }
        
//        let poi1 = layer?.addPoi(option: poiOption, at: MapPoint(longitude: kakaoMapViewModel.Location?.longitude ?? 0, latitude: kakaoMapViewModel.Location?.latitude ?? 0), callback: {(_ poi: (Poi?)) -> Void in
//            print("")
//        })
        
        
        let poi2 = layer?.addPois(option: poiOption, at: locationList, callback: {(_ pois: ([Poi]?)) -> Void in
            print("")
        })
        
        guard let pois = poi2 else {return}
        
        for poi in pois {
            let _ = poi.addPoiTappedEventHandler(target: self, handler: KakaoMapCoordinator.poiTappedHandler(_:))
        }
        
        layer?.showAllPois()
        
    }
    
    // POI 탭 이벤트가 발생하고, 표시하고 있던 Poi를 숨긴다.
    func poiTappedHandler(_ param: PoiInteractionEventParam) {
        
        let index = Int(param.poiItem.itemID.split(separator: "-")[1])!
        kakaoView.isTapped = true
        kakaoView.tappedPlace = kakaoMapViewModel.PlaceList![index]
        
    }
    
    func addViewSucceeded(_ viewName: String, viewInfoName: String) {
        print("OK")
        let view = controller?.getView("mapview")
        
        createLabelLayer()
        createPoiStyle()
        createPois()
        
        view?.viewRect = container!.bounds
    }
    
    func containerDidResized(_ size: CGSize) {
        let mapView: KakaoMap? = controller?.getView("mapview") as? KakaoMap
        mapView?.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
        
        if first {
            let cameraUpdate: CameraUpdate = CameraUpdate.make(target: MapPoint(longitude: kakaoMapViewModel.Location?.longitude ?? 0.0, latitude: kakaoMapViewModel.Location?.latitude ?? 0.0), mapView: mapView!)
            mapView?.moveCamera(cameraUpdate)
            first = false
        }
    }
    
    func authenticationSucceeded() {
        auth = true
    }
    
    
    
    var controller: KMController?
    var container: KMViewContainer?
    var first: Bool
    var auth: Bool
    var kakaoMapViewModel : KakaoMapViewModel
    var kakaoView : KakaoMapView
}





#Preview {
    Text("HELLO")
}
