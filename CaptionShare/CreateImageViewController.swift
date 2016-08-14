//
//  ViewController.swift
//  CaptionShare
//
//  Created by Gabriele on 8/10/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import UIKit

class CreateImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    

    @IBOutlet weak var memeImageView: UIImageView!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var captionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        captionTextField.delegate = self
        shareButton.enabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }

    @IBAction func chooseFromCamera(sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
        imagePickerController.allowsEditing = true
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func chooseFromAlbum(sender: AnyObject) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePickerController.allowsEditing = true
        self.presentViewController(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func clearMeme(sender: AnyObject) {
        if memeImageView.image != nil {
            memeImageView.image = nil
        }
        
        captionTextField.text = "Add Caption"
        shareButton.enabled = false
    }
    
    @IBAction func shareCaptionedImage(sender: AnyObject) {
        let captionedImage = generateCaptionedImage()
        let controller = UIActivityViewController(activityItems: [captionedImage], applicationActivities: nil)
        presentViewController(controller, animated: true) { 
            self.save()
            print("captioned image saved")
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            memeImageView.image = editedImage
            self.dismissViewControllerAnimated(true, completion: {
                print("dismissed with edited image")
            })
        }
        self.shareButton.enabled = true
    }
    
    func save() {
        let captionedImage = generateCaptionedImage()
        let finalProduct = CaptionedImage(text: captionTextField.text!, image: memeImageView.image!, captionedImage: captionedImage)
        print(finalProduct)
        
        (UIApplication.sharedApplication().delegate as! AppDelegate).captionedImages.append(finalProduct)
    }
    
    func generateCaptionedImage() -> UIImage {
        
        // Hide toolbar and navbar
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.toolbarHidden = true
        
        // Create image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let captionedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndPDFContext()
        
        // Show toolbar and navbar again
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.toolbarHidden = false
        
        return captionedImage
    }
    
    
//    Notifications for keyboard and textFields
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
       self.view.endEditing(true)
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        if textField.text == "Add Caption" {
            textField.text = ""
        }
    }
    
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CreateImageViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CreateImageViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
}

