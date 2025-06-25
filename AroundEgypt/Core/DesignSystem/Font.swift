//
//  Font.swift
//  Opportunities
//
//  Created by youssef on 12/1/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import Foundation

enum AppFont: String {
    case bold = "Gotham-Bold"
    case medium = "Gotham-Medium"
    case light = "Gotham-Light"
    case roundedBold = "GothamRnd-Bold"
    var name: String {
        return self.rawValue
    }
}
