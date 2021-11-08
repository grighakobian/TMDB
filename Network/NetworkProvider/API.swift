//
//  API.swift
//  Network
//
//  Created by Grigor Hakobyan on 08.11.21.
//

import Moya

private let apiKey = "55b14a25af9de1c89aeecfce2fdf963e"

public enum API: TargetType {
    
    case popularTVShows
    
    public var baseURL: URL {
        return URL(string: "https://api.themoviedb.org/3")!
    }
    
    public var path: String {
        switch self {
        case .popularTVShows:
            return "tv/popular"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    public var task: Task {
        return .requestPlain
    }
    
    public var headers: [String : String]? {
        return nil
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var validationType: ValidationType {
        return .successCodes
    }
}

extension API: Authenticable {
    
    public var authenticationType: AuthenticationType {
        switch self {
        case .popularTVShows:
            return .plain(apiKey: apiKey)
        }
    }
}

