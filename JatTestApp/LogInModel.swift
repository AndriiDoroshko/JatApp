//
//  LogInModel.swift
//  JatTestApp
//
//  Created by Andrey Doroshko on 9/6/18.
//  Copyright © 2018 Andrey Doroshko. All rights reserved.
//

import Foundation

struct LogInModel: Codable {
    let success: Bool
    let data: LogInData?
    let errors: [ErrorModel]?
    
    static var shared = LogInModel()
    
    private init() {
        self.success = false
        self.data = nil
        self.errors = nil
    }
}

struct LogInData: Codable {
    let uid: Int
    let name: String
    let email: String
    let access_token: String
    let role: Int
    let status: Int
    let created_at: Int
    let updated_at: Int
}
