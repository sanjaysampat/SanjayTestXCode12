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
    @State private var isPresentedPhPickerWithPhotoKit: Bool = false
    @State var imageArray: [ItemImage] = []
    @ObservedObject var imageStore: ImageStore
    
    var body: some View {
        
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                Text("Hello, world!").font(.title).fontWeight(.regular).multilineTextAlignment(.center).padding()
                Text("nice to see you")
                HStack {
                    Spacer()
                    Label("Tap on one of following buttons", systemImage: /*@START_MENU_TOKEN@*/""/*@END_MENU_TOKEN@*/)
                        .padding(.all, 5)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.888, green: 0.815, blue: 0.679)/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                    Spacer()
                }
            }
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.pink/*@END_MENU_TOKEN@*/)
            
            VStack {
                HStack {
                    Spacer()
                    Button("Select Image") {
                                isPresented.toggle()
                            }.sheet(isPresented: $isPresented) {
                                let configuration = PHPickerConfiguration(photoLibrary: PHPhotoLibrary.shared())
                                SwiftUIViewPhotoPicker(configuration: configuration, isPresented: $isPresented, imageArray : $imageArray )
                        }
                    .padding(.all, 5)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                    .cornerRadius(10.0)
                    .clipped(antialiased: true)
                    Spacer()
                }
            }
            .padding(5)

            VStack(alignment: .center) {
                Button("PhPickerWithPhotoKit") {
                    isPresentedPhPickerWithPhotoKit.toggle()
                        }.sheet(isPresented: $isPresentedPhPickerWithPhotoKit) {
                            PhPickerWithPhotoKit(isPresentedPhPickerWithPhotoKit: $isPresentedPhPickerWithPhotoKit, imageArray : $imageArray )
                        }
                .padding(.all, 5)
                .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                .cornerRadius(10.0)
                .clipped(antialiased: true)
                
                Label("Will ask access to full size photos, if any of the selected photo does not have access.", systemImage: /*@START_MENU_TOKEN@*/""/*@END_MENU_TOKEN@*/)
                    .padding(.all, 5)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.888, green: 0.815, blue: 0.679)/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .font(.footnote)
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
            .padding(5)
            
            //var rows: [GridItem] =
            //        Array(repeating: .init(.fixed(200)), count: 1)
            let layout = [
                    GridItem(.adaptive(minimum:50))
                ]
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: layout, alignment: .top) {
                    /*
                    ForEach((0...79), id: \.self) {
                        let codepoint = $0 + 0x1f600
                        let emoji = String(Character(UnicodeScalar(codepoint)!))
                        Text("\(emoji)")
                            .font(.largeTitle)
                    }
                    */
                        ForEach(imageArray, id: \.self) { item in
                            Image(uiImage: item.image)
                                .resizable(capInsets: /*@START_MENU_TOKEN@*/EdgeInsets()/*@END_MENU_TOKEN@*/, resizingMode: .stretch)
                                .antialiased(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 200, height: 200, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                                .clipped()
                                
                            
                        }
                }
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
