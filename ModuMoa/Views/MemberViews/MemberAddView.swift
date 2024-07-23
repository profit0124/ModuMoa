//
//  MemberAddView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/20/24.
//

import SwiftUI

struct MemberAddView: View {
    
    @Binding var fromNode: Node
    @Binding var selectedAddCase: CaseOfAdd?
    
    let nickName: String
    let level: Int
    let distance: Int

    @State private var name: String = .init()
    @State private var sex: Sex?
    @State private var birthDay: Date?
    @State private var bloodType: BloodType = .init(abo: .none, rh: .none)
    @State private var rh: BloodType.RhType?
    @State private var abo: BloodType.AboType?
    @Binding var isPushed: Bool
    
    init(from node: Binding<Node>, with selectedAddCase: Binding<CaseOfAdd?>, isPushed: Binding<Bool>) {
        self._fromNode = node
        self._selectedAddCase = selectedAddCase
        self._isPushed = isPushed
        var sex:Sex = .male
        var level = node.level.wrappedValue
        var distance = node.distance.wrappedValue
        switch selectedAddCase.wrappedValue {
        case .leftParent:
            sex = .male
            level += 1
            distance = node.wrappedValue.rightParent?.distance ?? distance + 1
            
        case .rightParent:
            sex = .female
            level += 1
            distance = node.wrappedValue.leftParent?.distance ?? distance + 1
            
        case .partner:
            sex = node.member.sex.wrappedValue == .male ? .male : .female
            
        case .son:
            sex = .male
            level -= 1
            distance += 1
            
        case .daughter:
            sex = .female
            level -= 1
            distance += 1
            
        default:
            break
        }
        self.sex = sex
        self.nickName = RelationshipInfoType(level: level, distance: distance, sex: sex).nickName()
        self.level = level
        self.distance = distance
    }
    
    var body: some View {
        
        VStack(spacing: .betweenElements) {
            HStack {
                Button(action: {
                    selectedAddCase = nil
                    isPushed = false
                }) {
                    HStack {
                        Image(systemName: "chevron.left")
                        Text("뒤로가기")
                    }
                    .font(.customFont(.callOut))
                    .foregroundStyle(.moduBlack)
                }
                Spacer()
            }
            
            MemberFormView(name: $name, sex: $sex, birthDay: $birthDay, bloodType: $bloodType, rh: $rh, abo: $abo, nickName: nickName)
            
            Spacer()
            
            Button(action:{
                saveNode()
            }) {
                RoundedRectangleButtonView(title: "완료")
            }
            .disabled(name.isEmpty || sex == nil)
            
        }
        .padding(.horizontal, .betweenTextAndLine)
        .ignoresSafeArea(.keyboard)
        .navigationBarBackButtonHidden()
    }
    
    func saveNode() {
        if let sex {
            let node = Node(member: .init(name: name, bloodType: bloodType, sex: sex, birthday: birthDay, nickName: nickName), level: level, distance: distance)
            switch selectedAddCase {
            case .leftParent:
                if fromNode.rightParent != nil {
                    node.children = fromNode.rightParent?.children ?? []
                    node.partner = fromNode.rightParent
                    fromNode.rightParent?.partner = node
                } else {
                    node.children = [fromNode]
                }
                fromNode.leftParent = node
            case .rightParent:
                if fromNode.leftParent != nil {
                    node.children = fromNode.leftParent?.children ?? []
                    node.partner = fromNode.leftParent
                    fromNode.leftParent?.partner = node
                } else {
                    node.children = [fromNode]
                }
                fromNode.rightParent = node
            case .partner:
                node.children = fromNode.children
                node.partner = fromNode
                fromNode.partner = node
            case .son, .daughter:
                if fromNode.member.sex == .male {
                    node.leftParent = fromNode
                    node.rightParent = fromNode.partner
                } else {
                    node.rightParent = fromNode
                    node.leftParent = fromNode.partner
                }
                fromNode.children.append(node)
                if fromNode.partner != nil {
                    fromNode.partner?.children.append(node)
                }
                
            default:
                break
            }
            do {
                try DatabaseModel.shared.addNode(node)
                // 추가 후 해당 Hierarychy card 에서 진입 시 사용했던 selectedAddCase 를 다시 nil 로 변경
                selectedAddCase = nil
                isPushed = false
            } catch {
                print("save error")
            }
            
        }
    }
}
