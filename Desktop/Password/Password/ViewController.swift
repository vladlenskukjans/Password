//
//  ViewController.swift
//  Password
//
//  Created by Vladlens Kukjans on 22/02/2023.
//

import UIKit

class ViewController: UIViewController {
    
    var alert: UIAlertController? // for tests
    
    typealias CustomValidation = PasswordLoginView.CustomValidation
    
    let newPasswordTextField = PasswordLoginView(placeHolderText: "New password")
    let statusView = PasswordStatusView()
    let confirmPasswordTextField = PasswordLoginView(placeHolderText: "Re-enter new password")
    
    lazy var resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.configuration = .filled()
        button.setTitle("Resset password", for: .normal)
        button.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 20
        //stackView.backgroundColor = .systemBlue
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        view.addSubview(stackView)
        stackView.addArrangedSubview(newPasswordTextField)
        // stackView.addArrangedSubview(passwordCriteriaView)
        stackView.addArrangedSubview(statusView)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(resetButton)
        newPasswordTextField.delegate = self
        setupConstaints()
        setup()
    }
    
    private func setup() {
        setupDismissKeyboardGesture()
        setupNewPassword()
        setupConfirmPassword()
        setupKeyboardHiding()
    }
    
    // typealias CustomValidation = (_ textValue: String?) -> (Bool, String)?

    private func setupNewPassword() {
        let newPasswordValidation: CustomValidation = { text in
            
            // Empty text
            guard let text = text, !text.isEmpty else {
                self.statusView.reset()
                return (false, "Enter your password")
            }
            
            // Valid characters
            let validChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,@:?!()$\\/#"
            let invalidSet = CharacterSet(charactersIn: validChars).inverted
            guard text.rangeOfCharacter(from: invalidSet) == nil else {
                self.statusView.reset()
                return (false, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
            }
            
            // Criteria met
                   self.statusView.updateDisplay(text)
                   if !self.statusView.validate(text) {
                       return (false, "Your password must meet the requirements below")
                   }
        
            return (true, "")
        }
        
        newPasswordTextField.customValidation = newPasswordValidation
        newPasswordTextField.delegate = self
    }
    
    private func setupConfirmPassword() {
        let confirmPasswordValidation: CustomValidation = { text in
            guard let text = text, !text.isEmpty else {
                return (false, "Enter your password.")
            }

            guard text == self.newPasswordTextField.text else {
                return (false, "Passwords do not match.")
            }

            return (true, "")
        }

        confirmPasswordTextField.customValidation = confirmPasswordValidation
        confirmPasswordTextField.delegate = self
    }
        
    private func  setupDismissKeyboardGesture() {
        let dismissKeyboardTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    @objc func viewTapped() {
        view.endEditing(true) // resign firs responder
    }
    
    private func setupKeyboardHiding() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
}

extension ViewController {
    private func setupConstaints() {
        NSLayoutConstraint.activate([
            
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
}

//MARK: - PsswordTextFiedDelegate
extension ViewController: LoginViewTextFieldDelegate {
    
    func editingDidEnd(_ sender: PasswordLoginView) {
        if sender === newPasswordTextField {
            // as soon as we lose focus, make ❌ appear
            statusView.shouldResetCriteria = false 
            _ = newPasswordTextField.validate()
        } else if sender === confirmPasswordTextField {
            _ = confirmPasswordTextField.validate()
        }
    }
    
    func editingChanged(_ sender: PasswordLoginView) {
        if sender === newPasswordTextField {
            statusView.updateDisplay(sender.passwordTextField1.text ?? "")
        }
    }
}
// MARK: Keyboard Interaction (up and down)
extension ViewController {
    
    @objc func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else { return }
        
      //  print("foo - userInfo: \(userInfo)")
       // print("foo - keyboardFrame: \(keyboardFrame)")
      //  print("foo - currentTextField: \(currentTextField)")
        
        // check if the top of the keyboard is above the bottom of the currently focused textbox
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height

        // if textField bottom is below keyboard bottom - bump the frame up
        if textFieldBottomY > keyboardTopY {
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY / 2) * -1
            view.frame.origin.y = newFrameY
        }
            
       // print("foo - currentTextFieldFrame: \(currentTextField.frame)")
       // print("foo - convertedTextFieldFrame: \(convertedTextFieldFrame)")
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}

// MARK: Actions
extension ViewController {

    @objc func resetPasswordButtonTapped(sender: UIButton) {
        view.endEditing(true)

        let isValidNewPassword = newPasswordTextField.validate()
        let isValidConfirmPassword = confirmPasswordTextField.validate()

        if isValidNewPassword && isValidConfirmPassword {
            showAlert(title: "Success", message: "You have successfully changed your password.")
        }
    }
    private func showAlert(title: String, message: String) {
         alert =  UIAlertController(title: "", message: "", preferredStyle: .alert)
        guard let alert = alert else { return }
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))

        alert.title = title
        alert.message = message
        present(alert, animated: true, completion: nil)
    }
}
// MARK: Tests
extension ViewController {
    var newPasswordText: String? {
        get { return newPasswordTextField.text }
        set { newPasswordTextField.text = newValue}
    }
    
    var confirmPasswordText: String? {
        get { return confirmPasswordTextField.text }
        set { confirmPasswordTextField.text = newValue}
    }
}
