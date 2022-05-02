//
//  ViewController.swift
//  Selduk-exhibition
//
//  Created by 권준상 on 2022/05/02.
//

import UIKit

import SnapKit
import Then

class StartViewController: UIViewController {

    let logoView = UIView()
    let logoGIFImageView = UIImageView(image: Image.logoGIF)
    let seldukImageView = UIImageView(image: Image.selduk)
    let startButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        setLayouts()
    }

}

extension StartViewController {
    private func setProperties() {
        view.do {
            $0.backgroundColor = .white
        }
        
        startButton.do {
            $0.setTitle("START", for: .normal)
            $0.titleLabel?.font = .nanumPen(size: 60)
            $0.setTitleColor(.white, for: .normal)
            $0.setBackgroundColor(.black, for: .normal)
            $0.addTarget(self, action: #selector(startButtonDidTap), for: .touchUpInside)
        }
    }
    
    private func setLayouts() {
        setViewHierarchy()
        setConstraints()
    }
    
    private func setViewHierarchy() {
        view.addSubviews(logoView, startButton)
        logoView.addSubviews(logoGIFImageView, seldukImageView)
    }
    
    private func setConstraints() {
        
        logoView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().offset(370)
            $0.width.equalTo(233)
            $0.height.equalTo(239)
        }
        
        logoGIFImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(151)
            $0.height.equalTo(145)
        }
        
        seldukImageView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.equalTo(233)
            $0.height.equalTo(66)
        }
        
        startButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(140)
        }
    }
    
    @objc func startButtonDidTap() {
        navigationController?.pushViewController(SelectShapeViewController(), animated: true)
    }
}
