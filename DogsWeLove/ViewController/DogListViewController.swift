//
//  DogListViewController.swift
//  DogsWeLove
//
//  Created by Carlos Linares on 24/01/20.
//  Copyright © 2020 Carlos Linares. All rights reserved.
//

import UIKit


final class DogListViewController: UIViewController {
    
    let collectionView: UICollectionView
    let dogsProvider: DogDataProvider

    private let flowLayout = UICollectionViewFlowLayout()
    private var dogs: [Dog] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    init(dogProvider: DogDataProvider) {
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        self.dogsProvider = dogProvider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollectionView()
        fetchDogs()
    }
    
    private func setupCollectionView() {
        let sideMargins: CGFloat = 21 * 2
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: view.frame.width - sideMargins, height: 160)
        flowLayout.minimumLineSpacing = 33
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 21, bottom: 0, right: 21)
        
        collectionView.dataSource = self
        collectionView.register(DogCollectionViewCell.self, forCellWithReuseIdentifier: DogCollectionViewCell.reuseIdentifier)
        collectionView.backgroundColor = UIColor.DogsWeLoveColorScheme.background
        view.backgroundColor = UIColor.DogsWeLoveColorScheme.background
        
        view.addSubview(collectionView)
        addCollectionViewConstraints()
    }
    
    private func addCollectionViewConstraints() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let margin = view.layoutMarginsGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: margin.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.bottomAnchor.constraint(equalTo: margin.bottomAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    private func fetchDogs() {
        dogsProvider.fetchDogs { [weak self] dogs in
            self?.dogs = dogs
        }
    }
        
}

extension DogListViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dogs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DogCollectionViewCell.reuseIdentifier, for: indexPath) as! DogCollectionViewCell
        
        let dog = dogs[indexPath.row]
        cell.configure(name: dog.name, description: dog.description, age: dog.age)
        
        dogsProvider.fetchImage(from: URL(string: dog.url)) { cell.configure($0) }
        
        return cell
    }
}
