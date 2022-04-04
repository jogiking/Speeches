//
//  ImageType.swift
//  Speeches
//
//  Created by turu on 2022/03/30.
//

import Foundation

enum ImageType {
    case studying
    
    var name: String {
        switch self {
        case .studying:
            return "studying"
        }
    }
    
    var reference: String {
        switch self {
        case .studying:
            return "Flaticon.com"
        }
    }
}
