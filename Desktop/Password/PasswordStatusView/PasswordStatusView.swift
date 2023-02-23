//
//  PasswordStatusView.swift
//  Password
//
//  Created by Vladlens Kukjans on 23/02/2023.
//

import UIKit
import Foundation

class PasswordStatusView: UIView {
    
    let lengthCriteriaView = PasswordCriteriaView(text: "8-32 characters (no spaces)")
    let uppercaseCriteriaView = PasswordCriteriaView(text: "uppercase letter (A-Z)")
    let lowerCaseCriteriaView = PasswordCriteriaView(text: "lowercase (a-z)")
    let digitCriteriaView = PasswordCriteriaView(text: "digit (0-9)")
    let specialCharacterCriteriaView = PasswordCriteriaView(text: "special character (e.g. !@#$%^)")
    
        
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .equalCentering
        return stack
    }()
    
    lazy var criteriaLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.attributedText = makeCriteriaMessage()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 200, height: 200)
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .tertiarySystemFill
        layer.cornerRadius = 10
        clipsToBounds = true
       
        addSubview(stackView)
        stackView.addArrangedSubview(lengthCriteriaView)
        stackView.addArrangedSubview(criteriaLabel)
        stackView.addArrangedSubview(uppercaseCriteriaView)
        stackView.addArrangedSubview(lowerCaseCriteriaView)
        stackView.addArrangedSubview(digitCriteriaView)
        stackView.addArrangedSubview(specialCharacterCriteriaView)
    }
    
    
    private func  makeCriteriaMessage() -> NSAttributedString {
        var plainTextAttributes = [NSAttributedString.Key: AnyObject]()
           plainTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)
           plainTextAttributes[.foregroundColor] = UIColor.secondaryLabel
           
           var boldTextAttributes = [NSAttributedString.Key: AnyObject]()
           boldTextAttributes[.foregroundColor] = UIColor.label
           boldTextAttributes[.font] = UIFont.preferredFont(forTextStyle: .subheadline)

           let attrText = NSMutableAttributedString(string: "Use at least ", attributes: plainTextAttributes)
           attrText.append(NSAttributedString(string: "3 of these 4 ", attributes: boldTextAttributes))
           attrText.append(NSAttributedString(string: "criteria when setting your password:", attributes: plainTextAttributes))

           return attrText
    }
}
  extension PasswordStatusView {
    private func setupConstraints() {
        NSLayoutConstraint.activate([
        
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16),
            
        
        ])
    }
}
