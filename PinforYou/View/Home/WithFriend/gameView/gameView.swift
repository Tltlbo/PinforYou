//
//  gameView.swift
//  PinforYou
//
//  Created by 박진성 on 5/28/24.
//

import SwiftUI

struct gameView: View {
    @State private var isAnimating = false
      var foreverAnimation: Animation {
        Animation
              .linear(duration: 2.0)
              .speed(5.0)
          //.repeatForever(autoreverses: false)
      }
      
      var body: some View {
        Button(
          action: {
            self.isAnimating.toggle()
          },
          label: {
            Image(systemName: "pencil.circle")
              .resizable()
              .frame(width: 80, height: 80)
              .rotationEffect(
                Angle(
                  degrees:  self.isAnimating ? 360 : 0
                )
              )
              .animation(self.isAnimating ? foreverAnimation : .default)
          }
        )
      }
}

#Preview {
    gameView()
}
