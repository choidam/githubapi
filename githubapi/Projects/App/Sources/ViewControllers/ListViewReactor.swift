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
        case search(String?, String?)
        case getIssueList
    }
    
    enum Mutation {
        case search(String?, String?)
        case getIssueList(Single<[IssueItem]>)
        
        var bindMutation: BindMutation {
            switch self {
            case .search: return .search
            case .getIssueList: return .getIssueList
            }
        }
    }
    
    enum BindMutation {
        case initialState
        case search
        case getIssueList
    }
    
    struct State {
        var state: BindMutation = .initialState
        
        var organization: String = "apple"
        var repository: String = "Swift"
        
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
        case .search(let org, let repo):
            return .just(.search(org, repo))
        case .getIssueList:
            let org = currentState.organization
            let repo = currentState.repository
            return .just(.getIssueList(gitProvider.fetchIssueList(organization: org, repository: repo)))
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var state = state
        state.state = mutation.bindMutation
        
        switch mutation {
        case .search(let org, let repo):
            state.organization = org ?? ""
            state.repository = repo ?? ""
            
            action.onNext(.getIssueList)
        case .getIssueList(let response):
            response.subscribe(onSuccess: { issues in
                print("🎉🎉🎉🎉🎉 issues: \(issues)")
                state.sections = self.sections(list: issues)
            }).disposed(by: disposeBag)
        }
        
        return state
    }
}

extension ListViewReactor {
    private func sections(list: [IssueItem]?) -> [GitIssueSection] {
        guard let list = list else { return [] }

        let items: [GitIssueSectionItem] = list.map { issue in
            let cellReactor = GitIssueCellReactor(issue: issue)
            return .item(cellReactor)
        }

        return items.count > 0 ? [.section(items)] : []
    }
}
