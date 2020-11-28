//
//  UIImageView.swift
//  TVBox
//
//  Created by Mohamed Sheta on 11/26/20.
//

import UIKit

extension UIImageView {
    func downloadImage(from url: URL, placeHolder: UIImage = #imageLiteral(resourceName: "placeholder.pdf"), completion: ((UIImage) -> Void)?) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else {
                    DispatchQueue.main.async() { [weak self] in
                        self?.image = placeHolder
                        if let completion = completion {
                            completion((self?.image)!)
                        }
                    }
                    return
            }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
                if let completion = completion {
                    completion(image)
                }
            }
        }.resume()
    }
    
    func downloadImage(from link: String, placeHolder: UIImage = #imageLiteral(resourceName: "placeholder.pdf"), completion: ((UIImage) -> Void)?) {
        guard let url = URL(string: link) else {
            self.image = placeHolder
            if let completion = completion {
                completion((self.image)!)
            }
            return }
        downloadImage(from: url, placeHolder: placeHolder, completion: completion)
    }
    
    func roundImage() {
        self.frame = CGRect(origin: self.frame.origin, size: CGSize(width: self.frame.width,height: self.frame.width))
        self.layer.cornerRadius = self.frame.width/2
        self.layer.masksToBounds = true
    }
}
