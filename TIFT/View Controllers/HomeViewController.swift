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

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchQuotes()
        setupUI()
        setupData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchQuotes()
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
        sections = [.highlights, .categories]
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.exploreQuotes(_fromNotification:)),
                                               name: NSNotification.Name(rawValue: "exploreQuotes"),
                                               object: nil)
        
        let highlightCell = UINib(nibName: "HighlightsTableViewCell", bundle: nil)
        table.register(highlightCell, forCellReuseIdentifier: "HighlightsTableViewCell")
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
    
    func exploreQuotes(quotes: [Quote], index: Int?) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let quoteViewController = storyBoard.instantiateViewController(withIdentifier: "QuoteViewController") as! QuoteViewController
        quoteViewController.quotes = quotes
        quoteViewController.index = index ?? 0
        self.navigationController?.pushViewController(quoteViewController, animated: true)
    }
    
    @objc func exploreQuotes(_fromNotification notification: NSNotification) {
        if let quotes = notification.userInfo?["quotes"] as? [Quote], let index = notification.userInfo?["index"] as? Int {
            exploreQuotes(quotes: quotes, index: index)
        }
    }
    
    //MARK: - Table View
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch sections[indexPath.row] {
        case .highlights:
            return 275
        case .categories:
            return 0
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //sections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch sections[indexPath.row] {
        case .highlights:
            let highlightCell = tableView.dequeueReusableCell(withIdentifier: "HighlightsTableViewCell", for: indexPath) as? HighlightsTableViewCell
            if let collection = collection {
                highlightCell?.quotes = collection.highlights
            }
            return highlightCell!
            
        case .categories:
            let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
            return cell
        }
    }

}

enum HomeSections: String {
    case highlights = "Highlights"
    case categories = "Categories"
}
