//
//  Coler.swift
//  Opportunities
//
//  Created by youssef on 12/1/20.
//  Copyright © 2020 youssef. All rights reserved.
//

import Foundation
import SwiftUI

extension DesignSystem {
    enum Colors: String {
        case main = "main"
        case background = "background"
        case searchBackground = "searchBackground"
        case description = "description"
        case title = "title"
        case subtitle = "subtitle"
        var color: Color {
            switch self {
            case .main,.background ,.searchBackground,.description,.title, .subtitle:
                return Color(self.rawValue)
            }
        }
    }
}
