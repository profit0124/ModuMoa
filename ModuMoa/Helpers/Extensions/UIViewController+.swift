//
//  UIViewController+.swift
//  ModuMoa
//
//  Created by Sooik Kim on 7/23/24.
//

import UIKit

extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.isEnabled = true
        interactivePopGestureRecognizer?.delegate = self
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard interactivePopGestureRecognizer == gestureRecognizer else { return false }
        return viewControllers.count > 1
    }
}
