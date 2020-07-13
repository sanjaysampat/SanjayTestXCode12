//
//  SwiftUIViewPhotoPicker.swift
//  SanjayTestXCode12
//
//  Created by Sanjay Sampat on 11/07/20.
//

import SwiftUI
import PhotosUI

struct SwiftUIViewPhotoPicker: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = PHPickerViewController
    
    var configuration: PHPickerConfiguration
    
    @Binding var isPresented: Bool
    @Binding var imageArray: [ItemImage]
    
    var itemProviders: [NSItemProvider] = []
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        let controller = PHPickerViewController(configuration: configuration)
        controller.delegate = context.coordinator
        return controller
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    // Use a Coordinator to act as your PHPickerViewControllerDelegate
    class Coordinator: PHPickerViewControllerDelegate {
      
        private var parent: SwiftUIViewPhotoPicker
        
        init(_ parent: SwiftUIViewPhotoPicker) {
            self.parent = parent
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            if !results.isEmpty {
                parent.itemProviders = []
                parent.imageArray = []
            }
            //print(results)
            parent.itemProviders = results.map(\.itemProvider)
            parent.isPresented = false // Set isPresented to false because picking has finished.
            loadImage()
            picker.dismiss(animated: true)
        }
        private func loadImage() {
            for itemProvider in parent.itemProviders {
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                        /*
                         // https://developer.apple.com/forums/thread/654021
                         
                         SanjayTestXCode12[1264:55492] [claims] Upload preparation for claim 629C5012-E4A3-486B-8FB2-38AEB664F129 completed with error: Error Domain=NSCocoaErrorDomain Code=260 "The file “CC95F08C-88C3-4012-9D6D-64A413D254B3.jpeg” couldn’t be opened because there is no such file." UserInfo={NSURL=file:///Users/sanjaysampat/Library/Developer/CoreSimulator/Devices/8A6FB310-2A14-4D03-A307-28B0706B1C52/data/Containers/Shared/AppGroup/EE90E9A4-6EA7-42DB-9FCF-B78A57ED4E31/File%20Provider%20Storage/CC95F08C-88C3-4012-9D6D-64A413D254B3.jpeg, NSFilePath=/Users/sanjaysampat/Library/Developer/CoreSimulator/Devices/8A6FB310-2A14-4D03-A307-28B0706B1C52/data/Containers/Shared/AppGroup/EE90E9A4-6EA7-42DB-9FCF-B78A57ED4E31/File Provider Storage/CC95F08C-88C3-4012-9D6D-64A413D254B3.jpeg, NSUnderlyingError=0x60000084f390 {Error Domain=NSPOSIXErrorDomain Code=2 "No such file or directory"}}
                         
                         */
                        if let image = image as? UIImage {
                            self.parent.imageArray.append(ItemImage(image: image))
                        } else {
                            print("Could not load image", error?.localizedDescription ?? "")
                        }
                    }
                }
            }
        }
    }

}

