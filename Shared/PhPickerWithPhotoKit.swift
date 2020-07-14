//
//  PhPickerWithPhotoKit.swift
//  SanjayTestXCode12
//
//  Created by Sanjay Sampat on 13/07/20.
//

import SwiftUI
import PhotosUI

struct PhPickerWithPhotoKit: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = PHPickerViewController
    
    let photoLibrary = PHPhotoLibrary.shared()
    
    @Binding var isPresentedPhPickerWithPhotoKit: Bool
    @Binding var imageArray: [ItemImage]
    
    var itemProviders: [NSItemProvider] = []
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration(photoLibrary: photoLibrary)
        configuration.selectionLimit = 0
        
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> CoordinatorPhPickerWithPhotoKit {
        CoordinatorPhPickerWithPhotoKit(self)
    }
    
    // Use a Coordinator to act as your PHPickerViewControllerDelegate
    class CoordinatorPhPickerWithPhotoKit: PHPickerViewControllerDelegate {
        
        private var parent: PhPickerWithPhotoKit
        
        init(_ parent: PhPickerWithPhotoKit) {
            self.parent = parent
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            if !results.isEmpty {
                parent.itemProviders = []
                parent.imageArray = []
            }
            //print(results)
            let identifiers: [String] = results.compactMap(\.assetIdentifier)
            parent.isPresentedPhPickerWithPhotoKit = false 
            let fetchResult = PHAsset.fetchAssets(withLocalIdentifiers: identifiers, options: nil)
            
            let phAssets = fetchResult.objects(at: IndexSet(0 ..< fetchResult.count))
            
            for asset in phAssets {
                
                let opts = PHImageRequestOptions()
                opts.deliveryMode = .highQualityFormat
                opts.isSynchronous = true
                opts.isNetworkAccessAllowed = true
                opts.resizeMode = .exact
                
                print("asset size: \(asset.pixelWidth) x \(asset.pixelHeight)")
                
                PHImageManager.default().requestImage(for: asset,
                                                      targetSize: PHImageManagerMaximumSize,
                                                      contentMode: .default,
                                                      options: opts,
                                                      resultHandler: { (image, info) in
                                                        
                                                        // SSTODO - to find how can we get if we are getting low resolution image in case of no image authorization. ( info key PHImageResultIsDegradedKey is giving same for authorized and no-access images )
                                                        
                                                        if let image = image {
                                                            //print("mage info \(String(describing: info))")
                                                            self.parent.imageArray.append(ItemImage(image: image))
                                                        } else {
                                                            print("Could not load image \(String(describing: info))")
                                                        }
                                                        
                                                      })
            }
            
            picker.dismiss(animated: true)
        }
    }
    
}
