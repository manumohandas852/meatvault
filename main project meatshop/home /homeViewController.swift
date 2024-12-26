import UIKit
import SideMenu

class homeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // Outlets for UI elements
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    // Arrays to store categories and image data
    var categories: [[String: Any]] = []
    var images = ["1", "2", "3", "4", "5"]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchTextField()
        setupTableView()
        fetchCategoriesData()
    }

    @IBAction func viewAll(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let nextPage = storyboard.instantiateViewController(identifier: "fresh") as? freshfishViewController {
            self.navigationController?.pushViewController(nextPage, animated: true)
        }
    }
    
    private func setupSearchTextField() {
        searchTextField.borderStyle = .none
        searchTextField.layer.cornerRadius = 10
        searchTextField.layer.masksToBounds = true
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor.lightGray.cgColor
        searchTextField.backgroundColor = UIColor(white: 0.95, alpha: 1)
        
        let magnifyingGlass = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        magnifyingGlass.tintColor = .gray
        magnifyingGlass.contentMode = .scaleAspectFit
        magnifyingGlass.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 34))
        leftView.addSubview(magnifyingGlass)
        magnifyingGlass.center = leftView.center
        
        searchTextField.leftView = leftView
        searchTextField.leftViewMode = .always
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView() // Remove extra empty cells
        tableView.separatorStyle = .none // Hide separator lines
    }
    
    // Fetch categories data from API
    private func fetchCategoriesData() {
        // Get user id from UserDefaults (assuming you have this logic)
        guard let userID = UserDefaults.standard.string(forKey: "MyKey") else {
            print("Error: User ID not found in UserDefaults")
            return
        }
        
        // API endpoint
        let apiEndpoint = "https://meatshop.b4production.com/index.php?route=api/completeapi&api_token="
        
        // Construct URL for API
        guard let url = URL(string: apiEndpoint) else {
            print("Error: Invalid URL")
            return
        }
        
        // Prepare POST request
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        // Set up the post string with userID and other required parameters
        let postString = "user_id=\(userID)&key=\("koFCpCMzm8hhn9ULj0BnUzZkpqM3rg9Mqdii3FwPRjBwZFQWriIJYgB5jjOhNIyasSl4RrmCFLW3tHDRtI39viQbYEP7nEkYvba2wstThYWjvkndZq0zaXJaWjuqeZo8vR3MMHa6OhBDKsFPmWOlIM4H1TgB1fudQndGKzUPg8YhAoaAoCxZ562zjbQdPO73ZkwyPV7iOIkyH11ZLAN42a5dgLH22Rs1VasEWBKdfkqMLPfDbLQpF9Ofqah4fqwc")"
        request.httpBody = postString.data(using: .utf8)
        
        // Start the data task
        let task = URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else {
                print("Error: No data received")
                return
            }
            
            do {
                // Parse the JSON data
                if let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let dataDict = jsonData["data"] as? [String: Any],
                   let categories = dataDict["categories"] as? [[String: Any]] {
                    
                    // Successfully fetched and parsed categories
                    self.categories = categories
                    
                    // Update UI on the main thread
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            } catch {
                print("Error: JSON parsing failed - \(error.localizedDescription)")
            }
        }
        
        // Execute the task
        task.resume()
    }

    // MARK: - UITableViewDelegate and UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2 // First row for the slider, second for categories
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! ImageSliderTableViewCell
            cell.configure(with: images)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! categoriesTableViewCell
        cell.categories = self.categories // Pass the categories array here
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 0 ? 224 : 400
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - CollectionView Delegate and DataSource

extension homeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categories", for: indexPath) as! categoriesCollectionViewCell
        let category = categories[indexPath.item]
        
        // Set category image and name
        if let imageName = category["image"] as? String {
            cell.imageView.image = UIImage(named: imageName)
        }
        
        if let categoryName = category["name"] as? String {
            cell.Label.text = categoryName
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        // Instantiate the singleViewController from the storyboard
        if let nextPage = storyboard.instantiateViewController(identifier: "single") as? singleViewController {
            
            // You can pass data to singleViewController if needed, for example:
            let selectedCategory = categories[indexPath.item]
            
            // Pass data to nextPage (singleViewController)
            nextPage.categoryData = selectedCategory  // Assuming 'categoryData' is a property in singleViewController
            
            // Push to the next view controller
            self.navigationController?.pushViewController(nextPage, animated: true)
        }
    }
}
