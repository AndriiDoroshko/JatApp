//
//  Token.swift
//  JatTestApp
//
//  Created by Andrey Doroshko on 9/6/18.
//  Copyright © 2018 Andrey Doroshko. All rights reserved.
//

import Foundation
import Security

let kSecClassValue = NSString(format: kSecClass)
let kSecAttrAccountValue = NSString(format: kSecAttrAccount)
let kSecValueDataValue = NSString(format: kSecValueData)
let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
let kSecAttrServiceValue = NSString(format: kSecAttrService)
let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
let kSecReturnDataValue = NSString(format: kSecReturnData)
let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)

class Token {
    let key: String
    
    static let shared = Token(with: "token")
    
    init(with key: String) {
        self.key = key
    }
    
    func saveToken(_ token: String?) {
        guard let token = token else { return }
        removeToken()
        if let dataFromString = token.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, key, dataFromString],
                                                                         forKeys: [kSecClassValue, kSecAttrServiceValue, kSecValueDataValue])
            
            let status = SecItemAdd(keychainQuery as CFDictionary, nil)
            //guard status == errSecSuccess else { return false }
            
        }
    }
    
    func updateToken(_ token: String?) -> Bool {
        guard let token = token else { return false }
        if let dataFromString: Data = token.data(using: String.Encoding.utf8, allowLossyConversion: false) {
            
            let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, key, kCFBooleanTrue, kSecMatchLimitOneValue],
                                                                         forKeys: [kSecClassValue, kSecAttrServiceValue, kSecReturnDataValue, kSecMatchLimitValue])
            
            let status = SecItemUpdate(keychainQuery as CFDictionary, [kSecValueDataValue:dataFromString] as CFDictionary)
            guard status == errSecSuccess else {
                if let err = SecCopyErrorMessageString(status, nil) {
                    print("Remove failed: \(err)")
                }
                return false
            }
            return true
        }
        return false
    }
    
    func getToken() -> String? {
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, key, kCFBooleanTrue, kSecMatchLimitOneValue],
                                                                     forKeys: [kSecClassValue, kSecAttrServiceValue, kSecReturnDataValue, kSecMatchLimitValue])
        
        var dataTypeRef :AnyObject?
        
        let status = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var contentsOfKeychain: String?
        
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data {
                contentsOfKeychain = String(data: retrievedData, encoding: String.Encoding.utf8)
            }
        } else {
            print("Nothing was retrieved from the keychain. Status code \(status)")
        }
        return contentsOfKeychain
    }
    
    func removeToken() -> Bool {
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, key, kCFBooleanTrue, kSecMatchLimitOneValue],
                                                                     forKeys: [kSecClassValue, kSecAttrServiceValue, kSecReturnDataValue, kSecMatchLimitValue])
        let status = SecItemDelete(keychainQuery as CFDictionary)
        guard status == errSecSuccess else { return false }
        return true
    }
}
