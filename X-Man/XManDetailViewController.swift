//
//  XManDetailViewController.swift
//  X-Man
//
//  Created by wuqiuhao on 2016/7/7.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

private let reuseIdentifier = "detailRateCell"

class XManDetailViewController: UIViewController {

    @IBOutlet var imgHead: UIImageView!
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var imgBack: UIImageView!
    
    @IBOutlet var viewBack: UIView!
    
    @IBOutlet var btnCancel: UIButton!
    
    @IBOutlet var btnBuy: UIButton!
    
    
    var delegate: CustomTransitioningDelegate!
    
    var dataModel: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBar.hidden = true
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

// MARK: - Private
extension XManDetailViewController {
    func configUI() {
        imgHead.image = UIImage(named: dataModel.posterImgName!)
        imgHead.clipsToBounds = true
        tableView.backgroundColor = UIColor(red: 7 / 255, green: 3 / 255, blue: 10 / 255, alpha: 1.0)
        imgBack.image = UIImage(named: dataModel.posterImgName!)
        let blur = UIBlurEffect(style: UIBlurEffectStyle.Light)
        let effectView = UIVisualEffectView(effect: blur)
        effectView.frame = view.frame
        imgBack.addSubview(effectView)
        view.bringSubviewToFront(viewBack)
        view.sendSubviewToBack(imgBack)
        viewBack.layer.cornerRadius = 10
        viewBack.clipsToBounds = true
        btnBuy.backgroundColor = UIColor(red: 211 / 255, green: 27 / 255, blue: 30 / 255, alpha: 1.0)
        tableView.scrollEnabled = false
        tableView.reloadData()
    }
    
    @IBAction func btnDismiss(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}

// MARK: - UITableViewDataSource
extension XManDetailViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(reuseIdentifier, forIndexPath: indexPath) as! XManDetailTableViewCell
        if indexPath.row == 0 {
            cell.movie = dataModel
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension XManDetailViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.min
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.max
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }
}
