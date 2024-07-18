//
//  MemberFormView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/17/24.
//

import SwiftUI


struct MemberFormView: View {
    
    let member: Member

    @State private var name: String = ""
    @State private var sex: Sex?
    @State private var birthDayToString: String?
    @State private var birthDay: Date?
    @State private var bloodType: BloodType
    @State private var rh: BloodType.RhType?
    @State private var abo: BloodType.AboType?
    
    @FocusState var isFocused: Bool
    @State private var focusState: MemberFormSection? {
        didSet {
            if focusState != nil {
                isPresented = true
            } else {
                isPresented = false
            }
        }
    }
    
    @State private var isPresented: Bool = false
    
    init() {
        self.member = .init(name: "", bloodType: .init(abo: .none, rh: .none), sex: .none, birthday: Date())
        self.name = ""
        self.sex = nil
        self.birthDayToString = nil
        self.birthDay = nil
        self.bloodType = .init(abo: .none, rh: .none)
    }
    
    init(_ member: Member) {
        self.member = member
        self.name = member.name
        self.sex = member.sex
        self.birthDay = member.birthday ?? Date()
        self.bloodType = member.bloodType
    }
    
    var body: some View {
        VStack(spacing: 44) {
            HStack {
                TextField("이름", text: $name)
                    .focused($isFocused)
                    .font(.customFont(.largeTitle))
                    .fontWeight(.bold)
                    .foregroundStyle(.moduBlack)
                
                Spacer()
                
                Text("Capsule")
                    .font(.customFont(.subHeadline))
                    .foregroundStyle(.moduYellow)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 6)
                    .background( Capsule().fill(.moduBlack))
            }
            
            VStack(alignment: .leading, spacing: 32) {
                VStack(alignment: .leading ,spacing: 10) {
                    Text("성별\(MemberFormSection.sex.rawValue)")
                        .font(.customFont(.callOut))
                        .foregroundStyle(.grayscale1)
                    ZStack(alignment: .bottomLeading) {
                        HStack {
                            
                            Text(sex?.rawValue ?? MemberFormSection.sex.getSectionPlaceholder())
                                .font(.customFont(.body))
                                .foregroundStyle(sex == nil ? .disableLine : .moduBlack)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.customFont(.body))
                                .foregroundStyle(.disableLine)
                        }
                        .padding(.bottom, 6)
                        
                        Rectangle()
                            .fill(focusState == .sex ? .moduBlack : .disableLine)
                            .frame(height: 2)
                    }
                    .onTapGesture {
                        if isFocused {
                            isFocused = false
                        }
                        focusState = .sex
                    }
                }
                
                VStack(alignment: .leading ,spacing: 10) {
                    Text(MemberFormSection.birthDay.rawValue)
                        .font(.customFont(.callOut))
                        .foregroundStyle(.grayscale1)
                    ZStack(alignment: .bottomLeading) {
                        HStack {
                            Text(birthDayToString ?? MemberFormSection.birthDay.getSectionPlaceholder())
                                .font(.customFont(.body))
                                .foregroundStyle(birthDayToString == nil ? .disableLine : .moduBlack)
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .font(.customFont(.body))
                                .foregroundStyle(.disableLine)
                        }
                        .padding(.bottom, 6)
                        
                        Rectangle()
                            .fill(focusState == .birthDay ? .moduBlack : .disableLine)
                            .frame(height: 2)
                    }
                    .onTapGesture {
                        if isFocused {
                            isFocused = false
                        }
                        focusState = .birthDay
                    }
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(MemberFormSection.abo.rawValue)
                        .font(.customFont(.callOut))
                        .foregroundStyle(.grayscale1)

                    GeometryReader {
                        let size = $0.size
                        HStack(spacing: 22) {
                            ZStack(alignment: .bottomLeading) {
                                HStack {
                                    Text(rh?.rawValue ?? MemberFormSection.rh.getSectionPlaceholder())
                                        .foregroundStyle(rh == nil ? .disableLine : .moduBlack)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.disableLine)
                                }
                                .font(.customFont(.body))
                                .padding(.bottom, 6)
                                
                                Rectangle()
                                    .fill(focusState == .rh ? .moduBlack : .disableLine)
                                    .frame(height: 2)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .onTapGesture {
                                if isFocused {
                                    isFocused = false
                                }
                                focusState = .rh
                            }
                            
                            ZStack(alignment: .bottomLeading) {
                                HStack {
                                    Text(abo?.rawValue ?? MemberFormSection.abo.getSectionPlaceholder())
                                        .foregroundStyle(abo == nil ? .disableLine : .moduBlack)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundStyle(.disableLine)
                                }
                                .font(.customFont(.body))
                                .padding(.bottom, 6)
                                
                                Rectangle()
                                    .fill(focusState == .abo ? .moduBlack : .disableLine)
                                    .frame(height: 2)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .onTapGesture {
                                if isFocused {
                                    isFocused = false
                                }
                                focusState = .abo
                            }
                        }
                        .font(.customFont(.body))
                        .foregroundStyle(.moduBlack)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(width: size.width / 2)
                    }
                }
            }
        }
        .onTapGesture {
            if isFocused {
                isFocused = false
            }
        }
        .customHalfSheet($isPresented) {
            switch focusState {
            case .sex:
                MemberSexView(sex: $sex, isPresented: $isPresented) {
                    self.focusState = nil
                }
            case .birthDay:
                MemberBirthdayView(birthday: $birthDay, isPresented: $isPresented) {
                    birthDayToString = birthDay?.toString() ?? "생일을 입력해주세요."
                    self.focusState = nil
                }
            case .rh:
                MemberRhTypeView(rhType: $rh, isPresented: $isPresented) {
                    self.focusState = nil
                }
            case .abo:
                MemberAboTypeView(aboType: $abo, isPresented: $isPresented) {
                    self.focusState = nil
                }
            default:
                EmptyView()
            }
        }
        .onChange(of: rh) { _, newVal in
            if let newVal {
                self.bloodType.rh = newVal
            }
        }
        .onChange(of: abo) { _, newVal in
            if let newVal {
                self.bloodType.abo = newVal
            }
        }
    }
}

#Preview {
    MemberFormView()
}


struct ClearBackgroundView: UIViewRepresentable {
    func makeUIView(context: Context) -> some UIView {
        let uiView = UIView()
        DispatchQueue.main.async {
            uiView.superview?.superview?.backgroundColor = .clear
        }
        return uiView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}
