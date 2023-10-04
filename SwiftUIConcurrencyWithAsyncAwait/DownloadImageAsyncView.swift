//
//  DownloadImageAsyncView.swift
//  SwiftUIConcurrencyWithAsyncAwait
//
//  Created by Amit Saini on 04/10/23.
//

import SwiftUI
import Combine

class DownloadImageAsyncImageLoader {
    
    let url = URL(string: "https://picsum.photos/200")!
    
    func handleResponse(data: Data?, response: URLResponse?) -> UIImage? {
        guard
            let data = data,
            let image = UIImage(data: data),
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            return nil
        }
        return image
    }
    
    func downloadWithEscaping(completionHandler: @escaping (_ image: UIImage?,_ error: Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            let image = self?.handleResponse(data: data, response: response)
            completionHandler(image, nil)
        }
        .resume()
    }
    
    func downloadWithCombine() -> AnyPublisher<UIImage?, Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map(handleResponse)
            .mapError( { $0 })
            .eraseToAnyPublisher()
    }
}

class DownloadImageAsyncViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    var loader = DownloadImageAsyncImageLoader()
    var cancellable = Set<AnyCancellable>()
    
    func fetchImage() {
        //Direct allocation
        //self.image = UIImage(systemName: "heart.fill")
        
        //Download with Escaping closure
        //        loader.downloadWithEscaping { [weak self] image,error in
        //            //Main thread issue
        //            /*
        //            if let image = image {
        //                self?.image = image
        //            } else {
        //                self?.image = UIImage(systemName: "heart.fill")
        //            }
        //             */
        //            DispatchQueue.main.async {
        //                self?.image = image
        //            }
        
        //Download image with Combine
        //        loader.downloadWithCombine()
        //            .sink { _ in
        //
        //            } receiveValue: { [weak self] image in
        //                DispatchQueue.main.async {
        //                    self?.image = image
        //                }
        //            }
        //            .store(in: &cancellable)
        
        loader.downloadWithCombine()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: {_ in
                
            }, receiveValue: { [weak self] image in
                self?.image = image
            })
            .store(in: &cancellable)
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
                    .frame(width: 250,height: 250)
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
