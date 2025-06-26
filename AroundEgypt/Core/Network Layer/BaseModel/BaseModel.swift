//
//  BaseModel.swift
//  POMacArch
//
//  Created by mohamed gamal on 22/12/2021.
//  Copyright © 2021 PoMac. All rights reserved.
//

import Foundation

// MARK: - BaseModel

struct BaseModel<T: Codable>: Codable {
    let meta: Meta
    let data: T?
}
