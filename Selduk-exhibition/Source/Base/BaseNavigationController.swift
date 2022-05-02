//
//  BaseNavigationController.swift
//  Selduk-exhibition
//
//  Created by 권준상 on 2022/05/02.
//

import UIKit


public class BaseNavigationController: UINavigationController {
    
    //  MARK: - 외부에서 지정할 수 있는 속성
    
    public override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    private func setupView() {
        setProperties()
    }
    
    private func setProperties() {
        setNavigationBarAppearance()
    }
    
    private var backButtonAppearance: UIBarButtonItemAppearance = {
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear, .font: UIFont.systemFont(ofSize: 0.0)]

        return backButtonAppearance
    }()
    
    private var backButtonImage: UIImage? {
        return Image.arrowLeftIcon.withAlignmentRectInsets(UIEdgeInsets(top: 0.0, left: 0.0, bottom: 5.0, right: 0.0))
    }
    
    private func setNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.setBackIndicatorImage(backButtonImage,
                                         transitionMaskImage: backButtonImage)
        appearance.shadowColor = nil
        appearance.backButtonAppearance = backButtonAppearance
        
        navigationBar.tintColor = UIColor.black
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
        navigationBar.compactAppearance = appearance
    }

    private lazy var fullWidthBackGestureRecognizer = UIPanGestureRecognizer()
}


extension BaseNavigationController {
    
    /**
     ViewController가 Push될 때
     count가 1이라면(=root밖에 없다면) 굵은 titleLabel을 세팅합니다.
     count가 1이 아니라면(=root 이외에 다른게 있다면) backBarButtonItem을 초기화하여
     backButton 옆에 상위 viewController의 title이 나타나지 않도록 합니다.
     */
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        setNavigationBarAppearance()
    }
    
    public override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
}
