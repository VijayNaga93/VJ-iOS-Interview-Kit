//
//  FetchImageView.swift
//  ConcurrencyByTutorialsVJ
//
//  Created by Vijay N on 31/03/25.
//

import SwiftUI

struct FetchImageView: View {
    
    let viewModel = FetchImageViewModel()
    
    var body: some View {
        
        
        VStack(spacing: 20) {
            Image(uiImage: viewModel.fetchedImage)
            
    
            if viewModel.imageFetchState == .start {
                Button("Fetch Image") {
                    viewModel.fetchImage()
                }
            } else if viewModel.imageFetchState == .downloading {
                Button("Cancel Fetch") {
                    viewModel.cancelImageFetch()
                }
            } else if viewModel.imageFetchState == .completed {
                Button("Fetch Another Image") {
                    viewModel.fetchImage()
                }
            } else if viewModel.imageFetchState == .cancelled {
                Button("Failed Try Again") {
                    viewModel.fetchImage()
                }
            }

            
        }
        .frame(width: 200, height: 200, alignment: .center)
        .background(.gray)
    }
}

#Preview {
    FetchImageView()
}

//enum ImageFetchState {
//    case start
//    case downloading
//    case completed
//    case cancelled
//}

@Observable
class FetchImageViewModel {
    
    var imageFetchState: ImageFetchState = ImageFetchState.start
    
    var fetchedImage: UIImage = UIImage(systemName: "photo.artframe")!
    
    var imageDownloadOpe: ImageDownloadOperation1? = nil
    
    func fetchImage() {
        imageFetchState = .downloading
        if let url = URL(string: "https://picsum.photos/200/300") {
            imageDownloadOpe = ImageDownloadOperation1(imageURL: url)
            imageDownloadOpe?.imageClosure = { [weak self] image in
                if let img = image {
                    self?.imageFetchState = .completed
                    self?.fetchedImage = img
                } else {
                    self?.fetchedImage = UIImage(systemName: "network.slash")!
                    print("image fetch failed")
                }
            }
            
            let queue = OperationQueue()
            queue.addOperation(imageDownloadOpe!)
        }
    }
    
    func cancelImageFetch() {
        imageFetchState = .cancelled
        imageDownloadOpe?.cancel()
    }
}


//    let imageClosure: ((Result<UIImage, Error>) -> Void)?

class ImageDownloadOperation1: Operation {
    var imageURL: URL
    var downloadedImage: UIImage?
    
    var imageClosure: ((UIImage?) -> Void)? = nil
    
    init(imageURL: URL) {
        self.imageURL = imageURL
    }
    
    override func main() {
        if isCancelled {
            imageClosure?(nil)
            return
        }
        
        guard let imageData = try? Data(contentsOf: imageURL) else {
            return
        }
        
        if isCancelled {
            imageClosure?(nil)
            return
        }
        
        if !imageData.isEmpty {
            downloadedImage = UIImage(data: imageData)
            imageClosure?(downloadedImage)
        }
    }
}
