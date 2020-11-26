//
//  Keys.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//

import Foundation
class Keys{
    static var BaseUrl: String  {
        get {
           return Bundle.main.object(forInfoDictionaryKey: "Base_URL") as? String ?? ""
        }
    }
}
