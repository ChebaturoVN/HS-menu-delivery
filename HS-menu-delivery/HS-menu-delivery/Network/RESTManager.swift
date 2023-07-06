//
//  RESTManager.swift
//  HS-menu-delivery
//
//  Created by VladimirCH on 06.07.2023.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

struct APIResponse<T: Codable> {
    let statusCode: Int
    var data: T?
}

class RESTManager {
    func request<T: Decodable>(url: URL, method: HTTPMethod, completion: @escaping (APIResponse<T>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue

        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(APIResponse(statusCode: 0, data: nil))
                return
            }

            let statusCode = httpResponse.statusCode
            var apiResponse = APIResponse<T>.init(statusCode: statusCode, data: nil)

            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(T.self, from: data)
                    apiResponse.data = decodedData
                } catch {
                    print("Error decoding response data: \(error)")
                    completion(apiResponse)
                }
            }

            completion(apiResponse)
        }
        task.resume()
    }
}
