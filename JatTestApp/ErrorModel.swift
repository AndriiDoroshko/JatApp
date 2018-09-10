//
//  ErrorModel.swift
//  JatTestApp
//
//  Created by Andrey Doroshko on 9/10/18.
//  Copyright © 2018 Andrey Doroshko. All rights reserved.
//

import Foundation

struct ErrorModel: Codable {
    let name: String
    let message: String
    let code: Int
    let status: Int
}
