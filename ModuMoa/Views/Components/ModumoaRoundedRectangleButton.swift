//
//  ModumoaRoundedRectangleButton.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/23/24.
//

import SwiftUI

struct ModumoaRoundedRectangleButton: View {
    let title: String
    let cornerRadius: CGFloat
    let buttonAction: () -> Void
    
    init(_ title: String, cornerRadius: CGFloat = 8, buttonAction: @escaping () -> Void) {
        self.title = title
        self.cornerRadius = cornerRadius
        self.buttonAction = buttonAction
    }
    
    var body: some View {
        Button(title) {
            buttonAction()
        }
        .buttonStyle(ModumoaRoundedRectangleButtonStyle(cornerRadius: cornerRadius))
    }
}


struct ModumoaRoundedRectangleButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled: Bool
    var cornerRadius: CGFloat
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.customFont(.callOut))
            .foregroundStyle(isEnabled ? .moduYellow : .disableText)
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .background {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(isEnabled ? .moduBlack : .disableCapture)
            }
            
    }
}

#Preview {
    ModumoaRoundedRectangleButton("") {}
}
