//
//  ContentView.swift
//  SwiftUI Example
//  This file contains the implementation of the ContentView struct, which is a SwiftUI View.
//  The ContentView struct defines the user interface of the app, displaying two text components
//  in a vertical stack (VStack).
//

import SwiftUI

/// A view that displays a vertical stack of text components.
struct ContentView: View {
    var body: some View {
        VStack {
            /// A text component that displays a greeting message.
            /// - font: largeTitle
            /// - fontWeight: bold
            /// - foregroundColor: blue
            /// - padding: standard padding
            Text("Hello, SwiftUI!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.blue)
                .padding()
            
            /// A text component that displays a simple description.
            /// - font: body
            /// - foregroundColor: gray
            Text("This is a simple text component example.")
                .font(.body)
                .foregroundColor(.gray)
        }
    }
}

/// A preview provider for the ContentView, used to display the view in the Xcode preview canvas.
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
