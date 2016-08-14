//
//  CaptionTableViewController.swift
//  CaptionShare
//
//  Created by Gabriele on 8/14/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit

class CaptionTableViewController: UITableViewController {
    
    var captions: [CaptionedImage]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: #selector(newImage))


        // Do any additional setup after loading the view.
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        captions = applicationDelegate.captionedImages
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func newImage() {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("CreateImage") as! CreateImageViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }

}
