//
//  ContentView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/9/23.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    
//    @State private var rootNode: Node?
    let store: StoreOf<Root> = .init(initialState: Root.State(addMyInformation: AddMyInformation.State()), reducer: {
        Root()
    })
    
    @State private var draggedOffset = CGSize.zero
    @State private var accumulatedOffset = CGSize.zero
    @State private var currentZoom = 0.0
    @State private var totalZoom = 1.0

    @State private var isMainViewOpen: Bool = true
    
    var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                switch viewStore.mainViewCase {
                case .main:
                    ZStack {
                        IfLetStore(self.store.scope(state: \.hierarchyCard, action: Root.Action.hierarchyCard), then: {
                            HierarchyCardView(store: $0)
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
                        })
//                        HierarchyCardView(me: viewStore.baseNode?.member ?? Member(name: "", bloodType: .init(abo: .A, rh: .negative), sex: .female), partner: Member(name: "Partner", bloodType: .init(abo: .A, rh: .negative), sex: .female, birthday: Date()))
                            
                        VStack {
                            Text("Click")
                                .foregroundStyle(.moduYellow)
                                .background {
                                    Color.moduBlack
                                }
                                .onTapGesture {
                                    viewStore.send(.setMainViewCase(.detail))
                                    viewStore.send(.setSelectedMember(viewStore.baseNode!.member))
                                }
                            Spacer()
                        }
                    }
                case .detail:
                    IfLetStore(self.store.scope(state: \.memberReducer, action: Root.Action.memberReducer), then: {
                        MemberView(store: $0)
                    })
                    
                case .addMyInformation:
                    IfLetStore(self.store.scope(state: \.addMyInformation, action: Root.Action.addMyInformation), then: {
                        AddMyInformationContainerView(store: $0)
                    })
                }
                //                if viewStore.mainViewCase == .main {
                //                    if isMainViewOpen {
                //                        ZStack {
                //                            HierarchyCardView(me: viewStore.baseNode?.member ?? Member(name: "", bloodType: .init(abo: .A, rh: .negative), sex: .female), partner: Member(name: "Partner", bloodType: .init(abo: .A, rh: .negative), sex: .female, birthday: Date()))
                //                                .scaleEffect(currentZoom + totalZoom)
                //                                .offset(draggedOffset)
                //                                .gesture(drag)
                //                                .gesture(
                //                                    MagnifyGesture()
                //                                        .onChanged { value in
                //                                            currentZoom = value.magnification - 1
                //                                        }
                //                                        .onEnded { value in
                //                                            totalZoom += currentZoom
                //                                            currentZoom = 0
                //                                        }
                //                                    
                //                                )
                //                                .accessibilityZoomAction { action in
                //                                    if action.direction == .zoomIn {
                //                                        totalZoom += 1
                //                                    } else {
                //                                        totalZoom -= 1
                //                                    }
                //                                }
                //                            VStack {
                //                                Text("Click")
                //                                    .foregroundStyle(.moduYellow)
                //                                    .background {
                //                                        Color.moduBlack
                //                                    }
                //                                    .onTapGesture {
                //                                        isMainViewOpen = false
                //                                    }
                //                                Spacer()
                //                            }
                //                        }
                //                    } else {
                ////                        MemberView(memberViewType: .detail, member: .constant(viewStore.baseNode?.member), isMainViewOpen: $isMainViewOpen)
                ////                        
                //                        IfLetStore(self.store.scope(state: \.memberReducer, action: Root.Action.memberReducer), then: {
                //                            MemberView(store: $0)
                //                        })
                //                    }
                //                    
                //                } else {
                //                    IfLetStore(self.store.scope(state: \.addMyInformation, action: Root.Action.addMyInformation), then: {
                //                        AddMyInformationContainerView(store: $0)
                //                    })
                //                    
                //                }
                //            }
                //            .onChange(of: viewStore.mainViewCase) { newValue, oldValue in
                //                print(newValue)
                //            }
                
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
