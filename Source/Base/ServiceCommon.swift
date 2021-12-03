import UIKit
import Nuke

@discardableResult
public func loadImage(with url: URL, options: ImageLoadingOptions = .shared,
                      into view: ImageDisplayingView,
                      completion: ((_ result: Result<ImageResponse, ImagePipeline.Error>) -> Void)? = nil) -> ImageTask? {
    return Nuke.loadImage(with: url, options: options, into: view, completion: completion)
}

fileprivate extension URLRequest {
    init(url: URL, method: String, headers: [String: String]? = nil) throws {
        self.init(url: url)
        httpMethod = method
        allHTTPHeaderFields = headers
    }
}
