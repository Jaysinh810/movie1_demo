//
//  RatingView.swift
//  
//
//  Created by Jay on 13/07/24.
//

import UIKit

class RatingView: UIView {
    
    private var starImageViews: [UIImageView] = []
    private let ratingLabel = UILabel()
    
    var rating: Int = 0 {
        didSet {
            updateStarImages()
        }
    }
    
    var ratingCount: Int = 0 {
        didSet {
            ratingLabel.text = "\(ratingCount)/5"
            ratingLabel.textColor = .white
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        for _ in 0..<5 {
            let starImageView = UIImageView()
            starImageView.contentMode = .scaleAspectFit
            starImageViews.append(starImageView)
            addSubview(starImageView)
        }
        
        ratingLabel.font = UIFont.systemFont(ofSize: 14)
        ratingLabel.textColor = .black
        addSubview(ratingLabel)
        
        layoutStarImageViews()
    }
    
    private func layoutStarImageViews() {
        let starSize = CGSize(width: 24, height: 24)
        let padding: CGFloat = 5
        
        for (index, imageView) in starImageViews.enumerated() {
            imageView.frame = CGRect(
                x: CGFloat(index) * (starSize.width + padding),
                y: 0,
                width: starSize.width,
                height: starSize.height
            )
        }
        
        ratingLabel.frame = CGRect(
            x: CGFloat(starImageViews.count) * (starSize.width + padding),
            y: 0,
            width: 50, // Adjust width as needed
            height: starSize.height
        )
    }
    
    private func updateStarImages() {
        for (index, imageView) in starImageViews.enumerated() {
            if index < rating {
                imageView.image = UIImage(systemName: "star.fill")
                imageView.tintColor = .systemYellow
            } else {
                imageView.image = UIImage(systemName: "star")
                imageView.tintColor = .lightGray
            }
        }
    }
}

