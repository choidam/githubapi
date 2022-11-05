//
//  GItIssueCellReactor.swift
//  App
//
//  Created by 최모지 on 2022/11/05.
//  Copyright © 2022 team.io. All rights reserved.
//

import Foundation
import ReactorKit

final class GitIssueCellReactor: Reactor {
    typealias Action = NoAction
    
    struct State {
        let number: Int?
        let title: String?
        let body: String?
    }
    
    var initialState: State
    
    init(issue: IssueItem) {
        self.initialState = State(number: issue.number,
                                  title: issue.title,
                                  body: issue.body)
    }
}
