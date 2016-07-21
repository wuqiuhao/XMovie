//
//  XManCollectionViewController.swift
//  X-Man
//
//  Created by wuqiuhao on 2016/7/7.
//  Copyright © 2016年 Hale. All rights reserved.
//

import UIKit

class HNavigationController: UINavigationController {
    override func childViewControllerForStatusBarStyle() -> UIViewController? {
        return self.topViewController
    }
}

private let reuseIdentifier = "xmanCollectionViewCell"

class XManCollectionViewController: UICollectionViewController {

    var dataArray = [Movie]()
    var animator: CustomTransitioningAnimator!
    var selectedCell: XManCollectionViewCell!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "X-Man"
        configDataSource()
        configCollectionLayout()
        // Uncomment the following line to preserve selection between presentations
         self.clearsSelectionOnViewWillAppear = false
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
}

// MARK: - Private
extension XManCollectionViewController {
    func configDataSource() {
        dataArray = [Movie(name: "X战警·逆转未来", country: "美国", posterImgName: "image2", rate: 4.8),
                    Movie(name: "X战警·天启", country: "美国", posterImgName: "image1", rate: 5.0),
                    Movie(name: "金刚狼", country: "美国", posterImgName: "image8", rate: 3.7),
                    Movie(name: "X战警·背水一战", country: "美国", posterImgName: "image4", rate: 4.5),
                    Movie(name: "X战警·第一站", country: "美国", posterImgName: "image3", rate: 5),
                    Movie(name: "金刚狼2", country: "美国", posterImgName: "image7", rate: 3.9),
                    Movie(name: "X战警", country: "美国", posterImgName: "image5", rate: 4.2),
                    Movie(name: "X战警2", country: "美国", posterImgName: "image6", rate: 4.7)]
        collectionView?.reloadData()
    }
    
    func configCollectionLayout() {
        let itemWidth = (UIScreen.mainScreen().bounds.width - 60) / 2
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        collectionView!.setCollectionViewLayout(layout, animated: true)
    }
}

// MARK: UICollectionViewDataSource
extension XManCollectionViewController {
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return dataArray.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! XManCollectionViewCell
        cell.movie = dataArray[indexPath.row]
        return cell
    }

}

// MARK: UICollectionViewDelegate
extension XManCollectionViewController {
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailVC = UIStoryboard(name: "XMain", bundle: nil).instantiateViewControllerWithIdentifier("XManDetailViewController") as! XManDetailViewController
        let animator = CustomTransitioningAnimator()
        selectedCell = collectionView.cellForItemAtIndexPath(indexPath) as! XManCollectionViewCell
        detailVC.dataModel = dataArray[indexPath.row]
        detailVC.modalPresentationStyle = UIModalPresentationStyle.Custom
        detailVC.transitioningDelegate = animator
        detailVC.delegate = self
        self.presentViewController(detailVC, animated: true, completion: nil)
    }
}

extension XManCollectionViewController: CustomTransitioningDelegate {
    func dismissPresentViewController() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}