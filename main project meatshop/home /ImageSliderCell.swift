//
//  ImageSliderCell.swift
//  main project meatshop
//
//  Created by irohub on 04/12/24.
//

import UIKit

class ImageSliderCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
       
    override func awakeFromNib() {
            super.awakeFromNib()
            
            // Apply rounded corners and shadow to imageView
            applyStylingToImageView(imageView)
        }
        
        func configure(with imageName: String) {
            imageView.image = UIImage(named: imageName)
        }
        
        // Function to apply rounded corners and shadow to imageView
        func applyStylingToImageView(_ imageView: UIImageView) {
            // Apply rounded corners
            imageView.layer.cornerRadius = 10  // Adjust the radius as needed
            imageView.layer.masksToBounds = true  // Ensure the content is clipped to rounded corners
            
            // Apply shadow
            imageView.layer.shadowColor = UIColor.black.cgColor
            imageView.layer.shadowOpacity = 0.6
            imageView.layer.shadowOffset = CGSize(width: 0, height: 2)
            imageView.layer.shadowRadius = 4
            imageView.layer.masksToBounds = false  // Allow shadow to be drawn outside of bounds
        }
    }
