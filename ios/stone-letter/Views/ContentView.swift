//
//  ContentView.swift
//  stone-letter
//
//  Created by SY L on 1/17/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack{
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                
                NavigationLink(destination: AdTestView()){
                    Text("ad test view")
                }
                NavigationLink(destination: LoginTestView()){
                    Text("login test view")
                }

            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
