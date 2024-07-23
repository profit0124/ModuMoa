//
//  MemberDetailView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/15/24.
//

import SwiftUI

struct MemberDetailView: View {
    
    @Binding var isPushed: Bool
    @Binding var node: Node
    @Binding var fromMe: Bool
    @State private var isPresented: Bool = false
    
    var body: some View {
        let member = fromMe ? node.member : node.partner!.member
        VStack(spacing: 22) {
            // MARK: Navigation Bar
            HStack {
                Button(action: {
                    isPushed = false
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
                    
                    Text(member.nickName)
                        .font(.customFont(.subHeadline))
                        .foregroundStyle(.moduYellow)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 6)
                        .background( Capsule().fill(.moduBlack))
                }
                
                VStack(alignment: .leading, spacing: 32) {
                    customLabel("성별", member.sex.rawValue)
                    
                    customLabel("생일", member.birthday?.toString() ?? "모름")
                    
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
        .fullScreenCover(isPresented: $isPresented, content: {
            MemberUpdateView(node: $node, fromMe: $fromMe, isPresented: $isPresented)
        })
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar, content: {
                HStack {
                    Spacer()
                    Button(action: {
                        isPresented = true
                    }) {
                        Image(systemName: "pencil")
                    }
                }
            })
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
