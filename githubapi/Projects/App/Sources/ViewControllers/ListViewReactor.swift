//
//  ListViewReactor.swift
//  App
//
//  Created by 최모지 on 2022/11/05.
//  Copyright © 2022 team.io. All rights reserved.
//

import Foundation
import ReactorKit

final class ListViewReactor: Reactor {
    typealias Action = NoAction
    
    struct State {
        // test
        var sections: [GitIssueSection] = [.section([.item(GitIssueCellReactor()),
                                                     .item(GitIssueCellReactor()),
                                                     .item(GitIssueCellReactor()),
                                                     .item(GitIssueCellReactor()),
                                                     .item(GitIssueCellReactor()),
                                                     .item(GitIssueCellReactor()),
                                                     .item(GitIssueCellReactor()),
                                                    ])]
    }
    
    var initialState: State
    
    init() {
        self.initialState = State()
    }
}
