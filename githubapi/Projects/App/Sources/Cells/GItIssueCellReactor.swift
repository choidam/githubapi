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
        
    }
    
    var initialState: State
    
    init() {
        self.initialState = State()
    }
}
