//
//  Exceptions.swift
//  Instructions+
//
//  Created by Wenyue Deng on 2021-01-16.
//


import Foundation

enum EntityExceptions: Error {
    case EntityNotFoundException(String)
}

enum HTTPRequestExceptions: Error {
    case DataRetrievalException(String)
    case JSONParsingException(String)
}

enum NetworkError: Error {
    case url
    case server
    case dataFormat
    case other(String)
}
