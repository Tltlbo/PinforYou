//
//  CardInsertView.swift
//  PinforYou
//
//  Created by 박진성 on 7/28/24.
//

import SwiftUI

struct CardInsertView: View {
    
    @EnvironmentObject var cardlistViewModel : CardListViewModel
    @StateObject var cardInsertViewModel: CardInsertViewModel
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
                        Button {
                            presentationMode.wrappedValue.dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.white)
                                .font(.system(size: 25))
                            
                        }
                        
                    }
                    
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
                        .onChange(of: cardNum) { num in
                            cardInsertViewModel.send(action: .cardValidate, cardNum: num)
                        }
                    Rectangle()
                        .frame(height: 1)
                    Text(cardInsertViewModel.companyName)
                    Text(cardInsertViewModel.cardName)
                    
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
                        Alert(title: Text("등록하시겠습니까?"), message: Text("\(cardInsertViewModel.companyName) \(cardInsertViewModel.cardName)카드가 등록됩니다."), primaryButton: .destructive(Text("등록"), action: {
                            cardInsertViewModel.send(action: .cardAppend, cardNum: self.cardNum, cardName: self.cardName)
                            cardlistViewModel.inert(cardName: cardName, cardNum: insertDashes(into: self.cardNum))
                            
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
    
    func insertDashes(into text: String) -> String {
            return text.enumerated().map { index, character in
                return (index > 0 && index % 4 == 0) ? "-\(character)" : "\(character)"
            }.joined()
        }
}

#Preview {
    CardInsertView( cardInsertViewModel: .init(container: .init(services: StubService())))
}
