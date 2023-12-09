//
//  HTTPClient.swift
//  Template
//
//  Created by Martin Kock on 08/12/2023.
//

import Foundation

public class HTTPClient {
      
      
      // MARK: - Private init
      public init() {}
      
      // MARK: - Private properties
      
      // MARK: - Public properties
     public enum typesOfRequest: String {
            case GET = "GET"
            case POST = "POST"
            case PUT = "PUT"
            case DELETE = "DELETE"
      }
      
     public enum NetworkError: Error {
            case badURL
            case noData
            case decodingError
            case timeout
      }
      
      // MARK: - Private functions
      
      
      // MARK: - Public functions
      
     public static func request<U: Decodable>(urlString: String, method: typesOfRequest, parameters: Parameters? = nil, responseType: U.Type, header: HTTPHeaders? = nil, timeout: TimeInterval = 60.0) async throws -> U {
            var finalURLString = urlString
            
            if method == .GET, let parameters = parameters {
                  let queryItems = parameters.parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
                  var urlComponents = URLComponents(string: urlString)
                  urlComponents?.queryItems = queryItems
                  guard let urlWithQuery = urlComponents?.url else {
                        throw NetworkError.badURL
                  }
                  finalURLString = urlWithQuery.absoluteString
            }
            
            guard let url = URL(string: finalURLString) else {
                  throw NetworkError.badURL
            }
            
            var request = URLRequest(url: url, timeoutInterval: timeout)
            request.httpMethod = method.rawValue
            
            if method == .POST, let parameters = parameters {
                  request.httpBody = parameters.encode()
            }
            
            if let header = header {
                  for httpHeader in header.headers {
                        request.addValue(httpHeader.value, forHTTPHeaderField: httpHeader.field)
                  }
            }
            
            do {
                  let (data, _) = try await URLSession.shared.data(for: request)
                  if data.isEmpty {
                        throw NetworkError.noData
                  }
                  let decoder = JSONDecoder()
                  let decodedResponse = try decoder.decode(U.self, from: data)
                  return decodedResponse
            } catch {
                  if let urlError = error as? URLError, urlError.code == .timedOut {
                        throw NetworkError.timeout
                  } else {
                        throw NetworkError.decodingError
                  }
            }
      }
}

// MARK: - Models
public struct Parameter {
      let key: String
      let value: String
}

public struct Parameters {
      let parameters: [Parameter]
}

extension Parameters {
      public func encode() -> Data {
            let parameterArray = parameters.map { "\($0.key)=\($0.value)" }
            return parameterArray.joined(separator: "&").data(using: .utf8)!
      }
      
      public func toDictionary() -> [String: String] {
            var dict = [String: String]()
            for param in parameters {
                  dict[param.key] = param.value
            }
            return dict
      }
}

public struct HTTPHeader {
      let field: String
      let value: String
}

public struct HTTPHeaders {
      let headers: [HTTPHeader]
}

