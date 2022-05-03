//
//  SelectEffectViewController.swift
//  Selduk-exhibition
//
//  Created by 권준상 on 2022/05/03.
//

import UIKit

import SnapKit

final class SelectEffectViewController: UIViewController {
    
    let characterLabel = UILabel()
    let loadingBar = UIProgressView()
    let titleLabel = UILabel()
    let containerView = UIView()
    let shapeImageView = UIImageView()
    let expressionImageView = UIImageView()
    let featureImageView = UIImageView()
    let effectImageView = UIImageView()
    let nextButton = UIButton()
    let popButton = UIButton()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 44
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 120), collectionViewLayout: layout)
        return cv
    }()
    
    var cellImageList = [
        Image.effectBar1, Image.effectBar2, Image.effectBar3, Image.effectBar4, Image.effectBar5, Image.effectBar6, Image.effectBar7, Image.effectBar8, Image.effectBar9, Image.effectBar10, Image.effectBar11
    ]
    
    var effectImageList = [
        Image.effect1, Image.effect2, Image.effect3, Image.effect4, Image.effect5, Image.effect6, Image.effect7, Image.effect8, Image.effect9, Image.effect10, Image.effect11
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        setLayouts()
        registerTarget()
        setLoadingBarAnimation()
    }
    
    private func registerTarget() {
        [nextButton, popButton].forEach {
            $0.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        }
    }
    
    private func setLoadingBarAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.loadingBar.setProgress(5 / 8, animated: true)
        }
    }

}

extension SelectEffectViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 102, height: 102)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 11
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MakeCharacterCell", for: indexPath) as? MakeCharacterViewCell else { return UICollectionViewCell() }
        
        cell.setImage(image: cellImageList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.effectImageView.image = effectImageList[indexPath.item]
        CharacterData.selectedEffect = effectImageList[indexPath.item]
    }
}

extension SelectEffectViewController {
    private func setProperties() {
        view.do {
            $0.backgroundColor = .white
        }
        
        characterLabel.do {
            $0.text = "MY CHARACTER"
            $0.font = .nanumPen(size: 60)
        }
        
        loadingBar.do {
            $0.layer.cornerRadius = 8.5
            $0.clipsToBounds = true
            $0.layer.sublayers![1].cornerRadius = 8.5
            $0.subviews[1].clipsToBounds = true
            $0.progress = 1 / 2
            $0.progressTintColor = UIColor.colorWithRGBHex(hex: 0x178900)
            $0.trackTintColor = .lightGray
        }
        
        titleLabel.do {
            $0.text = "5. EFFECT"
            $0.textColor = UIColor.black
            $0.font = .nanumPen(size: 50)
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
        
        collectionView.do {
            $0.register(MakeCharacterViewCell.self, forCellWithReuseIdentifier: "MakeCharacterCell")
            $0.delegate = self
            $0.dataSource = self
            $0.contentInset = UIEdgeInsets(top: 8, left: 80, bottom: 8, right: 80)
            $0.showsHorizontalScrollIndicator = false
        }
        
        nextButton.do {
            $0.setTitle("NEXT", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.setBackgroundColor(.black, for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 60)
        }
        
        popButton.do {
            $0.setImage(Image.arrowLeftIcon, for: .normal)
        }
        
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubviews(characterLabel, loadingBar, titleLabel, containerView, collectionView, nextButton)
        containerView.addSubviews(shapeImageView, expressionImageView, featureImageView, effectImageView)
        effectImageView.bringSubviewToFront(shapeImageView)
        shapeImageView.bringSubviewToFront(expressionImageView)
        expressionImageView.bringSubviewToFront(featureImageView)
    }
    
    private func setConstraints() {
        let safeArea = view.safeAreaLayoutGuide

        characterLabel.snp.makeConstraints {
            $0.top.equalTo(safeArea)
            $0.centerX.equalToSuperview()
        }
        
        loadingBar.snp.makeConstraints {
            $0.top.equalTo(characterLabel.snp.bottom).offset(54)
            $0.leading.trailing.equalToSuperview().inset(80)
            $0.height.equalTo(25)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(loadingBar.snp.bottom).offset(50)
            $0.centerX.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(collectionView.snp.top)
        }
        
        shapeImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(350)
        }
        
        effectImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(350)
        }
        
        expressionImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(100)
        }
        
        featureImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(50)
        }
        
        collectionView.snp.makeConstraints {
            $0.leading.trailing.equalTo(safeArea)
            $0.bottom.equalTo(nextButton.snp.top).offset(-80)
            $0.height.equalTo(120)
        }
        
        nextButton.snp.makeConstraints {
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalTo(safeArea)
            $0.height.equalTo(140)
        }
    }
    
    @objc private func buttonTapAction(_ sender: UIButton) {
        switch sender {
        case nextButton:
            let selectEffectViewController = SelectEffectViewController()
            navigationController?.pushViewController(selectEffectViewController, animated: false)
        case popButton:
            navigationController?.popViewController(animated: true)
        default:
            return
        }
    }
}
