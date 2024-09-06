//
//  EventView.swift
//  PinforYou
//
//  Created by 박진성 on 5/31/24.
//

import SwiftUI
import Kingfisher

struct EventView: View {
    
    @StateObject var eventViewModel : EventViewModel
    
    var body: some View {
        VStack(alignment:.leading) {
            Section(header: Text("카드 이벤트").font(.title)) {
                
                TabView {
                    ForEach(eventViewModel.issuanceEventList, id: \.self) {
                        event in
                        KFImage(URL(string: event))
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width, height:  200)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 200)
            }
            
            
            Section(header: Text("결제 이벤트").font(.title)) {
                TabView {
                    ForEach(eventViewModel.paymentEventList, id: \.self) {
                        event in
                        KFImage(URL(string: event))
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width, height:  200)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 200)
            }
        }
        .background {
            Color("BackgroundColor")
                .ignoresSafeArea()
        }
        .onAppear {
            eventViewModel.send(action: .getEventInfo)
        }
    }
}


#Preview {
    EventView(eventViewModel: .init(container: .init(services: StubService())))
}
