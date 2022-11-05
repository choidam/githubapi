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
        case getIssueList
    }
    
    enum Mutation {
        case getIssueList(Single<[IssueItem]>)
        
        var bindMutation: BindMutation {
            switch self {
            case .getIssueList: return .getIssueList
            }
        }
    }
    
    enum BindMutation {
        case initialState
        case getIssueList
        case setList
    }
    
    struct State {
        var state: BindMutation = .initialState
        
        var sections: [GitIssueSection] = []
    }
    
    var initialState: State
    var gitProvider: GithubProvider
    var disposeBag = DisposeBag()
    
    init(gitProvider: GithubProvider) {
        self.initialState = State()
        self.gitProvider = gitProvider
        
        action.onNext(.getIssueList)
    }
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .getIssueList:
            return .just(.getIssueList(gitProvider.fetchIssueList()))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        state.state = mutation.bindMutation
        
        switch mutation {
        case .getIssueList(let response):
            response.subscribe(onSuccess: { issues in
                print("🎉🎉🎉🎉🎉 issues: \(issues)")
                state.sections = self.sections(list: ["", "", ""])
            }).disposed(by: disposeBag)
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
