//
//  HomeTableViewCell.swift
//  Speeches
//
//  Created by turu on 2022/03/22.
//

import UIKit

import RxRelay
import RxSwift

class HomeTableViewCell: UITableViewCell {
    static let identifier = "HomeTableViewCell"
    private let gap = 15
    private var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private lazy var bodyTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = .yellow
        return label
    }()
    
    override func prepareForReuse() {
        if let imageView = imageView {
            imageView.image = nil
        }
        
        disposeBag = DisposeBag()
        headerTitle.text = ""
        bodyTitle.text = ""
        
        configureUI()
    }
    
    private func configureUI() {
        guard let imageView = imageView else {
            return
        }
        
        imageView.image = UIImage(systemName: "folder.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.backgroundColor = .gray
        
        contentView.backgroundColor = .green
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.height.equalTo(imageView.snp.width).multipliedBy(1.2)
            make.leading.top.equalToSuperview().offset(gap)
            make.leading.top.bottom.equalToSuperview().inset(gap)
        }
        contentView.addSubview(headerTitle)
        headerTitle.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(gap)
            make.top.equalToSuperview().offset(gap)
            make.trailing.equalToSuperview().inset(gap)
        }
        contentView.addSubview(bodyTitle)
        bodyTitle.snp.makeConstraints { make in
            make.leading.equalTo(imageView.snp.trailing).offset(gap)
            make.top.equalTo(headerTitle.snp.bottom)
            make.trailing.bottom.equalToSuperview().inset(gap)
        }
    }
    
    func bind(_ relay: BehaviorRelay<ReadableEntity>) {
        
        relay.subscribe(onNext: {
            [weak self] entity in
            guard let self = self else {
                return
            }
            self.headerTitle.text = entity.title
            self.bodyTitle.text = entity.contents
        })
        .disposed(by: disposeBag)
    }
    
}
