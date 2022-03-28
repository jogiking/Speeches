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
    
    private lazy var headline: PadddingLabel = {
        let label = PadddingLabel()
        label.rightInset = 8
        label.text = "Sign up"
        label.textAlignment = .right
        label.contentMode = .right
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    private lazy var headline2: UILabel = {
        let label = UILabel()
        label.text = "or sign in"
        label.textAlignment = .left
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    private lazy var subtitle: UILabel = {
        let label = UILabel()
        label.text = "to get started"
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "brain.head.profile")
        imageView.contentMode = .scaleAspectFit
        return imageView
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
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign in", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .title3)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    private let inset = UIScreen.main.bounds.width * 0.08

    private func configureUI() {
        backgroundColor = .systemGray2
        
        addSubview(createAccountButton)
        createAccountButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(inset)
            make.height.equalTo(44)
            make.width.equalTo(self.snp.height).priority(500)
            make.leading.greaterThanOrEqualTo(inset).priority(750)
        }
        
        addSubview(signInButton)
        signInButton.backgroundColor = .orange
        signInButton.snp.makeConstraints { make in
            make.centerX.equalTo(createAccountButton.snp.centerX)
            make.top.equalTo(createAccountButton.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(8)
            make.height.equalTo(self.snp.height).multipliedBy(16/HomeScene.maxHeight)
        }
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.size.equalTo(self.snp.width).multipliedBy(0.3)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(HomeScene.maxHeight - HomeScene.minHeight * 0.25)
        }
        
        addSubview(headline)
        headline.backgroundColor = .red
        headline.snp.contentCompressionResistanceHorizontalPriority = 1000
        headline.snp.makeConstraints { make in
            make.top.equalTo(self.snp.centerY).multipliedBy(1.2).priority(500)
            make.top.greaterThanOrEqualTo(imageView.snp.bottom)
            
            make.top.lessThanOrEqualTo(createAccountButton.snp.top).priority(750)
            make.bottom.lessThanOrEqualTo(createAccountButton.snp.bottom)
            
            make.leading.equalToSuperview().offset(inset)
            make.width.equalTo(self.snp.height).multipliedBy(0.5).priority(500)
            make.trailing.lessThanOrEqualToSuperview().inset(UIScreen.main.bounds.width * 0.5)
        }
        
        addSubview(headline2)
        headline2.backgroundColor = .purple
        headline2.snp.contentCompressionResistanceHorizontalPriority = 750
        headline2.snp.makeConstraints { make in
            make.centerY.equalTo(headline)
            make.leading.equalTo(headline.snp.trailing)
            make.trailing.equalToSuperview().inset(inset)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let alpha = (frame.height - HomeScene.minHeight)/HomeScene.maxHeight
        imageView.alpha = alpha
        headline2.alpha = alpha
        signInButton.alpha = alpha
    }
}

