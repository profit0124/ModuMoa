//
//  MemberUpdateView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/18/24.
//

import SwiftUI
//import ComposableArchitecture

struct MemberUpdateView: View {
    
    @Binding var node: Node
    @Binding var fromMe: Bool
    @Binding var isPresented: Bool
    
    @State private var name: String
    @State private var sex: Sex?
    @State private var birthDay: Date?
    @State private var bloodType: BloodType
    @State private var rh: BloodType.RhType?
    @State private var abo: BloodType.AboType?
    
    init(node: Binding<Node>, fromMe: Binding<Bool>, isPresented: Binding<Bool>) {
        self._node = node
        self._fromMe = fromMe
        self._isPresented = isPresented
        let wrappedValue = node.wrappedValue
        if fromMe.wrappedValue {
            self.name = wrappedValue.member.name
            self.sex = wrappedValue.member.sex
            self.birthDay = wrappedValue.member.birthday
            self.bloodType = wrappedValue.member.bloodType
        } else {
            self.name = wrappedValue.partner!.member.name
            self.sex = wrappedValue.partner!.member.sex
            self.birthDay = wrappedValue.partner!.member.birthday
            self.bloodType = wrappedValue.partner!.member.bloodType
        }
    }
    
    var body: some View {
        VStack(spacing: 22) {
            // MARK: Navigation Bar
            HStack {
                Button(action: {
                    isPresented = false
                }) {
                    Text("닫기")
                }
                .font(.customFont(.callOut))
                .foregroundColor(.moduBlack)
                Spacer()
                
                Button(action: {
                    if fromMe {
                        node.member.name = name
                        if let sex {
                            node.member.sex = sex
                        }
                        node.member.bloodType = bloodType
                        node.member.birthday = birthDay
                    } else {
                        node.partner?.member.name = name
                        if let sex {
                            node.partner?.member.sex = sex
                        }
                        node.partner?.member.bloodType = bloodType
                        node.partner?.member.birthday = birthDay
                    }
                    isPresented = false
                }) {
                    Text("저장")
                }
                .font(.customFont(.callOut))
                .foregroundColor(isEnabled() ? .moduBlack : .disableText)
                .disabled(!isEnabled())
            }
            
            MemberFormView(name: $name, sex: $sex, birthDay: $birthDay, bloodType: $bloodType, rh: $rh, abo: $abo)
        }
        .padding(.horizontal, 16)
        .onAppear {
            self.rh = bloodType.rh
            self.abo = bloodType.abo
        }
    }
    
    private func isEnabled() -> Bool {
        if name.isEmpty || sex == nil || rh == nil || abo == nil {
            return false
        }
        if fromMe {
            if node.member.name != name {
                return true
            }
            if node.member.sex != sex {
                return true
            }
            if node.member.birthday != birthDay {
                return true
            }
            if node.member.bloodType != bloodType {
                return true
            }
        } else {
            if node.partner?.member.name != name {
                return true
            }
            if node.partner?.member.sex != sex {
                return true
            }
            if node.partner?.member.birthday != birthDay {
                return true
            }
            if node.partner?.member.bloodType != bloodType {
                return true
            }
        }
        return false
    }
}

//#Preview {
//    MemberUpdateView(member)
//}
