//
//  ReadableRepository.swift
//  Speeches
//
//  Created by turu on 2022/05/03.
//

import Foundation

import RxSwift

enum ReadableRepositoryError: Error {
    case fetchFailed
    case saveFailed
    case deleteFailed
}

class ReadableRepository: ReadableRepositoryProtocol {
    
    func fetch() -> Single<[ReadableEntity]> {
        return Single.create { single in
            do {
                let readableEntityObject = try RealmManager.shared.read(ReadableEntityObject.self)
                let readableEntities = readableEntityObject.map {
                    ReadableEntity(managedObject: $0)
                }
                single(.success(readableEntities))
            } catch {
                single(.failure(ReadableRepositoryError.fetchFailed))
            }
            return Disposables.create()
        }
        
    }
    
    func save(_ entity: ReadableEntity) -> Single<Bool> {
        return Single.create { single in
            do {
                try RealmManager.shared.create(entity.managedObject())
            } catch {
                single(.failure(ReadableRepositoryError.saveFailed))
            }
            single(.success(true))
            return Disposables.create()
        }
    }

    func delete(_ entity: ReadableEntity) -> Single<Bool> {
        return Single.create { single in
            do {
                let readableEntityObjects = try RealmManager.shared.read(ReadableEntityObject.self)
                
                if let object = readableEntityObjects.first (where: { $0.date == entity.date }) {
                    try RealmManager.shared.delete(object)
                    single(.success(true))
                } else {
                    single(.success(false))
                }
            } catch {
                single(.failure(ReadableRepositoryError.deleteFailed))
            }
            
            return Disposables.create()
        }
    }
}
