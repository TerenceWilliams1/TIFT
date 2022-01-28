//
//  Page1ViewController.swift
//  TIFT
//
//  Created by Terence Williams on 1/27/22.
//

import UIKit

class Page1ViewController: UIViewController {
    
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()

        actionButton.layer.cornerRadius = 5
        actionButton.addTarget(self, action: #selector(goToPage2), for: .touchUpInside)
    }
    
    @objc func goToPage2() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "continueWalkthrough1"),
        object: nil,
        userInfo: nil)
    }
}
