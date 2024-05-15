//
//  PlaceCell.swift
//  PinforYou
//
//  Created by 박진성 on 5/15/24.
//

import SwiftUI

struct PlaceCell : View {
    
    var Place : PlaceModel.Place
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text(Place.placeName)
                    .font(.system(size: 20))
                
                
                VStack {
                    Spacer()
                    Text(Place.categoryName)
                        .font(.system(size: 12))
                }
                
                
            }
            .frame(height: 20)
            
            .padding(.bottom, 5)
            Text(Place.addressName)
                .font(.system(size: 16))
        }
    }
}

#Preview {
    PlaceCell(Place: PlaceModel.placestub1.PlaceList[0])
}
