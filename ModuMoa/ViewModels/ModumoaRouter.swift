//
//  Coordinator.swift
//  ModuMoa
//
//  Created by Sooik Kim on 9/4/24.
//

import SwiftUI
import Observation

protocol ModumoaRouterType {
    var path: [NavigationDestination] { get set }
    var fullScreenType: FullScreenDestination? { get set }
    
    func push(_ navigationType: NavigationDestination)
    func pop()
    func goToRoot()
    func presentFullScreenCover(_ fullScreen: FullScreenDestination)
    func dismissFullScreenCover()
}

@Observable
final class ModumoaRouter: ModumoaRouterType {
    
    var path: [NavigationDestination] = []
    var fullScreenType: FullScreenDestination?
    
    func push(_ destination: NavigationDestination) {
        path.append(destination)
    }
    
    func pop() {
        let _ = path.removeLast()
    }
    
    func goToRoot() {
        path = []
    }
    
    func presentFullScreenCover(_ destination: FullScreenDestination)  {
        self.fullScreenType = destination
    }
    
    func dismissFullScreenCover() {
        self.fullScreenType = nil
    }
}
