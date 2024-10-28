//
//  File.swift
//  NetworkKit
//
//  Created by Данила Рахманов on 27.10.2024.
//

import Foundation
import Moya

public protocol Networkable {
    var provider: MoyaProvider<API> { get }
    
    func fetchHeroes<T: Codable>(completion: @escaping (Result<T, Error>) -> Void)
    func fetchHeroImage(for image: String, completion: @escaping (Result<Data, Error>) -> Void)
}

public final class NetworkManager: Networkable {
    
    public var provider = MoyaProvider<API>()
    
    nonisolated(unsafe) public static let shared = NetworkManager()
    
    public func fetchHeroes<T: Codable>(completion: @escaping (Result<T, Error>) -> Void) {
        moyaRequest(API.getHeroes, completion: completion)
    }
    
    public func fetchHeroImage(for image: String, completion: @escaping (Result<Data, Error>) -> Void) {
        moyaRequest(API.getHeroImage(imageName: image), completion: completion)
    }
}

extension NetworkManager {
    
    private func moyaRequest<T: Codable>(_ target: API, completion: @escaping (Result<T, Error>) -> Void) {
        provider.request(target) { result in
            switch result {
            case let .success(response):
                do {
                    if T.self == Data.self {
                        completion(.success(response.data as! T))
                        return
                    }
                    
                    let result = try JSONDecoder().decode(T.self, from: response.data)
                    completion(.success(result))
                } catch {
                    completion(.failure(NetworkError.dataConversionFailure))
                }
            case .failure(_):
                completion(.failure(NetworkError.invalidResponse))
            }
        }
    }
}
