//
//  ProductViewController.swift
//  Memento
//
//  Created by Alok Sahay on 08.09.2024.
//

import Foundation
import UIKit

enum ProductType {
    case mug
    case tshirt
    case cap
}

class ProductViewController: UIViewController {
    
    var product: ProductType = .mug
    var isMintable: Bool = false
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var mintButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayProductInfo(for: product)
        mintButton.isHidden = !isMintable
    }
    
    func displayProductInfo(for product: ProductType) {
        switch product {
        case .mug:
            imageView.image = .mug
            titleLabel.text = "McLaren Garage Mug #4"
            descriptionLabel.text = "Show your passion for speed and style with the McLaren F1 Coffee Mug! Perfect for Formula 1 enthusiasts, this sleek, high-quality mug features the iconic McLaren logo and bold racing colors. Whether you're fueling up for the day or celebrating a race victory, this mug is the ultimate companion for any McLaren fan."
        case .tshirt:
            imageView.image = .mercJersey
            titleLabel.text = "Mercedes F1 Jersey White #44"
            descriptionLabel.text = "Designed for fans of the seven-time World Champion, this premium jersey features the iconic Mercedes F1 colors and logos, along with Hamilton's name and number. Made from high-quality, breathable fabric, it's perfect for race days or everyday wear. Whether you're at the track or watching from home, this jersey lets you proudly display your passion for Mercedes F1 and one of the greatest drivers in Formula 1 history."
        case .cap:
            imageView.image = .ferrCap
            titleLabel.text = "Ferrari Team cap #16"
            descriptionLabel.text = "Designed with precision and style, this high-performance jersey features the iconic Ferrari red, adorned with team and sponsor logos. Crafted from breathable, lightweight materials, it offers ultimate comfort whether you're cheering trackside or watching from home. The jersey proudly bears Charles Leclerc’s name and number, making it the perfect way to celebrate your favorite driver as he battles for the championship. Elevate your race day experience and wear the passion of Ferrari with pride!"
        }
    }
    
    @IBAction func mintPressed(_ sender: Any) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
            self?.mintButton.setTitle("Mint complete!", for: .normal)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self?.dismiss(animated: true, completion: {
                    NotificationCenter.default.post(name: NSNotification.Name("PopoverDismissed"), object: nil)
                })
            }
        }
        
    }
    
}
