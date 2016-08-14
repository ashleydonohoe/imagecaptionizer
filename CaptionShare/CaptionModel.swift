//
//  CaptionModel.swift
//  CaptionShare
//
//  Created by Gabriele on 8/12/16.
//  Copyright © 2016 Ashley Donohoe. All rights reserved.
//

import Foundation
import UIKit


struct CaptionedImage {
    let text: String
    let image: UIImage
    let captionedImage: UIImage
    
    init(text: String, image: UIImage, captionedImage: UIImage) {
        self.text = text
        self.image = image
        self.captionedImage = captionedImage
    }
}
