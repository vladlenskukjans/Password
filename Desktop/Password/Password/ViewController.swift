//
//  ViewController.swift
//  Password
//
//  Created by Vladlens Kukjans on 22/02/2023.
//

import UIKit

class ViewController: UIViewController {
  
        
    let newPasswordTextField = PasswordLoginView(placeHolderText: "New password")
   // let passwordCriteriaView = PasswordCriteriaView()
    let statusView = PasswordStatusView()
    let confirmPasswordTextField = PasswordLoginView(placeHolderText: "Re-enter new password")
    
    let resetButton: UIButton = {
        let button = UIButton(type: .system)
        button.configuration = .filled()
        button.setTitle("Resset password", for: .normal)
       // button.addTarget(self, action: #selector(resetPasswordButtonTapped), for: .primaryActionTriggered)
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
    func editingChanged(_ sender: PasswordLoginView) {
        if sender === newPasswordTextField {
            statusView.updateDisplay(sender.passwordTextField1.text ?? "")
        }
    }
}
