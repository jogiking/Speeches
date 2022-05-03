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
        tableView.sectionHeaderHeight = 0
        tableView.scrollsToTop = true
        tableView.rowHeight = 120
        tableView.backgroundColor = .white
        tableView.register(
            HomeTableViewCell.self,
            forCellReuseIdentifier: HomeTableViewCell.identifier
        )
        return tableView
    }()
    private lazy var headerView = HeaderView()
    
    private lazy var addButton: UIButton = {
        let width = UIScreen.main.bounds.width / 8
        let button = UIButton(frame: CGRect(origin: .zero, size: CGSize(width: width, height: width)))
        let image = UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: width*0.7, weight: .regular))
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = width/2
        button.layer.masksToBounds = true
        button.menu = addMenu
        button.showsMenuAsPrimaryAction = true
        
        return button
    }()
    
    private lazy var addMenu: UIMenu = {
        let menuElements = ContentsType.allCases.map { contents in
            UIAction(
                title: contents.titleDescription,
                image: UIImage(systemName: contents.imageName),
                handler: { _ in self.presentAddView(contents)}
            )
        }
        return UIMenu(
            title: "Add Contents",
            image: nil,
            identifier: nil,
            options: .displayInline,
            children: menuElements
        )
    }()
    
    private let maxHeight = HomeScene.maxHeight
    private let minHeight = HomeScene.minHeight
    private var prevOffsetY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindUI()
    }
    
    func configureUI() {
        view.backgroundColor = .white
        view.addSubview(mainTableView)
        mainTableView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(minHeight)
        }
        
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(minHeight)
        }
        
        view.addSubview(addButton)
        addButton.snp.makeConstraints { make in
            make.size.equalTo(UIScreen.main.bounds.width/8)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview().inset(HomeScene.minHeight)
            make.trailing.equalToSuperview().inset(HomeScene.inset)
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
    
        mainTableView.rx.willEndDragging
            .asDriver()
            .drive(onNext: { [weak self] velocity, _ in
                guard let self = self else { return }
                let offset = self.mainTableView.contentOffset.y
                let isOpen = self.viewModel.isOpen.value
                let isAttach = self.viewModel.isAttach.value
                
                if isAttach {
                    if -self.maxHeight...0 ~= offset && isOpen && velocity.y >= 0{
                        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseOut) {
                            self.mainTableView.contentInset.top = 0
                            self.headerView.snp.updateConstraints { make in
                                make.height.equalTo(self.minHeight)
                            }
                            self.view.layoutIfNeeded()
                        }
                        // 다시 켜주는건 didScroll에도 켜주는 작업만 해주고 있다
                        self.viewModel.isOpen.accept(false)
                    } else if -self.maxHeight...0 ~= offset && !isOpen && velocity.y <= 0 {
                        UIView.animate(withDuration: 0.2, delay: 0  , options: .curveEaseOut) {
                            self.mainTableView.contentInset.top = self.maxHeight
                            self.headerView.snp.updateConstraints { make in
                                make.height.equalTo(self.maxHeight+self.minHeight)
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
                            
                if offset == -inset { self.viewModel.isAttach.accept(true) }
                if inset == self.maxHeight { self.viewModel.isOpen.accept(true) }
                
                if -self.maxHeight...0 ~= offset {
                    if isOpen { self.mainTableView.contentInset.top = -offset }
                    if isDragging {
                        let diff = offset - self.prevOffsetY
                        self.headerView.snp.updateConstraints { make in
                            make.height.equalTo(
                                max(
                                    self.minHeight,
                                    min(
                                        self.maxHeight + self.minHeight,
                                        self.headerView.frame.height - diff
                                    )
                                )
                            )
                        }
                        self.view.layoutIfNeeded()
                        self.prevOffsetY = offset // 경계선에 닿았을 때 높이 갱신처리를 하지 않기 위해서 isDragging일 때만 갱신
                    }
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func presentAddView(_ contents: ContentsType) {
        
        switch contents {
        case .plainText:
            let viewController = AddTextViewController()
            viewController.modalPresentationStyle = .pageSheet
            self.present(viewController, animated: true)
        case .webURL:
            let viewController = AddURLViewController()
            viewController.modalPresentationStyle = .pageSheet
            self.present(viewController, animated: true)
        case .image:
            print(#function, #line, contents)
        case .scan:
            print(#function, #line, contents)
        }
    }
}



