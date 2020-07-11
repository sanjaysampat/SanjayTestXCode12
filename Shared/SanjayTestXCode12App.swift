//
//  SanjayTestXCode12App.swift
//  Shared
//
//  Created by Sanjay Sampat on 30/06/20.
//

import SwiftUI

@main
struct SanjayTestXCode12App: App {
    @StateObject private var imageStore = ImageStore()
    var body: some Scene {
        WindowGroup {
            ContentView( imageStore: imageStore )
        }
    }
}
