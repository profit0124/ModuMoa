//
//  ContentView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/9/23.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {

    let store: StoreOf<Root> = .init(initialState: Root.State(addMyInformation: AddMyInformation.State()), reducer: {
        Root()
    })
    @State private var baseNode: Node?
    @State private var draggedOffset = CGSize.zero
    @State private var accumulatedOffset = CGSize.zero
    @State private var currentZoom = 0.0
    @State private var totalZoom = 1.0

    @State private var isMainViewOpen: Bool = true
    
    init(baseNode: Node? = nil) {
        self.baseNode = baseNode
    }
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationStack {
                ZStack {
                    switch viewStore.mainViewCase {
                    case .main:
                        ZStack {
                            if let baseNode = Binding($baseNode) {
                                HierarchyCardView(node: baseNode) {
                                    viewStore.send(.setBaseNode($0))
//                                    self.baseNode = $0
                                    
                                }
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
                            }
                        }
                        .onAppear {
                            self.baseNode = viewStore.baseNode
                        }
                        
                    case .addMyInformation:
                        IfLetStore(self.store.scope(state: \.addMyInformation, action: Root.Action.addMyInformation), then: {
                            AddMyInformationContainerView(store: $0)
                        })
                    }
                }
            }
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
