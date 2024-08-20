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
    @State private var isSmallScreenDevice: Bool = false
    @State private var isNoSafeAreaDevice: Bool = false

    @State private var viewModel = RootViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                switch viewModel.rootViewCase {
                case .familyTreeView:
                    VStack {
                        SearchBarView(text: .constant(""))
                            .disabled(true)
                            .onTapGesture {
                                viewModel.isPushed = true
                            }
                        OptionView(nicknameMode: $viewModel.nicknameMode, baseNodeMode: $viewModel.sideOfBaseNode) {
                            viewModel.changeBaseNode($0)
                        }
                        Spacer()
                    }
                    .padding(.horizontal, 16)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background{
                        ZStack {
                            ZStack {
                                GeometryReader {
                                    let size = $0.size
                                    let zoom = min(currentZoom + totalZoom, 0.7)
                                    Color.clear
                                        .frame(width: size.width / zoom, height: size.height / zoom)
                                        .contentShape(Rectangle())
                                }
                                if let baseNode = viewModel.baseNode {
                                    HierarchyCardView(node: baseNode)
                                } else {
                                    ProgressView()
                                }
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                case .loadingView:
                    ProgressView()
                        .onAppear{
                            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                               let window = windowScene.windows.first {
                                let safeAreaInsets = window.safeAreaInsets
                                self.isNoSafeAreaDevice = safeAreaInsets.top <= 20 && safeAreaInsets.bottom <= 20
                                self.isSmallScreenDevice = window.bounds.size.height < 844
                            }
                            
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
        .onAppear {
            
        }
        .onChange(of: viewModel.baseNode?.leftParent) { oldValue, newValue in
            if viewModel.baseNode?.rightParent == nil, oldValue == nil, newValue != nil {
                /// BaseNode 가 바뀔때 기존 BaseNode 는 자식을 2명 이상 가지고 있었을 경우 HeirarchyCardView의 자식 View 가 index 에러 발생
                /// 기존 baseNode 는 자식이 2 이상인데, 새로 baseNode 로 바꾸게 되면 자식이 1명이라서 문제가 발생하는 것으로 보임
                /// 시간차이를 두고 baseNode를 바꿔주는 형식으로 disappear가 될 시간을 보장
                Task {
                    do {
                        viewModel.baseNode = nil
                        try await Task.sleep(nanoseconds: 100_000_000)
                        viewModel.setBaseNode(newValue)
                    } catch {
                        print(error)
                    }
                }
                
            }
        }
        .onChange(of: viewModel.baseNode?.rightParent) { oldValue, newValue in
            if viewModel.baseNode?.leftParent == nil, oldValue == nil, newValue != nil {
                Task {
                    do {
                        viewModel.baseNode = nil
                        try await Task.sleep(nanoseconds: 100_000_000)
                        viewModel.setBaseNode(newValue)
                    } catch {
                        print(error)
                    }
                }
            }
        }
        .onChange(of: viewModel.sideOfBaseNode) { _, _ in
            draggedOffset = .zero
            accumulatedOffset = .zero
            currentZoom = 0
            totalZoom = 0.7
        }
        .environment(viewModel)
        .environment(\.nicknameMode, viewModel.nicknameMode)
        .environment(\.isSmallScreenDevice, isSmallScreenDevice)
        .environment(\.isNoSafeAreaDevice, isNoSafeAreaDevice)
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
