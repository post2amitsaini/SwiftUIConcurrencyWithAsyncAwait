//
//  DownloadImageAsyncView.swift
//  SwiftUIConcurrencyWithAsyncAwait
//
//  Created by Amit Saini on 04/10/23.
//

import SwiftUI

class DownloadImageAsyncImageLoader {
    
    let url = URL(string: "https://picsum.photos/200")!
    
    func downloadWithEscaping(completionHandler: @escaping (_ image: UIImage?,_ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let data = data,
                let image = UIImage(data: data),
                let response = response as? HTTPURLResponse,
                response.statusCode >= 200 && response.statusCode < 300 else {
                completionHandler(nil, error)
                return
            }
            completionHandler(image, nil)
        }
        .resume()
    }
}

class DownloadImageAsyncViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    var loader = DownloadImageAsyncImageLoader()
    
    func fetchImage() {
        //self.image = UIImage(systemName: "heart.fill")
        loader.downloadWithEscaping { [weak self] image,error in
            self?.image = image
        }
    }
}
struct DownloadImageAsyncView: View {
    @StateObject var vm = DownloadImageAsyncViewModel()
    
    var body: some View {
        ZStack {
            if let image = vm.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100,height: 100)
            }
        }
        .onAppear {
            vm.fetchImage()
        }
    }
}

struct DownloadImageAsyncView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadImageAsyncView()
    }
}
