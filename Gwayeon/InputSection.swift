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
    
    private (set) lazy var label: UILabel = {
        let label = UILabel()
        label.text = style.text
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return label
    }()

    private (set) lazy var textField: InputSectionTextField = {
        let textField = InputSectionTextField()
        textField.delegate = self
        textField.placeholder = style.placeholder
        textField.keyboardType = style.keyboardType
        return textField
    }()
    
    private (set) lazy var textView: InputSectionTextView = {
        let textView = InputSectionTextView()
        textView.delegate = self
        textView.text = style.placeholder
        textView.keyboardType = style.keyboardType
        return textView
    }()
    
    var startEditingAction: (() -> Void)?
    var endEditingAction: (() -> Void)?
    var returnAction: (() -> Void)?
    
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
        switch style {
        case .fruitCategory:
            textField.isCategory = true
            addArrangedSubview(textField)
        case .fruitVariety, .farmName:
            addArrangedSubview(textField)
        case .farmNumber:
            addArrangedSubview(textField)
            textField.addTarget(self, action: #selector(checkNumberLength(textField:)), for: .editingChanged)
        case .recommendation:
            addArrangedSubview(textView)
            textView.heightAnchor.constraint(equalToConstant: 130).isActive = true
        }
    }
    
    func setTextFieldItem(_ item: String) {
        textField.attributedPlaceholder = NSAttributedString(string: item, attributes: [.foregroundColor: UIColor.black])
    }
}

extension InputSection {
    class InputSectionTextField: UITextField {
        var isCategory: Bool = false {
            didSet {
                isUserInteractionEnabled = false
                rightView = downImage
                rightViewMode = .always
            }
        }
        
        private lazy var downImage: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(systemName: "chevron.down")
            imageView.tintColor = UIColor.placeholderText
            return imageView
        }()
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            setUI()
        }

        required init?(coder: NSCoder) {
            fatalError("not implement required init?(coder: NSCoder)")
        }
        
        private func setUI() {
            borderStyle = .roundedRect
            clearButtonMode = .whileEditing
            returnKeyType = .done
        }

        override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
            var padding = super.rightViewRect(forBounds: bounds)
            padding.origin.x -= 8
            return padding
        }
    }
    
    class InputSectionTextView: UITextView {
        override init(frame: CGRect, textContainer: NSTextContainer?) {
            super.init(frame: frame, textContainer: textContainer)
            setUI()
        }

        required init?(coder: NSCoder) {
            fatalError("not implement required init?(coder: NSCoder)")
        }
        
        private func setUI() {
            textColor = UIColor.placeholderText
            font = UIFont.preferredFont(forTextStyle: .body)
            adjustsFontForContentSizeCategory = true
            layer.cornerRadius = 5
            layer.backgroundColor = UIColor.systemGray6.cgColor
            layer.borderColor = UIColor.systemGray5.cgColor
            layer.borderWidth = 0.5
            isScrollEnabled = true
            spellCheckingType = .no
        }
    }
}

extension InputSection: UITextViewDelegate, UITextFieldDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == InputStyle.recommendation.placeholder {
            textView.text = nil
            textView.textColor = .black
        }
        startEditingAction?()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = InputStyle.recommendation.placeholder
            textView.textColor = .placeholderText
        }
        endEditingAction?()
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        startEditingAction?()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        endEditingAction?()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        returnAction?()
        return true
    }
    
    @objc final private func checkNumberLength(textField: UITextField) {
        if self.textField.text?.count == 11 {
            returnAction?()
        }
    }
}
