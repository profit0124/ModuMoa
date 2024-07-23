//
//  ContentView.swift
//  ModuMoa
//
//  Created by Sooik Kim on 10/9/23.
//

import SwiftUI

struct ContentView: View {
    @State private var draggedOffset = CGSize.zero
    @State private var accumulatedOffset = CGSize.zero
    @State private var currentZoom = 0.0
    @State private var totalZoom = 0.7

    @State private var viewModel = RootViewModel()
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                switch viewModel.rootViewCase {
                case .familyTreeView:
                    ZStack {
                        if let baseNode = Binding<Node>($viewModel.baseNode) {
                            HierarchyCardView(node: baseNode)
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
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(alignment: .top) {
                        VStack {
                            SearchBarView(text: .constant(""))
                                .disabled(true)
                                .onTapGesture {
                                    viewModel.isPushed = true
                                }
                        }
                        .padding(.horizontal, 16)
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
            .navigationDestination(isPresented: $viewModel.isPushed, destination: {
                SearchView(isPushed: $viewModel.isPushed)
            })
        }
        .environment(viewModel)
        .onChange(of: viewModel.baseNode?.leftParent) { oldValue, newValue in
            if viewModel.baseNode?.rightParent == nil, oldValue == nil, newValue != nil {
                viewModel.setBaseNode(newValue)
            }
        }
        .onChange(of: viewModel.baseNode?.rightParent) { oldValue, newValue in
            if viewModel.baseNode?.leftParent == nil, oldValue == nil, newValue != nil {
                viewModel.setBaseNode(newValue)
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
