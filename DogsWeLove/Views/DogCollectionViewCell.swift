//
//  DogCollectionViewCell.swift
//  DogsWeLove
//
//  Created by Carlos Linares on 24/01/20.
//  Copyright © 2020 Carlos Linares. All rights reserved.
//

import UIKit

final class DogCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "DogCollectionViewCell"
    
    let detailsContainer: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = UIColor.DogsWeLoveColorScheme.textTitle
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.DogsWeLoveColorScheme.textContent
        return label
    }()
    
    var ageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.DogsWeLoveColorScheme.textTitle
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        imageView.backgroundColor = .gray
        
        addConstriantsDetailsContainer()
        addConstraintsImageView()
        addConstraintstoText()
        
    }
    
    private func addConstriantsDetailsContainer() {
        addSubview(detailsContainer)
        detailsContainer.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            detailsContainer.topAnchor.constraint(equalTo: topAnchor, constant: 24),
            detailsContainer.leftAnchor.constraint(equalTo: leftAnchor),
            detailsContainer.bottomAnchor.constraint(equalTo: bottomAnchor),
            detailsContainer.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    private func addConstraintsImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leftAnchor.constraint(equalTo: leftAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    private func addConstraintstoText() {
        detailsContainer.addSubview(nameLabel)
        detailsContainer.addSubview(descriptionLabel)
        detailsContainer.addSubview(ageLabel)
        
        let stackView = UIStackView(arrangedSubviews: [nameLabel, descriptionLabel, ageLabel])
    
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.alignment = .top
        stackView.distribution = .fill
        
        detailsContainer.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: detailsContainer.topAnchor, constant: 14),
            stackView.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 21),
            stackView.bottomAnchor.constraint(equalTo: detailsContainer.bottomAnchor, constant: -33),
            stackView.rightAnchor.constraint(equalTo: detailsContainer.rightAnchor, constant: -21)
        ])
    }
    
    func configure(name: String, description: String, age: Int) {
        nameLabel.text = name
        descriptionLabel.text = description
        ageLabel.text = "Almost \(age) years"
    }
    
    func configure(_ image: UIImage?) {
        imageView.image = image
    }
}
