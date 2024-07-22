//
//  ContentView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/9/23.
//

import SwiftUI
//import ComposableArchitecture

struct ContentView: View {
    @State private var draggedOffset = CGSize.zero
    @State private var accumulatedOffset = CGSize.zero
    @State private var currentZoom = 0.0
    @State private var totalZoom = 1.0

    @State private var viewModel = RootViewModel()
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                switch viewModel.rootViewCase {
                case .familyTreeView:
                    ZStack {
                        if let baseNode = Binding<Node>($viewModel.baseNode) {
                            HierarchyCardView(node: baseNode) {
                                viewModel.setBaseNode($0)
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
                case .loadingView:
                    ProgressView()
                        .onAppear{
                            viewModel.onAppear()
                        }
                case .introView:
                    AddMyInformationContainerView()
                }
            }
        }
        .environment(viewModel)
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
