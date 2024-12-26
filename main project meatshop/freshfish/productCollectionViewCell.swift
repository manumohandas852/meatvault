//
//  productCollectionViewCell.swift
//  main project meatshop
//
//  Created by irohub on 05/12/24.
//

import UIKit

class productCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productprice: UILabel!
    @IBOutlet weak var productname: UILabel!
    @IBOutlet weak var productimage: UIImageView!
    override func awakeFromNib() {
            super.awakeFromNib()
            
            // Apply shadow to the product image
            addShadowToProductImage()
        }

        private func addShadowToProductImage() {
            // Make sure the image view has a corner radius (optional, but looks good with shadows)
            productimage.layer.cornerRadius = 8
            productimage.layer.masksToBounds = false
            
            // Set shadow properties
            productimage.layer.shadowColor = UIColor.black.cgColor
            productimage.layer.shadowOffset = CGSize(width: 0, height: 2)  // Shadow position
            productimage.layer.shadowRadius = 4  // Shadow blur radius
            productimage.layer.shadowOpacity = 0.2  // Shadow transparency
        }
    }

