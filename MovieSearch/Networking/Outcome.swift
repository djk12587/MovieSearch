//
//  Outcome.swift
//  MovieSearch
//
//  Created by Dan_Koza on 8/18/18.
//  Copyright © 2018 DanielKoza. All rights reserved.
//

import Foundation

enum Outcome<Value>
{
    case success(Value)
    case failure(Error)

    var value: Value?
    {
        if case .success(let theValue) = self
        {
            return theValue
        }
        return nil
    }

    var error: Error?
    {
        if case .failure(let theError) = self
        {
            return theError
        }
        return nil
    }

    var success: Bool
    {
        if case .success = self
        {
            return true
        }
        return false
    }
}
