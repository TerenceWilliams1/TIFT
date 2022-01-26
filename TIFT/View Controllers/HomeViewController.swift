//
//  HomeViewController.swift
//  TIFT
//
//  Created by Terence Williams on 1/5/22.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var quotes: [Quote] = []
    var collection: Collection!
    var sections: [HomeSections] = []
    private let refresh = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuotes()
        setupUI()
        setupData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchQuotes()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setupUI() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
    }
    
    func setupData() {
        sections = [.heaader, .highlights, .categories]
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.exploreQuotes(_fromNotification:)),
                                               name: NSNotification.Name(rawValue: "exploreQuotes"),
                                               object: nil)
        
        let highlightCell = UINib(nibName: "HighlightsTableViewCell", bundle: nil)
        table.register(highlightCell, forCellReuseIdentifier: "HighlightsTableViewCell")
        
        let categoriesTableViewCell = UINib(nibName: "CategoriesTableViewCell", bundle: nil)
        table.register(categoriesTableViewCell, forCellReuseIdentifier: "CategoriesTableViewCell")
        
        let headerTableViewCell = UINib(nibName: "HeaderTableViewCell", bundle: nil)
        table.register(headerTableViewCell, forCellReuseIdentifier: "HeaderTableViewCell")
    }

    func fetchQuotes() {
        URLCache.shared.removeAllCachedResponses()

        guard let artistURL = URL(string: "https://terencewilliams1.github.io/TIFT/data.json") else { return }
        let configuration = URLSessionConfiguration.ephemeral
        let session = URLSession(configuration: configuration)
        session.dataTask(with: artistURL) { (data, response
            , error) in
            guard let data = data else {
                return
            }
            do {
                let decoder = JSONDecoder()
                self.collection = nil
                let collectionData = try decoder.decode(Collection.self, from: data)
                self.collection = collectionData
                DispatchQueue.main.async {
                    print("\n\n***Successfully loaded quotes***\n\n")
                    self.table.reloadData()
                    let generator = UIImpactFeedbackGenerator(style: .light)
                    generator.impactOccurred()
                }
            } catch let err {
                print("Error Loading: ", err)
            }
            print(data)
            }.resume()
    }
    
    //MARK: - Actions
    @IBAction func exploreAll() {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let quoteViewController = storyBoard.instantiateViewController(withIdentifier: "QuoteViewController") as! QuoteViewController
        let category = collection.categories[0]
        quoteViewController.quotes = category.quotes
        self.navigationController?.pushViewController(quoteViewController, animated: true)
    }
    
    func exploreQuotes(quotes: [Quote], index: Int?, themeColor: UIColor?) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let quoteViewController = storyBoard.instantiateViewController(withIdentifier: "QuoteViewController") as! QuoteViewController
        quoteViewController.quotes = quotes
        quoteViewController.themeColor = themeColor ?? UIColor.label
        quoteViewController.index = index ?? 0
        self.navigationController?.pushViewController(quoteViewController, animated: true)
    }
    
    @objc func exploreQuotes(_fromNotification notification: NSNotification) {
        if let quotes = notification.userInfo?["quotes"] as? [Quote],
           let index = notification.userInfo?["index"] as? Int {
            
            if let themeColor = notification.userInfo?["color"] as? UIColor {
                exploreQuotes(quotes: quotes, index: index, themeColor: themeColor)
                return
            }
            exploreQuotes(quotes: quotes, index: index, themeColor: UIColor.label)
        }
    }
    
    //MARK: - Table View
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.row] {
        case .heaader:
            return 65
        case .highlights:
            return 275
        case .categories:
            return 800
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch sections[indexPath.row] {
        case .heaader:
            let headerCell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as? HeaderTableViewCell
            return headerCell!
            
        case .highlights:
            let highlightCell = tableView.dequeueReusableCell(withIdentifier: "HighlightsTableViewCell", for: indexPath) as? HighlightsTableViewCell
            highlightCell?.titleLabel.text = "Highlights"
            if let collection = collection {
                highlightCell?.quotes = collection.highlights
            }
            return highlightCell!
            
        case .categories:
            let categoriesCell = tableView.dequeueReusableCell(withIdentifier: "CategoriesTableViewCell", for: indexPath) as? CategoriesTableViewCell
            categoriesCell?.titleLabel.text = "Categories"
            if let collection = collection {
                categoriesCell?.categories = collection.categories
            }
            return categoriesCell!
        }
    }

}

enum HomeSections: String {
    case heaader = "header"
    case highlights = "Highlights"
    case categories = "Categories"
}
