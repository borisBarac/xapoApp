//
//  AppState.swift
//  XapoTest
//
//  Created by Boris Barac on 03.01.2022.
//

import Foundation

enum AppState: Int {
    case normal = 1
    case start = 0
}

extension AppState {

    // using static because this is just wraper for userDefaults

    private static let userDefsKey = "AppStateUserDefsKey"

    static func getState(dataStore: UserDefaults = UserDefaults.standard) -> AppState {
        return AppState(rawValue: dataStore.integer(forKey: userDefsKey)) ?? .start
    }

    static func set(state: AppState, dataStore: UserDefaults = UserDefaults.standard) {
        dataStore.set(state.rawValue, forKey: userDefsKey)
    }
}
