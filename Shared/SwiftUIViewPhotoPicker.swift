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
    @Binding var imageArray: [UIImage]?
    
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
            picker.dismiss(animated: true)
            
            if !results.isEmpty {
                parent.itemProviders = []
                parent.imageArray = []
            }
            print(results)
            parent.itemProviders = results.map(\.itemProvider)
            parent.isPresented = false // Set isPresented to false because picking has finished.
        }
        private func loadImage() {
            for itemProvider in parent.itemProviders {
                if itemProvider.canLoadObject(ofClass: UIImage.self) {
                    itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                        if let image = image as? UIImage {
                            self.parent.imageArray?.append(image)
                        } else {
                            print("Could not load image", error?.localizedDescription ?? "")
                        }
                    }
                }
            }
        }
    }

}

