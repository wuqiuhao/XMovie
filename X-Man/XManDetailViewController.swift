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
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
}

// MARK: - Private
extension XManDetailViewController {
    func configUI() {
        tableView.isScrollEnabled = false
        tableView.reloadData()
    }
    
    @IBAction func btnDismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - UITableViewDataSource
extension XManDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! XManDetailTableViewCell
        if indexPath.row == 0 {
            cell.movie = dataModel
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension XManDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.greatestFiniteMagnitude
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
