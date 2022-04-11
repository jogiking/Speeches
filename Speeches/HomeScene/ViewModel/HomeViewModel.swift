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
    var testDataSource = Observable<[String]>.just((1...30).map{String($0)})
    var isAttach = BehaviorRelay<Bool>(value: true)
    var isOpen = BehaviorRelay<Bool>(value: false)
}
