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
    @State private var myAuthorizationStatus: PHAuthorizationStatus = .notDetermined
    @State private var myAuthorizationMessage = "Authorization status not found"
    @State private var myAuthorizationSystemImage = "hand.raised"
    @State var imageArray: [ItemImage] = []
    @ObservedObject var imageStore: ImageStore
    
    var body: some View {
        
        VStack(alignment: .center) {
            VStack(alignment: .center) {
                Text("Hello, world!").font(.title).fontWeight(.regular).multilineTextAlignment(.center).padding()
                Text("nice to see you")
                HStack {
                    Spacer()
                    Label("App to select photos and display at bottom in LazyHGrid", systemImage: "forward")
                        .padding(.all, 5)
                        .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.888, green: 0.815, blue: 0.679)/*@END_MENU_TOKEN@*/)
                        .multilineTextAlignment(.center)
                        .lineLimit(nil)
                        .font(/*@START_MENU_TOKEN@*/.body/*@END_MENU_TOKEN@*/)
                        .labelStyle(CenteredLabelStyle())
                    Spacer()
                }
            }
            .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.pink/*@END_MENU_TOKEN@*/)
            
            VStack {
                HStack {
                    Button("Grant Access") {
                        // system prompts user, if user has not choose any option.
                        let accessLevel: PHAccessLevel = .readWrite
                        PHPhotoLibrary.requestAuthorization(for: accessLevel) { authorizationStatus in
                            myAuthorizationStatus = authorizationStatus
                            switch myAuthorizationStatus {
                            case PHAuthorizationStatus.limited:
                                myAuthorizationMessage = "Limited Authorization"
                                myAuthorizationSystemImage = "photo"
                            case PHAuthorizationStatus.authorized:
                                myAuthorizationMessage = "Full Authorization"
                                myAuthorizationSystemImage = "hand.thumbsup"
                            default:
                                myAuthorizationMessage = "Please grant access from Settings->Privacy->Photos->SanjayTestXcode12"
                                myAuthorizationSystemImage = "hand.raised"
                            }
                        }
                    }
                    
                    Spacer()
                    /*
                    // currently not getting access to photos.
                    // https://developer.apple.com/forums/thread/654021
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
                     */

                    Button("PhPickerWithPhotoKit") {
                        let accessLevel: PHAccessLevel = .readWrite
                        myAuthorizationStatus = PHPhotoLibrary.authorizationStatus(for: accessLevel)
                        if myAuthorizationStatus == .authorized || myAuthorizationStatus == .limited {
                            isPresentedPhPickerWithPhotoKit.toggle()
                        } else {
                            PHPhotoLibrary.requestAuthorization(for: accessLevel) { authorizationStatus in
                                myAuthorizationStatus = authorizationStatus
                                switch myAuthorizationStatus {
                                case PHAuthorizationStatus.limited:
                                    myAuthorizationMessage = "Limited Authorization"
                                    myAuthorizationSystemImage = "photo"
                                case PHAuthorizationStatus.authorized:
                                    myAuthorizationMessage = "Full Authorization"
                                    myAuthorizationSystemImage = "hand.thumbsup"
                                default:
                                    myAuthorizationMessage = "Please grant access from Settings->Privacy->Photos->SanjayTestXcode12"
                                    myAuthorizationSystemImage = "hand.raised"
                                }
                                if authorizationStatus == .authorized || authorizationStatus == .limited {
                                    isPresentedPhPickerWithPhotoKit.toggle()
                                }
                            }
                        }
                    }.sheet(isPresented: $isPresentedPhPickerWithPhotoKit) {
                        PhPickerWithPhotoKit(isPresentedPhPickerWithPhotoKit: $isPresentedPhPickerWithPhotoKit, imageArray : $imageArray )
                    }
                    .padding(.all, 5)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color.white/*@END_MENU_TOKEN@*/)
                    .cornerRadius(10.0)
                    .clipped(antialiased: true)
                }
            }
            .padding(5)
            
            VStack(alignment: .center) {
                
                Label("\(myAuthorizationMessage)", systemImage:myAuthorizationSystemImage)
                    .padding(.all, 5)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.888, green: 0.815, blue: 0.679)/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .font(.footnote)
                    .labelStyle(CenteredLabelStyle())
                
                Label("If access for the selected photo is not given then will show thumbnail quality photo.", systemImage: "info.circle")
                    .padding(.all, 5)
                    .background(/*@START_MENU_TOKEN@*//*@PLACEHOLDER=View@*/Color(red: 0.888, green: 0.815, blue: 0.679)/*@END_MENU_TOKEN@*/)
                    .multilineTextAlignment(.center)
                    .lineLimit(nil)
                    .font(.footnote)
                    .labelStyle(CenteredLabelStyle())
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
                    //GridItem(.adaptive(minimum:50))
                GridItem(.fixed(250))
                ]
            
            ScrollView(.horizontal) {
                LazyHGrid(rows: layout, alignment: .center) {
                    /*
                    ForEach((0...79), id: \.self) {
                        let codepoint = $0 + 0x1f600
                        let emoji = String(Character(UnicodeScalar(codepoint)!))
                        Text("\(emoji)")
                            .font(.largeTitle)
                    }
                    */
                        ForEach(imageArray, id: \.self) { item in
                            //Text("\(item.id)")
                            Image(uiImage: item.image)
                                .resizable(capInsets: /*@START_MENU_TOKEN@*/EdgeInsets()/*@END_MENU_TOKEN@*/, resizingMode: .stretch)
                                .antialiased(/*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 250, height: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
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

struct CenteredLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
            configuration.title
        }
    }
}
