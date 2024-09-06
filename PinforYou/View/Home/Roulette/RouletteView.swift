//
//  RouletteView.swift
//  PinforYou
//
//  Created by 김성훈 on 9/2/24.
//

import SwiftUI

struct RouletteView: View {
    let names = ["김성훈", "노지인", "정수열", "박진성", "송재민"]  // 돌림판에 들어갈 이름
    let colors: [Color] = [.red, .green, .blue, .yellow, .purple]  // 섹터별 다른 색상 배열
    @State private var selectedName = ""
    @State private var degrees = 0.0
    @State private var spinning = false
    @State private var navigateToCardInfo = false  // 네비게이션 트리거

    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    ForEach(0..<names.count) { index in
                        RouletteSegment(sliceCount: names.count, index: index, name: names[index], wheelSize: 320, color: colors[index % colors.count])
                    }
                    .rotationEffect(.degrees(degrees))

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

                NavigationLink("", destination: CardInfoView(selectedName: selectedName), isActive: $navigateToCardInfo)
            }
        }
    }

    func spinWheel() {
        selectedName = ""
        spinning = true
        let randomSpin = Double.random(in: 720...1440)  // 무작위 회전 각도

        withAnimation(Animation.timingCurve(0.33, 0.01, 0.66, 1.0, duration: 4)) {
            degrees += randomSpin
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            spinning = false
            let normalizedDegrees = degrees.truncatingRemainder(dividingBy: 360)
            let segmentAngle = 360 / Double(names.count)
            let arrowTipAngle = (normalizedDegrees + 180).truncatingRemainder(dividingBy: 360)
            let index = Int(arrowTipAngle / segmentAngle) % names.count
            selectedName = names[(names.count - index) % names.count]  // 섹터가 반시계 방향이므로 배열을 반전
            degrees = normalizedDegrees  // 각도 정규화
            navigateToCardInfo = true  // 선택 후 네비게이션 활성화
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

struct RouletteView_Previews: PreviewProvider {
    static var previews: some View {
        RouletteView()
    }
}
