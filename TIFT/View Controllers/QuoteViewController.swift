//
//  QuoteViewController.swift
//  TIFT
//
//  Created by Terence Williams on 1/4/22.
//

import UIKit

class QuoteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!

    var quotes: [Quote] = []
    var index = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quotes.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuoteTableViewCell", for: indexPath) as? QuoteTableViewCell
        
        let quote = quotes[indexPath.row]
        cell?.quoteLabel.text = quote.quote
        cell?.authorLabel.text = "- \(quote.author)"
        return cell!
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            centerTableView()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        centerTableView()
    }
    
    func centerTableView() {
        let centerPath: IndexPath = table.indexPathForRow(at: CGPoint(x: table.bounds.midX, y: table.bounds.midY))!
        table.scrollToRow(at: centerPath, at: .middle, animated: true)
    }
}
