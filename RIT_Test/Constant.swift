//
//  Constant.swift
//  RIT_Test
//
//  Created by Alexander Ruduk on 14.07.17.
//  Copyright © 2017 Alexander Ruduk. All rights reserved.
//

import Foundation

struct Constant {
    
    static let googleLoginNotification = Notification.Name("GoogleLoginSuccessNotification")
    
    struct User {
        static let userID =         "kUserID"
        static let idToken =        "kToken"
        static let fullName =       "kFullName"
        static let givenName =      "kGivenName"
        static let familyName =     "kFamilyName"
        static let email =          "kEmail"
        static let hasImage =       "kHasImage"
        static let imageURL =       "kImageURL"
    }
    
}
