//
//  NetworkProvider.swift
//  Network
//
//  Created by Grigor Hakobyan on 08.11.21.
//


import Moya

public protocol NetworkProviderType: AnyObject {
    init(configuration: URLSessionConfiguration)
    
    func provideDefaultNetworkProvider()->MoyaProvider<API>
}

public final class NetworkProvider: NetworkProviderType {
    
    private let moyaProvider: MoyaProvider<API>
    
    public init(configuration: URLSessionConfiguration) {
        let session = Session(configuration: configuration)
        moyaProvider = MoyaProvider<API>(session: session)
    }
    
    public func provideDefaultNetworkProvider() -> MoyaProvider<API> {
        return moyaProvider
    }
}
