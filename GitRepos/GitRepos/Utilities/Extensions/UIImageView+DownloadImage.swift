//
//  UIImageView+DownloadImage.swift
//  GitRepos
//
//  Created by Leon Horvath on 11/02/2024.
//

import UIKit

extension UIImageView {
    func downloadImage(from urlString: String) {
        
        let cache = NetworkManager.shared.cache
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if error != nil {
                return
            }
            guard let urlResponse = response as? HTTPURLResponse, urlResponse.statusCode == 200 else {
                return
            }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async { self?.image = image }
        }
        task.resume()
    }
}
