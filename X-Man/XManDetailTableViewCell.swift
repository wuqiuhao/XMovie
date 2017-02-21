//
//  XManDetailTableViewCell.swift
//  X-Man
//
//  Created by wuqiuhao on 2016/7/7.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class XManDetailTableViewCell: UITableViewCell {

    @IBOutlet var lbName: UILabel!
    
    @IBOutlet var lbCountry: UILabel!
    
    @IBOutlet var viewRate: FloatRatingView!
    
    var movie: Movie! {
        didSet {
            lbName.text = movie.name!
            lbCountry.text = movie.country!
            viewRate.rating = movie.rate!
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
