//
//  ImageView.swift
//  SelectTravelOptions
//
//  Created by Claudio Madureira Silva Filho on 15/01/19.
//

import UIKit

var images: [String: UIImage?] = [:]

class ImageView: UIImageView {
    var dataTask: URLSessionDataTask?

    func castImage(from url: URL, with placeholder: UIImage?) {
        if images.keys.contains(url.absoluteString) {
            self.image = images[url.absoluteString] as? UIImage
            return
        }
        self.image = placeholder
        self.dataTask?.cancel()
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            OperationQueue.main.addOperation({
                self.dataTask = nil
                if let error = error {
                    print("SelectTravelOptionViewPod [\(Date())] -", error)
                    return
                }
                guard let data = data,
                    let image = UIImage(data: data) else { return }
                images.updateValue(image, forKey: url.absoluteString)
                self.image = image
            })
        })
        self.dataTask = task
        task.resume()
    }
}
