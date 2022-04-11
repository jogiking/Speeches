//
//  FontType.swift
//  Speeches
//
//  Created by turu on 2022/03/29.
//

import Foundation

enum FontType: String {
    case bmDoHyeon
    
    var name: String {
        switch self {
        case .bmDoHyeon:
            return "BMDoHyeon-OTF"
        }
    }
    
    var reference: String {
        switch self {
        case .bmDoHyeon:
            return "배달의민족 도현체"
        }
    }
}
