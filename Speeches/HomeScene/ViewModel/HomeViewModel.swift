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
    var disposeBag = DisposeBag()
    
    private let readableRepository: ReadableRepositoryProtocol
    
    init(readableRespository: ReadableRepositoryProtocol) {
        self.readableRepository = readableRespository
        fetchDatasource()
    }
    
    private func fetchDatasource() {
        readableRepository.fetch().subscribe { [weak self] entities in
            guard let self = self else {
                return
            }
            print(#function, #line, "size=\(entities.count)")
            let relays = entities.map {
                BehaviorRelay<ReadableEntity>(value: $0)
            }
            
            self.dataSource.accept(relays)
            
        } onFailure: { error in
            print(#function, #line, error.localizedDescription)
        }.disposed(by: disposeBag)
    }
    
    func update() {
        fetchDatasource()
    }
}
