//
//  UserDefaultsStore.swift
//  IBI
//
//  Created by niv ben-porath on 31/12/2024.
//

import Foundation

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard

    var wrappedValue: Value {
        get {
            return container.object(forKey: key) as? Value ?? defaultValue
        }
        set {
            container.set(newValue, forKey: key)
        }
    }
}

extension UserDefaults {
    @UserDefault(key: "isLoggedIn", defaultValue: false)
    static var isLoggedIn: Bool
    
    @UserDefault(key: "applicationAppearance", defaultValue: Appearance.defaultAppearance.rawValue)
    static var applicationAppearance: String
}
