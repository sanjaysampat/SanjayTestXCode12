//
//  ContentView.swift
//  Shared
//
//  Created by Sanjay Sampat on 30/06/20.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @State private var isPresented: Bool = false
    @State var imageArray: [UIImage]?
    @ObservedObject var imageStore: ImageStore
    
    var body: some View {
        
        VStack(alignment: .leading) {
            HStack(alignment: .center) {
                Text("Hello, world!").font(.title).fontWeight(.regular).multilineTextAlignment(.center).padding()
                Text("nice to see you")
            }
            Label("Information is to be provided as under", systemImage: /*@START_MENU_TOKEN@*/""/*@END_MENU_TOKEN@*/)
                .padding(5)
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.888, green: 0.815, blue: 0.679)/*@END_MENU_TOKEN@*/)
                .multilineTextAlignment(.trailing)
                .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
            
            HStack {
                Button("Select Image") {
                            isPresented.toggle()
                        }.sheet(isPresented: $isPresented) {
                            let configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
                            SwiftUIViewPhotoPicker(configuration: configuration, isPresented: $isPresented, imageArray : $imageArray )
                    }
                /*
                Button("Select Multi Images") {
                            isPresented.toggle()
                        }.sheet(isPresented: $isPresented) {
                            var configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
                            configuration.selectionLimit = 0
                            SwiftUIViewPhotoPicker(configuration: configuration, isPresented: $isPresented, imageArray : $imageArray )
                    }
                */
            }

                
        }
        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.yellow/*@END_MENU_TOKEN@*/)
        //.cornerRadius(10)
        //.border(/*@START_MENU_TOKEN@*/Color.pink/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/3/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        /*
        var imageArray: [UIImage]?
        if let image = UIImage(named: "default") {
            imageArray?.append(image)
        }
        */
        let someView = ContentView(imageStore: testImageStore)
        return someView
    }
}
