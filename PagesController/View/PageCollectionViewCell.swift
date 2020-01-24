//
//  PageCollectionViewCell.swift
//  PagesController
//
//  Created by @rtur drohobytskyy on 23/01/2020.
//  Copyright © 2020 @rtur drohobytskyy. All rights reserved.
//

import UIKit

class PageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var page: Page? {
        didSet{
            
            guard let unwrappedPage = page else { return }
            
            imageView.image = UIImage(named: unwrappedPage.image)
            imageView.contentMode = .scaleAspectFit
            titleLabel.text = unwrappedPage.title
            descriptionLabel.text = unwrappedPage.description
        }
    }
}
