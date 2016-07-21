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
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isDismiss = false
        return self
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
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
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.3
    }
    
    /**
     动画执行效果
     
     - parameter transitionContext:
     */
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey) as! XManDetailViewController
        let fromViewController = (transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! UINavigationController).topViewController as! XManCollectionViewController
        let container = transitionContext.containerView()!
        
        //1.创建一个 Cell 中 imageView 的截图，并把 imageView 隐藏，造成使用户以为移动的就是 imageView 的假象
        let snapshotView = fromViewController.selectedCell.imgPoster.snapshotViewAfterScreenUpdates(false)
        snapshotView.layer.cornerRadius = 10
        snapshotView.clipsToBounds = true
        snapshotView.contentMode = UIViewContentMode.ScaleAspectFill
        snapshotView.frame = container.convertRect(fromViewController.selectedCell.imgPoster.frame, fromView: fromViewController.selectedCell)
        fromViewController.selectedCell.imgPoster.hidden = true
        
        //2.设置目标控制器的位置，并把透明度设为0，在后面的动画中慢慢显示出来变为1
        toViewController.view.frame = transitionContext.finalFrameForViewController(toViewController)
        toViewController.view.alpha = 0
        
        //3.都添加到 container 中。注意顺序不能错了
        container.addSubview(toViewController.view)
        container.addSubview(snapshotView)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            snapshotView.frame = CGRect(x: 20, y: 55, width: 335, height: 446.5)
            toViewController.view.alpha = 1
        }) { (finish: Bool) -> Void in
            if finish {
                fromViewController.selectedCell.imgPoster.hidden = false
                snapshotView.removeFromSuperview()
                transitionContext.completeTransition(true)
            }
        }
    }
}
