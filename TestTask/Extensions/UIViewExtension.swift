//
//  UIViewExtension.swift
//  TestTask
//
//  Created by mac on 26.07.2023.
//

import UIKit.UIView

extension UIView {
    func fillContainer(_ container: UIView,
                       leading: CGFloat? = nil,
                       top: CGFloat? = nil,
                       trailing: CGFloat? = nil,
                       bottom: CGFloat? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false

        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: leading).isActive = true
        }

        if let top = top {
            self.topAnchor.constraint(equalTo: container.topAnchor, constant: top).isActive = true
        }

        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -trailing).isActive = true
        }

        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -bottom).isActive = true
        }
    }

    func fillContainerSafeArea(_ container: UIView,
                       leading: CGFloat? = nil,
                       top: CGFloat? = nil,
                       trailing: CGFloat? = nil,
                       bottom: CGFloat? = nil) {
        self.translatesAutoresizingMaskIntoConstraints = false

        if let leading = leading {
            self.leadingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.leadingAnchor, constant: leading).isActive = true
        }

        if let top = top {
            self.topAnchor.constraint(equalTo: container.safeAreaLayoutGuide.topAnchor, constant: top).isActive = true
        }

        if let trailing = trailing {
            self.trailingAnchor.constraint(equalTo: container.safeAreaLayoutGuide.trailingAnchor, constant: -trailing).isActive = true
        }

        if let bottom = bottom {
            self.bottomAnchor.constraint(equalTo: container.safeAreaLayoutGuide.bottomAnchor, constant: -bottom).isActive = true
        }
    }

    func fillSuperviewSafeArea(leading: CGFloat? = nil,
                       top: CGFloat? = nil,
                       trailing: CGFloat? = nil,
                       bottom: CGFloat? = nil) {
        guard let superview = self.superview else {
            assertionFailure("The view must be added to view hierarchy")
            return
        }

        self.fillContainerSafeArea(superview, leading: leading, top: top, trailing: trailing, bottom: bottom)
    }

    func fillSuperview(leading: CGFloat? = nil,
                       top: CGFloat? = nil,
                       trailing: CGFloat? = nil,
                       bottom: CGFloat? = nil) {
        guard let superview = self.superview else {
            assertionFailure("The view must be added to view hierarchy")
            return
        }

        self.fillContainer(superview, leading: leading, top: top, trailing: trailing, bottom: bottom)
    }
}
