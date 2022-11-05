//
//  GithubProvider.swift
//  App
//
//  Created by 최모지 on 2022/11/05.
//  Copyright © 2022 team.io. All rights reserved.
//

class GithubProvider: ProviderProtocol {

    typealias T = GithubAPI
    var provider: MoyaProvider<GithubAPI>

    required init(isStub: Bool = false, sampleStatusCode: Int = 200, customEndpointClosure: ((T) -> Endpoint)? = nil) {
        provider = Self.consProvider(isStub, sampleStatusCode, customEndpointClosure)
    }

    func fetchIssueList(organization: String, repository: String) -> Single<[IssueItem]> {
        return request(type: [IssueItem].self,
                       target: .getIssues(organization: organization, repository: repository))
    }
}
