//
//  ReadableEntityObject.swift
//  Speeches
//
//  Created by turu on 2022/05/02.
//

import Foundation

import RealmSwift

class ReadableEntityObject: Object {
    @Persisted var date: String
    @Persisted var imageURL: List<String>
    @Persisted var title: String
    @Persisted var contents: String
}
