//
//  MemberView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/29/23.
//

import SwiftUI

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
    
    @State var memberViewType: MemberViewType
    @State private var isPresented: Bool = false
    @State private var selectedSectionType: SectionType?
//    @State private var bloodType: SectionType.MemberBloodType?
    
    @State private var selectedBloodType: SectionType.MemberBloodType?
    
    @State private var name: String = ""
    @State private var birthDayString: String = ""
    @State private var sexString: String = ""
    @State private var bloodTypeToString: String = ""
    @State private var aboTypeToString: String = ""
    
    @State private var birthDay: Date = Date()
    @State private var sex: Sex?
    @State private var aboType: BloodType.AboType?
    @State private var rhType: BloodType.RhType?
    @State private var bloodType: BloodType?
    
    @Binding var member: Member?
    @State private var isUpdated: Bool = false
    
    @Binding var isMainViewOpen: Bool
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                if memberViewType == .update {
                    Group {
                        Text("닫기")
                            .font(.customFont(.callOut))
                            .onTapGesture {
                                if isUpdated {
                                    
                                }
                                memberViewType = .detail
                            }
                        Spacer()
                        Text("저장")
                            .font(.customFont(.callOut))
                            .onTapGesture {
                                member = setMember()
                                memberViewType = .detail
                            }
                    }
                } else {
                    Group {
                        Image(systemName: "chevron.left")
                            .font(.customFont(.callOut))
                        Text("뒤로가기")
                    }
                    .onTapGesture {
                        isMainViewOpen = true
                    }
                    Spacer()
                }
            }
            .padding(.bottom, .betweenTextAndLine)
            
            HStack {
                if memberViewType == .detail {
                    Text(name)
                        .font(.customFont(.title1) .bold())
                        .foregroundStyle(.moduBlack)
                } else {
                    TextField("이름", text: $name)
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
                if type != .name {
                    textSectionView(type)
                        .padding(.bottom, .betweenContents)
                }
            }
            Spacer()
            
            if memberViewType == .add {
                if !name.isEmpty, let sex, !birthDayString.isEmpty, let rhType, let aboType {
                    RoundedRectangleButtonView(title: "저장하기", isEnabled: true)
                        .onTapGesture {
                            let newMember = Member(name: name, bloodType: BloodType(abo: aboType, rh: rhType), sex: sex, birthday: birthDay)
                        }
                } else {
                    RoundedRectangleButtonView(title: "저장하기", isEnabled: false)
                }
                
            } else if memberViewType == .detail {
                HStack {
                    Spacer()
                    Image(systemName: "pencil")
                        .font(.customFont(.body))
                        .onTapGesture {
                            memberViewType = .update
                        }
                }
            }
            
        }
        .padding(.horizontal, 20)
        .sheet(isPresented: $isPresented, content: {
            Group {
                if selectedSectionType == .sex {
                    MemberSexView(title: selectedSectionType?.rawValue ?? "", sex: $sex, isPresented: $isPresented)
                } else if selectedSectionType == .birthDay {
                    MemberBirthdayView(birthday: $birthDay, isPresented: $isPresented)
                } else if selectedSectionType == .bloodType {
                    if selectedBloodType == .rhType {
                        MemberRhTypeView(rhType: $rhType, isPresented: $isPresented)
                    } else {
                        MemberAboTypeView(aboType: $aboType, isPresented: $isPresented)
                    }
                }
            }
            .padding(.top, .betweenContents)
            .padding(.horizontal, 20)
            .presentationDetents([.medium])
        })
        .onAppear {
            if memberViewType == .detail, let member {
                name = member.name
                sex = member.sex
                sexString = member.sex.rawValue
                birthDay = member.birthday
                birthDayString = member.birthday.toString()
                rhType = member.bloodType.rh
                bloodTypeToString = member.bloodType.rh.rawValue
                aboType = member.bloodType.abo
                aboTypeToString = member.bloodType.abo.rawValue
            }
        }
        .onChange(of: isPresented, {(_, _) in
            if !isPresented {
                selectedBloodType = nil
                selectedSectionType = nil
                sexString = sex?.rawValue ?? ""
                bloodTypeToString = rhType?.rawValue ?? ""
                aboTypeToString = aboType?.rawValue ?? ""
                if memberViewType == .update {
                    isUpdated = checkUpdate()
                }
            }
        })
        .onChange(of: birthDay, {(_, _) in
            birthDayString = birthDay.toString()
            if memberViewType == .update {
                isUpdated = checkUpdate()
            }
        })
        .onChange(of: name, {(_, _) in
            if memberViewType == .update {
                isUpdated = checkUpdate()
            }
        })
    }
    
    private func getValue(_ type: SectionType, _ bloodType: SectionType.MemberBloodType? = nil) -> Binding<String> {
        switch type {
        case .name:
            $name
        case .sex:
            $sexString
        case .birthDay:
            $birthDayString
        case .bloodType:
            switch bloodType {
            case .aboType:
                $aboTypeToString
            case .rhType:
                $bloodTypeToString
            default:
                $bloodTypeToString
            }
            
        }
    }
    
    private func tapGesture(_ type: SectionType, _ bloodType: SectionType.MemberBloodType? = nil) {
        if memberViewType != .detail {
            selectedSectionType = type
            selectedBloodType = bloodType
            isPresented = true
        }
    }
    
    @ViewBuilder
    private func textSectionView(_ type: SectionType) -> some View {
        VStack(alignment: .leading, spacing: .betweenHeadlineAndTitle2 ){
            Text(type.getTitle())
                .font(.customFont(.headline))
            switch type {
            case .bloodType:
                HStack(spacing: 8) {
                    ForEach(SectionType.MemberBloodType.allCases, id: \.self) { blood in
                        TextSectionSubView(needSpacing: false, value: getValue(type, blood), sectionType: type, bloodType: blood, selectedSection: $selectedSectionType, selectedBloodType: $selectedBloodType, memberViewType: $memberViewType)
                            .onTapGesture {
                                tapGesture(type, blood)
                            }
                    }
                    
                    Spacer()
                }
                
            default:
                TextSectionSubView(needSpacing: true, value: getValue(type), sectionType: type, bloodType: nil, selectedSection: $selectedSectionType, selectedBloodType: $selectedBloodType, memberViewType: $memberViewType)
                    .onTapGesture {
                        tapGesture(type)
                    }
            }
        }
    }
    
    private func checkUpdate() -> Bool {
        if member?.name == name,
            member?.sex == sex,
            member?.birthday == birthDay,
            member?.bloodType.rh == rhType,
            member?.bloodType.abo == aboType {
            return false
        } else {
            return true
        }
    }
    
    private func setMember() -> Member {
        return Member(name: name, bloodType: BloodType(abo: aboType!, rh: rhType!), sex: sex!, birthday: birthDay)
    }
}

#Preview {
    MemberView(memberViewType: .detail, member: .constant(nil), isMainViewOpen: .constant(false))
}
