//
//  PasswordLoginView.swift
//  Password
//
//  Created by Vladlens Kukjans on 22/02/2023.
//

import UIKit


protocol LoginViewTextFieldDelegate: AnyObject {
    func editingChanged(_ sender: PasswordLoginView)
    func editingDidEnd(_ sender: PasswordLoginView)
}

class PasswordLoginView: UIView {
    
    /**
        A function one passes in to do custom validation on the text field.

        - Parameter: textValue: The value of text to validate
        - Returns: A Bool indicating whether text is valid, and if not a String containing an error message
        */
       typealias CustomValidation = (_ textValue: String?) -> (Bool, String)?

    
    var customValidation: CustomValidation?
    weak var  delegate: LoginViewTextFieldDelegate?
    var placeHolderText: String
    
    var text: String? {
        get { return passwordTextField1.text }
        set {  passwordTextField1.text = newValue }
    }
    
    let lockImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "lock.fill"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
       // imageView.tintColor = .systemRed
        return imageView
    }()
    
    lazy var eyeButtonView: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye.circle"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash.circle"), for: .selected)
        button.addTarget(self, action: #selector(togglePasswordView), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
       // button.tintColor = .systemRed
        return button
    }()
    
    let errorLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .footnote)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemRed
        label.text = "Your password must meet the requirement below"
        label.isHidden = true
//        label.adjustsFontSizeToFitWidth = true
//        label.minimumScaleFactor = 0.8
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var passwordTextField1: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = false // true
        //field.clearButtonMode = .always
        field.delegate = self
        field.autocorrectionType = .no
        field.autocapitalizationType = .none
        field.keyboardType = .asciiCapable
        field.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor: UIColor.secondaryLabel])
        field.addTarget(self, action: #selector(textFieldEdetingChanged), for: .editingChanged)
        
        field.translatesAutoresizingMaskIntoConstraints = false
        //field.layer.cornerRadius = 12
        return field
    }()
    
//    let passwordTextField2: UITextField = {
//       let field = UITextField()
//        field.autocapitalizationType = .none
//        field.keyboardType = .asciiCapable
//        field.backgroundColor = .secondarySystemBackground
//       // field.placeholder = "Enter your password."
////        field.heightAnchor.constraint(equalToConstant: 50).isActive = true
////        field.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        field.translatesAutoresizingMaskIntoConstraints = false
//       // field.layer.cornerRadius = 12
//        return field
//    }()
    
    let lineDividerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .separator
        view.heightAnchor.constraint(equalToConstant: 3).isActive = true
        return view
    }()
    
    
    
    init(placeHolderText: String) {
        self.placeHolderText = placeHolderText
        super.init(frame: .zero)
        setupView()
        setConstraints()
       
    }
    
    private func setupView() {
         //backgroundColor = .systemTeal
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(lockImageView)
        addSubview(passwordTextField1)
        addSubview(eyeButtonView)
        addSubview(lineDividerView)
        addSubview(errorLabel)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 250, height: 60)
    }

}
//MARK: - Actions
extension PasswordLoginView {
    @objc func togglePasswordView() {
        passwordTextField1.isSecureTextEntry.toggle()
        eyeButtonView.isSelected.toggle()
    }
    
    @objc func textFieldEdetingChanged(_ sender: UITextField) {
        delegate?.editingChanged(self)
    }
}
//MARK: - setConstraints
extension PasswordLoginView {
    private func setConstraints() {
        NSLayoutConstraint.activate([
        
            lockImageView.centerYAnchor.constraint(equalTo: passwordTextField1.centerYAnchor),
            lockImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            passwordTextField1.leadingAnchor.constraint(equalTo: lockImageView.trailingAnchor,constant: 8),
            passwordTextField1.widthAnchor.constraint(equalToConstant: 200),
            
            eyeButtonView.centerYAnchor.constraint(equalTo: passwordTextField1.centerYAnchor),
            eyeButtonView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8),
            
            lineDividerView.topAnchor.constraint(equalTo: passwordTextField1.bottomAnchor,constant: 10),
            lineDividerView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 8),
            lineDividerView.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -8),
            
            errorLabel.topAnchor.constraint(equalTo: lineDividerView.bottomAnchor,constant: 4),
            errorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            errorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)

        ])
    }
}
//MARK: - UITextFieldDelegate
extension PasswordLoginView: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.editingDidEnd(self)
       }

       // Called when 'return' key pressed. Necessary for dismissing keyboard.
       func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           textField.endEditing(true) // resign first responder
           return true
       }
}

// typealias CustomValidation = (_ textValue: String?) -> (Bool, String)?

// MARK: - Validation
extension PasswordLoginView {
    func validate() -> Bool {
        if let customValidation = customValidation,
            let customValidationResult = customValidation(text),
            customValidationResult.0 == false {
            showError(customValidationResult.1)
            return false
        }
        clearError()
        return true
    }
    
    private func showError(_ errorMessage: String) {
        errorLabel.isHidden = false
        errorLabel.text = errorMessage
    }

    private func clearError() {
        errorLabel.isHidden = true
        errorLabel.text = ""
    }
}
