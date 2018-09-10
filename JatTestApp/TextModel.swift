//
//  TextModel.swift
//  JatTestApp
//
//  Created by Andrey Doroshko on 9/10/18.
//  Copyright © 2018 Andrey Doroshko. All rights reserved.
//

import Foundation

struct TextModel: Codable {
    let success: Bool
    let data: String?
    let error: ErrorModel?
}
