//
//  InstructionsViewController.swift
//  DarkTower
//
//  Created by Louis Revor on 3/7/15.
//  Copyright (c) 2015 Louis Revor. All rights reserved.
//

import Foundation
import UIKit

class InstructionsViewController: UIViewController {
    @IBOutlet weak var webView: UIWebView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        let termsPath:String? = NSBundle.mainBundle().pathForResource("dark_tower", ofType: "pdf")!
        let url = NSURL(fileURLWithPath: termsPath!)
        let pdfRequest = NSURLRequest(URL: url!)
        webView.loadRequest(pdfRequest)
    }
}

