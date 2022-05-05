//
//  WriteCommentViewController.swift
//  Selduk-exhibition
//
//  Created by 권준상 on 2022/05/04.
//

import UIKit

import SnapKit

final class WriteCommentViewController: BaseViewController {
    
    let characterLabel = UILabel()
    let loadingBar = UIProgressView()
    let titleLabel = UILabel()
    let commentTextView = UITextView()
    let wordCountLabel = UILabel()
    let nextButton = UIButton()
    let popButton = UIButton()
    let popBarButton = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setProperties()
        setLayouts()
        registerTarget()
        setLoadingBarAnimation()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBarAppearance()
    }
    
    override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
        view.endEditing(true)
    }
    
    private func registerTarget() {
        [nextButton, popButton].forEach {
            $0.addTarget(self, action: #selector(buttonTapAction(_:)), for: .touchUpInside)
        }
    }
    
    private func setLoadingBarAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.loadingBar.setProgress(7 / 8, animated: true)
        }
    }

}

extension WriteCommentViewController {
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
            $0.textColor = .black
            $0.font = .nanumPen(size: 60)
        }
        
        loadingBar.do {
            $0.layer.cornerRadius = 8.5
            $0.clipsToBounds = true
            $0.layer.sublayers![1].cornerRadius = 8.5
            $0.subviews[1].clipsToBounds = true
            $0.progress = 3 / 4
            $0.progressTintColor = UIColor.colorWithRGBHex(hex: 0x178900)
            $0.trackTintColor = .lightGray
        }
        
        titleLabel.do {
            $0.text = "7. COMMENT"
            $0.textColor = UIColor.black
            $0.font = .nanumPen(size: 50)
        }
        
        commentTextView.do {
            $0.delegate = self
            $0.text = "칭찬을 작성해주세요"
            $0.backgroundColor = .white
            $0.textColor = UIColor.lightGray
            $0.font = .nanumPen(size: 35)
            $0.isScrollEnabled = false
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.black.cgColor
            $0.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
        }
        
        wordCountLabel.do {
            $0.textColor = .black
            $0.text = "0/40자"
            $0.font = .nanumPen(size: 23)
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
        view.addSubviews(characterLabel, loadingBar, titleLabel, commentTextView, wordCountLabel, nextButton)
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
        
        commentTextView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(70)
            $0.leading.trailing.equalToSuperview().inset(80)
            $0.height.equalTo(226)
        }
        
        wordCountLabel.snp.makeConstraints {
            $0.trailing.equalTo(commentTextView.snp.trailing).offset(-20)
            $0.bottom.equalTo(commentTextView.snp.bottom).offset(-25)
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
            var commentTrimText = ""
            
            if (commentTextView.textColor == UIColor.lightGray) || commentTextView.text.trimmingCharacters(in: .whitespaces).count == 0 {
                commentTextView.text = commentTextView.text.trimmingCharacters(in: .whitespaces)
                wordCountLabel.text = "0/40자"
                self.showToastMessageAlert(message: "칭찬을 작성해주세요")
                return
            } else {
                commentTrimText = commentTextView.text.trimmingCharacters(in: .whitespaces)
                CharacterData.comment = commentTrimText
                navigationController?.pushViewController(SelectBackgroundViewController(), animated: false)
            }
            
        case popButton:
            CharacterData.nickname = nil
            navigationController?.popViewController(animated: true)
        default:
            return
        }
    }
    
}

extension WriteCommentViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
      if commentTextView.textColor == UIColor.lightGray {
          commentTextView.text = nil
          commentTextView.textColor = UIColor.black
      }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
      if commentTextView.text.isEmpty {
        commentTextView.text = "칭찬을 작성해주세요"
        commentTextView.textColor = UIColor.lightGray
      }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        guard text != "\n" else { return false }
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        
        wordCountLabel.text = "\(changedText.count)/40자"
        return changedText.count <= 39
    }
    
}

