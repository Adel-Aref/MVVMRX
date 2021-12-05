//
//  ViewController.swift
//  AssessmentTask
//
//  Created by Adel Aref on 04/12/2021.
//

import Foundation

extension UserDefaults {
    struct Keys {
        static let isLoggedIn: String = "isLoggedIn"
        static let user: String = "user"

    }
    public var isLoggedIn: Bool {
        get {
            guard let isLoggedIn = value(forKey: Keys.isLoggedIn) as? Bool else { return false }
            return isLoggedIn
        }
        set {
            set(newValue, forKey: Keys.isLoggedIn)
        }
    }
    var user: UserModel? {
        get {
            guard let savedUser = value(forKey: Keys.user) as? Data else { return nil }
            let decoder = JSONDecoder()
            if let loadedUser = try? decoder.decode(UserModel.self, from: savedUser) {
                return loadedUser
            }
            return nil
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: Keys.user)
            }
        }
    }
}
