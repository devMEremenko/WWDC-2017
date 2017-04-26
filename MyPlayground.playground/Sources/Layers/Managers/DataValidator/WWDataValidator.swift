//
//  WWDataValidator.swift
//  WWDC
//
//  Created by Maxim Eremenko on 3/26/17.
//  Copyright © 2017 Maxim Eremenko. All rights reserved.
//

import UIKit

class WWDataValidator: NSObject {
    
    static func validate(username: String?) -> NSError? {
        
        if let username = username {
            if !username.isEmpty {
                return nil
            }
        }
        
        return NSError(domain: "wwdc.app.domain", code: -199, userInfo: nil)
    }
}
