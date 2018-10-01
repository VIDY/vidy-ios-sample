//
//  ViewController.swift
//  SwiftExample
//
//  Created by Arria Owlia on 6/14/18.
//  Copyright © 2018 Vidy. All rights reserved.
//

import UIKit
import VDYEmbedSDK

class ViewController: UIViewController {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        scrollView.delegate = self
        
        // Activate all labels that are part of the presented postID together
        let myPostID = "demo-post-slug"
        VDYEmbedSDK.shared().activate(labels: [label1, label2, label3], viewController: self, postID: myPostID, displayDelegate: self)
    }
    
    /// Executes any pending changeBlocks on our labels, with animation, if our scrollView is not tracking/dragging/decelerating
    ///
    /// - Parameter forced: determines whether we should mind the scrollView's tracking/dragging/decelerating properties
    func executeChangeBlocksForced(forced: Bool) {
        let allowed = forced || (!scrollView.isTracking && !scrollView.isDragging && !scrollView.isDecelerating)
        
        if (allowed) {
            for label in [ label1, label2, label3 ] {
                if let changeBlock = label?.vdy_pendingChangeBlock {
                    UIView.transition(with: label!, duration: 0.33, options: [.transitionCrossDissolve, .allowUserInteraction], animations: {
                        changeBlock()
                    }, completion: nil)
                }
            }
        }
    }

}

extension ViewController : VDYDisplayDelegate {
    
    func vdy_container(_ container: UIView & VDYAttributedTextDisplay, shouldUpdate update: UnsafeMutablePointer<ObjCBool>!, withPendingChange changeBlock: (() -> Void)!) {
        // Notifies VDYEmbedSDK that it should not execute the changeBlock
        update.initialize(to: .init(false))
        
        // Attempting to execute on our own
        executeChangeBlocksForced(forced: false)
    }
    
//    Implement this method if manually laying out containers
//    func vdy_containerTextChanged(_ container: UIView & VDYAttributedTextDisplay) {
//        view.setNeedsLayout()
//    }
    
}

// These callbacks help us determine when to execute changeBlocks for smooth transitions
extension ViewController : UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate == false {
            executeChangeBlocksForced(forced: false)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        executeChangeBlocksForced(forced: false)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if (targetContentOffset.pointee.equalTo(scrollView.contentOffset)) {
            executeChangeBlocksForced(forced: true)
        }
    }
    
}
