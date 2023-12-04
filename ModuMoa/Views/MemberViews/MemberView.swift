//
//  MemberView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/29/23.
//

import SwiftUI
import ComposableArchitecture

enum MemberViewType {
    case add
    case update
    case detail
}

enum SectionType: String, CaseIterable {
    case name = "이름"
    case sex = "성별을 선택해주세요"
    case birthDay = "생일을 입력해주세요"
    case bloodType = "혈액형"
    
    
    func getTitle() -> String {
        switch self {
        case .name:
            "이름"
        case .sex:
            "성별"
        case .birthDay:
            "생일"
        case .bloodType:
            "혈액형"
        }
    }
    
    enum MemberBloodType: String, CaseIterable {
        case rhType = "RH식"
        case aboType = "혈액형"
    }
}

struct MemberView: View {
    
    let store: StoreOf<MemberReducer>
    
//    @State var memberViewType: MemberViewType
//    @State private var isPresented: Bool = false
//    @State private var selectedSectionType: SectionType?
////    @State private var bloodType: SectionType.MemberBloodType?
//    
//    @State private var selectedBloodType: SectionType.MemberBloodType?
//    
//    @State private var name: String = ""
//    @State private var birthDayString: String = ""
//    @State private var sexString: String = ""
//    @State private var bloodTypeToString: String = ""
//    @State private var aboTypeToString: String = ""
//    
//    @State private var birthDay: Date = Date()
//    @State private var sex: Sex?
//    @State private var aboType: BloodType.AboType?
//    @State private var rhType: BloodType.RhType?
//    @State private var bloodType: BloodType?
//    
//    @Binding var member: Member?
//    @State private var isUpdated: Bool = false
//    
//    @Binding var isMainViewOpen: Bool
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            VStack(spacing: 0) {
                HStack {
                    if viewStore.memberViewType == .update {
                        Group {
                            Text("닫기")
                                .font(.customFont(.callOut))
                                .onTapGesture {
                                    if viewStore.isUpdated {
                                        
                                    }
                                    viewStore.send(.setMemberViewType(.detail))
                                }
                            Spacer()
                            Text("저장")
                                .font(.customFont(.callOut))
                                .onTapGesture {
                                    //TODO: viewStore member save
                                    viewStore.send(.setMember)
//                                    viewStore.member = setMember()
                                    viewStore.send(.setMemberViewType(.detail))
//                                    viewStore.memberViewType = .detail
                                }
                        }
                    } else {
                        Group {
                            Image(systemName: "chevron.left")
                                .font(.customFont(.callOut))
                            Text("뒤로가기")
                        }
                        .onTapGesture {
                            //TODO: DismissAction
//                            viewStore.isMainViewOpen = true
                            viewStore.send(.dismissAction)
                        }
                        Spacer()
                    }
                }
                .padding(.bottom, .betweenTextAndLine)
                
                HStack {
                    if viewStore.memberViewType == .detail {
                        Text(viewStore.name)
                            .font(.customFont(.title1) .bold())
                            .foregroundStyle(.moduBlack)
                    } else {
                        TextField("이름", text: viewStore.$name)
                            .font(.customFont(.title1) .bold())
                            .foregroundStyle(.moduBlack)
                    }
                    Spacer()
                    
                    Text("어머니")
                        .foregroundStyle(.moduYellow)
                        .padding(8)
                        .background {
                            Capsule()
                                .fill(.moduBlack)
                        }
                }
                .padding(.bottom, .betweenTitleAndContent)
                
                ForEach(SectionType.allCases, id: \.self) { type in
//                    switch type {
//                    case .name
//                    }
                    Group {
                        if type == .bloodType {
                            HStack(spacing: 8) {
                                ForEach(SectionType.MemberBloodType.allCases, id: \.self) { blood in
                                    TextSectionSubView(needSpacing: false, value: getValue(viewStore: viewStore, type, blood), sectionType: type, bloodType: blood, selectedSection: viewStore.$selectedSectionType, selectedBloodType: viewStore.$selectedBloodType, memberViewType: viewStore.$memberViewType)
                                        .onTapGesture {
                                            viewStore.send(.tapGesture(type, blood))
                                        }
                                }
                                
                                Spacer()
                            }
                            //                        textSectionView(viewStore: viewStore, type)
                            //                            .padding(.bottom, .betweenContents)
                        } else if type != .name {
                            TextSectionSubView(needSpacing: true, value: getValue(viewStore: viewStore, type), sectionType: type, bloodType: nil, selectedSection: viewStore.$selectedSectionType, selectedBloodType: viewStore.$selectedBloodType, memberViewType: viewStore.$memberViewType)
                                .onTapGesture {
                                    //                        tapGesture(type)
                                    viewStore.send(.tapGesture(type))
                                }
                        }
                        
                    }
                    .padding(.bottom, .betweenContents)
//                    if type == .bloodType {
//                        
//                        textSectionView(viewStore: viewStore, type)
//                    }
//                    switch type {
//                    case .name:
//                        break
//                        
//                    case .bloodType:
//                        Text("sex")
//                        
//                    default:
//                        Text("default")
//                    }
                }
                Spacer()
                
                if viewStore.memberViewType == .add {
                    if !viewStore.name.isEmpty, let sex = viewStore.sex, !viewStore.birthDayString.isEmpty, let rhType = viewStore.rhType, let aboType = viewStore.aboType {
                        RoundedRectangleButtonView(title: "저장하기", isEnabled: true)
                            .onTapGesture {
                                let newMember = Member(name: viewStore.name, bloodType: BloodType(abo: aboType, rh: rhType), sex: sex, birthday: viewStore.birthDay)
                            }
                    } else {
                        RoundedRectangleButtonView(title: "저장하기", isEnabled: false)
                    }
                    
                } else if viewStore.memberViewType == .detail {
                    HStack {
                        Spacer()
                        Image(systemName: "pencil")
                            .font(.customFont(.body))
                            .onTapGesture {
                                // TODO: Change Action
                                viewStore.send(.setMemberViewType(.update))
                            }
                    }
                }
                
            }
            .padding(.horizontal, 20)
            .sheet(isPresented: viewStore.$isPresented, content: {
                Group {
                    if viewStore.selectedSectionType == .sex {
                        MemberSexView(title: viewStore.selectedSectionType?.rawValue ?? "", sex: viewStore.$sex, isPresented: viewStore.$isPresented)
                    } else if viewStore.selectedSectionType == .birthDay {
                        MemberBirthdayView(birthday: viewStore.$birthDay, isPresented: viewStore.$isPresented)
                    } else if viewStore.selectedSectionType == .bloodType {
                        if viewStore.selectedBloodType == .rhType {
                            MemberRhTypeView(rhType: viewStore.$rhType, isPresented: viewStore.$isPresented)
                        } else {
                            MemberAboTypeView(aboType: viewStore.$aboType, isPresented: viewStore.$isPresented)
                        }
                    }
                }
                .padding(.top, .betweenContents)
                .padding(.horizontal, 20)
                .presentationDetents([.medium])
            })
            .onAppear {
                viewStore.send(.onAppear)
//                if viewStore.memberViewType == .detail, let member = viewStore.member {
//                    viewStore.name = member.name
//                    viewStore.sex = member.sex
//                    viewStore.sexString = member.sex.rawValue
//                    viewStore.birthDay = member.birthday ?? Date()
//                    viewStore.birthDayString = member.birthday?.toString() ?? Date().toString()
//                    viewStore.rhType = member.bloodType.rh
//                    viewStore.bloodTypeToString = member.bloodType.rh.rawValue
//                    viewStore.aboType = member.bloodType.abo
//                    viewStore.aboTypeToString = member.bloodType.abo.rawValue
//                }
            }
//            .onChange(of: viewStore.isPresented, {(_, _) in
//                if !viewStore.isPresented {
//                    viewStore.selectedBloodType = nil
//                    viewStore.selectedSectionType = nil
//                    viewStore.sexString = viewStore.sex?.rawValue ?? ""
//                    viewStore.bloodTypeToString = viewStore.rhType?.rawValue ?? ""
//                    viewStore.aboTypeToString = viewStore.aboType?.rawValue ?? ""
//                    if viewStore.memberViewType == .update {
//                        viewStore.isUpdated = checkUpdate()
//                    }
//                }
//            })
//            .onChange(of: viewStore.birthDay, {(_, _) in
//                viewStore.birthDayString = viewStore.birthDay.toString()
//                if viewStore.memberViewType == .update {
//                    viewStore.isUpdated = checkUpdate()
//                }
//            })
//            .onChange(of: viewStore.name, {(_, _) in
//                if viewStore.memberViewType == .update {
//                    viewStore.isUpdated = checkUpdate()
//                }
//            })
            
        }
        
    }
    
    @MainActor private func getValue(viewStore: ViewStoreOf<MemberReducer>,_ type: SectionType, _ bloodType: SectionType.MemberBloodType? = nil) -> Binding<String> {
        switch type {
        case .name:
            viewStore.$name
        case .sex:
            viewStore.$sexString
        case .birthDay:
            viewStore.$birthDayString
        case .bloodType:
            switch bloodType {
            case .aboType:
                viewStore.$aboTypeToString
            case .rhType:
                viewStore.$bloodTypeToString
            default:
                viewStore.$bloodTypeToString
            }
        }
    }
    
