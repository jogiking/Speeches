//
//  ReadableEntity.swift
//  Speeches
//
//  Created by turu on 2022/04/05.
//

import Foundation

struct ReadableEntity {
    var date: String
    var imageURL: String?
    var title: String
    var contents: String
}

extension ReadableEntity: Persistable {
    init(managedObject: ReadableEntityObject) {
        self.date = managedObject.date
        self.imageURL = managedObject.imageURL
        self.title = managedObject.title
        self.contents = managedObject.contents
    }
    
    func managedObject() -> ReadableEntityObject {
        let readable = ReadableEntityObject()
        readable.date = self.date
        readable.imageURL = self.imageURL
        readable.title = self.title
        readable.contents = self.contents
        return readable
    }
}
