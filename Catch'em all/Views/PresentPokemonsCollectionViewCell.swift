//
//  PresentPokemonsCollectionViewCell.swift
//  Catch'em all
//
//  Created by Ivan Solohub on 07.06.2024.
//

import UIKit

class PresentPokemonsCollectionViewCell: UICollectionViewCell {
    
    var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "mainVCBackground")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
     //   self.backgroundColor = .green
        
        setupImageView()
    }
    
    private func setupImageView() {
        self.addSubview(previewImageView)
        previewImageView.addConstraints(to_view: self)
    }
}
