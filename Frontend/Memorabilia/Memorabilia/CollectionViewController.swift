//
//  CollectionViewController.swift
//  Memorabilia
//
//  Created by Alok Sahay on 08.09.2024.
//

import Foundation
import UIKit

class CollectionViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    @IBOutlet weak var mintedViewController: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mintedViewController.alpha = 0.0
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
        
        if let popoverPresentationController = productVC.popoverPresentationController {
            popoverPresentationController.delegate = self
        }
        present(productVC, animated: true, completion: nil)
    }
    
    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {
        print("show minted item")
    }
}
