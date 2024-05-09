//
//  KakaoMapView.swift
//  PinforYou
//
//  Created by 박진성 on 5/6/24.
//

import SwiftUI
import KakaoMapsSDK

struct KakaoMapView: UIViewRepresentable {
    @Binding var draw: Bool
    var Location : Location
    
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
        return KakaoMapCoordinator(location: Location)
    }
    
    /// Cleans up the presented `UIView` (and coordinator) in
    /// anticipation of their removal.
    static func dismantleUIView(_ uiView: KMViewContainer, coordinator: KakaoMapCoordinator) {
        
    }
}

class KakaoMapCoordinator: NSObject, MapControllerDelegate {
    init(location : Location) {
        first = true
        auth = false
        Location = location
        super.init()
    }
    
    func createController(_ view: KMViewContainer) {
        container = view
        controller = KMController(viewContainer: view)
        controller?.delegate = self
    }
    
    func addViews() {
        let defaultPosition: MapPoint = MapPoint(longitude: Location.longitude, latitude: Location.latitude)
        let mapviewInfo: MapviewInfo = MapviewInfo(viewName: "mapview", viewInfoName: "map", defaultPosition: defaultPosition)
        
        controller?.addView(mapviewInfo)
    }
    
    func addViewSucceeded(_ viewName: String, viewInfoName: String) {
        print("OK")
        let view = controller?.getView("mapview")
        view?.viewRect = container!.bounds
    }
    
    func containerDidResized(_ size: CGSize) {
        let mapView: KakaoMap? = controller?.getView("mapview") as? KakaoMap
        mapView?.viewRect = CGRect(origin: CGPoint(x: 0.0, y: 0.0), size: size)
        if first {
            let cameraUpdate: CameraUpdate = CameraUpdate.make(target: MapPoint(longitude: Location.longitude, latitude: Location.latitude), mapView: mapView!)
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
    var Location : Location
}


#Preview {
    Text("HELLO")
}
