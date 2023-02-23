//
//  PasswordCriteriaView.swift
//  Password
//
//  Created by Vladlens Kukjans on 23/02/2023.
//

import UIKit

class PasswordCriteriaView: UIView {
    
  
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.spacing = 8
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
      //stack.backgroundColor = .systemBlue
        return stack
    }()
    
    
  let imageView: UIImageView = {
        let image = UIImageView()
      image.image = UIImage(systemName: "circle")?.withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
 let labelView: UILabel = {
        let label = UILabel()
        label.text = "uppercase letter (A-Z)"
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
         setupView()
        setConstraints()
    }
    
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
         stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(labelView)
          //backgroundColor = .systemOrange
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 40)
        
    }
    
    
    
}
extension PasswordCriteriaView {
    func setConstraints() {
        NSLayoutConstraint.activate([

            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
    }
}
