//
//  ProviderProtocol.swift
//  App
//
//  Created by 최모지 on 2022/11/05.
//  Copyright © 2022 team.io. All rights reserved.
//

protocol ProviderProtocol {
    associatedtype T: TargetType

    var provider: MoyaProvider<T> { get }
    init(isStub: Bool, sampleStatusCode: Int, customEndpointClosure: ((T) -> Endpoint)?)
}

extension ProviderProtocol {

    static func consProvider(
        _ isStub: Bool = false,
        _ sampleStatusCode: Int = 200,
        _ customEndpointClosure: ((T) -> Endpoint)? = nil) -> MoyaProvider<T> {

        if isStub == false {
            return MoyaProvider<T>()
        } else {
            let endPointClosure = { (target: T) -> Endpoint in
                let sampleResponseClosure: () -> EndpointSampleResponse = {
                    EndpointSampleResponse.networkResponse(sampleStatusCode, target.sampleData)
                }

                return Endpoint(
                    url: URL(target: target).absoluteString,
                    sampleResponseClosure: sampleResponseClosure,
                    method: target.method,
                    task: target.task,
                    httpHeaderFields: target.headers
                )
            }
            return MoyaProvider<T>(
                endpointClosure: customEndpointClosure ?? endPointClosure,
                stubClosure: MoyaProvider.immediatelyStub
            )
        }
    }
}

extension ProviderProtocol {
    func request<D: Decodable>(type: D.Type,
                               atKeyPath keyPath: String? = nil,
                               target: T) -> Single<D> {
        provider.rx.request(target)
                    .map(type, atKeyPath: keyPath)
    }
}
