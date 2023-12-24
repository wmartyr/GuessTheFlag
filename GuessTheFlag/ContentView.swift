//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Woodrow Martyr on 24/12/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                HStack(spacing: 0) {
                    Color.red
                    Color.blue
                }
                HStack(spacing: 0) {
                    Color.blue
                    Color.red
                }
            }
            Text("Hello World!")
                .foregroundStyle(.secondary)
                .padding(50)
                .background(.ultraThinMaterial)
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
