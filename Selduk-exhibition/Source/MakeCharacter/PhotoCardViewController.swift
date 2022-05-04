//
//  PhotoCardViewController.swift
//  Selduk-exhibition
//
//  Created by 권준상 on 2022/05/04.
//

import UIKit

import SnapKit
import Lottie

final class PhotoCardViewController: BaseViewController {
    
    let todayLabel = UILabel()
    let nicknameButton = UIButton()
    let containerView = UIView()
    let shapeImageView = UIImageView()
    let expressionImageView = UIImageView()
    let featureImageView = UIImageView()
    let effectImageView = UIImageView()
    let commentLabel = UILabel()
    let animationView = AnimationView(name: "confetti")
    
    let monthAndDayFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        dateFormatter.locale = Locale(identifier: "en_US")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        return dateFormatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        setLayouts()
        registerTarget()
        setAnimation()
        setNavigationBarAppearance()
    }
    
    private func registerTarget() {
        nicknameButton.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
    }
    
    private func setAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animationView.contentMode = .scaleAspectFill
            self.animationView.frame = self.view.bounds
            self.animationView.play()
            self.animationView.loopMode = .playOnce
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            self.animationView.removeFromSuperview()
        }
        
    }
    
    private func setNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = CharacterData.selectedBackground
        appearance.shadowColor = nil
        
        navigationController?.navigationBar.tintColor = UIColor.black
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
    }

}

extension PhotoCardViewController {
    private func setProperties() {
                
        view.do {
            $0.backgroundColor = CharacterData.selectedBackground
        }
        
        navigationItem.do {
            $0.hidesBackButton = true
        }
        
        todayLabel.do {
            $0.text = monthAndDayFormatter.string(from: Date()).uppercased()
            $0.font = .nanumPen(size: 59)
        }
        
        nicknameButton.do {
            $0.setTitle(CharacterData.nickname, for: .normal)
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 90)
        }
        
        shapeImageView.do {
            $0.image = CharacterData.selectedColorWithShape
            $0.contentMode = .scaleToFill
        }
        
        expressionImageView.do {
            $0.image = CharacterData.selectedExpression
            $0.contentMode = .scaleToFill
        }
        
        featureImageView.do {
            $0.image = CharacterData.selectedFeature
            $0.contentMode = .scaleToFill
        }
        
        effectImageView.do {
            $0.image = CharacterData.selectedEffect
            $0.contentMode = .scaleToFill
        }
        
        commentLabel.do {
            $0.text = "\"\(CharacterData.comment ?? "")\""
            $0.font = .nanumPen(size: 50)
            $0.lineBreakMode = .byWordWrapping
            $0.numberOfLines = 0
            $0.textAlignment = .center
        }
        
        
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubviews(todayLabel, nicknameButton, containerView, commentLabel, animationView)
        containerView.addSubviews(shapeImageView, expressionImageView, featureImageView, effectImageView)
        effectImageView.bringSubviewToFront(shapeImageView)
        shapeImageView.bringSubviewToFront(expressionImageView)
        expressionImageView.bringSubviewToFront(featureImageView)
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        todayLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea).offset(50)
            $0.centerX.equalToSuperview()
        }
        
        nicknameButton.snp.makeConstraints {
            $0.top.equalTo(todayLabel.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(nicknameButton.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(commentLabel.snp.top)
        }
        
        shapeImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(400)
        }
        
        effectImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(400)
        }
        
        expressionImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(400)
        }
        
        featureImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(400)
        }
        
        commentLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(110)
            $0.bottom.equalToSuperview().offset(-120)
        }
        
    }
    
    @objc private func buttonTapAction(_ sender: UIButton) {
        switch sender {
        case nicknameButton:
            CharacterData.selectedBackground = .white
            CharacterData.selectedEffect = nil
            CharacterData.selectedShape = Image.navyShapeCircle
            CharacterData.selectedFeature = nil
            CharacterData.selectedExpression = Image.expression1
            CharacterData.selectedShapeIndex = 1
            CharacterData.selectedColorWithShape = CharacterData.colorShapeImageList[0][0]
            CharacterData.nickname = nil
            CharacterData.comment = nil
            navigationController?.popToRootViewController(animated: true)
        default:
            return
        }
    }
}
