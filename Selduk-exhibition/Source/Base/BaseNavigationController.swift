//
//  BaseNavigationController.swift
//  Selduk-exhibition
//
//  Created by 권준상 on 2022/05/04.
//

import UIKit


public class BaseNavigationController: UINavigationController {
        
    public override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
    }
    
    private func setProperties() {
        setNavigationBarAppearance()
    }
    
    private func setNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = nil
        
        navigationBar.tintColor = UIColor.black
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
    }

}


extension BaseNavigationController {
    
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        setNavigationBarAppearance()
    }
}
