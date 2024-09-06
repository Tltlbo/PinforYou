//
//  CardInfoView.swift
//  PinforYou
//
//  Created by 김성훈 on 9/2/24.
//

import SwiftUI

struct CardInfoView: View {
    var selectedName: String  // RouletteView에서 전달 받은 이름

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("\(selectedName)님이 등록한 카드 중 이 카드로 결제하는 게 가장 좋아요!")
                        .font(.title)
                        .padding()

<<<<<<< HEAD
                    Image(systemName: "creditcard")  // 사용할 이미지 파일명을 정확히 지정해야 합니다.
=======
                    Image(systemName: "creditcard")
>>>>>>> main
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                        .cornerRadius(10)
                        .padding()

                    Text("노리2 체크카드 (KB Pay)")
                        .font(.title2)
                        .padding(.bottom, 1)

                    VStack(alignment: .leading) {
                        Text("• 포인트, 현금화 5% 할인")
                        Text("• KB Pay 2% 추가 할인")
                    }
                    .font(.headline)
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                    
                    Spacer()
                }
            }
            .navigationTitle("")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
        }
    }
}

struct CardInfoView_Previews: PreviewProvider {
    static var previews: some View {
        CardInfoView(selectedName: "김성훈")
    }
}
