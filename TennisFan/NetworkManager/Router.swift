//
//  File.swift
//  TennisFan
//
//  Created by OS on 16.11.2022.
//

import Foundation
import Alamofire

enum TPType {
  case atp, wta
}

enum Router: URLRequestConvertible {
  case events(date: String), playerDetail(playerID: Int), playerImage(playerID: Int), rankings(gender: TPType), search(string: String)
  
  var baseURL: URL {
    switch self {
      case .events, .playerDetail, .playerImage, .rankings, .search: return URL(string: "https://tennisapi1.p.rapidapi.com/api/tennis")!
    }
  }
  var path: String {
    switch self {
      case .events(let date): return "events/\(date)"
      case .playerDetail(let id): return "player/\(id)"
      case .playerImage(let id): return "player/\(id)/image"
      case .rankings(let gender): return "rankings/\(gender)"
      case .search(let search): return "search/\(search)"
    }
  }
  var httpHeaders: [String : String] {
    switch self {
      case .search, .events, .playerDetail, .playerImage, .rankings:
        return ["X-RapidAPI-Key": "128a63a140mshfd951a8d630513ap1ef303jsnb96e928d33ce",
                "X-RapidAPI-Host": "tennisapi1.p.rapidapi.com"]
    }
  }
  var method: HTTPMethod {
    switch self {
      case .rankings, .playerDetail, .playerImage, .events, .search: return .get
    }
  }
  func asURLRequest() throws -> URLRequest {
    let url = baseURL.appendingPathComponent(path)
    var request = try URLRequest(url: url, method: method)
    request.allHTTPHeaderFields = httpHeaders
    return request
  }
}
