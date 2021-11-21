//
//  UserService.swift
//  Moya_Practice
//
//  Created by 김수연 on 2021/11/22.
//

import Foundation
import Moya

enum UserService {
    case createUser(name: String)
    case readUsers
    case updateUser(id: Int, name: String)
    case deleteUser(id: Int)
}

/// MoyaProvider에 필요한 규격을 정의하는데 사용되는 프로토콜입니다. TargetType을 채택 후 제공하는 속성들을 통해서 구현을 해야만 통신이 가능
extension UserService: TargetType {
    /// endpoint의 baseURL 반환
    var baseURL: URL {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com") else {
            fatalError()
        }
        return url
    }
    /// 모든 target의 endpoint를 완성하기 위한 path를 반환
    var path: String {
        switch self {
        case .readUsers, .createUser(_):
            return "/users"
        case .updateUser(let id, _), .deleteUser(let id):
            return "/users/\(id)"
        }
    }
    /// 모든 target의 case에 따른 HTTP 메소드 반환
    var method: Moya.Method {
        switch self {
        case .createUser(_):
            return .post
        case .readUsers:
            return .get
        case .updateUser(_, _):
            return .put
        case .deleteUser(_):
            return .delete
        }
    }

    var sampleData: Data {
        switch self {
        case .createUser(let name):
            return "{'name':'\(name)'}".data(using: .utf8)!
        case .readUsers:
            return Data()
        case .updateUser(let id, let name):
            return "{'id':'\(id)', 'name':'\(name)'}".data(using: .utf8)!
        case .deleteUser(let id):
            return "{'id':'\(id)'}".data(using: .utf8)!
        }
    }
    /// 모든 target의 case에 따른 task를 반환
    var task: Task {
        switch self {
        /// param이 필요없는 경우
        case .readUsers, .deleteUser(_):
            return .requestPlain
        /// param 명시가 필요한 경우 
        case .createUser(let name), .updateUser(_, let name):
            return .requestParameters(parameters: ["name": name], encoding: JSONEncoding.default)
        }
    }

    var headers: [String : String]? {
        return ["Content-Typer" : "application/json"]
    }

}

