//
//  ApiService.swift
//  JatTestApp
//
//  Created by Andrey Doroshko on 9/6/18.
//  Copyright © 2018 Andrey Doroshko. All rights reserved.
//

import Foundation

class ApiService {
    
    static let getTextURLString = "https://apiecho.cf/api/get/text/?locale="
    
    func getText(with locale: String, completion: @escaping (_ data: TextModel?, _ response: HTTPURLResponse?, _ error: Error?) -> ()) {
        let authKey: String = "Bearer \(LogInModel.shared.data!.access_token)"
        guard let url = URL(string: ApiService.getTextURLString + locale) else { return  }
        var request = URLRequest(url: url)
        request.setValue(authKey, forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, nil, error)
                return }
            guard let respData = data else {
                completion(nil, httpResponse, error)
                return
            }
            
            let text = try? JSONDecoder().decode(TextModel.self, from: respData)
            completion(text, httpResponse, error)
        })
        task.resume()
    }
}

