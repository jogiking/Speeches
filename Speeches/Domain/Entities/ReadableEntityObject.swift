//
//  ReadableEntityObject.swift
//  Speeches
//
//  Created by turu on 2022/05/02.
//

import Foundation

import RealmSwift

class ReadableEntityObject: Object {
    @Persisted var id: Int
    @Persisted var imageURL: String?
    @Persisted var title: String
    @Persisted var contents: String
}
