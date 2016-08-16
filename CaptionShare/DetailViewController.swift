//
//  DetailViewController.swift
//  CaptionShare
//
//  Created by Gabriele on 8/14/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var currentImage: CaptionedImage!

    @IBOutlet weak var captionedImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Action, target: self, action: #selector(DetailViewController.shareCaptionedImage))
        
        captionedImageView.image = currentImage.captionedImage
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func shareCaptionedImage() {
        let captionedImage = currentImage.captionedImage
        let controller = UIActivityViewController(activityItems: [captionedImage], applicationActivities: nil)
        controller.completionWithItemsHandler = {
            (activity, success, items, error) in
            if success {
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        presentViewController(controller, animated: true, completion: nil)
        
    }
}
