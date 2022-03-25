//
//  HeaderView.swift
//  Speeches
//
//  Created by turu on 2022/03/25.
//

import UIKit

import SnapKit

final class HeaderView: UIView {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    private lazy var headline: UILabel = {
        let label = UILabel()
        label.text = "Sign up"
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    
    private lazy var subtitle: UILabel = {
        let label = UILabel()
        label.text = "to get started"
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    private lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create account", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let inset = 24
    
    // 접혔을때만 일단 생각하기
    // label * 2
    // button * 1
    private func configureUI() {
        backgroundColor = .yellow
        
        addSubview(createAccountButton)
        createAccountButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(inset)
            make.trailing.equalToSuperview().inset(inset)
            make.height.equalTo(HomeScene.minHeight * 0.3)
            make.width.equalTo(self.snp.height).multipliedBy(0.8)
        }
    }
}
