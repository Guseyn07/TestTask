//
//  PersonalTableViewCell.swift
//  TestTask
//
//  Created by mac on 26.07.2023.
//

import UIKit

class PersonalTableViewCell: UITableViewCell {
    struct Model: Hashable, Equatable {
        let person: Person
        let didUpdateName: ((String) -> Void)
        let didUpdateAge: ((String) -> Void)
        
        static func == (lhs: PersonalTableViewCell.Model, rhs: PersonalTableViewCell.Model) -> Bool {
            return lhs.person == rhs.person
        }
        
        func hash(into hasher: inout Hasher) {
            hasher.combine(person)
        }
    }
    
    private let nameAlefTextField = CustomTextField()
    private let ageAlefTextField = CustomTextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(_ model: Model) {
        nameAlefTextField.setData(.init(title: "Имя",
                                        value: model.person.name,
                                        didUpdateValue: model.didUpdateName))
        
        ageAlefTextField.setData(.init(title: "Возраст",
                                       value: model.person.age,
                                       didUpdateValue: model.didUpdateAge))
    }
}

private extension PersonalTableViewCell {
    func addSubviews() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 6
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        contentView.addSubview(stackView)
        stackView.fillSuperview(leading: 0, top: 6, trailing: 0, bottom: 6)
        
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 17, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.text = "Персональные данные"
        
        [titleLabel, nameAlefTextField, ageAlefTextField].forEach(stackView.addArrangedSubview(_:))
    }
}
