//
//  SelectBloodTypeView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/29/23.
//

import SwiftUI

struct SelectBloodTypeView: View {
    
    @Binding var name: String
    @Binding var sex: Sex?
    @Binding var birthDay: Date
    @Binding var bloodType: BloodType?
    @Binding var index: Int
    
    @State private var aboType: BloodType.AboType?
    @State private var rhType: BloodType.RhType?
    
    @State private var isPresented: Bool = true
    
    var body: some View {
        GeometryReader { reader in
            let width = reader.size.width
            VStack(alignment: .leading, spacing: 0) {
                
                Image(systemName: "chevron.left")
                    .resizable()
                    .font(.customFont(.headline))
                
                    .frame(width: 10, height: 20)
                    .onTapGesture {
                        index -= 1
                    }
                    .padding(.leading, 8)
                VStack(alignment: .leading, spacing: 0) {
                    Text("혈액형을 입력해주세요")
                        .font(.customFont(.largeTitle).bold())
                        .padding(.top, .betweenElements)
                        .padding(.bottom, .betweenTitleAndContent)
                    
                    HStack {
                        Group {
                            Text(rhType?.rawValue ?? "Rh식")
                                .font(.customFont(.body))
                            Image(systemName: "chevron.right")
                        }
                        .foregroundStyle(rhType == nil ? .disableText : .moduBlack)
                        .onTapGesture {
                            if !isPresented {
                                isPresented = true
                            }
                        }
                        Spacer()
                    }
                    .padding(.bottom, .betweenElements)
                    
                    HStack(spacing: 8) {
                        ForEach(BloodType.AboType.allCases, id: \.self) { type in
                            selectedCapusle(type, width: width)
                        }
                    }
                    .padding(.bottom, .betweenSelectPoint)
                    
                    makeSection("생일", birthDay.toString())
                        .padding(.bottom, .betweenElements)
                    
                    
                    makeSection("성별", sex?.rawValue ?? "")
                        .padding(.bottom, .betweenElements)
                    
                    makeSection("이름", name)
                    
                    Spacer()
                
                    
                    if aboType != nil, rhType != nil {
                        RoundedRectangleButtonView(title: "완료", isEnabled: true)
                            .onTapGesture {
                                if let aboType, let rhType {
                                    self.bloodType = BloodType(abo: aboType, rh: rhType)
                                    index += 1
                                }
                            }
                    } else {
                        RoundedRectangleButtonView(title: "완료", isEnabled: false)
                    }
                    
                    
                }
                .padding(.horizontal, 20)
            }
        }
        .sheet(isPresented: $isPresented) {
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Text("Rh 식 혈액형을 입력하세요")
                        .font(.customFont(.title2))
                        .padding(.top, .betweenContents)
                        .padding(.bottom, .betweenTitleAndContent)
                    Spacer()
                }
                
                
                ForEach(BloodType.RhType.allCases, id: \.self) { type in
                    Group {
                        HStack {
                            Text(type.rawValue)
                                .font(.customFont(.callOut))
                                .padding(.bottom, .betweenTextAndLine)
                            Spacer()
                        }
                        .background {
                            Color.white
                        }
                        Divider()
                            .padding(.bottom, .betweenTextAndLine)
                    }
                    .onTapGesture {
                        self.rhType = type
                        isPresented = false
                    }
                    

                }
                
                Text("모름")
                    .font(.customFont(.callOut))
                    .onTapGesture {
                        self.rhType = .positive
                        isPresented = false
                    }
                    
                Spacer()
            }
            .padding(.horizontal, 16)
            .presentationDetents([.medium])
        }
    }
    
    
    
    @ViewBuilder
    private func makeSection(_ headline: String, _ value: String) -> some View {
        VStack(alignment: .leading, spacing: .betweenHeadlineAndTitle2) {
            Text(headline)
                .foregroundStyle(.moduBlack)
                .font(.customFont(.footnote))
                
            Text(value)
                .foregroundStyle(.moduBlack)
                .font(.customFont(.body))
        }
        .padding(.bottom, .betweenContents)
    }
    
    @ViewBuilder
    private func selectedCapusle(_ value: BloodType.AboType, width: CGFloat) -> some View {
        let width = (width - 64) / 4
        Text(value.rawValue)
            .font(.customFont(.callOut))
            .foregroundStyle(aboType == value ? .moduYellow : .disableText)
            .padding(.vertical, 8)
            .frame(width: width)
            .background {
                Capsule()
                    .fill(aboType == value ? .moduBlack : .disableCapture)
            }
            .onTapGesture {
                aboType = value
            }
    }
}

#Preview {
    SelectBloodTypeView(name: .constant("d"), sex: .constant(.female), birthDay: .constant(Date()), bloodType: .constant(nil), index: .constant(4))
}
