//
//  File.swift
//  NetworkKit
//
//  Created by Данила Рахманов on 27.10.2024.
//

import Foundation

public final class NetworkManager: Sendable {
    
    public static let shared = NetworkManager()
    
    public func fetchHeroes<T: Codable>(completion: @escaping @Sendable (Result<T, Error>) -> Void) {
        request(ApiTarget.getHeroes, completion: completion)
    }
    
    public func fetchHeroImage(for image: String, completion: @escaping @Sendable (Result<Data, Error>) -> Void) {
        request(ApiTarget.getHeroImage(imageName: image), completion: completion)
    }
    
    private func request<T: Codable>(_ target: ApiTargetProtocol, completion: @escaping @Sendable (Result<T, Error>) -> Void) {
        guard let url = URL(string: target.baseUrl)?.appendingPathComponent(target.path) else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        print("fetching")
        
        var request = URLRequest(url: url)
        request.httpMethod = target.method.rawValue
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200..<299).contains(response.statusCode) else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            if let data {
                do {
                    if T.self == Data.self {
                        completion(.success(data as! T))
                        return
                    }
                    
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(NetworkError.dataConversionFailure))
                }
            }
        }.resume()
    }
}
