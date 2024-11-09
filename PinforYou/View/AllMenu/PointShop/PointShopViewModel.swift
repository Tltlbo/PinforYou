import Foundation
import Combine

class PointShopViewModel : ObservableObject {
    
    enum Action {
        case getUserPointInfo
    }
    
    @Published var isFinished : Bool = false
    @Published var point: Int = 0
    
    private var container : DIContainer
    private var subscriptions = Set<AnyCancellable>()
    
    init(container: DIContainer) {
        self.container = container
    }
    
    func send(action : Action, userid: Int) {
        switch action {
        case .getUserPointInfo:
            container.services.pointShopService.getUserPointInfo(userid: userid)
                .sink { [weak self] completion in
                    if case .failure = completion {
                        //
                    }
                } receiveValue: { [weak self] point in
                    self?.point = point
                    self?.isFinished = true
                }
                .store(in: &subscriptions)

        }
    }
}

