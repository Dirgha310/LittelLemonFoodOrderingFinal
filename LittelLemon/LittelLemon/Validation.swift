//
//  Validation.swift
//  LittleLemon
//
//  Created by Dirgha Kathiriya on 09/08/2023.
//

import Foundation


extension String {
    func isValidUrl() -> Bool {
        let urlPattern = #"^(http(s)?://)?([\w-]+\.)+[\w-]+(/[\w- ;,./?%&=]*)?$"#
        let regex = try! NSRegularExpression(pattern: urlPattern)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
    
    func isValidEmail() -> Bool {
        let emailRegex = try! NSRegularExpression(pattern: "\\b[\\w.%-]+@[\\w.-]+\\.[A-Za-z]{2,}\\b")
        return emailRegex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}

