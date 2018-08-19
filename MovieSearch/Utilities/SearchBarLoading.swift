//
//  SearchBarLoading.swift
//  MovieSearch
//
//  Created by Dan_Koza on 8/18/18.
//  Copyright © 2018 DanielKoza. All rights reserved.
//

import Foundation
import UIKit

var searchBarMagnifyingGlassImage: UIImage?

extension UISearchBar
{
    var textField: UITextField?
    {
        let svs = subviews.flatMap { $0.subviews }
        guard let tf = (svs.filter { $0 is UITextField }).first as? UITextField else { return nil }
        return tf
    }

    private var activityIndicator: UIActivityIndicatorView?
    {
        return textField?.leftView?.subviews.compactMap { $0 as? UIActivityIndicatorView }.first
    }

    var isLoading: Bool
    {
        get
        {
            return activityIndicator != nil
        }

        set
        {
            if newValue
            {
                if activityIndicator == nil
                {
                    let newActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
                    newActivityIndicator.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                    newActivityIndicator.startAnimating()
                    let localTextField = textField
                    localTextField?.leftView?.addSubview(newActivityIndicator)
                    let leftViewSize = localTextField?.leftView?.frame.size ?? CGSize.zero
                    newActivityIndicator.center = CGPoint(x: leftViewSize.width/2, y: leftViewSize.height/2)
                    let searchBarImageView = localTextField?.leftView as? UIImageView
                    if searchBarMagnifyingGlassImage == nil
                    {
                        searchBarMagnifyingGlassImage = searchBarImageView?.image
                    }
                    searchBarImageView?.image = nil
                }
            }
            else
            {
                if let cachedMagnifyingGlassImage = searchBarMagnifyingGlassImage
                {
                    (textField?.leftView as? UIImageView)?.image = cachedMagnifyingGlassImage
                }
                activityIndicator?.removeFromSuperview()
            }
        }
    }
}
