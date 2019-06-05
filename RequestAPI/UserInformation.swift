//
//  UserInformation.swift
//  RequestAPI
//
//  Created by Vu on 4/23/19.
//  Copyright © 2019 Vu. All rights reserved.
//

import Foundation

extension UserInfor {
    init(from service: UserInformation) {
        id = service.code
        client = []
        for data in service.data {
            client.append(data.client)
            
        }
    }
}
struct UserInfor {
    var id: Int
    var client: [Client]
    struct Client: Codable {
        var id: Int
        var phone: String
        var name: String
        var status: Int
        private enum CodingKeys: String, CodingKey {
            case id
            case phone = "phone_number"
            case name = "display_name"
            case status
        }
    }
}
struct UserInformation: Decodable {
    let code: Int
    let data: [Data]
    struct Data: Decodable {
        let id: Int
        let client: UserInfor.Client
    }
}

let decoder = JSONDecoder()
let userInfor = try decoder.decode([UserInformation].self, from: DataService.getData(([UserInformation])))
