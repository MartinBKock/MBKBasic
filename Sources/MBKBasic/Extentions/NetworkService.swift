//
//  File.swift
//  
//
//  Created by Martin Kock on 28/09/2023.
//

import Foundation

enum NetworkError: Error {
          case invalidURL
          case invalidCode
    }

public class JSONService {
    
    
    
    private init() {}
    
    @available(iOS 13.0.0, *)
    public func LoadJsonArray<T: Codable>(from urlString: String, for type: T.Type) async throws -> [T] {
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidCode
        }
        
        let decoder = JSONDecoder()
        let jsonObjects: [T] = try decoder.decode([T].self, from: data)
        return jsonObjects
    }
    
    @available(iOS 13.0.0, *)
    public func LoadJson<T: Codable>(from urlString: String, for type: T.Type) async throws -> T {
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL }
        let request = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: request)
        guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.invalidCode
        }
        
        let decoder = JSONDecoder()
        let jsonObject: T = try decoder.decode(T.self, from: data)
        return jsonObject
    }
    
}

