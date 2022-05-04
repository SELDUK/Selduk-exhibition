//
//  SelectShapeViewController.swift
//  Selduk-exhibition
//
//  Created by 권준상 on 2022/05/02.
//

import UIKit

final class SelectShapeViewController: UIViewController {
    
    let characterLabel = UILabel()
    let loadingBar = UIProgressView()
    let titleLabel = UILabel()
    let containerView = UIView()
    let shapeImageView = UIImageView()
    let expressionImageView = UIImageView()
    let nextButton = UIButton()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 44
        let cv = UICollectionView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 120), collectionViewLayout: layout)
        return cv
    }()
    
    var cellImageList = [Image.navyShapeCircle, Image.navyShapeCloud, Image.navyShapeSharpEar, Image.navyShapeBread, Image.navyShapeRoundEar, Image.navyShapeJjang]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        setLayouts()
        setLoadingBarAnimation()
    }
    
    private func setLoadingBarAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.loadingBar.setProgress(1 / 8, animated: true)
        }
    }
    
}

extension SelectShapeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
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
        self.shapeImageView.image = cellImageList[indexPath.item]
        CharacterData.selectedShape = cellImageList[indexPath.item]
        CharacterData.selectedShapeIndex = indexPath.item + 1
    }
}

extension SelectShapeViewController {
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
            $0.progress = 0
            $0.progressTintColor = UIColor.colorWithRGBHex(hex: 0x178900)
            $0.trackTintColor = .lightGray
        }
        
        titleLabel.do {
            $0.text = "1. SHAPE"
            $0.textColor = UIColor.black
            $0.font = .nanumPen(size: 50)
        }
        
        shapeImageView.do {
            $0.image = Image.navyShapeCircle
            $0.contentMode = .scaleToFill
        }
        
        expressionImageView.do {
            $0.image = Image.expression1
            $0.contentMode = .scaleToFill
        }
        
        collectionView.do {
            $0.register(MakeCharacterViewCell.self, forCellWithReuseIdentifier: "MakeCharacterCell")
            $0.delegate = self
            $0.dataSource = self
            $0.contentInset = UIEdgeInsets(top: 8, left: 80, bottom: 8, right: 8)
            $0.showsHorizontalScrollIndicator = false
        }
        
        nextButton.do {
            $0.setTitle("NEXT", for: .normal)
            $0.setTitleColor(.white, for: .normal)
            $0.setBackgroundColor(.black, for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 60)
            $0.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        }
        
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubviews(characterLabel, loadingBar, titleLabel, containerView, collectionView, nextButton)
        containerView.addSubview(shapeImageView)
        shapeImageView.addSubview(expressionImageView)
        shapeImageView.bringSubviewToFront(expressionImageView)
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
        
        expressionImageView.snp.makeConstraints {
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
            let selectColorViewController = SelectColorViewController()
            navigationController?.pushViewController(selectColorViewController, animated: false)
        default:
            return
        }
    }
}
