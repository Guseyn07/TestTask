//
//  ChildTableViewCell.swift
//  TestTask
//
//  Created by mac on 26.07.2023.
//

import UIKit

class ChildTableViewCell: UITableViewCell {
    struct Model: Hashable, Equatable {
        let person: Person
        let didUpdateName: ((String) -> Void)
        let didUpdateAge: ((String) -> Void)
        let didTapDelete: (() -> Void)
        
        private let uuid = UUID()
        static func == (lhs: ChildTableViewCell.Model, rhs: ChildTableViewCell.Model) -> Bool {
            return lhs.uuid == rhs.uuid
        }
        func hash(into hasher: inout Hasher) {
            hasher.combine(uuid)
        }
    }
    
    private let nameAlefTextField = CustomTextField()
    private let ageAlefTextField = CustomTextField()
    private let deleteButton: UIButton = {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Удалить"
        configuration.baseBackgroundColor = .clear
        configuration.baseForegroundColor = .systemBlue
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private var model: Model!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ model: Model) {
        self.model = model
        nameAlefTextField.setData(.init(title: "Имя",
                                        value: model.person.name,
                                        didUpdateValue: model.didUpdateName))
        
        ageAlefTextField.setData(.init(title: "Возраст",
                                       value: model.person.age,
                                       didUpdateValue: model.didUpdateAge))
        
        deleteButton.addTarget(self, action: #selector(deleteButtonT), for: .touchUpInside)
    }
    
    @objc private func deleteButtonT() {
        model.didTapDelete()
    }
}

private extension ChildTableViewCell {
    func addSubviews() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        contentView.addSubview(stackView)
        stackView.fillSuperview(leading: 0, top: 6, bottom: 6)
        stackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 17, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.text = "Персональные данные"
        
        [nameAlefTextField, ageAlefTextField].forEach(stackView.addArrangedSubview(_:))
        
        contentView.addSubview(deleteButton)
        
        deleteButton.leadingAnchor.constraint(equalTo: stackView.trailingAnchor, constant: 12).isActive = true
        deleteButton.centerYAnchor.constraint(equalTo: nameAlefTextField.centerYAnchor).isActive = true
    }
}

