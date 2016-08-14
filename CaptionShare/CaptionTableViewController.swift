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
    @IBOutlet weak var captionImage: UIImageView!
    @IBOutlet weak var captionText: UILabel!

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
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.captions.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let captionedImageToShow = self.captions[indexPath.row].captionedImage
        let captionToShow = self.captions[indexPath.row].text
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        cell.imageView?.image = captionedImageToShow
        cell.textLabel?.text = captionToShow
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        <#code#>
    }

}
