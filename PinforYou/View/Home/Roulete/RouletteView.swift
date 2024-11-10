//
//  RouletteView.swift
//  PinforYou
//
//  Created by 김성훈 on 9/2/24.
//

import SwiftUI

struct RouletteView: View {
    @State private var selectedIndex: Int?
    @State private var degrees = 0.0
    @State private var spinning = false
    @State private var navigateToCardInfo = false  // 네비게이션 트리거
    @EnvironmentObject var roulleteViewModel: GameViewModel
    @EnvironmentObject var authViewModel : AuthenticationViewModel
    @EnvironmentObject var container: DIContainer
    var StoreName : String
    var StoreCategory : String

    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    ForEach(roulleteViewModel.selecedFriends, id: \.self) { friend in
                        if let index = roulleteViewModel.selecedFriends.firstIndex(of: friend)  {
                            RouletteSegment(sliceCount: roulleteViewModel.selecedFriends.count, index: index, name: roulleteViewModel.selecedFriends[index].name, wheelSize: 320, color: roulleteViewModel.colors[index % roulleteViewModel.colors.count])
                                .rotationEffect(.degrees(degrees))
                        }
                    }
                    

                    Triangle()
                        .fill(Color.red)
                        .frame(width: 20, height: 40)
                        .offset(y: -160)
                        .shadow(radius: 5)
                }
                .frame(width: 320, height: 320)

                Button("Spin!") {
                    spinWheel()
                }
                .padding()
                .background(spinning ? Color.gray : Color.blue)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .shadow(radius: 5)
                
                if let selectedIndex {
                    NavigationLink("", destination: CardInfoView(selectedFriend: roulleteViewModel.selecedFriends[selectedIndex], StoreName: StoreName, StoreCategory: StoreCategory, cardInfoViewModel: .init(container: container)), isActive: $navigateToCardInfo)
                }
            }
            .navigationBarBackButtonHidden()
        }
        .onAppear {
            roulleteViewModel.selecedFriends.append(Friend(friendID: UserID.shared.hashedID ?? "", name: authViewModel.userName))
            roulleteViewModel.colors.append(Color(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1)))
        }
        .onChange(of: selectedIndex) { newValue in
            if newValue != nil {
                navigateToCardInfo = true
            }
        }
    }

    func spinWheel() {
        spinning = true
        let randomSpin = Double.random(in: 720...1440)  // 무작위 회전 각도

        withAnimation(Animation.timingCurve(0.33, 0.01, 0.66, 1.0, duration: 4)) {
            degrees += randomSpin
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            spinning = false
            let normalizedDegrees = degrees.truncatingRemainder(dividingBy: 360)
            let segmentAngle = 360 / Double(roulleteViewModel.selecedFriends.count)
            let arrowTipAngle = (360 - normalizedDegrees).truncatingRemainder(dividingBy: 360)
            let index = Int(arrowTipAngle / segmentAngle) % roulleteViewModel.selecedFriends.count
            print("hello\(normalizedDegrees / segmentAngle)")
            print("degrees \(degrees)")
            //selectedIndex = Int(normalizedDegrees / segmentAngle)
            //이거 그냥 낙장불입으로 바로 랜덤뽑기해서 이름 튀어나오게 하고 바로 다음화면으로 넘겨버리자
            degrees = normalizedDegrees  // 각도 정규화
            selectedIndex = index
            /*selectedIndex = roulleteViewModel.selecedFriends.firstIndex(of: roulleteViewModel.selecedFriends[(roulleteViewModel.selecedFriends.count + index) % (roulleteViewModel.selecedFriends.count)]) ?? 0*/  // 섹터가 반시계 방향이므로 배열을 반전
            print("normalized: \(normalizedDegrees)")
            print("segment: \(segmentAngle)")
            print("arrow: \(arrowTipAngle)")
            print("index \(index)")
            print("select \(selectedIndex)")
            
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY))  // 바닥 중앙에서 시작
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))  // 왼쪽 상단
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))  // 오른쪽 상단
        path.closeSubpath()
        return path
    }
}

struct RouletteSegment: View {
    var sliceCount: Int
    var index: Int
    var name: String
    var wheelSize: CGFloat
    var color: Color  // 각 섹터의 색상

    var body: some View {
        GeometryReader { geometry in
            let angle = 360 / Double(sliceCount)
            let startAngle = angle * Double(index)
            let midAngle = startAngle + angle / 2
            let labelRadius = wheelSize / 2 * 0.7

            Path { path in
                path.move(to: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2))
                path.addArc(center: CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2), radius: geometry.size.width / 2, startAngle: .degrees(startAngle), endAngle: .degrees(startAngle + angle), clockwise: false)
            }
            .fill(color)

            Text(name)
                .rotationEffect(.degrees(-midAngle))
                .position(x: geometry.size.width / 2 + labelRadius * CGFloat(cos(midAngle * .pi / 180)),
                          y: geometry.size.height / 2 + labelRadius * CGFloat(sin(midAngle * .pi / 180)))
                .foregroundColor(.white)
        }
    }
}

