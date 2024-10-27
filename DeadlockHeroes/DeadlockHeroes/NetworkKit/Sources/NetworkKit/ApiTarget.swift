//
//  File.swift
//  NetworkKit
//
//  Created by Данила Рахманов on 27.10.2024.
//

import Foundation

public protocol ApiTargetProtocol {
    var baseUrl: String { get }
    var path: String { get }
    var method: HttpMethod { get }
    var headers: [String: String]? { get }
}

public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum ApiTarget: ApiTargetProtocol {
    
    case getHeroes
    case getHeroImage(imageName: String)
    
    public var baseUrl: String {
        switch self {
        case .getHeroes:
            return "https://assets.deadlock-api.com"
        case .getHeroImage(let imagePath):
            return imagePath
        }
    }
    
    public var path: String {
        switch self {
        case .getHeroes:
            return "/v2/heroes"
        case .getHeroImage:
            return ""
        }
    }
    
    public var method: HttpMethod {
        switch self {
        case .getHeroes:
            return .get
        case .getHeroImage:
            return .get
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .getHeroes:
            return nil
        case .getHeroImage:
            return nil
        }
    }
}
