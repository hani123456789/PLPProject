//
//  ImageExtension.swift
//  PLP
//
//  Created by HaniMac on 03/08/2022.
//
import UIKit

let imageCache = NSCache<NSString, UIImage>()

extension UIImageView {
    
    func loadImageUsingCache(withUrl urlString : String, placeholder: String) {
        image = placeholder.isEmpty ? nil : UIImage(named: placeholder)
        
        if let cachedImage = imageCache.object(forKey: urlString as NSString)  {
            image = cachedImage
            return
        }
        guard let url = URL(string: urlString) else {
            image = UIImage(named: placeholder)
            return
        }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                DispatchQueue.main.async {
                    self.image = UIImage(named: placeholder)
                    return
                }
            }
            DispatchQueue.main.async {
                if data != nil {
                    if let image = UIImage(data: data!) {
                        imageCache.setObject(image, forKey: urlString as NSString)
                        self.image = image
                    }
                    else {
                        self.image = UIImage(named: placeholder)
                    }
                }
                else {
                    self.image = UIImage(named: placeholder)
                }
            }
        }).resume()
    }
}
