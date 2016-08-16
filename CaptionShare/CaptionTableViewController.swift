//
//  CaptionTableViewController.swift
//  CaptionShare
//
//  Created by Gabriele on 8/14/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit

class CaptionTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var imagesTable: UITableView!
    var captions: [CaptionedImage]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: #selector(newImage))

        getImages()
        imagesTable.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        getImages()
        imagesTable.reloadData()
    }
    
    func getImages() {
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        captions = applicationDelegate.captionedImages
    }
    
    
    func newImage() {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("CreateImage") as! CreateImageViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return captions.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let captionedImageToShow = self.captions[indexPath.row].captionedImage
        let captionToShow = self.captions[indexPath.row].text
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell")! as UITableViewCell
        cell.imageView?.image = captionedImageToShow
        cell.textLabel?.text = captionToShow
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailController.currentImage = captions[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            captions.removeAtIndex(indexPath.row)
            (UIApplication.sharedApplication().delegate as! AppDelegate).captionedImages.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            imagesTable.reloadData()
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }

}
