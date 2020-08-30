//
//  FNavigationController.swift
//  follower
//
//  Created by Luke Wakeford on 28/08/2020.
//

import UIKit

protocol HidesNavBar {}

class FNavigationController:UINavigationController, UINavigationControllerDelegate {
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        self.delegate = self
        self.navigationBar.barStyle = .blackOpaque
        self.navigationBar.tintColor = .white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        self.setNavigationBarHidden(
            viewController is HidesNavBar,
            animated: true
        )
    }
    
}
