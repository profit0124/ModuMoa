//
//  CustomHalfSheet.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/17/24.
//

import SwiftUI

struct CustomHalfSheet<T: View>: ViewModifier {
    
    @State private var animationPresented: Bool = false
    @Binding var isPresented: Bool
    @ViewBuilder let sheetContent: T
    
    init(isPresented: Binding<Bool>, @ViewBuilder sheetContent: @escaping () -> T) {
        self._isPresented = isPresented
        self.sheetContent = sheetContent()
    }
    
    func body(content: Content) -> some View {
        content
            .fullScreenCover(isPresented: $isPresented, content: {
                GeometryReader {
                    let size = $0.size
                    ZStack(alignment: .bottom) {
                        if isPresented {
                            Color.black.opacity(0.3)
                                .ignoresSafeArea()
                                .transaction { transaction in
                                    transaction.disablesAnimations = true
                                }
                                .onTapGesture {
                                    isPresented = false
                                }
                        }
                            
                        
                        if animationPresented {
                            VStack(spacing: 0) {
                                Spacer()
                                sheetContent
                                    .padding(.top, 16)
                                    .padding(.horizontal, 16)
                                    .frame(width: size.width, height: size.height / 2)
                                    .background {
                                        Color.white
                                    }
                                    .cornerRadius(8, corners: [.topLeft, .topRight])
                                
                                
                                let bottomInsets = UIApplication.shared.connectedScenes.compactMap{ $0 as? UIWindowScene }.flatMap{ $0.windows }.first { $0.isKeyWindow }?.safeAreaInsets.bottom
                                Color.white.frame(height: bottomInsets)
                            }
                            .transition(.move(edge: .bottom))
                        }
                    }
                    .onAppear {
                        withAnimation {
                            animationPresented = true
                        }
                    }
                    .onDisappear{
                        animationPresented = false
                    }
                }
                .ignoresSafeArea()
                .background {
                    ClearBackgroundView()
                }
            })
            .transaction { transaction in
                transaction.disablesAnimations = true
            }
        
    }
}
