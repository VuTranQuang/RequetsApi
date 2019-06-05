//
//  DataServices.swift
//  RequestAPI
//
//  Created by Vu on 4/23/19.
//  Copyright © 2019 Vu. All rights reserved.
//

import Foundation
typealias JSON = Dictionary<AnyHashable, Any>
class DataService {
    static var shared: DataService = DataService()
    
    func getData(completedHandler: @escaping([UserInformation]) -> Void){
        guard let url = URL(string: "http://159.65.135.188:9670/clients/history/4") else {return}
        let urlRequest = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) {(data, _, error) in
            guard error == nil else {
                print(error?.localizedDescription ?? "Response Error")
                return
            }
            guard let aData = data else {return}
            
            do {
                if let jsonResponse = try JSONSerialization.jsonObject(with: aData, options: .mutableContainers) as? JSON {
                    completedHandler([try UserInformation(from: jsonResponse as! Decoder)])
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
    }
}
