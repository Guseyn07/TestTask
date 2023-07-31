//
//  AddChildTableViewCell.swift
//  TestTask
//
//  Created by mac on 26.07.2023.
//

import UIKit

class AddChildTableViewCell: UITableViewCell {
    struct Model: Hashable, Equatable {
        let addChildButtonIsHidden: Bool
        let didTapAddChild: (() -> Void)
        
        private let uuid = UUID(uuidString: String(describing: Self.self))
        static func == (lhs: AddChildTableViewCell.Model, rhs: AddChildTableViewCell.Model) -> Bool {
            return lhs.uuid == rhs.uuid && lhs.addChildButtonIsHidden == rhs.addChildButtonIsHidden
        }
        func hash(into hasher: inout Hasher) {
            hasher.combine(uuid)
        }
    }
    
    private let addChildButton: UIButton = {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Добавить ребенка"
        configuration.image = UIImage(systemName: "plus")
        configuration.imagePadding = 6
        configuration.contentInsets = .init(top: 12, leading: 0, bottom: 12, trailing: 0)
        configuration.baseBackgroundColor = .clear
        configuration.baseForegroundColor = .systemBlue
        let button = UIButton(configuration: configuration)
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.borderWidth = 2
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        addChildButton.layer.cornerRadius = addChildButton.frame.height / 2
    }
    
    func setData(_ model: Model) {
        self.model = model
        addChildButton.isHidden = model.addChildButtonIsHidden
        addChildButton.addTarget(self, action: #selector(addChildButtonT), for: .touchUpInside)
    }
    
    @objc private func addChildButtonT() {
        model.didTapAddChild()
    }
}

private extension AddChildTableViewCell {
    func addSubviews() {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.alignment = .fill
        stackView.distribution = .fillProportionally
        contentView.addSubview(stackView)
        stackView.fillSuperview(leading: 0, top: 6, trailing: 0, bottom: 6)
        
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 17, weight: .medium)
        titleLabel.textColor = .black
        titleLabel.text = "Дети (макс. 5)"
        
        [titleLabel, addChildButton].forEach(stackView.addArrangedSubview(_:))
    }
}
