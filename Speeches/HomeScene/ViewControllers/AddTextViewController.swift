//
//  AddTextViewController.swift
//  Speeches
//
//  Created by turu on 2022/03/30.
//

import UIKit

import RxSwift
import SnapKit

class AddTextViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    
    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let navigationItem = UINavigationItem(title: "Paste Text")
        let rightItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addBarButtonTouched(_:)))
        
        navigationItem.rightBarButtonItem = rightItem
        navigationBar.items = [navigationItem]
        return navigationBar
    }()
    
    private lazy var documentInputField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Document Title"
        return textField
    }()
    
    private lazy var contentsInputField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Input Your Contents"
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configureUI()
    }
    
    private func configureUI() {
        view.addSubview(navigationBar)
        navigationBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
        
        view.addSubview(documentInputField)
        documentInputField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(navigationBar.snp.bottom).offset(12)
        }
        
        view.addSubview(contentsInputField)
        contentsInputField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(documentInputField.snp.bottom).offset(8)
        }
    }
    
    @objc private func addBarButtonTouched(_ sender: UIBarButtonItem) {
        guard let documentTitle = documentInputField.text,
              let contents = contentsInputField.text,
              !documentTitle.isEmpty && !contents.isEmpty
        else {
            return
        }
        
        let entity = ReadableEntity(date: Date().currentDateString, imageURL: [String](), title: documentTitle, contents: contents)
        
        ReadableRepository().save(entity).subscribe { event in
            switch event {
            case .success(_):
                NotificationCenter.default.post(name: Notification.Name.readableRepositoryChanged, object: nil)
                self.dismiss(animated: true)
                
            case .failure(let error):
                self.presentAlert(error.localizedDescription)
            }
        }.disposed(by: disposeBag)
    }
    
    private func presentAlert(_ description: String) {
        let alert = UIAlertController(title: description, message: nil, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}
