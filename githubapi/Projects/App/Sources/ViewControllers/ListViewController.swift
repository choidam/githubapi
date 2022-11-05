//
//  ListViewController.swift
//  App
//
//  Created by 최모지 on 2022/11/05.
//  Copyright © 2022 team.io. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import ReactorKit

final class ListViewController: UIViewController, ReactorKit.View {
    
    // MARK: UI
    
    private let tableView = UITableView().then {
        $0.register(cellType: GitIssueCell.self)
        $0.separatorStyle = .singleLine
        $0.allowsSelection = false
    }
    
    // MARK: Property
    
    var dataSource = RxTableViewSectionedReloadDataSource<GitIssueSection> { dataSource, tableView, indexPath, sectionItem in
        switch sectionItem {
        case .item(let reactor):
            let cell = tableView.dequeueReusableCell(for: indexPath) as GitIssueCell
            cell.reactor = reactor
            return cell
        }
    }
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
    }
    
    func bind(reactor: ListViewReactor) {
        bindState(reactor: reactor)
        bindAction(reactor: reactor)
    }
}

extension ListViewController {
    static func create() -> ListViewController? {
        let gitProvier = GithubProvider(isStub: true)
        let listViewReactor = ListViewReactor(gitProvider: gitProvier)
        let listViewController = ListViewController()
        listViewController.reactor = listViewReactor
        
        return listViewController
    }
    
    private func setNavigationBar(){
        view.backgroundColor = .white
        
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "test test"
        
        let searchButton = UIBarButtonItem(title: "Search", style: .plain, target: self, action: #selector(tapSearch))
        self.navigationItem.rightBarButtonItem = searchButton
    }
    
    private func addViews(){
        view.addSubview(tableView)
    }
    
    private func initLayout(){
        setNavigationBar()
        addViews()
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(0)
        }
    }
}

extension ListViewController {
    private func bindState(reactor: ListViewReactor){
        reactor.state
            .map { $0.sections }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func bindAction(reactor: ListViewReactor){
        
    }
    
    @objc func tapSearch(){
        print("tap search")
    }
}
