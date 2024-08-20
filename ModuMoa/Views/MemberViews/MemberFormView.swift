//
//  MemberFormView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/17/24.
//

import SwiftUI


struct MemberFormView: View {
    
    @Binding var name: String
    @Binding var sex: Sex?
    @State var birthDayToString: String?
    @Binding var birthDay: Date?
    @Binding var bloodType: BloodType
    @Binding var rh: BloodType.RhType?
    @Binding var abo: BloodType.AboType?
    let nickName: String
    
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
    @Environment(\.isNoSafeAreaDevice) var isNoSafeArea
    
    init(name: Binding<String>, sex: Binding<Sex?>, birthDay: Binding<Date?>, bloodType: Binding<BloodType>, rh: Binding<BloodType.RhType?>, abo: Binding<BloodType.AboType?>, nickName: String = "") {
        self._name = name
        self._sex = sex
        self._birthDay = birthDay
        self._bloodType = bloodType
        self._rh = rh
        self._abo = abo
        self.nickName = nickName
    }
    
    var body: some View {
        VStack(spacing: .betweenTitleAndContent) {
            HStack {
                TextField("이름", text: $name)
                    .focused($isFocused)
                    .font(.customFont(.largeTitle))
                    .fontWeight(.bold)
                    .foregroundStyle(.moduBlack)
                
                Spacer()
                /// 멤버 추가시 생일 입력 전 형, 동생, 누나, 등 나와 나이차이 발생시 닉네임을 결정할 수 없음
                if !nickName.isEmpty {
                    Text(nickName)
                        .font(.customFont(.subHeadline))
                        .foregroundStyle(.moduYellow)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 6)
                        .background( Capsule().fill(.moduBlack))                    
                }
            }
            
            VStack(alignment: .leading, spacing: .betweenContents) {
                VStack(alignment: .leading ,spacing: .betweenHeadlineAndTitle2) {
                    Text(MemberFormSection.sex.rawValue)
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
                    .background {
                        Color.clear
                    }
                    .onTapGesture {
                        if isFocused {
                            isFocused = false
                        }
                        focusState = .sex
                    }
                }
                
                VStack(alignment: .leading ,spacing: .betweenHeadlineAndTitle2) {
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
                
                VStack(alignment: .leading, spacing: .betweenHeadlineAndTitle2) {
                    Text(MemberFormSection.abo.rawValue)
                        .font(.customFont(.callOut))
                        .foregroundStyle(.grayscale1)

                    GeometryReader {
                        let size = $0.size
                        HStack(spacing: .betweenElements) {
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
        .onAppear {
            birthDayToString = birthDay?.toString()
        }
        .onTapGesture {
            if isFocused {
                isFocused = false
            }
        }
        .customDynamicHeightSheet($isPresented) {
            ZStack {
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
            .padding(.bottom, isNoSafeArea ? 16 : 0)
            
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
        .onChange(of: isPresented) { _, newValue in
            if !newValue {
                focusState = nil
            }
            
        }
    }
}

//#Preview {
//    MemberFormView()
//}


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
