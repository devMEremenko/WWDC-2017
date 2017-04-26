//
//  WWMemoryDataManager.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/26/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import Foundation

class WWMemoryDataManager: NSObject {
    
    static let shared = WWMemoryDataManager()
    
    internal var username : String?
    
    func update(username: String?) {
        self.username = username
    }
    
    func currentUsername() -> String? {
        return self.username
    }
}
