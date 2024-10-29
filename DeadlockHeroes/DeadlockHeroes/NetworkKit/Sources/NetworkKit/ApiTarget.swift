//
//  File.swift
//  NetworkKit
//
//  Created by Данила Рахманов on 27.10.2024.
//

import Foundation
import Moya

public enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

public enum API {
    case getHeroes
    case getHeroImage(imageName: String)
}

extension API: TargetType {

    public var baseURL: URL {
        switch self {
        case .getHeroes:
            return URL(string: "https://assets.deadlock-api.com")!
        case .getHeroImage(let image):
            return URL(string: image) ??
                URL(string: "https://developers.elementor.com/docs/assets/img/elementor-placeholder-image.png")!
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

    public var method: Moya.Method {
        switch self {
        case .getHeroes:
            return .get
        case .getHeroImage:
            return .get
        }
    }

    public var task: Task {
        return .requestPlain
    }

    public var headers: [String: String]? {
        return nil
    }

    public var sampleData: Data {
        return Data()
    }
}
