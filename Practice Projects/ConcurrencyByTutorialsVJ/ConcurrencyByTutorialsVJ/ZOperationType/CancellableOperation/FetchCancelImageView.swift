//
//  FetchCancelImageView.swift
//  ConcurrencyByTutorialsVJ
//
//  Created by Vijay N on 01/04/25.
//

import SwiftUI

struct FetchCancelImageView: View {
    @StateObject private var viewModel = FetchCancelImageViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Image(uiImage: viewModel.fetchedImage)
                .resizable()
                .scaledToFit()
                .frame(width: 150, height: 150)
                .background(Color.gray.opacity(0.3))
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            switch viewModel.imageFetchState {
            case .start:
                ActionButton(title: "Fetch Image", action: viewModel.fetchImage)
            case .downloading:
                ActionButton(title: "Cancel Fetch", action: viewModel.cancelImageFetch, color: .red)
            case .completed:
                ActionButton(title: "Fetch Another Image", action: viewModel.fetchImage)
            case .cancelled:
                ActionButton(title: "Failed Try Again", action: viewModel.fetchImage, color: .orange)
            }
            
        }
        .padding()
    }
}

struct ActionButton: View {
    let title: String
    let action: () -> Void
    var color: Color = .blue
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(color)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
    }
}

#Preview {
    FetchCancelImageView()
}

// MARK: - ImageFetchState Enum
enum ImageFetchState {
    case start, downloading, completed, cancelled
}

// MARK: - FetchCancelImageViewModel
class FetchCancelImageViewModel: ObservableObject {
    @Published var imageFetchState: ImageFetchState = .start
    @Published var fetchedImage: UIImage = UIImage(systemName: "photo.artframe")!
    
    private var imageDownloadOpe: ImageDownloadOperation?
    
    func fetchImage() {
        imageFetchState = .downloading
        guard let url = URL(string: "https://picsum.photos/200/300") else { return }
        
        imageDownloadOpe = ImageDownloadOperation(imageURL: url)
        imageDownloadOpe?.completionHandler = { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    self?.imageFetchState = .completed
                    self?.fetchedImage = image
                case .failure:
                    self?.imageFetchState = .cancelled
                    self?.fetchedImage = UIImage(systemName: "network.slash")!
                }
            }
        }
        
        ImageDownloadManager.shared.addOperation(imageDownloadOpe!)
    }
    
    func cancelImageFetch() {
        imageFetchState = .cancelled
        imageDownloadOpe?.cancel()
    }
}

// MARK: - ImageDownloadOperation
class ImageDownloadOperation: Operation {
    let imageURL: URL
    var completionHandler: ((Result<UIImage, Error>) -> Void)?
    
    init(imageURL: URL) {
        self.imageURL = imageURL
    }
    
    override func main() {
        if isCancelled {
            completionHandler?(.failure(NSError(domain: "Cancelled", code: -999, userInfo: nil)))
            return
        }
        
        let semaphore = DispatchSemaphore(value: 0)
        var fetchedImage: UIImage?
        var fetchError: Error?
        
        
        let task = URLSession.shared.dataTask(with: imageURL) { data, _, error in
            if let error = error {
                fetchError = error
            } else if let data = data {
                fetchedImage = UIImage(data: data)
            }
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
        
        if isCancelled {
            completionHandler?(.failure(NSError(domain: "Cancelled", code: -999, userInfo: nil)))
        } else if let image = fetchedImage {
            completionHandler?(.success(image))
        } else {
            completionHandler?(.failure(NSError(domain: "DownloadError", code: -1, userInfo: nil)))
        }
    }
}

// MARK: - ImageDownloadManager (Singleton for Queue Management)
class ImageDownloadManager {
    static let shared = ImageDownloadManager()
    private let queue = OperationQueue()
    
    private init() {
        queue.maxConcurrentOperationCount = 2
    }
    
    func addOperation(_ operation: ImageDownloadOperation) {
        queue.addOperation(operation)
    }
    
    func cancelAllDownloads() {
        queue.cancelAllOperations()
    }
}
