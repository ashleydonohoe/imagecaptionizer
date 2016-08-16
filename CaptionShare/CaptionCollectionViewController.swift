//
//  CaptionCollectionViewController.swift
//  CaptionShare
//
//  Created by Gabriele on 8/14/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit

class CaptionCollectionViewController: UICollectionViewController {
    
    @IBOutlet var captionCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    var captions: [CaptionedImage]!
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup collectionview layout
        let space: CGFloat = 3.0
        let dimension = (self.view.frame.size.width - (2 * space)) / 3.0
        flowLayout.minimumInteritemSpacing = space
        flowLayout.minimumLineSpacing = space
        flowLayout.itemSize = CGSizeMake(dimension, dimension)
        
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .Plain, target: self, action: #selector(newImage))

        // Do any additional setup after loading the view.
        getImages()
        captionCollectionView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
         getImages()
        captionCollectionView.reloadData()
    }

    func getImages() {
        let applicationDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate)
        captions = applicationDelegate.captionedImages
    }
    
    
    func newImage() {
        let controller = self.storyboard!.instantiateViewControllerWithIdentifier("CreateImage") as! CreateImageViewController
        self.presentViewController(controller, animated: true, completion: nil)
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return captions.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = captionCollectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! CaptionCollectionViewCell
        let captionedImage = captions[indexPath.item].captionedImage
        cell.backgroundView = UIImageView(image: captionedImage)
        return cell
        
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailController.currentImage = self.captions[indexPath.item]
        navigationController!.pushViewController(detailController, animated: true)
    }
}
