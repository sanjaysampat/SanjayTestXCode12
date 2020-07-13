//
//  ImageStore.swift
//  SanjayTestXCode12
//
//  Created by Sanjay Sampat on 11/07/20.
//

import Foundation
import PhotosUI

class ImageStore: ObservableObject {
    var images: [ItemImage]
    
    init( images: [ItemImage] = [] ) {
        self.images = images
    }
}

var imageArray: [ItemImage] = []
let testImageStore = ImageStore( images: imageArray )
