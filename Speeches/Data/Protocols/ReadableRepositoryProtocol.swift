//
//  ReadableRepositoryProtocol.swift
//  Speeches
//
//  Created by turu on 2022/05/05.
//

import Foundation

import RxSwift

protocol ReadableRepositoryProtocol {
    func fetch() -> Single<[ReadableEntity]>
    func save(_ entity: ReadableEntity) -> Single<Bool>
    func delete(_ entity: ReadableEntity) -> Single<Bool>
}
