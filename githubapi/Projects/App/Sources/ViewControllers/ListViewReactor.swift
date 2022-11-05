//
//  ListViewReactor.swift
//  App
//
//  Created by 최모지 on 2022/11/05.
//  Copyright © 2022 team.io. All rights reserved.
//

import RxRelay

final class ListViewReactor: Reactor {
    
    enum Action {
        case setList
    }
    
    enum Mutation {
        case setList
        
        var bindMutation: BindMutation {
            switch self {
            case .setList: return .setList
            }
        }
    }
    
    enum BindMutation {
        case initialState
        case setList
    }
    
    struct State {
        var state: BindMutation = .initialState
        
        var sections: [GitIssueSection] = []
    }
    
    var initialState: State
    
    init() {
        self.initialState = State()
        
        action.onNext(.setList)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .setList:
            return .just(.setList)
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        state.state = mutation.bindMutation
        
        switch mutation {
        case .setList:
            state.sections = self.sections(list: ["", "", "", "", ""])
        }
        
        return state
    }
}

extension ListViewReactor {
    private func sections(list: [String]?) -> [GitIssueSection] {
        guard let list = list else { return [] }

        let items: [GitIssueSectionItem] = list.map { _ in
            let cellReactor = GitIssueCellReactor()
            return .item(cellReactor)
        }

        return items.count > 0 ? [.section(items)] : []
    }
}
