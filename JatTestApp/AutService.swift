//
//  ApiService.swift
//  JatTestApp
//
//  Created by Andrey Doroshko on 9/5/18.
//  Copyright © 2018 Andrey Doroshko. All rights reserved.
//

import Foundation

class AutService {
    static let signUpURLString = "https://apiecho.cf/api/signup/"
    static let logInURLString = "https://apiecho.cf/api/login/"
    static let logOutURLString = "https://apiecho.cf/api/logout/"

    func createAccount(with data: Dictionary<String, String>, completion: @escaping (_ data: LogInModel?, _ response: HTTPURLResponse?, _ error: Error?) -> ()) {
    
        let url = URL(string: AutService.signUpURLString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: data, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, nil, error)
                return }
            guard let respData = data else {
                completion(nil, httpResponse, error)
                return
            }
            let logInModel = try? JSONDecoder().decode(LogInModel.self, from: respData)
            if logInModel != nil {
                LogInModel.shared = logInModel!
            }
            Token.shared.saveToken(logInModel?.data?.access_token)
//                logOut()
            completion(logInModel, httpResponse, error)
        })
        task.resume()
    }
    
    func logIn(with data: Dictionary<String, String>, completion: @escaping (_ data: LogInModel?, _ response: HTTPURLResponse?, _ error: Error?) -> ()) {
        let url = URL(string: AutService.logInURLString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: data, options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, nil, error)
                return }
            guard let respData = data else {
                completion(nil, httpResponse, error)
                return
            }
            
            let logInModel = try? JSONDecoder().decode(LogInModel.self, from: respData)
            if logInModel != nil {
                LogInModel.shared = logInModel!
            }
            Token.shared.updateToken(logInModel?.data?.access_token)
//                logOut()
            print(Token.shared.getToken())
            completion(logInModel, httpResponse, error)
        })
        task.resume()
    }
    
    func logOut(completion: @escaping (_ response: HTTPURLResponse?, _ error: Error?) -> ()) {
        let url = URL(string: AutService.logInURLString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: ["access_token": Token.shared.getToken()], options: [])
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data, response, error in
            let _ = Token.shared.removeToken()
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, error)
                return
            }
            completion(httpResponse, error)
        })
        task.resume()
    }
}
