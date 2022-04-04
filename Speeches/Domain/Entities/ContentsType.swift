//
//  ContentsType.swift
//  Speeches
//
//  Created by turu on 2022/03/30.
//

import Foundation

enum ContentsType: CaseIterable {
    case plainText
    case webURL
    case image
    case scan
    
    var titleDescription: String {
        switch self {
        case .plainText:
            return "Paste Plain Text"
        case .scan:
            return "Scan"
        case .webURL:
            return "Web URL"
        case .image:
            return "From Image"
        }
    }
    
    var imageName: String {
        switch self {
        case .plainText:
            return "doc.text"
        case .image:
            return "photo"
        case .webURL:
            return "link"
        case .scan:
            return "camera"
        }
    }
}
