//
//  MemberAddView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/20/24.
//

import SwiftUI

struct MemberAddView: View {
    
    @Binding var fromNode: Node
    let selectedAddCase: CaseOfAdd
    
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
    
    let addAction: (Node) -> Void
    
    init(from node: Binding<Node>, with selectedAddCase: CaseOfAdd, isPushed: Binding<Bool>, completion: @escaping (Node) -> Void) {
        self._fromNode = node
        self.selectedAddCase = selectedAddCase
        self._isPushed = isPushed
        var sex:Sex = .male
        var level = node.level.wrappedValue
        var distance = node.distance.wrappedValue
        switch selectedAddCase {
        case .leftParent:
            sex = .male
            level += 1
            distance += 1
            
        case .rightParent:
            sex = .female
            level += 1
            distance += 1
            
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
        }
        self.sex = sex
        self.nickName = RelationshipInfoType(level: level, distance: distance, sex: sex).nickName()
        self.level = level
        self.distance = distance
        
        addAction = completion
    }
    
    var body: some View {
        
        VStack(spacing: .betweenElements) {
            HStack {
                Button(action: {
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
            var node = Node(member: .init(name: name, bloodType: bloodType, sex: sex, birthday: birthDay, nickName: nickName), level: level, distance: distance)
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
                    node.rightParent = fromNode
                    node.leftParent = fromNode.partner
                } else {
                    node.leftParent = fromNode
                    node.rightParent = fromNode.partner
                }
                fromNode.children.append(node)
                if fromNode.partner != nil {
                    fromNode.partner?.children.append(node)
                }
            }
            do {
                try DatabaseModel.shared.addNode(node)
                isPushed = false
                addAction(node)
            } catch {
                print("save error")
            }
            
        }
    }
}
