//
//  ImageStore.swift
//  SanjayTestXCode12
//
//  Created by Sanjay Sampat on 11/07/20.
//

import Foundation
import PhotosUI

class ImageStore: ObservableObject {
    var images: [UIImage]?
    
    init( images: [UIImage]? = [] ) {
        self.images = images
    }
}

var imageArray: [UIImage]?
let testImageStore = ImageStore( images: imageArray )
