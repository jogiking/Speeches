//
//  ReadableEntity.swift
//  Speeches
//
//  Created by turu on 2022/04/05.
//

import Foundation

struct ReadableEntity {
    var date: String
    var imageURL: [String]
    var title: String
    var contents: String
    var url: String?
}

extension ReadableEntity: Persistable {
    init(managedObject: ReadableEntityObject) {
        self.date = managedObject.date
        self.imageURL = Array(managedObject.imageURL)
        self.title = managedObject.title
        self.contents = managedObject.contents
        self.url = managedObject.url
    }
    
    func managedObject() -> ReadableEntityObject {
        let readable = ReadableEntityObject()
        readable.date = self.date
        readable.imageURL.append(objectsIn: self.imageURL)
        readable.title = self.title
        readable.contents = self.contents
        readable.url = self.url
        return readable
    }
}
