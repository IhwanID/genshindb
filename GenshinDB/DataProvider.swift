//
//  DataProvider.swift
//  GenshinDB
//
//  Created by Ihwan on 04/05/21.
//

import Foundation
import Moya

let genshinProvider = MoyaProvider<GenshinDB>(plugins: [NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))])

public enum GenshinDB {
    case artifacts
    case characters
    case consumables
    case domains
    case elements
    case enemies
    case materials
    case nations
    case weapons
}

extension GenshinDB: TargetType {
    
    public var baseURL: URL { return URL(string: "https://api.genshin.dev")! }
    
    public var path: String {
        switch self {
        case .artifacts:
            return "/artifacts"
        case .characters:
            return "/characters"
        case .consumables:
            return "/consumables"
        case .domains:
            return "/domains"
        case .elements:
            return "/elements"
        case .enemies:
            return "/enemies"
        case .materials:
            return "/materials"
        case .nations:
            return "/nations"
        case .weapons:
            return "/weapons"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var headers: [String: String]? {
        return nil
    }
}

