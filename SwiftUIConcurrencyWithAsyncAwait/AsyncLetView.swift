//
//  AsyncLetView.swift
//  SwiftUIConcurrencyWithAsyncAwait
//
//  Created by Amit Saini on 06/10/23.
//

import SwiftUI

struct AsyncLetView: View {
    @State private var images: [UIImage] = []
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVGrid(columns: columns, content: {
                    ForEach(images, id: \.self, content: { image in
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                    })
                })
            }
            .navigationTitle("Async Let Learning")
            .onAppear {
                self.images.append(UIImage(systemName: "heart.fill")!)
            }
        }
    }
}

#Preview {
    AsyncLetView()
}
