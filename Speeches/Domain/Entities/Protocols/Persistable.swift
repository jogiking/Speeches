//
//  Persistable.swift
//  Speeches
//
//  Created by turu on 2022/05/02.
//

import Foundation

import RealmSwift

protocol Persistable {
    associatedtype ManagedObject: RealmSwift.Object
    
    // Persistance Object -> Entity
    init(managedObject: ManagedObject)
    // Entity -> Persistance Object
    func managedObject() -> ManagedObject
}
