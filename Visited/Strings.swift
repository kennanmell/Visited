//
//  Strings.swift
//  Visited
//
//  Created by Kennan Mell on 4/7/24.
//

import Foundation

extension String {
    static let visited = loc("Visited")
    static let notVisited = loc("Not Visited")
    static let wantToGo = loc("Want to Go")
    static let status = loc("Status")
    static let firstYearVisited = loc("First Year Visited")
    
    static let usa = loc("USA")
    static let world = loc("World")
    
    static let cancel = loc("Cancel")
    
    private static func loc(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}
