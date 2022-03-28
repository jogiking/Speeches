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
        label.textAlignment = .center
        label.contentMode = .center // 이 부분을 redraw에서 center로 바꿔야 축소 애니메이션이 부드럽게됨
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    private lazy var headline2: UILabel = {
        let label = UILabel()
        label.text = "or sign in"
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
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(imageView.snp.width)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(HomeScene.maxHeight)
        }
        
        addSubview(headline)
        headline.backgroundColor = .red
        headline.snp.makeConstraints { make in
            make.centerY.equalToSuperview().multipliedBy(1.2)
            make.leading.equalTo(inset)
            make.width.equalTo(self.snp.height).multipliedBy(UIScreen.main.bounds.width/HomeScene.maxHeight*0.45)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.alpha = (frame.height - HomeScene.minHeight)/HomeScene.maxHeight
    }
}
