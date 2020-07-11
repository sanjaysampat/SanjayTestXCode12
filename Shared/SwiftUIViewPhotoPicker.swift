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
    
    let configuration: PHPickerConfiguration
    
    @Binding var isPresented: Bool
    
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
      
        private let parent: SwiftUIViewPhotoPicker
        
        init(_ parent: SwiftUIViewPhotoPicker) {
            self.parent = parent
        }
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            print(results)
            parent.isPresented = false // Set isPresented to false because picking has finished.
        }
    }

}

