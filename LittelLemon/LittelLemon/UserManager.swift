//
//  UserManager.swift
//  LittleLemon
//
//  Created by Dirgha Kathiriya on 09/08/2023.
//

import Foundation

class UserManager {
    private let FIRST_NAME = "first_name"
    private let LAST_NAME = "last_name"
    private let EMAIL = "email"
    private let PHONE_NUMBER = "phone_number"
    private let ORDER_STATUS = "order_status"
    private let PASSWORD_CHANGES = "password_changes"
    private let SPECIAL_OFFERS = "special_offers"
    private let NEWSLETTER = "newsletter"
    
    private let defaults = UserDefaults.standard
    
    var lastName: String {
        get {
            return defaults.string(forKey: LAST_NAME) ?? ""
        }
        set(value) {
            defaults.set(value, forKey: LAST_NAME)
        }
    }
    
    
    var firstName: String {
        get {
            return defaults.string(forKey: FIRST_NAME) ?? ""
        }
        set(value) {
            defaults.set(value, forKey: FIRST_NAME)
        }
    }
    

    var email: String {
        get {
            return defaults.string(forKey: EMAIL) ?? ""
        }
        set(value) {
            defaults.set(value, forKey: EMAIL)
        }
    }
    
    var phoneNumber: String {
        get {
            return defaults.string(forKey: PHONE_NUMBER) ?? ""
        }
        set(value) {
            defaults.set(value, forKey: PHONE_NUMBER)
        }
    }
    
    var isEmailNotificationOrderStatusEnabled: Bool {
        get {
            return defaults.bool(forKey: ORDER_STATUS)
        }
        set(value) {
            defaults.set(value, forKey: ORDER_STATUS)
        }
    }
    
    var isEmailNotificationPasswordChangesEnabled: Bool {
        get {
            return defaults.bool(forKey: PASSWORD_CHANGES)
        }
        set(value) {
            defaults.set(value, forKey: PASSWORD_CHANGES)
        }
    }
    
    var isEmailNotificationSpecialOffersEnabled: Bool {
        get {
            return defaults.bool(forKey: SPECIAL_OFFERS)
        }
        set(value) {
            defaults.set(value, forKey: SPECIAL_OFFERS)
        }
    }
    
    var isEmailNotificationNewsletterEnabled: Bool {
        get {
            return defaults.bool(forKey: NEWSLETTER)
        }
        set(value) {
            defaults.set(value, forKey: NEWSLETTER)
        }
    }
    
    func isUserLoggedIn() -> Bool {
        return !firstName.isEmpty &&
            !lastName.isEmpty &&
            !email.isEmpty &&
            email.isValidEmail()
    }
    
    func saveLoginDetails(
        firstName: String = "",
        lastName: String = "",
        email: String = ""
    ) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        isEmailNotificationOrderStatusEnabled = true
        isEmailNotificationPasswordChangesEnabled = true
        isEmailNotificationSpecialOffersEnabled = true
        isEmailNotificationNewsletterEnabled = true
    }
    
    func clear() {
        firstName = ""
        lastName = ""
        email = ""
        phoneNumber = ""
    }
}
