//
//  MainPresenter.swift
//  TestTask
//
//  Created by mac on 26.07.2023.
//

import Foundation
import UIKit

protocol MainPresenterProtocol: AnyObject {
    func setItems(_ items: [MainTableAdapter.Item])
    func showActionSheet(_ actionSheet: UIAlertController)
}

class MainPresenter {
    unowned private var view: MainPresenterProtocol!
    
    init(view: MainPresenterProtocol) {
        self.view = view
    }
    
    private var personalModel = Person()
    private var childrenModels = [Person]()
    
    func makeItems() {
        var items: [MainTableAdapter.Item] = [
            .personal(makePersonalModel(self.personalModel)),
            .addChild(makeAddChildModel())
        ]

        for (index, element) in childrenModels.enumerated() {
            items.append(.child(makeChildModel(element, index: index)))
        }
        
        if !childrenModels.isEmpty {
            items.append(.delete(makeDeleteModel()))
        }
        
        view.setItems(items)
    }
}

//  MARK: Child logic
private extension MainPresenter {
    func addChild() {
        childrenModels.append(Person())
        makeItems()
    }
    
    func removeChild(at index: Int) {
        childrenModels.remove(at: index)
        makeItems()
    }
    
    func removeAllChild() {
        self.personalModel = Person()
        self.childrenModels.removeAll()
        self.makeItems()
    }
}

//  MARK: Make Items
private extension MainPresenter {
    func makePersonalModel(_ person: Person) -> PersonalTableViewCell.Model {
        return .init(person: person) { [unowned self] name in
            self.personalModel.name = name
        } didUpdateAge: { [unowned self] age in
            self.personalModel.age = age
        }
    }
    
    func makeAddChildModel() -> AddChildTableViewCell.Model {
        return .init(addChildButtonIsHidden: childrenModels.count >= 5) { [unowned self] in
            self.addChild()
        }
    }
    
    func makeChildModel(_ person: Person, index: Int) -> ChildTableViewCell.Model {
        return .init(person: person) { [unowned self] name in
            self.childrenModels[index].name = name
        } didUpdateAge: { [unowned self] age in
            self.childrenModels[index].age = age
        } didTapDelete: { [unowned self] in
            self.removeChild(at: index)
        }
    }
    
    func makeDeleteModel() -> DeleteTableViewCell.Model {
        return .init { [unowned self] in
            let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            actionSheet.addAction(.init(title: "Отменить", style: .cancel))
            actionSheet.addAction(.init(title: "Cбросить данные", style: .default, handler: { _ in
                self.removeAllChild()
            }))
            self.view.showActionSheet(actionSheet)
        }
    }
}


