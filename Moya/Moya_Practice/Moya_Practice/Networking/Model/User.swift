//
//  User.swift
//  Moya_Practice
//
//  Created by 김수연 on 2021/11/22.
//

struct User: Decodable {

    var user = [User]()

    let id: Int
    let name: String
    let userName: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case userName = "username"
    }
}
