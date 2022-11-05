//
//  DetailViewReactor.swift
//  App
//
//  Created by 최모지 on 2022/11/05.
//  Copyright © 2022 team.io. All rights reserved.
//

final class DetailViewReactor: Reactor {
    typealias Action = NoAction
    
    struct State {
        var number: Int
        var body: String
    }
    
    var initialState: State
    
    init(number: Int, body: String) {
        self.initialState = State(number: number,
                                  body: body)
    }
}
