//
//  ViewController.swift
//  Password
//
//  Created by Vladlens Kukjans on 22/02/2023.
//

import UIKit

class ViewController: UIViewController {
    
    let passwordLoginView = LoginView(placeHolderText: "New password")
   // let passwordCriteriaView = PasswordCriteriaView()
    let statusView = PasswordStatusView()
    let confirmPasswordTextField = LoginView(placeHolderText: "Re-enter new password")
    
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
       stackView.addArrangedSubview(passwordLoginView)
       // stackView.addArrangedSubview(passwordCriteriaView)
        stackView.addArrangedSubview(statusView)
        stackView.addArrangedSubview(confirmPasswordTextField)
        stackView.addArrangedSubview(resetButton)
        
        setupConstaints()
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
       // passwordLoginView.layer.cornerRadius = 10
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
