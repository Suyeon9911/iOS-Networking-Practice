//
//  PostService.swift
//  DaangnMarket
//
//  Created by 김수연 on 2021/12/04.
//

import Foundation

import Moya
import AVFAudio

enum PostService {
    case postItem(title: String,
                  category: String,
                  price: String,
                  state: String,
                  trade: String,
                  content: String)
}

extension PostService: TargetType {
    public var baseURL: URL {
        return URL(string: GeneralAPI.baseURL)!
    }

    var path: String {
        switch self {
        case .postItem(_, _, _, _, _, _):
            return "/post/upload"
        }
    }

    var method: Moya.Method {
        switch self {
        case .postItem(_, _, _, _, _, _):
            return .post
        }
    }

    var task: Task {
        switch self {
        case .postItem(let title, let category, let price, let state, let trade, let content):
            return .requestParameters(parameters: [
                "title": title,
                "category": category,
                "price": price,
                "state": state,
                "trade": trade,
                "content": content
            ], encoding: JSONEncoding.default)
        }
    }

    var headers: [String : String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
}
