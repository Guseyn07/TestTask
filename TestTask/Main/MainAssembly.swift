//
//  MainAssembly.swift
//  TestTask
//
//  Created by mac on 27.07.2023.
//

import UIKit

enum MainAssembly {
    static func makeModule() -> UIViewController {
        let viewController = MainViewController()
        let presenter = MainPresenter(view: viewController)
        viewController.presenter = presenter
        return viewController
    }
}
