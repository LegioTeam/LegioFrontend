//
//  NetworkManager.swift
//  Legio
//
//  Created by Марат Нургалиев on 15/10/2019.
//  Copyright © 2019 Марат Нургалиев. All rights reserved.
//

import Foundation

protocol NetworkManagerProtocol {
	
	func registrate(login: String, password: String, completion: @escaping(_ userData: Success?, _ error: Error?) -> Void)
    func userAuth(login: String, password: String, completion: @escaping(_ userData: Success?, _ error: Error?) -> Void)
}

class NetworkManager: NetworkManagerProtocol {
	
	static let shared = NetworkManager()
	private init() {}
	
	func registrate(login: String, password: String, completion: @escaping(_ userData: Success?, _ error: Error?) -> Void) {
		var urlConstructor = URLComponents()
		
		
		urlConstructor.scheme = "http"
		urlConstructor.host = "legio-app.tmweb.ru"
		urlConstructor.path = "/api/register"
		
		urlConstructor.queryItems = [
			URLQueryItem(name: "email",  value: login),
			URLQueryItem(name: "password", value: password),
		]
		
		guard let registerURL = urlConstructor.url else {
			return
		}
		var requst = URLRequest(url: registerURL)
		requst.httpMethod = "POST"
		
		URLSession.shared.dataTask(with: requst) { (data, response, error) in
			guard let data = data else { return }
			
			DispatchQueue.main.async {
				do {
					let userData = try JSONDecoder().decode(Success.self, from: data)
					completion(userData, nil)
				} catch let error {
					print(error)
					completion(nil, error)
				}
			}
			}.resume()
	}
    
    func userAuth(login: String, password: String, completion: @escaping (_ userData:Success?, _ error: Error?) -> Void) {
        var urlConstructor = URLComponents()
        
        
        urlConstructor.scheme = "http"
        urlConstructor.host = "legio-app.tmweb.ru"
        urlConstructor.path = "/api/login"
        
        urlConstructor.queryItems = [
            URLQueryItem(name: "email",  value: login),
            URLQueryItem(name: "password", value: password),
        ]
        
        guard let registerURL = urlConstructor.url else {
            return
        }
        var requst = URLRequest(url: registerURL)
        requst.httpMethod = "POST"
        
        URLSession.shared.dataTask(with: requst) { (data, response, error) in
            guard let data = data else { return }
            
            DispatchQueue.main.async {
                do {
                    let userData = try JSONDecoder().decode(Success.self, from: data)
                    completion(userData, nil)
                } catch let error {
                    print(error)
                    completion(nil, error)
                }
            }
            }.resume()
    }
    
}
