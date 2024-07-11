//
//  ButtonAnimation.swift
//  PinforYou
//
//  Created by 박진성 on 7/11/24.
//

import Foundation
import SwiftUI

struct EmptyActionStyle : ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