//    private func tapGesture(_ type: SectionType, _ bloodType: SectionType.MemberBloodType? = nil) {
//        if viewStore.memberViewType != .detail {
//            viewStore.selectedSectionType = type
//            viewStore.selectedBloodType = bloodType
//            isPresented = true
//        }
//    }
    
//    @ViewBuilder
//    private func textSectionView(viewStore: ViewStoreOf<MemberReducer>,_ type: SectionType) async -> some View {
//        VStack(alignment: .leading, spacing: .betweenHeadlineAndTitle2 ){
//            Text(type.getTitle())
//                .font(.customFont(.headline))
//            switch type {
//            case .bloodType:
//                HStack(spacing: 8) {
//                    ForEach(SectionType.MemberBloodType.allCases, id: \.self) { blood in
//                        TextSectionSubView(needSpacing: false, value: getValue(viewStore: viewStore, type, blood), sectionType: type, bloodType: blood, selectedSection: viewStore.$selectedSectionType, selectedBloodType: viewStore.$selectedBloodType, memberViewType: viewStore.$memberViewType)
//                            .onTapGesture {
//                                viewStore.send(.tapGesture(type, blood))
//                            }
//                    }
//                    
//                    Spacer()
//                }
//                
//            default:
//                TextSectionSubView(needSpacing: true, value: getValue(viewStore: viewStore, type), sectionType: type, bloodType: nil, selectedSection: viewStore.$selectedSectionType, selectedBloodType: viewStore.$selectedBloodType, memberViewType: viewStore.$memberViewType)
//                    .onTapGesture {
////                        tapGesture(type)
//                        viewStore.send(.tapGesture(type))
//                    }
//            }
//        }
//    }
    
//    private func checkUpdate(_ viewStore: ViewStoreOf<MemberReducer>) -> Bool {
//        if viewStore.member?.name == viewStore.name,
//           viewStore.member?.sex == viewStore.sex,
//           viewStore.member?.birthday == viewStore.birthDay,
//           viewStore.member?.bloodType.rh == viewStore.rhType,
//           viewStore.member?.bloodType.abo == viewStore.aboType {
//            return false
//        } else {
//            return true
//        }
//    }
    
//    private func setMember() -> Member {
//        return Member(name: name, bloodType: BloodType(abo: aboType!, rh: rhType!), sex: sex!, birthday: birthDay)
//    }
}
//
//#Preview {
//    MemberView(memberViewType: .detail, member: .constant(nil), isMainViewOpen: .constant(false))
//}
