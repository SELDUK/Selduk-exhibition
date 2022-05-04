//
//  SelectBackgroundViewController.swift
//  Selduk-exhibition
//
//  Created by 권준상 on 2022/05/04.
//

import UIKit

import SnapKit

final class SelectBackgroundViewController: BaseViewController {
    
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
        layout.minimumLineSpacing = 40
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 120), collectionViewLayout: layout)
        return cv
    }()
    let popBarButton = UIBarButtonItem()
    
    private var backButtonAppearance: UIBarButtonItemAppearance = {
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.clear, .font: UIFont.systemFont(ofSize: 0.0)]

        return backButtonAppearance
    }()
    
    private var backButtonImage: UIImage? {
        return Image.arrowLeftIcon.withAlignmentRectInsets(UIEdgeInsets(top: 0.0, left: 0.0, bottom: 5.0, right: 0.0))
    }
    
    var cellImageList = [
        Image.colorWhite, Image.colorPaleYellow, Image.colorPaleLilac, Image.colorLightBlue, Image.colorEcru, Image.colorPalePink
    ]
    
    var colorList = [
        UIColor.white, UIColor.colorWithRGBHex(hex: 0xfffdde), UIColor.colorWithRGBHex(hex: 0xe6e4f2), UIColor.colorWithRGBHex(hex: 0xd8efe9), UIColor.colorWithRGBHex(hex: 0xe8f1d4), UIColor.colorWithRGBHex(hex: 0xf9d0d8)
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
            self.loadingBar.setProgress(1, animated: true)
        }
    }

}

extension SelectBackgroundViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 102, height: 102)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MakeCharacterCell", for: indexPath) as? MakeCharacterViewCell else { return UICollectionViewCell() }
        
        cell.setImage(image: cellImageList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.backgroundColor = colorList[indexPath.item]
        collectionView.backgroundColor = colorList[indexPath.item]
        setNavigationBarAppearance(color: colorList[indexPath.item])
        CharacterData.selectedBackground = colorList[indexPath.item]
    }
}

extension SelectBackgroundViewController {
    private func setProperties() {
        view.do {
            $0.backgroundColor = .white
        }
        
        popBarButton.do {
            $0.customView = popButton
            $0.customView?.translatesAutoresizingMaskIntoConstraints = false
            $0.customView?.heightAnchor.constraint(equalToConstant: 35).isActive = true
            $0.customView?.widthAnchor.constraint(equalToConstant: 25).isActive = true
        }
        
        navigationItem.do{
            $0.leftBarButtonItem = popBarButton
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
            $0.progress = 7 / 8
            $0.progressTintColor = UIColor.colorWithRGBHex(hex: 0x178900)
            $0.trackTintColor = .lightGray
        }
        
        titleLabel.do {
            $0.text = "8. BACKGROUND"
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
        
        effectImageView.do {
            $0.image = CharacterData.selectedEffect
            $0.contentMode = .scaleToFill
        }
        
        collectionView.do {
            $0.backgroundColor = .white
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
            $0.width.height.equalTo(350)
        }
        
        featureImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.height.equalTo(350)
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
            navigationController?.pushViewController(PhotoCardViewController(), animated: false)
        case popButton:
            CharacterData.selectedBackground = .white
            CharacterData.comment = nil
            navigationController?.popViewController(animated: true)
        default:
            return
        }
    }
}
