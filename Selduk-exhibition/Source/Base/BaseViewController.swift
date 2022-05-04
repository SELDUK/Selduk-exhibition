//
//  BaseViewController.swift
//  Selduk-exhibition
//
//  Created by 권준상 on 2022/05/04.
//

import UIKit

class BaseViewController: UIViewController {
    
//    private var backButtonAppearance: UIBarButtonItemAppearance = {
//        let backButtonAppearance = UIBarButtonItemAppearance()
//        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear, .font: UIFont.systemFont(ofSize: 0.0)]
//
//        return backButtonAppearance
//    }()
//
//    private var backButtonImage: UIImage? {
//        return Image.arrowLeftIcon.withAlignmentRectInsets(UIEdgeInsets(top: 0.0, left: 0.0, bottom: 5.0, right: 0.0))
//    }
    
    func showToastMessageAlert(message: String) {
        let alert = UIAlertController(title: message,
                                      message: "",
                                      preferredStyle: .alert)
        
        present(alert, animated: true, completion: nil)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.0) {
            alert.dismiss(animated: true)
        }
    }
    
    func setNavigationBarAppearance(color: UIColor = UIColor.white) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = color
        appearance.shadowColor = nil

//        appearance.setBackIndicatorImage(backButtonImage,
//                                         transitionMaskImage: backButtonImage)
//        appearance.backButtonAppearance = backButtonAppearance
        
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }
    
}
