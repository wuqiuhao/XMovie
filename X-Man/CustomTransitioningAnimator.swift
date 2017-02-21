//
//  CustomAnimatedTransitioning.swift
//  headViewDemo
//
//  Created by wuqiuhao on 2016/6/30.
//  Copyright © 2016年 wuqiuhao. All rights reserved.
//

import UIKit

class CustomTransitioningAnimator: NSObject, UIViewControllerTransitioningDelegate {
    var isDismiss: Bool!
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isDismiss = false
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isDismiss = true
        return self
    }
}

// MARK: - UIViewControllerAnimatedTransitioning
extension CustomTransitioningAnimator: UIViewControllerAnimatedTransitioning {
    
    /**
     动画持续时间
     
     - parameter transitionContext:
     
     - returns:
     */
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    /**
     动画执行效果
     
     - parameter transitionContext:
     */
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! XManDetailViewController
        let fromViewController = (transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! UINavigationController).topViewController as! XManCollectionViewController
        let container = transitionContext.containerView
        
        //1.创建一个 Cell 中 imageView 的截图，并把 imageView 隐藏，造成使用户以为移动的就是 imageView 的假象
        let snapshotView = fromViewController.selectedCell.imgPoster.snapshotView(afterScreenUpdates: false)
        let shapLayer = CAShapeLayer()
        
        snapshotView?.frame = container.convert(fromViewController.selectedCell.imgPoster.frame, from: fromViewController.selectedCell)
        fromViewController.selectedCell.imgPoster.isHidden = true
        let bounds = snapshotView!.frame
        shapLayer.frame = CGRect(origin: CGPoint.zero, size: bounds.size)
        shapLayer.path = UIBezierPath(roundedRect: CGRect(origin: CGPoint.zero, size: bounds.size), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 10, height: 10)).cgPath
        snapshotView?.layer.mask = shapLayer
        
        toViewController.imgHead.image = UIImage(named: toViewController.dataModel.posterImgName!)
        toViewController.imgHead.clipsToBounds = true
        toViewController.tableView.backgroundColor = UIColor(red: 7 / 255, green: 3 / 255, blue: 10 / 255, alpha: 1.0)
        toViewController.imgBack.image = UIImage(named: toViewController.dataModel.posterImgName!)
        let blur = UIBlurEffect(style: UIBlurEffectStyle.light)
        let effectView = UIVisualEffectView(effect: blur)
        effectView.frame = toViewController.view.frame
        toViewController.imgBack.addSubview(effectView)
        toViewController.view.bringSubview(toFront: toViewController.viewBack)
        toViewController.view.sendSubview(toBack: toViewController.imgBack)
        toViewController.viewBack.layer.cornerRadius = 10
        toViewController.viewBack.clipsToBounds = true
        toViewController.btnBuy.backgroundColor = UIColor(red: 211 / 255, green: 27 / 255, blue: 30 / 255, alpha: 1.0)
        
        
        //2.设置目标控制器的位置，并把透明度设为0，在后面的动画中慢慢显示出来变为1
        toViewController.view.frame = transitionContext.finalFrame(for: toViewController)
        toViewController.imgHead.alpha = 0
        toViewController.view.alpha = 0
        
        
        //3.都添加到 container 中。注意顺序不能错了
        container.addSubview(toViewController.view)
        container.addSubview(snapshotView!)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: UIViewAnimationOptions(), animations: { () -> Void in
            snapshotView?.frame = CGRect(x: 20, y: 55, width: 335, height: 446.5)
            shapLayer.path = UIBezierPath(roundedRect: CGRect(origin: .zero, size: CGSize(width: 335, height: 446.5)), byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 10, height: 10)).cgPath
            snapshotView?.layer.mask = shapLayer
            toViewController.view.alpha = 1
        }) { (finish: Bool) -> Void in
            if finish {
                toViewController.imgHead.alpha = 1
                fromViewController.selectedCell.imgPoster.isHidden = false
                snapshotView?.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        }
    }
}
