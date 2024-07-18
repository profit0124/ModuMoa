//
//  MemberDetailView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/15/24.
//

import SwiftUI
import ComposableArchitecture

struct MemberDetailView: View {
    
    let store: StoreOf<MemberDetail>
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            let member = viewStore.node.member
            VStack(spacing: 22) {
                // MARK: Navigation Bar
                HStack {
                    Button(action: {
                        viewStore.send(.backbuttonTapped)
                    }) {
                        HStack(spacing: 4) {
                            Image(systemName: "chevron.left")
                            Text("뒤로 가기")
                        }
                    }
                    .font(.customFont(.callOut))
                    .foregroundColor(.moduBlack)
                    Spacer()
                }
                .padding(.horizontal, 8)
                
                VStack(spacing: 44) {
                    HStack {
                        Text(member.name)
                            .font(.customFont(.largeTitle))
                            .fontWeight(.bold)
                            .foregroundStyle(.moduBlack)

                        Spacer()
                        
                        Text("나")
                            .font(.customFont(.subHeadline))
                            .foregroundStyle(.moduYellow)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 6)
                            .background( Circle().fill(.moduBlack))
                    }
                    
                    VStack(alignment: .leading, spacing: 32) {
                        customLabel("성별", member.sex.rawValue)
                        
                        customLabel("생일", member.birthday?.toString() ?? Date().toString())
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text("혈액형")
                                .font(.customFont(.callOut))
                                .foregroundStyle(.grayscale1)
                            
                            GeometryReader {
                                let size = $0.size
                                HStack(spacing: 22) {
                                    Text(member.bloodType.rh.rawValue)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    Text(member.bloodType.abo.rawValue)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                }
                                .font(.customFont(.body))
                                .foregroundStyle(.moduBlack)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(width: size.width / 2)
                            }
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 16)
                
                Spacer()
            }
            .fullScreenCover(isPresented: viewStore.$isPresented, content: {
                IfLetStore(self.store.scope(state: \.memberUpdate, action: MemberDetail.Action.memberUpdate), then: {
                    MemberUpdateView(member, with: $0)
                })
            })
            .transaction { transaction in
                transaction.disablesAnimations = true
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar, content: {
                    HStack {
                        Spacer()
                        Button(action: {
                            viewStore.send(.updateButtonTapped)
                        }) {
                            Image(systemName: "pencil")
                        }
                    }
                })
            }
        }
        .navigationBarBackButtonHidden()
        
    }
    
    @ViewBuilder func customLabel(_ title: String, _ value: String) -> some View {
        VStack(alignment: .leading ,spacing: 10) {
            Text(title)
                .font(.customFont(.callOut))
                .foregroundStyle(.grayscale1)
            
            Text(value)
                .font(.customFont(.body))
                .foregroundStyle(.moduBlack)
        }
    }
}

#Preview {
    MemberDetailView(store: .init(initialState: MemberDetail.State(node: .init(member: .init(name: "린다", bloodType: .init(abo: .A, rh: .positive), sex: .female))), reducer: { MemberDetail() }))
}
