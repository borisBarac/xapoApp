//
//  UserDefaults.swift
//  XapoTest
//
//  Created by Boris Barac on 09.01.2022.
//

import Foundation

protocol UserDefaultsStorage {
    func value(forKey key: String) -> Any?
    func setValue(_ value: Any?, forKey key: String)
}

extension UserDefaults: UserDefaultsStorage {}

@propertyWrapper
struct UserDefsStorage<Value> {
    private let key: String
    private let storage: UserDefaultsStorage

    var wrappedValue: Value? {
        get {
            return storage.value(forKey: key) as? Value
        }
        nonmutating set {
            storage.setValue(newValue, forKey: key)
        }
    }

    init(key: String, storage: UserDefaultsStorage = UserDefaults.standard) {
        self.key = key
        self.storage = storage
    }
}
