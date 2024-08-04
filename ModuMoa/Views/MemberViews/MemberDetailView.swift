//
//  MemberDetailView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/15/24.
//

import SwiftUI

struct MemberDetailView: View {
    
    @Environment(\.nicknameMode) var nicknameMode
    
    @Binding var isPushed: Bool
    @State private var vm: MemberDetailViewModel
    
    init(isPushed: Binding<Bool>, node: Node) {
        self._isPushed = isPushed
        self.vm = .init(node: node)
    }
    
    var body: some View {
        let member = vm.node.member
        VStack(spacing: .betweenElements) {
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
            
            VStack(spacing: .betweenTitleAndContent) {
                HStack {
                    Text(member.name)
                        .font(.customFont(.largeTitle))
                        .fontWeight(.bold)
                        .foregroundStyle(.moduBlack)

                    Spacer()
                    
                    let nickname = member.getNickname(nicknameMode)
                    Text(nickname)
                        .font(.customFont(.subHeadline))
                        .foregroundStyle(.moduYellow)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 6)
                        .background{
                            if nickname.count == 1 {
                                Circle().fill(.moduBlack)
                            } else {
                                Capsule().fill(.moduBlack)
                            }
                        }
                }
                
                VStack(alignment: .leading, spacing: .betweenContents) {
                    
                    ModumoaMemberSectionView(title: "성별", value: member.sex.rawValue)
                    
                    ModumoaMemberSectionView(title: "생일", value: member.birthday?.toString() ?? "모름")
                    
                    VStack(alignment: .leading, spacing: .betweenHeadlineAndTitle2) {
                        Text("혈액형")
                            .font(.customFont(.callOut))
                            .foregroundStyle(.grayscale1)
                        
                        GeometryReader {
                            let size = $0.size
                            HStack(spacing: .betweenElements) {
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
        .fullScreenCover(isPresented: $vm.isPresented, content: {
            MemberUpdateView(node: vm.node, isPresented: $vm.isPresented)
        })
        .transaction { transaction in
            transaction.disablesAnimations = true
        }
        .toolbar {
            ToolbarItem(placement: .bottomBar, content: {
                HStack {
                    Spacer()
                    Button(action: {
                        vm.updateButtonTapped()
                    }) {
                        Image(systemName: "pencil")
                    }
                }
            })
        }
        .navigationBarBackButtonHidden()
    }
}
