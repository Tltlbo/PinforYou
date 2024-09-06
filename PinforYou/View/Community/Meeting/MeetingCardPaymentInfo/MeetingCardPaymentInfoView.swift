//
//  MeetingCardPaymentInfoView.swift
//  PinforYou
//
//  Created by 김성훈 on 8/8/24.
//

import Foundation

import SwiftUI

struct MeetingCardPaymentInfoView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(spacing: 0) {
            // 최상단 바
            HStack {
                Spacer()
                Text("모임 이름")
                    .font(.title2)
                Spacer()
            }
            .padding()
            
            Divider()
            
            // 탭바
            HStack(spacing: 0) {
                Button(action: {
                    selectedTab = 0
                }) {
                    Text("사용내역")
                        .fontWeight(selectedTab == 0 ? .bold : .regular)
                        .frame(maxWidth: .infinity)
                }
                Button(action: {
                    selectedTab = 1
                }) {
                    Text("카드")
                        .fontWeight(selectedTab == 1 ? .bold : .regular)
                        .frame(maxWidth: .infinity)
                }
                Button(action: {
                    selectedTab = 2
                }) {
                    Text("모임 멤버")
                        .fontWeight(selectedTab == 2 ? .bold : .regular)
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.2))
            
            // 선택된 탭에 따라 다른 내용 표시
            if selectedTab == 0 {
                UsageHistoryView()
            } else if selectedTab == 1 {
                CardDetailView()
            } else if selectedTab == 2 {
                MembersView()
            }
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.top) // 화면 최상단까지 확장
    }
}

struct UsageHistoryView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 0) {
                // 카드 정보와 잔액
                VStack {
                    Text("KB 국민 노리2 체크 카드(Play)")
                    Text("(1234-1234-1234-1234)")
                    Text("190,000")
                        .font(.largeTitle)
                        .padding()
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                Divider()
                
                // 사용내역
                VStack(alignment: .leading) {
                    GroupedTransactionView(date: "04.22 월요일", transactions: [
                        TransactionItem(name: "장군제육", category: "식당", amount: "+10,000", balance: "190,000", time: "16:27"),
                        TransactionItem(name: "교보문고", category: "서점", amount: "-20,000", balance: "180,000", time: "10:43")
                    ])
                    GroupedTransactionView(date: "04.20 토요일", transactions: [
                        TransactionItem(name: "대구은행 김성훈", category: "입금", amount: "+200,000", balance: "200,000", time: "23:11")
                    ])
                }
                .padding()
                
                Spacer()
            }
        }
        
    }
}

struct CardDetailView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text("모임 카테고리: 음식")
                        .font(.headline)
                    Spacer()
                }
                .padding(.horizontal)
                
                HStack {
                    Spacer()
                    Image(systemName: "creditcard")
                        .resizable()
                        .frame(width: 200, height: 120)
                        .aspectRatio(contentMode: .fit)
                    Spacer()
                }
                .padding()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("카드 혜택")
                        .font(.headline)
                    Text("* 혜택 1")
                    Text("* 혜택 2")
                    Text("* 혜택 3")
                }
                .padding(.horizontal)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("렌트 카테고리에서 많이 사용하셨네요! 이 카드는 어떠세요?")
                        .font(.title3)
                        .fontWeight(.bold)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("현대카드 R 체크 카드")
                                .font(.headline)
                            Text("렌트 시 10% 페이백")
                        }
                        Spacer()
                        Image(systemName: "creditcard")
                            .resizable()
                            .frame(width: 100, height: 60)
                            .aspectRatio(contentMode: .fit)
                    }
                    .padding(.vertical)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding(.vertical)
        }
    }
}

struct MembersView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("모임주")
                        .font(.headline)
                    Spacer()
                    Button(action: {
                        // 추가 버튼 액션
                    }) {
                        Text("추가")
                            .foregroundColor(.blue)
                    }
                    Button(action: {
                        // 편집 버튼 액션
                    }) {
                        Text("편집")
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                
                HStack {
                    Image(systemName: "person.circle")
                        .resizable()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .leading) {
                        Text("김성훈")
                            .font(.headline)
                        Text("모임주")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
                .padding()
                
                Divider()
                
                Text("멤버")
                    .font(.headline)
                    .padding([.leading, .top])
                
                MemberItemView(name: "박진성")
                MemberItemView(name: "송재민")
                MemberItemView(name: "노지인")
                MemberItemView(name: "정수열")
                
                Spacer()
            }
            
        }
        
    }
}

struct MemberItemView: View {
    var name: String
    
    var body: some View {
        HStack {
            Image(systemName: "person.circle")
                .resizable()
                .frame(width: 40, height: 40)
            Text(name)
                .font(.headline)
            Spacer()
        }
        .padding([.leading, .vertical])
    }
}

struct GroupedTransactionView: View {
    var date: String
    var transactions: [TransactionItem]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(date)
                .font(.subheadline)
                .foregroundColor(.gray)
            
            ForEach(transactions, id: \.name) { transaction in
                HStack {
                    Image(systemName: "fork.knife")
                    VStack(alignment: .leading) {
                        Text(transaction.name)
                        Text(transaction.category).font(.caption).foregroundColor(.gray)
                    }
                    Spacer()
                    Text(transaction.amount)
                        .foregroundColor(transaction.amount.hasPrefix("+") ? .blue : .red)
                }
                .padding(.vertical, 5)
                
                HStack {
                    Spacer()
                    Text("잔액 \(transaction.balance)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(.vertical, 5)
    }
}

struct TransactionItem {
    var name: String
    var category: String
    var amount: String
    var balance: String
    var time: String
}

struct MeetingCardPaymentInfoView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingCardPaymentInfoView()
    }
}
