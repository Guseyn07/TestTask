//
//  MainViewController.swift
//  TestTask
//
//  Created by mac on 26.07.2023.
//

import UIKit

class MainViewController: UIViewController {
    var presenter: MainPresenter!
    
    private lazy var tableAdapter = MainTableAdapter(tableView: self.tableView)
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.separatorStyle = .none
        view.estimatedRowHeight = 100
        view.rowHeight = UITableView.automaticDimension
        view.alwaysBounceVertical = false
        view.keyboardDismissMode = .interactive
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupUI()
        presenter.makeItems()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_ :)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_ :)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset.bottom = keyboardSize.height + 80
        }
    }

    @objc private func keyboardWillHide(_ notification: NSNotification) {
        tableView.contentInset = .zero
    }
}

extension MainViewController: MainPresenterProtocol {
    func setItems(_ items: [MainTableAdapter.Item]) {
        tableAdapter.setItems(items)
    }
    
    func showActionSheet(_ actionSheet: UIAlertController) {
        present(actionSheet, animated: true)
    }
}

private extension MainViewController {
    func setupUI() {
        view.backgroundColor = .white
    }
    
    func addSubviews() {
        view.addSubview(tableView)
        tableView.fillSuperviewSafeArea(leading: 16, top: 0, trailing: 16, bottom: 0)
    }
}


