//
//  MainTableAdapter.swift
//  TestTask
//
//  Created by mac on 26.07.2023.
//

import UIKit

final class MainTableAdapter {
    enum Item: Hashable {
        case personal(PersonalTableViewCell.Model)
        case addChild(AddChildTableViewCell.Model)
        case child(ChildTableViewCell.Model)
        case delete(DeleteTableViewCell.Model)
    }

    private unowned var tableView: UITableView
    private lazy var dataSource = UITableViewDiffableDataSource<Int, Item>(tableView: self.tableView, cellProvider: self.cellProvider)

    init(tableView: UITableView) {
        self.tableView = tableView
        self.tableView.register(cellType: PersonalTableViewCell.self)
        self.tableView.register(cellType: AddChildTableViewCell.self)
        self.tableView.register(cellType: ChildTableViewCell.self)
        self.tableView.register(cellType: DeleteTableViewCell.self)
    }

    func setItems(_ items: [Item]) {
        let filteredItems = NSOrderedSet(array: items).array as? [Item] ?? []

#if DEBUG
        if filteredItems.count != items.count {
            assertionFailure()
            return
        }
#endif

        var snapshot = NSDiffableDataSourceSnapshot<Int, Item>()
        snapshot.appendSections([0])
        snapshot.appendItems(filteredItems, toSection: 0)

        self.dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func cellProvider(tableView: UITableView, indexPath: IndexPath, item: Item) -> UITableViewCell? {
        switch item {
        case .personal(let model):
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: PersonalTableViewCell.self)
            cell.setData(model)
            return cell
        case .addChild(let model):
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: AddChildTableViewCell.self)
            cell.setData(model)
            return cell
        case .child(let model):
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: ChildTableViewCell.self)
            cell.setData(model)
            return cell
        case .delete(let model):
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: DeleteTableViewCell.self)
            cell.setData(model)
            return cell
        }
    }
}

fileprivate extension UITableView {
    func register<T: UITableViewCell>(cellType: T.Type) {
        register(T.self, forCellReuseIdentifier: "\(T.self)")
    }

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, cellType: T.Type) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: "\(T.self)", for: indexPath) as? T else {
            fatalError()
        }
        return cell
    }
}
