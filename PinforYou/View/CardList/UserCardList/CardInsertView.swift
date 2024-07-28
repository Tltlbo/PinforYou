//
//  CardInsertView.swift
//  PinforYou
//
//  Created by 박진성 on 7/28/24.
//

import SwiftUI

struct CardInsertView: View {
    
    @EnvironmentObject var cardlistViewModel : CardListViewModel
    @EnvironmentObject var container : DIContainer
    @Environment(\.presentationMode) var presentationMode
    
    @State var isInsert : Bool = false
    @State var cardName : String = ""
    @State var cardNum : String = ""
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                
                Color("BackgroundColor")
                    .ignoresSafeArea()
                
                VStack(alignment: .leading) {
                    
                    HStack {
                        Text("""
                            카드 정보를
                            입력해주세요!
                            """)
                        .font(.system(size: 26, weight: .bold))
                        
                        Spacer()
                    }
                    .padding(.top, 80)
                    
                    
                    Text("카드 번호(-를 제외한 카드 번호)")
                        .padding(.top, 48)
                    
                    TextField("카드 번호를 입력해주세요",  text: $cardNum)
                    Rectangle()
                        .frame(height: 1)
                        
                    
                    Text("카드 이름")
                        .padding(.top, 82)
                    
                    TextField("카드 이름을 입력해주세요",  text: $cardName)
                    
                    Rectangle()
                        .frame(height: 1)
                    
                    Spacer()
                    
                    Button {
                        isInsert = true
                    } label: {
                        HStack(alignment: .center) {
                            Text("완료")
                        }
                        .frame(width: UIScreen.main.bounds.size.width - 20, height: 72)
                        .background(Color("CellBackgroundColor"))
                        .clipShape(.rect(cornerRadius: 20))
                    }
                    .alert(isPresented: $isInsert) {
                        Alert(title: Text("등록하시겠습니까?"), message: Text("국민카드가 등록됩니다."), primaryButton: .destructive(Text("등록"), action: {
                            cardlistViewModel.inert(cardName: cardName, cardNum: cardNum)
                            
                            presentationMode.wrappedValue.dismiss()
                            
                        }), secondaryButton: .cancel(Text("취소"), action: {
                            //
                        }))
                    }


                    
                }
                .padding(.leading, 10)
            }
            }
            
            
    }
}

#Preview {
    CardInsertView()
}
