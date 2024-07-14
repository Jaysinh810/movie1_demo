//
//  MovieCell.swift
//  
//
//  Created by Jay on 13/07/24.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImg: UIImageView!
    
    @IBOutlet weak var movietitleLbl: UILabel!
    @IBOutlet weak var moviegenreLbl: UILabel!
    @IBOutlet weak var moviedateLbl: UILabel!
    
    @IBOutlet weak var movieratingView: RatingView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        self.movieratingView.rating = 4
        //self.movieratingView.ratingCount = 4
        self.movieratingView.layer.masksToBounds = true
        self.movieratingView.layer.cornerRadius = 5
        //self.movieratingView.backgroundColor = .darkGray
        self.movieratingView.backgroundColor = UIColor(red: 25/256, green: 25/256, blue: 39/256, alpha: 1)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setdata(movieid:Int, movieImg:String, movietitle:String, moviedate: String, movierating: Double) {
        print("id ==> ", movieid)
        //print("image ==> ", movieImg)
        let url = URL(string: "https://image.tmdb.org/t/p/w500\(movieImg)")
        self.movieImg.kf.setImage(with: url)
        self.movietitleLbl.text = movietitle
        self.movietitleLbl.numberOfLines = 0
        //self.moviegenreLbl.text = moviegenre
        self.moviedateLbl.text = moviedate
        self.movieratingView.ratingCount = Int(movierating)
    }

}
