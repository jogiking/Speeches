//
//  HomeViewController.swift
//  Speeches
//
//  Created by turu on 2022/03/21.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class HomeViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    private var viewModel = HomeViewModel()
    private lazy var mainTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        return tableView
    }()
    private lazy var headerView = UIView()
    private let maxHeight = UIScreen.main.bounds.height * 0.3
    private let minHeight = UIScreen.main.bounds.height * 0.2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //        view.backgroundColor = .red
        
        mainTableView.sectionHeaderHeight = 0
        mainTableView.scrollsToTop = true
        mainTableView.rowHeight = 120
        mainTableView.backgroundColor = .white
        mainTableView.register(
            HomeTableViewCell.self,
            forCellReuseIdentifier: HomeTableViewCell.identifier
        )
        configureUI()
        bindUI()
    }
    
    func configureUI() {
        view.addSubview(mainTableView)
        mainTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalToSuperview().inset(minHeight)
        }
        
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(minHeight)
        }
        headerView.backgroundColor = .systemPink
        headerView.alpha = 0.2
    }
    
    func bindUI() {
        viewModel.testDataSource
            .bind(to: mainTableView.rx.items(
                cellIdentifier: HomeTableViewCell.identifier,
                cellType: HomeTableViewCell.self
            )){ index, element, cell in
                cell.bodyTitle.text = element
            }.disposed(by: disposeBag)
        
        //        mainTableView.rx.didScroll
        //        mainTableView.rx.didEndDragging
        //        mainTableView.rx.didEndDecelerating
        //        mainTableView.isDragging
        //        offset, inset
        //        mainTableView.rx.willBeginDecelerating
        //        mainTableView.rx.willEndDragging // 손뗄때 속도, 방향
        
        // 여기 작업중
        mainTableView.rx.didEndDragging
            .asDriver()
            .drive(onNext: { [weak self] a in
                guard let self = self else { return }
                let offset = self.mainTableView.contentOffset.y
                let inset = self.mainTableView.contentInset.top
                let isOpen = self.viewModel.isOpen.value
                let isAttach = self.viewModel.isAttach.value
                let minHeight = self.minHeight
                let maxHeight = self.maxHeight
                print(a, "offset:\(offset), inset:\(inset), isAttach:\(isAttach), isOpen:\(isOpen), min:\(minHeight), max:\(maxHeight)")
                if isAttach {
                    if -self.maxHeight...0 ~= offset && isOpen{
                        UIView.animate(withDuration: 0.2) {
                            self.mainTableView.contentInset.top = 0
//                            self.mainTableView.contentOffset.y = 0
                        }
                        self.viewModel.isOpen.accept(false) // 다시 켜주는건 didScroll에서 해주고 있다
                    } else if -self.maxHeight...0 ~= offset && !isOpen {
                        UIView.animate(withDuration: 0.2) {
                            self.mainTableView.contentInset.top = maxHeight
//                            self.mainTableView.contentOffset.y = -maxHeight
                        }
                    }
                }
            })
            .disposed(by: disposeBag)
        
        
        mainTableView.rx.didScroll
            .asDriver()
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                let offset = self.mainTableView.contentOffset.y
                let inset = self.mainTableView.contentInset.top
                let isDragging = self.mainTableView.isDragging
                let isOpen = self.viewModel.isOpen.value
                let isAttach = self.viewModel.isAttach.value
                let minHeight = self.minHeight
                let maxHeight = self.maxHeight
                
                if offset == -inset {
                    self.viewModel.isAttach.accept(true)
                }
                if inset == maxHeight {
                    self.viewModel.isOpen.accept(true)
                }
                
                print("offset: \(offset), inset: \(inset), isOpen: \(isOpen), isDragging: \(isDragging), max-min: \(maxHeight):\(minHeight)" )
                
                if 0...maxHeight ~= inset && isOpen {
//                if -maxHeight...0 ~= offset && isOpen {
                    self.mainTableView.contentInset.top = -offset
//                    self.headerView.snp.updateConstraints { make in
//                        make.height.equalTo(max(self.minHeight, self.minHeight-offset))
//                    }
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.isAttach
            .asDriver()
//            .distinctUntilChanged()
            .drive(onNext: {
                print("isAttach: \($0)")
            })
            .disposed(by: disposeBag)
        viewModel.isOpen
            .asDriver()
//            .distinctUntilChanged()
            .drive(onNext: {
                print("isOpen: \($0)")
            })
            .disposed(by: disposeBag)
    }
}

