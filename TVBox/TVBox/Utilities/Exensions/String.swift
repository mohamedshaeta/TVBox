//
//  String.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//

import UIKit
extension CharacterSet {

    static var urlAllowedCharacters: CharacterSet {
        var characters = CharacterSet(charactersIn: "#")
        // All URL-legal characters
        characters.formUnion(.urlUserAllowed)
        characters.formUnion(.urlPasswordAllowed)
        characters.formUnion(.urlHostAllowed)
        characters.formUnion(.urlPathAllowed)
        characters.formUnion(.urlQueryAllowed)
        characters.formUnion(.urlFragmentAllowed)

        return characters
    }
}
extension String {
    func encodedUrl() -> URL? {
        
        guard let decodedString = self.removingPercentEncoding,
        
            let unicodeEncodedString = decodedString.addingPercentEncoding(withAllowedCharacters: .urlAllowedCharacters),
           
            let components = URLComponents(string: unicodeEncodedString),
           
            let percentEncodedUrl = components.url else {
           
            return nil
        }

        return percentEncodedUrl
    }
}
