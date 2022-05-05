//
//  RealmManager.swift
//  Speeches
//
//  Created by turu on 2022/05/02.
//

import Foundation

import RealmSwift

final class RealmManager {
    private init() {}
    
    static let shared = RealmManager()
    
    private let realm = try? Realm()
    
    func create<T: Object>(_ object: T) throws {
        guard let realm = realm else {
            throw RealmError.initializeFailed
        }
        
        do {
            try realm.write {
                realm.add(object)
            }
        } catch {
            throw RealmError.createEntityFailed
        }
    }
    
    func read<T: Object>(_ type: T.Type, keyPath: String? = nil) throws -> [T] {
        guard let realm = realm else {
            throw RealmError.initializeFailed
        }
        
        if let keyPath = keyPath {
            return Array(realm.objects(type).sorted(byKeyPath: keyPath, ascending: true))
        } else {
            return Array(realm.objects(type))
        }
        
    }
    
    func update<T: Object>(_ object: T, with dictionary: [String: Any?]) throws {
        guard let realm = realm else {
            throw RealmError.initializeFailed
        }
        
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            throw RealmError.updateFailed
        }
    }
    
    func delete<T: Object>(_ object: T) throws {
        guard let realm = realm else {
            throw RealmError.initializeFailed
        }
        
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            throw RealmError.deleteFailed
        }
    }
}

enum RealmError: Error {
    case initializeFailed
    case createEntityFailed
    case updateFailed
    case deleteFailed
}
