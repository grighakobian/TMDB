//
//  AuthenticationPlugin.swift
//  Network
//
//  Created by Grigor Hakobyan on 08.11.21.
//

import Moya


public enum AuthenticationType {
    case noAuth
    case auth(URLQueryItem)
}

public protocol Authenticable {
    
    var authenticationType: AuthenticationType { get }
}


public final class AuthenticationPlugin: PluginType {
    
    public func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
        guard let target = target as? Authenticable, let url = request.url,
              var components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            return request
        }
        switch target.authenticationType {
        case .noAuth:
            return request
        case .auth(let queryItem):
            var adaptRequst = request
            var queryItems = components.queryItems ?? []
            queryItems.append(queryItem)
            components.queryItems = queryItems
            let url = try! components.asURL()
            adaptRequst.url = url
            return adaptRequst
        }
    }
}
