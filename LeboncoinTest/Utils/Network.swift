//
//  Network.swift
//  LeboncoinTest
//
//  Created by Aurélien Haie on 05/09/2020.
//  Copyright © 2020 Aurélien Haie. All rights reserved.
//

import UIKit

class Network {
    
    static func parseUrl<T>(_ urlString: String, to object: T.Type, completion: @escaping (T) -> (), errorCompletion: @escaping () -> ()) where T : Decodable {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Failed fetching ads with err:", err)
                errorCompletion()
                return
            }
            
            guard let data = data else { return }
            
            do {
                let parsedData = try JSONDecoder().decode(T.self, from: data)
                completion(parsedData)
            } catch let e {
                print("Exception caught parsing JSON", e)
            }
        }.resume()
    }
    
    static func fetchImage(urlString: String, completion: @escaping (UIImage?) -> (), errorHandler: @escaping () -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            if let err = err {
                print("Error loading the image url:", err)
                return
            }
            
            if let response = response as? HTTPURLResponse, response.statusCode != 200 {
                print("Bad network response:", response.statusCode)
                errorHandler()
                return
            }
            
            guard let data = data else { return }
            OnlineImageView.savedImages[urlString] = UIImage(data: data)
            completion(UIImage(data: data))
        }.resume()
    }
    
}
