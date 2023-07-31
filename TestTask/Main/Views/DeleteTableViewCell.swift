//
//  DeleteTableViewCell.swift
//  TestTask
//
//  Created by mac on 26.07.2023.
//

import UIKit

class DeleteTableViewCell: UITableViewCell {
    struct Model: Hashable, Equatable {
        let didTapDelete: (() -> Void)
        
        private let uuid = UUID(uuidString: String(describing: Self.self))
        static func == (lhs: DeleteTableViewCell.Model, rhs: DeleteTableViewCell.Model) -> Bool {
            return lhs.uuid == rhs.uuid
        }
        func hash(into hasher: inout Hasher) {
            hasher.combine(uuid)
        }
    }
    
    private let deleteButton: UIButton = {
        var configuration = UIButton.Configuration.bordered()
        configuration.title = "Очистить"
        configuration.contentInsets = .init(top: 12, leading: 48, bottom: 12, trailing: 48)
        configuration.baseBackgroundColor = .clear
        configuration.baseForegroundColor = .systemRed
        let button = UIButton(configuration: configuration)
        button.layer.borderColor = UIColor.systemRed.cgColor
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
        deleteButton.layer.cornerRadius = deleteButton.frame.height / 2
    }
    
    
    
    func setData(_ model: Model) {
        self.model = model
        deleteButton.addTarget(self, action: #selector(deleteButtonT), for: .touchUpInside)
    }
    
    @objc private func deleteButtonT() {
        model.didTapDelete()
    }
}

private extension DeleteTableViewCell {
    func addSubviews() {
        contentView.addSubview(deleteButton)
        deleteButton.fillSuperview(top: 6, bottom: 6)
        deleteButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}

