//
//  AlefTextField.swift
//  TestTask
//
//  Created by mac on 26.07.2023.
//

import UIKit

class CustomTextField: UIView {
    struct Model {
        let title: String
        let value: String?
        let didUpdateValue: ((String) -> Void)
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .lightGray
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 13)
        textField.returnKeyType = .done
        textField.autocorrectionType = .no
        textField.keyboardType = .namePhonePad
        return textField
    }()
    
    private var model: Model!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.addSubviews()
        self.textField.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ model: Model) {
        self.model = model
        titleLabel.text = model.title
        textField.text = model.value
        textField.addTarget(self, action: #selector(textFieldValueChanged), for: .editingChanged)
    }
    
    @objc private func textFieldValueChanged() {
        guard let text = textField.text else { return }
        model.didUpdateValue(text)
    }
}

private extension CustomTextField {
    func setupUI() {
        layer.cornerRadius = 6
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    func addSubviews() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        addSubview(stackView)
        [titleLabel, textField].forEach(stackView.addArrangedSubview(_:))
        stackView.fillSuperview(leading: 6, top: 6, trailing: 6, bottom: 6)
    }
}

extension CustomTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
