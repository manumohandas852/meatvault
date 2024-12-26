//
//  categoriesTableViewCell.swift
//  main project meatshop
//
//  Created by irohub on 04/12/24.
//
import UIKit

class categoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var categories: [[String: Any]] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension categoriesTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categories", for: indexPath) as! categoriesCollectionViewCell
        let category = categories[indexPath.item]
        
        // Set category image
        let predefinedImages = ["seafood", "fresh water fish", "poultry", "other"]
        if indexPath.item < predefinedImages.count {
            let imageName = predefinedImages[indexPath.item]
            cell.imageView.image = UIImage(named: imageName)
        }
        
        // Set category name
        if let categoryName = category["name"] as? String {
            cell.Label.text = categoryName
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 170)
    }
}
