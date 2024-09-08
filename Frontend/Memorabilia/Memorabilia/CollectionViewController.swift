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
        NotificationCenter.default.addObserver(self, selector: #selector(handlePopoverDismissal), name: NSNotification.Name("PopoverDismissed"), object: nil)
    }
    
    func mintMemento() {
        
        guard let productVC = storyboard?.instantiateViewController(withIdentifier: "ProductVC") as? ProductViewController else {
            print("error loading product VC")
            return
        }
        
        print("mint memento")
        
        productVC.product = .tshirt
        productVC.isMintable = true
        productVC.modalPresentationStyle = .popover
        present(productVC, animated: true, completion: nil)
    }
    
    @objc func handlePopoverDismissal() {
        print("Popover was dismissed! Performing action via notification.")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) { [weak self] in
            self?.mintedViewController.alpha = 1.0
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("PopoverDismissed"), object: nil)
    }
}
