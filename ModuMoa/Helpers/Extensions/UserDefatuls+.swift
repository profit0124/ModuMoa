//
//  UserDefatuls+.swift
//  ModuMoa
//
//  Created by Sooik Kim on 8/2/24.
//

import Foundation

extension UserDefaults {
    public enum Key: String {
        case myNode
        case baseNode
        case showNicknameMode
        case sideOfBaseNode
    }
    
    var sideOfBaseNode: SideOfBaseNode {
        get {
            guard let rawValue = UserDefaults.standard.string(forKey: Key.sideOfBaseNode.rawValue), let baseNodeMode = SideOfBaseNode(rawValue: rawValue) else { return .sideOfFather }
            return baseNodeMode
        }
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: Key.sideOfBaseNode.rawValue)
        }
    }
    
    var nicknameMode: NicknameMode {
        get {
            guard let rawValue = UserDefaults.standard.string(forKey: Key.showNicknameMode.rawValue), let nicknameMode = NicknameMode(rawValue: rawValue) else { return .nickname }
            return nicknameMode
        }
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: Key.showNicknameMode.rawValue)
        }
    }
    
    var baseNodeID: String? {
        get {
            return UserDefaults.standard.string(forKey: Key.baseNode.rawValue)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Key.baseNode.rawValue)
        }
    }
    
    var myNodeID: String? {
        get {
            return UserDefaults.standard.string(forKey: Key.myNode.rawValue)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Key.myNode.rawValue)
        }
    }
}
