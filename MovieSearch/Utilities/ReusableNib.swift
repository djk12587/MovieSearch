//
//  ReusableNib.swift
//  RotoReWrite
//
//  Created by Dan_Koza on 12/22/17.
//  Copyright © 2017 DanielKoza. All rights reserved.
//

import Foundation
import UIKit

protocol ReusableNib
{
    static var nibName: String { get }
    static var identifier: String { get }
    static func nib(bundle: Bundle) -> UINib
}

extension ReusableNib
{
    static var nibName: String
    {
        return String(describing: self)
    }

    static var identifier: String
    {
        return nibName + "ID"
    }

    static func nib(bundle: Bundle = Bundle.main) -> UINib
    {
        return UINib(nibName: nibName, bundle: bundle)
    }
}
