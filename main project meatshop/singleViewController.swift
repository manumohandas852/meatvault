//
//  singleViewController.swift
//  main project meatshop
//
//  Created by irohub on 09/12/24.
//

import UIKit

class singleViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource {
    var categoryData: [String: Any]?
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        similarproducts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           guard let cell = collectionview.dequeueReusableCell(withReuseIdentifier: "similar", for: indexPath) as? similarproductsCollectionViewCell else {
               return UICollectionViewCell()
           }
           cell.products.text = similarproducts[indexPath.row]
           cell.productimage.image = UIImage(named: similarimages[indexPath.row])
        cell.price.text = prices[indexPath.row]
           return cell
       }
    
    @IBOutlet weak var collectionview: UICollectionView!
    @IBOutlet weak var kgquantity: UILabel!
    @IBOutlet weak var kgplus: UIButton!
    @IBOutlet weak var kgminus: UIButton!
    @IBOutlet weak var tirdview: UIView!
    @IBOutlet weak var select: UITextField!
    @IBOutlet weak var gramsminus: UIButton!
    @IBOutlet weak var gramplus: UIButton!
    @IBOutlet weak var gramquantity: UILabel!
    let dropdownView = UIView()
        let tableView = UITableView()
        let fish = ["option 1", "option 2", "option 3"]
    let similarproducts = ["Catla (1 kg to 1.9 kg)","Indian Mackerel / Ayala / Bangde / Ayle (large) 1+ Count/kg)","Pink Perch / Glimeen / Sankara (Large) (180g to 310g)","Tapia / Tilapia Fish (100g to 240g)"]
    let similarimages = ["catla","indian makrel","pink perch","tilapia"]
    let prices = ["190.00/500g","299.00/500g","199.00/500g","179.00/500g"]
        var isDropdownVisible = false
        var currentGramQuantity = 0 // Track the current gram quantity
        var currentKgQuantity = 0   // Track the current kg quantity
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            // Configure the TextField
            configureTextField()
            
            // Configure dropdown view
            configureDropdown()
            
            // Configure gram buttons
            gramsminus.addTarget(self, action: #selector(decreaseGramQuantity), for: .touchUpInside)
            gramplus.addTarget(self, action: #selector(increaseGramQuantity), for: .touchUpInside)
            
            // Configure kg buttons
            kgminus.addTarget(self, action: #selector(decreaseKgQuantity), for: .touchUpInside)
            kgplus.addTarget(self, action: #selector(increaseKgQuantity), for: .touchUpInside)
            
            // Initialize quantities
            updateGramQuantityLabel()
            updateKgQuantityLabel()
            
            if let flowLayout = collectionview.collectionViewLayout as? UICollectionViewFlowLayout {
                       // Set item size (2 items per row, with gaps of 0.5)
                       let itemWidth = (collectionview.frame.width - 1) / 2 // Adjust for the gap
                       flowLayout.itemSize = CGSize(width: itemWidth, height: 170) // Cell height of 170
                       
                       // Set minimum spacing
                       flowLayout.minimumInteritemSpacing = 2 // Horizontal gap between items
                       flowLayout.minimumLineSpacing = 8 // Vertical gap between rows
                       
                       // Optional: Set section inset for padding around the collection view
                       flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
                   }
        }
        
        func configureTextField() {
            // Add a downward arrow button
            let arrowButton = UIButton(type: .custom)
            arrowButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            arrowButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
            arrowButton.addTarget(self, action: #selector(toggleDropdown), for: .touchUpInside)
            
            select.rightView = arrowButton
            select.rightViewMode = .always
            select.placeholder = "Select"
            select.addTarget(self, action: #selector(hideKeyboard), for: .editingDidBegin)
        }
        
        func configureDropdown() {
            dropdownView.layer.borderColor = UIColor.gray.cgColor
            dropdownView.layer.borderWidth = 1
            dropdownView.clipsToBounds = true
            dropdownView.backgroundColor = .white
            dropdownView.isHidden = true // Start hidden
            
            tableView.frame = dropdownView.bounds
            tableView.dataSource = self
            tableView.delegate = self
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            dropdownView.addSubview(tableView)
            
            // Add dropdownView to thirdView
            tirdview.addSubview(dropdownView)
        }
        
        @objc func toggleDropdown() {
            isDropdownVisible.toggle()
            dropdownView.isHidden = !isDropdownVisible
            
            if isDropdownVisible {
                // Position the dropdown view just below the TextField within thirdView
                let textFieldFrame = select.frame
                let dropdownHeight: CGFloat = CGFloat(fish.count * 44) // Height based on number of items
                
                dropdownView.frame = CGRect(
                    x: textFieldFrame.origin.x,
                    y: textFieldFrame.maxY,
                    width: textFieldFrame.width,
                    height: dropdownHeight
                )
                tableView.frame = dropdownView.bounds
            }
        }
        
        @objc func hideKeyboard() {
            // Prevent keyboard from showing
            select.resignFirstResponder()
        }
        
        // Gram quantity adjustments
        @objc func decreaseGramQuantity() {
            if currentGramQuantity > 0 {
                currentGramQuantity -= 100
                updateGramQuantityLabel()
            }
        }
        
        @objc func increaseGramQuantity() {
            if currentGramQuantity < 900 {
                currentGramQuantity += 100
                updateGramQuantityLabel()
            }
        }
        
        func updateGramQuantityLabel() {
            gramquantity.text = "\(currentGramQuantity) g"
        }
        
        // KG quantity adjustments
        @objc func decreaseKgQuantity() {
            if currentKgQuantity > 0 {
                currentKgQuantity -= 1
                updateKgQuantityLabel()
            }
        }
        
        @objc func increaseKgQuantity() {
            if currentKgQuantity < 10 {
                currentKgQuantity += 1
                updateKgQuantityLabel()
            }
        }
        
        func updateKgQuantityLabel() {
            kgquantity.text = "\(currentKgQuantity) kg"
        }
        
        // TableView DataSource Methods
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return fish.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = fish[indexPath.row]
            return cell
        }
        
        // TableView Delegate Method
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            select.text = fish[indexPath.row]
            toggleDropdown() // Hide the dropdown
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
