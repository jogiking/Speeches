//
//  HeaderView.swift
//  Speeches
//
//  Created by turu on 2022/03/25.
//

import UIKit

import SnapKit

//
//final class MyLabel: UILabel {
//    override func draw(_ rect: CGRect) {
//        super.draw(rect)
//    }
//}

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
        label.textAlignment = .right
        label.contentMode = .right
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    private lazy var headline2: UILabel = {
        let label = UILabel()
        label.text = " or sign in"
        label.textAlignment = .center
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
    
    private let inset = UIScreen.main.bounds.width * 0.08

    private func configureUI() {
        backgroundColor = .systemGray2
        
        addSubview(createAccountButton)
        createAccountButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(inset)
            make.trailing.equalToSuperview().inset(inset)
            make.height.equalTo(HomeScene.minHeight * 0.3)
            make.width.equalTo(self.snp.height).priority(600)
            make.leading.greaterThanOrEqualTo(inset).priority(800)
        }
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.size.equalTo(self.snp.width).multipliedBy(0.3)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(HomeScene.maxHeight * 0.6)
        }
        
        addSubview(headline)
//        headline.backgroundColor = .red
        headline.snp.contentCompressionResistanceHorizontalPriority = 1000
        headline.snp.makeConstraints { make in
            make.top.equalTo(self.snp.centerY).multipliedBy(1.2).priority(800)
            make.top.greaterThanOrEqualTo(imageView.snp.bottom)
            make.leading.equalTo(inset)
            make.width.equalTo(self.snp.height).multipliedBy(0.5*0.8).priority(600)
        }
        
        addSubview(headline2)
//        headline2.backgroundColor = .purple
        headline2.snp.makeConstraints { make in
            make.centerY.equalTo(headline)
            make.leading.equalTo(headline.snp.trailing)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.alpha = (frame.height - HomeScene.minHeight)/HomeScene.maxHeight
    }
}
