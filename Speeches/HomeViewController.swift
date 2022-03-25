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
    private var prevOffsetY: CGFloat = 0
    
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
    }
    
    func bindUI() {
        viewModel.testDataSource
            .bind(to: mainTableView.rx.items(
                cellIdentifier: HomeTableViewCell.identifier,
                cellType: HomeTableViewCell.self
            )){ index, element, cell in
                cell.bodyTitle.text = element
            }.disposed(by: disposeBag)
    
        mainTableView.rx.willEndDragging
            .asDriver()
            .drive(onNext: { [weak self] velocity, _ in
                guard let self = self else { return }
                let offset = self.mainTableView.contentOffset.y
                let inset = self.mainTableView.contentInset.top
                let isOpen = self.viewModel.isOpen.value
                let isAttach = self.viewModel.isAttach.value
                let minHeight = self.minHeight
                let maxHeight = self.maxHeight
                print(velocity.y, "offset:\(offset), inset:\(inset), isAttach:\(isAttach), isOpen:\(isOpen), min:\(minHeight), max:\(maxHeight)")
                if isAttach {
                    if -self.maxHeight...0 ~= offset && isOpen && velocity.y >= 0{
                        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
                            self.mainTableView.contentInset.top = 0
                            
                            self.headerView.snp.updateConstraints { make in
                                make.height.equalTo(minHeight)
                                make.leading.top.trailing.equalToSuperview()
                            }
                            self.view.layoutIfNeeded()
                        }
                        // 다시 켜주는건 didScroll에도 켜주는 작업만 해주고 있다
                        self.viewModel.isOpen.accept(false)
                    } else if -self.maxHeight...0 ~= offset && !isOpen && velocity.y <= 0 {
                        
                        UIView.animate(withDuration: 0.2, delay: 0  , options: .curveEaseOut) {
                            self.mainTableView.contentInset.top = maxHeight
                            
                            self.headerView.snp.updateConstraints { make in
                                make.height.equalTo(maxHeight+minHeight)
                            }
                            self.view.layoutIfNeeded()
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
                var isAttach = self.viewModel.isAttach.value
                let minHeight = self.minHeight
                let maxHeight = self.maxHeight
                
                
                if offset == -inset {
                    self.viewModel.isAttach.accept(true)
                    isAttach = true
                }
                
                if inset == maxHeight {
                    self.viewModel.isOpen.accept(true)
                }
                
                print("offset: \(offset), inset: \(inset), isAttach:\(isAttach), isOpen: \(isOpen), isDragging: \(isDragging), max-min: \(maxHeight):\(minHeight)" )
                
                if -maxHeight...0 ~= offset {
                    if isOpen {
                        self.mainTableView.contentInset.top = -offset
                    }
                    
//                    print("내부에서 진행중,,offset=\(offset), inset=\(inset), diff=\(diff)")
                    print("내부에서 진행중,,offset=\(offset), inset=\(inset)")
                    if isDragging {
                        let diff = offset - self.prevOffsetY
                        self.headerView.snp.updateConstraints { make in
//                            make.height.equalTo(minHeight-offset)
                            make.height.equalTo(max(minHeight,
                                                    min(maxHeight+minHeight,
                                                        self.headerView.frame.height - diff)))
                        }
                        self.view.layoutIfNeeded()
                        self.prevOffsetY = offset // 경계선에 닿았을 때 높이 갱신처리를 하지 않기 위해서 isDragging일 때만 갱신
                    }
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

