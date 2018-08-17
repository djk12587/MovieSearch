//
//  SegueIdentifier.swift
//  RotoReWrite
//
//  Created by Dan_Koza on 1/6/18.
//  Copyright © 2018 DanielKoza. All rights reserved.
//

import Foundation
import UIKit

protocol SegueIdentifier
{
    static var segueId: String { get }
}

extension SegueIdentifier where Self: UIViewController
{
    static var segueId: String
    {
        return String(describing: Self.self)
    }
}
