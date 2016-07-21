//
//  XManCollectionViewCell.swift
//  X-Man
//
//  Created by wuqiuhao on 2016/7/7.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class XManCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imgPoster: UIImageView!
    
    @IBOutlet var viewRate: FloatRatingView!
    
    @IBOutlet var lbName: UILabel!
    
    @IBOutlet var lbCountry: UILabel!
    
    @IBOutlet var viewRateBack: UIView!
    
    var movie: Movie! {
        didSet {
            imgPoster.image = UIImage(named: movie.posterImgName!)
            viewRate.rating = movie.rate!
            lbName.text = movie.name!
            lbCountry.text = movie.country!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        viewRateBack.layer.shouldRasterize = true
        viewRateBack.layer.rasterizationScale = UIScreen.mainScreen().scale
        imgPoster.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        viewRateBack.layer.shadowColor = UIColor.blackColor().CGColor
        viewRateBack.layer.shadowRadius = 30
        viewRateBack.layer.shadowOpacity = 0.5
        contentView.bringSubviewToFront(lbName)
        contentView.bringSubviewToFront(lbCountry)
    }
}
