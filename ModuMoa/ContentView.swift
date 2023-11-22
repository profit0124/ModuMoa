//
//  ContentView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/9/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var rootNode: Node?
    
    @State private var draggedOffset = CGSize.zero
    @State private var accumulatedOffset = CGSize.zero
    @State private var currentZoom = 0.0
    @State private var totalZoom = 1.0

    @State private var isMainViewOpen: Bool = true
    
    var body: some View {
        if let member = rootNode?.member {
            if isMainViewOpen {
                ZStack {
                    HierarchyCardView(me: member, partner: Member(name: "Partner", bloodType: .init(abo: .A, rh: .negative), sex: .female, birthday: Date()))
                        .scaleEffect(currentZoom + totalZoom)
                        .offset(draggedOffset)
                        .gesture(drag)
                        .gesture( 
                            MagnifyGesture()
                                .onChanged { value in
                                    currentZoom = value.magnification - 1
                                }
                                .onEnded { value in
                                    totalZoom += currentZoom
                                    currentZoom = 0
                                }
                            
                        )
                        .accessibilityZoomAction { action in
                            if action.direction == .zoomIn {
                                totalZoom += 1
                            } else {
                                totalZoom -= 1
                            }
                        }
                    VStack {
                        Text("Click")
                            .foregroundStyle(.moduYellow)
                            .background {
                                Color.moduBlack
                            }
                            .onTapGesture {
                                isMainViewOpen = false
                            }
                        Spacer()
                    }
                }
            } else {
                MemberView(memberViewType: .detail, member: .constant(member), isMainViewOpen: $isMainViewOpen)
            }
            
        } else {
            AddMyInformationContainerView()
        }
    }
    
    var drag: some Gesture {
        DragGesture()
          .onChanged { gesture in
            draggedOffset = accumulatedOffset + gesture.translation
          }
          .onEnded { gesture in
            accumulatedOffset = accumulatedOffset + gesture.translation
          }
      }
}

#Preview {
    ContentView()
}
