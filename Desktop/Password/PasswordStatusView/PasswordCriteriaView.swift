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
    
    var imageView: UIImageView = {
          let image = UIImageView()
         //image.image = UIImage(systemName: "checkmark.circle")!.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
          image.translatesAutoresizingMaskIntoConstraints = false
          return image
      }()
    
    let checkmarkImage = UIImage(systemName: "checkmark.circle")!.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
    let xmarkImage = UIImage(systemName: "xmark.circle")!.withTintColor(.systemRed, renderingMode: .alwaysOriginal)
    let circleImage = UIImage(systemName: "circle")!.withTintColor(.tertiaryLabel, renderingMode: .alwaysOriginal)


    var isCriteriaMet: Bool = false {
        didSet {
            if isCriteriaMet {
                imageView.image = checkmarkImage
            } else {
                imageView.image = xmarkImage
            }
        }
    }

    func reset() {
        isCriteriaMet = false
        imageView.image = circleImage
    }

    
    let textLabel: UILabel = {
        let label = UILabel()
       // label.text = "uppercase letter (A-Z)"
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init(text: String) {
        textLabel.text = text
        super.init(frame: .zero)
        setupView()
       setConstraints()
        reset()
    }
        
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
         stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(textLabel)
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
            
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),
            
           
        ])
    }
}
