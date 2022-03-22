//
//  HomeTableViewCell.swift
//  Speeches
//
//  Created by turu on 2022/03/22.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
//        print(#function, #line)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static let identifier = "HomeTableViewCell"
    private let gap = 15
    
    private(set) lazy var headerTitle: UILabel = {
        let label = UILabel()
        label.text = "This is Test"
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.adjustsFontForContentSizeCategory = true
        return label
    }()
    
    private(set) lazy var bodyTitle: UILabel = {
       let label = UILabel()
        label.text = "Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.adjustsFontForContentSizeCategory = true
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = .yellow
        return label
    }()
    
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        configureUI()
//    }
    override func prepareForReuse() {
//        print(#function, #line)
//        imageView = UIImageView(image: UIImage(systemName: "folder.fill"))
        headerTitle.text = "reused cell"
//        bodyTitle.text = ""
        bodyTitle.text = "Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo Memo"
    }
    
    func configureUI() {
//        imageView = UIImageView(image: UIImage(systemName: "folder.fill"))
        guard let imageView = imageView else {
            return
        }
//        frame = CGSize(width: UIScreen.main.bounds.width, height: 120)
        
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
            make.top.equalTo(headerTitle.snp.bottom) // .offset(gap)
            make.trailing.bottom.equalToSuperview().inset(gap)
        }
    }
}
