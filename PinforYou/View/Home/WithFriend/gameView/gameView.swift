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
//              .linear(duration: 10.0)
              .easeOut(duration: 30.0)
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
              .frame(width: 350, height: 350)
              .rotationEffect(
                Angle(
                  degrees:  self.isAnimating ? 360*20 : 0
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
