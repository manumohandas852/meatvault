//
//  freshfishViewController.swift
//  main project meatshop
//
//  Created by irohub on 04/12/24.
//

import UIKit
struct Fish {
    let name: String
    let price: Int
    let imageName: String
}

class freshfishViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    @IBOutlet weak var collectionview: UICollectionView!
  
        
    
       var fishList: [Fish] = [] // Array to hold fish data
       
       override func viewDidLoad() {
           super.viewDidLoad()
           
           
           setupFishData()
           
           collectionview.delegate = self
           collectionview.dataSource = self
        // Set up collection view layout
            
       }
       
       func setupFishData() {
           // Populate the fish array with data
        let fish = Fish(name: "Catla (1 kg to 1.9 kg)", price: Int(190.00), imageName: "catla")
           fishList = Array(repeating: fish, count: 10) // Add 10 items
       }
       
       
      
       
       // MARK: - UICollectionViewDataSource
       
       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
           return fishList.count
       }
       
       func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "product", for: indexPath) as? productCollectionViewCell
           else {
               return UICollectionViewCell()
           }
           
           let fish = fishList[indexPath.row]
           cell.productname.text = fish.name
           cell.productprice.text = "\(fish.price)rupees"
           cell.productimage.image = UIImage(named: fish.imageName)
           
           return cell
       }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let sttoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextpage1 = sttoryboard.instantiateViewController(identifier: "single")as! singleViewController
        self.navigationController?.pushViewController(nextpage1, animated: true)
    }
    @IBAction func back(_ sender: Any) {
        if let navigationController = self.navigationController {
            navigationController.popViewController(animated: true)
        } else {
            // If there's no navigation controller, dismiss the current view controller
            self.dismiss(animated: true, completion: nil)
        }
    }
}

