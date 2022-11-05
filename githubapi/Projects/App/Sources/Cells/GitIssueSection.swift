//
//  GitIssueSection.swift
//  App
//
//  Created by 최모지 on 2022/11/05.
//  Copyright © 2022 team.io. All rights reserved.
//


enum GitIssueSection {
    case section([GitIssueSectionItem])
}

extension GitIssueSection: SectionModelType {
    public var items: [GitIssueSectionItem] {
        switch self {
        case .section(let items): return items
        }
    }
    
    public init(original: GitIssueSection, items: [GitIssueSectionItem]) {
        switch original {
        case .section: self = .section(items)
        }
    }
}

enum GitIssueSectionItem {
    case item(GitIssueCellReactor)
}

