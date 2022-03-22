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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        
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
        view.addSubview(headerView)

        headerView.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
            make.height.equalTo(330)
        }
        headerView.backgroundColor = .systemPink
        
        view.addSubview(mainTableView)
        mainTableView.snp.makeConstraints { make in
            //            make.edges.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(headerView.snp.bottom)
        }
    }
    
    func bindUI() {
        viewModel.testDataSource
            .bind(to: mainTableView.rx.items(
                cellIdentifier: HomeTableViewCell.identifier,
                cellType: HomeTableViewCell.self
            )){ index, element, cell in
                cell.bodyTitle.text = element
            }.disposed(by: disposeBag)
        
        mainTableView.rx.didEndDecelerating
            .map({ [weak self] in
                guard let self = self else { return false }
                return self.mainTableView.contentOffset.y == 0
            })
            .bind(to: viewModel.isAttach)
            .disposed(by: disposeBag)
        
        
        // didscroll될때와 attached된 상태일때,
        // 스크롤 방향이 + 이고 isOPen이 아닐때 -> 펼침
        // 스크롤 방향이 - 이고 isOpen일때 -> 접음
        mainTableView.rx.didScroll
            .asDriver()
            .filter({ [weak self] in
                guard let self = self else { return false }
                return self.viewModel.isAttach.value == true
            })
            .drive(onNext: { [weak self] in
                guard let self = self else { return }
                let offset = self.mainTableView.contentOffset.y
                let isOpen = self.viewModel.isOpen.value
                
                if offset < 0 && !isOpen {
                    print(#function, #line, "펼친다")
                    self.openHeaderView()
                    self.viewModel.isOpen.accept(true)
                } else if offset > 0 && isOpen {
                    print(#function, #line, "접는다")
                    self.collapseHeaderView()
                    self.viewModel.isOpen.accept(false)
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.isOpen
            .bind {
                print(#function, #line, $0)
                
            }
            .disposed(by: disposeBag)
        
        //        viewModel.isAttach
        //            .asDriver()
        ////            .filter({$0})
        //            .drive(onNext: {
        //                print(#function, #line, "isAttach 상태", $0)
        //            }).disposed(by: disposeBag)
        
    }
    
    private func collapseHeaderView() {
        headerView.snp.updateConstraints { make in
            make.height.equalTo(120)
        }
    }
    private func openHeaderView() {
        headerView.snp.updateConstraints { make in
            make.height.equalTo(330)
        }
    }
}
