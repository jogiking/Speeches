//
//  ReadableEntity.swift
//  Speeches
//
//  Created by turu on 2022/04/05.
//

import Foundation

struct ReadableEntity {
    var id: Int
    var imageURL: String?
    var title: String
    var contents: String
}

extension ReadableEntity: Persistable {
    init(managedObject: ReadableEntityObject) {
        self.id = managedObject.id
        self.imageURL = managedObject.imageURL
        self.title = managedObject.title
        self.contents = managedObject.contents
    }
    
    func managedObject() -> ReadableEntityObject {
        let readable = ReadableEntityObject()
        readable.id = self.id
        readable.imageURL = self.imageURL
        readable.title = self.title
        readable.contents = self.contents
        return readable
    }
}
