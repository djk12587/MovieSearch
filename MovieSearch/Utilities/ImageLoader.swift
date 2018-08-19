//
//  ImageLoader.swift
//  MovieSearch
//
//  Created by Dan_Koza on 8/18/18.
//  Copyright © 2018 DanielKoza. All rights reserved.
//

import Foundation
import  UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView
{
    func imageFromURL(url: URL?, placeholder: UIImage = #imageLiteral(resourceName: "missing"))
    {
        guard let url = url else { image = placeholder; return }

        if let cachedImage = imageCache.object(forKey: url.absoluteString as NSString) as? UIImage {
            image = cachedImage
            return
        }

        image = placeholder
        URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) -> Void in
            guard error == nil else { return }
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data)
                {
                    imageCache.setObject(image, forKey: url.absoluteString as NSString)
                    self.image = image
                }
                else
                {
                    self.image = placeholder
                }
            }

        }).resume()
    }
}
