//
//  AsyncPublisherView.swift
//  SwiftUIConcurrencyWithAsyncAwait
//
//  Created by Amit Saini on 09/10/23.
//

import SwiftUI

/*
 
 */

class AsyncPublisherDataManager {
    @Published var fruitsArray: [String] = []
    
    func getFruits() {
        
    }
}

class AsyncPublisherViewModel: ObservableObject {
    @Published var dataArray: [String] = []
    var manager = AsyncPublisherDataManager()
    
    func getData() async {
        
    }
}
struct AsyncPublisherView: View {
    @StateObject private var vm = AsyncPublisherViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.dataArray, id: \.self) { element in
                    Text(element)
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    AsyncPublisherView()
}
