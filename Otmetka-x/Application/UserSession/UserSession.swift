//
//  UserSession.swift
//  Otmetka-x
//
//  Created by Тимур Миргалиев on 30.01.2024.
//

import Foundation

class UserSession {
    
    private(set) static var accessToken: String? {
        get {
            guard let token = Keychain.getAnyToken(forKey: KeychainKeys.kAccessToken) else { return nil }
            return token
        }
        
        set {
            Keychain.saveAnyToken(newValue, forKey: KeychainKeys.kAccessToken)
        }
    }
    
    private static var isOrganization: Bool? {
        get {
            UserDefaults.standard.bool(forKey: UserDefaultKeys.isOrganization)
        }
        
        set {
            UserDefaults.standard.setValue(newValue, forKey: UserDefaultKeys.isOrganization)
        }
    }
    
    public static func isLoggedIn() -> Bool {
        accessToken != nil
    }
    
    public static func isOrganizationLoggedIn() -> Bool {
        guard let isOrganization = isOrganization else { return false }
        return isOrganization
    }
    
    public static func login(with token: String, isOrganization: Bool) {
        accessToken = token
        self.isOrganization = isOrganization
    }
    
    public static func logout() {
        Keychain.deleteAnyToken(forKey: KeychainKeys.kAccessToken)
    }
}
