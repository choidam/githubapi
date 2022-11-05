//
//  GithubApi.swift
//  App
//
//  Created by 최모지 on 2022/11/05.
//  Copyright © 2022 team.io. All rights reserved.
//


enum GithubAPI {
    static var token = "Bearer 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" // test
    
    // 이슈 리스트 조회
    case getIssues
}

extension GithubAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api.github.com")!
    }
    
    var path: String {
        switch self {
        case .getIssues:
            return "repos/apple/swift/issues"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getIssues:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case .getIssues:
            return .requestParameters(parameters: [:], encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        default:
            return ["Authorization" : GithubAPI.token]
        }
    }
    
    var sampleData: Data {
        switch self {
        case .getIssues:
            return Data(
                """
                    [
                        {
                            "number": 123,
                            "title": "title1111",
                        },
                        {
                            "number": 456,
                            "title": "title2222222"
                        }
                    ]
                """.utf8
            )
        }
    }
}
