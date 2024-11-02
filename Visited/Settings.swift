//
//  Settings.swift
//  Visited
//
//  Created by Kennan Mell on 4/7/24.
//

import Foundation

private enum Keys: String {
    case selectedTab
}

private let store = NSUbiquitousKeyValueStore.default

class Settings {
    private init() {}
    static let instance = Settings()

    var selectedTab: Int = Int(store.longLong(forKey: Keys.selectedTab.rawValue)) {
        didSet {
            store.set(selectedTab, forKey: Keys.selectedTab.rawValue)
            store.synchronize()
        }
    }

    func getLocation(for key: String) -> Location {
        if let dict = store.dictionary(forKey: key) {
            return Location(dict: dict)
        } else {
            return Location(visitedStatus: .none, year: nil, notes: nil)
        }
    }

    func setLocation(_ location: Location, for key: String) {
        store.set(location.dict, forKey: key)
        store.synchronize()
    }
}
