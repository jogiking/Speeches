//
//  AddURLViewController.swift
//  Speeches
//
//  Created by turu on 2022/05/04.
//

import UIKit

import RxSwift
import SnapKit

class AddURLViewController: UIViewController {
    
    private var disposeBag = DisposeBag()
    
    private lazy var navigationBar: UINavigationBar = {
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 44))
        let navigationItem = UINavigationItem(title: "Paste URL")
        let rightItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addBarButtonTouched(_:)))
        
        navigationItem.rightBarButtonItem = rightItem
        navigationBar.items = [navigationItem]
        return navigationBar
    }()
    
    private lazy var urlInputField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Input Web URL"
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
        
        view.addSubview(urlInputField)
        urlInputField.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(navigationBar.snp.bottom).offset(12)
        }
    }
    
    @objc private func addBarButtonTouched(_ sender: UIBarButtonItem) {
        guard let urlString = urlInputField.text,
              !urlString.isEmpty
        else {
            return
        }
        
        let entity = ReadableEntity(date: Date().currentDateString,
                                    imageURL: [], title: "", contents: "", url: urlString)
        
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
