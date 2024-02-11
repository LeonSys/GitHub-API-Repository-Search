//
//  NetworkManager.swift
//  GitRepos
//
//  Created by Leon Horvath on 10/02/2024.
//

import UIKit

public class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com"
    let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getRepositories(searchingKeyWord: String?, completion: @escaping(Result<Response, NetworkError>) -> Void) {
        let keyWord = searchingKeyWord ?? "Swift"
        let endpoint = baseURL + "/search/repositories?q=\(keyWord)"
        
        guard let url = URL(string: endpoint) else {
            completion(.failure(.badURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.requestError))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.invalidDataRecieved))
                return
            }
            do {
                let decoder = JSONDecoder()
                let repos = try decoder.decode(Response.self, from: data)
                completion(.success(repos))
            } catch {
                completion(.failure(.invalidDataRecieved))
            }
        }
        task.resume()
    }
}
