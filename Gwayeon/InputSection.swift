//
//  InputSection.swift
//  Gwayeon
//
//  Created by 이윤영 on 2022/07/20.
//

import UIKit

enum InputStyle {
    case fruitCategory
    case fruitVariety
    case farmName
    case farmNumber
    case recommendation
    
    var text: String {
        switch self {
        case .fruitCategory:
            return "과일"
        case .fruitVariety:
            return "품종"
        case .farmName:
            return "농장 이름"
        case .farmNumber:
            return "농장 번호"
        case .recommendation:
            return "추천 한마디"
        }
    }
    
    var placeholder: String {
        switch self {
        case .fruitCategory:
            return "과일을 입력해주세요."
        case .fruitVariety:
            return "품종을 입력해주세요."
        case .farmName:
            return "농장 이름을 입력해주세요."
        case .farmNumber:
            return "농장 번호를 입력해주세요."
        case .recommendation:
            return "가격, 맛, 배송에 대한 정보를 알려주면\n내 친구들이 더 쉽게 살 수 있어요."
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .fruitCategory, .fruitVariety, .farmName, .recommendation:
            return UIKeyboardType.default
        case .farmNumber:
            return UIKeyboardType.numberPad
        }
    }
}

final class InputSection: UIStackView {
    let style: InputStyle
    
    private lazy var label: UILabel = {
        let label = UILabel()
        label.text = style.text
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()
    
    // TODO: 겹치는 스타일 Extension으로 변경
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = style.placeholder
        textField.borderStyle = .roundedRect
        textField.clearButtonMode = .whileEditing
        textField.returnKeyType = .done
        textField.keyboardType = style.keyboardType
        textField.returnKeyType = .done
        return textField
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.delegate = self
        textView.textColor = UIColor.placeholderText
        textView.text = style.placeholder
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.adjustsFontForContentSizeCategory = true
        textView.isScrollEnabled = false
        textView.layer.cornerRadius = 5
        textView.layer.backgroundColor = UIColor.systemGray6.cgColor
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.layer.borderWidth = 0.5
        textView.clipsToBounds = true
        textView.isScrollEnabled = true
        textView.spellCheckingType = .no
        textView.keyboardType = style.keyboardType
        
        return textView
    }()
    
    init(frame: CGRect, style: InputStyle) {
        self.style = style
        super.init(frame: frame)
        self.setUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        axis = .vertical
        alignment = .fill
        spacing = 8
        
        addArrangedSubview(label)
        if style == .recommendation {
            addArrangedSubview(textView)
            NSLayoutConstraint.activate([
                textView.heightAnchor.constraint(equalToConstant: 130)
            ])
        } else {
            addArrangedSubview(textField)
        }
    }
    
    @discardableResult
    override func becomeFirstResponder() -> Bool {
        super.becomeFirstResponder()
        return self.textField.becomeFirstResponder()
    }
    
    @discardableResult
    override func resignFirstResponder() -> Bool {
        super.resignFirstResponder()
        return self.textField.resignFirstResponder()
    }
}

// TODO: Extension 폴더 분리
extension UIStackView: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == InputStyle.recommendation.placeholder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    public func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = InputStyle.recommendation.placeholder
            textView.textColor = .placeholderText
        }
    }
}
