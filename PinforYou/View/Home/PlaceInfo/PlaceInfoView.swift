//
//  PlaceInfoView.swift
//  PinforYou
//
//  Created by 박진성 on 5/14/24.
//

import SwiftUI

struct PlaceInfoView: View {
    
    @Binding var Place : PlaceModel.Place
    var body: some View {
        
        VStack {
            HStack {
                PlaceCell(Place: Place)
                Spacer()
            }
            
            
            Spacer()
        }
    }
}



#Preview {
    PlaceInfoView(Place: .constant(PlaceModel.placestub1.PlaceList[0]))
        
}
