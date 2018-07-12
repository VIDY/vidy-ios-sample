//
//  ViewController.swift
//  SwiftExample
//
//  Created by Arria Owlia on 6/14/18.
//  Copyright © 2018 Vidy. All rights reserved.
//

import UIKit
import VDYEmbedSDK

class ViewController: UIViewController, VDYDisplayDelegate {

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        VDYEmbedSDK.shared().activate(labels: [label1, label2, label3], viewController: self, postID: "demo-post-slug", displayDelegate: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.scrollView.contentSize = CGSize(width: view.bounds.width, height: label3.frame.maxY)
    }
    
    func vdy_containerTextChanged(_ container: UIView & VDYAttributedTextDisplay) {
        view.setNeedsLayout() // If applicable
    }


}

