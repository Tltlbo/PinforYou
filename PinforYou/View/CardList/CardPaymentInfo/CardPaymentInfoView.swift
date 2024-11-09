//
//  CardPaymentInfoView.swift
//  PinforYou
//
//  Created by 박진성 on 6/20/24.
//

import SwiftUI
import Kingfisher

struct CardPaymentInfoView: View {
    
    @StateObject var cardPaymentInfoViewModel : CardPaymentInfoViewModel
    var cardID : Int
    @State private var isSheetPresented = false
    @State private var selectedMonth = Calendar.current.component(.month, from: Date())
    
    var body: some View {
        if cardPaymentInfoViewModel.isFinished {
            NavigationStack {
                VStack {
                    ZStack {
                        Color.gray
                            .frame(height: 100)
                        
                        HStack(alignment: .center) {
                            VStack(alignment:.leading) {
                                Text(cardPaymentInfoViewModel.paymentInfo?.cardName ?? "")
                                Text(cardPaymentInfoViewModel.paymentInfo?.cardNum ?? "")
                            }
                            .padding(.trailing, 60)
                            
                            KFImage(URL(string: cardPaymentInfoViewModel.paymentInfo?.card_image_url ?? ""))
                                .resizable()
                                .scaledToFit()
                                .rotationEffect(.degrees(-90.0))
                        }
                        .frame(width: UIScreen.main.bounds.width ,height: 100)
                    }
                    .padding(.bottom, 10)
                    
                    
                    HStack {
                        Text("일자")
                            .padding(.leading, 10)
                        Text("요일")
                        Spacer()
                        Text("일일 누적 금액")
                            .padding(.trailing, 10)
                    }
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.gray)
                    
                    if let info = cardPaymentInfoViewModel.paymentInfo {
                        ScrollView(.vertical) {
                            VStack(spacing: 10) {
                                ForEach(cardPaymentInfoViewModel.paymentInfo!.Payments, id: \.self) { info in
                                    PaymentInfoCell(Info: info)
                                }
                            }
                        }
                    }
                    
                    else {
                        Text("결제내역이 존재하지 않습니다.")
                    }
                    
                    
                    Spacer()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            isSheetPresented = true
                        } label: {
                            Image(systemName: "calendar")
                        }

                    }
                }
                .navigationTitle("\(cardPaymentInfoViewModel.month)월")
                .sheet(isPresented: $isSheetPresented) {
                    MonthPicker(selectedMonth: $selectedMonth)  // 선택된 월을 바인딩으로 전달
                }
                .onChange(of: selectedMonth) { newValue in
                    cardPaymentInfoViewModel.month = newValue
                    cardPaymentInfoViewModel.send(action: .getPaymentInfo, cardid: cardID)
                }
            }
        }
        else {
            ProgressView()
                .onAppear {
                    cardPaymentInfoViewModel.send(action: .getPaymentInfo, cardid: cardID)
                }
        }
        
    }
}

struct MonthPicker: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedMonth: Int

    var body: some View {
        VStack {
            Picker("Select Month", selection: $selectedMonth) {
                ForEach(1..<13) { month in
                    Text("\(month)월").tag(month)
                }
            }
            .pickerStyle(WheelPickerStyle()) // 휠 스타일을 사용하여 선택

            Button("Done") {
                dismiss()  // 선택 후 시트 닫기
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    //CardPaymentInfoView()
    Text("HELLO")
}
