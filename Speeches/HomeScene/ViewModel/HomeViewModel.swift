//
//  HomeViewModel.swift
//  Speeches
//
//  Created by turu on 2022/03/22.
//

import Foundation

import RxRelay
import RxSwift

final class HomeViewModel {
    lazy var dataSource = BehaviorRelay<[BehaviorRelay<ReadableEntity>]>(value: [])
    var isAttach = BehaviorRelay<Bool>(value: true)
    var isOpen = BehaviorRelay<Bool>(value: false)
    private let readableRepository: ReadableRepositoryProtocol
    
    init(readableRespository: ReadableRepositoryProtocol) {
        self.readableRepository = readableRespository
        fetchDatasource()
    }
    
    private func fetchDatasource() {
        
    }
    
    func update() {
        fetchDatasource()
    }
}
