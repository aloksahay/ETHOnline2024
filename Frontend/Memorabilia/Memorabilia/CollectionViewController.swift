//
//  CollectionViewController.swift
//  Memorabilia
//
//  Created by Alok Sahay on 08.09.2024.
//

import Foundation
import UIKit

class CollectionViewController: UIViewController {
    
    @IBOutlet weak var mintedViewController: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mintedViewController.alpha = 0.0
    }
    
    func mintMemento() {        
        print("mint tshirt")
        let productVC = ProductViewController()
        productVC.product = .tshirt
        productVC.isMintable = true
        productVC.modalPresentationStyle = .popover
        present(productVC, animated: true, completion: nil)
    }
}
