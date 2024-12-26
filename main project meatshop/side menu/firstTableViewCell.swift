//
//  firstTableViewCell.swift
//  main project meatshop
//
//  Created by irohub on 05/12/24.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    @IBOutlet weak var productimage: UIImageView!
    @IBOutlet weak var name: UILabel!
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Make the image view round
        //image1.layer.cornerRadius = image1.frame.size.width / 2
        //image1.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
