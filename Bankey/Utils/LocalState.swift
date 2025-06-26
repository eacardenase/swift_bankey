//
//  LocalState.swift
//  Bankey
//
//  Created by Edwin Cardenas on 6/26/25.
//

import Foundation

public class LocalState {

    private enum Keys: String {
        case hasOnboarded
    }

    public static var hasOnboarded: Bool {
        get {
            return UserDefaults.standard.bool(
                forKey: Keys.hasOnboarded.rawValue
            )
        }

        set {
            UserDefaults.standard.set(
                newValue,
                forKey: Keys.hasOnboarded.rawValue
            )
            UserDefaults.standard.synchronize()
        }
    }

}
