//
//  CaptionCollectionViewController.swift
//  CaptionShare
//
//  Created by Gabriele on 8/14/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit

class CaptionCollectionViewController: UICollectionViewController {
    
    var captions: [CaptionedImage]!
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: #selector(newImage))

        // Do any additional setup after loading the view.
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        captions = applicationDelegate.captionedImages
    }
    
    override func viewWillAppear(animated: Bool) {
        <#code#>
    }

    func getImages() {
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        captions = applicationDelegate.captionedImages
    }
    
    
    func newImage() {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("CreateImage") as! CreateImageViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
