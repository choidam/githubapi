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
    }
    
    private var orgTextField = UITextField()
    
    private var repoTextField = UITextField()
    
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
            .map { ($0.organization, $0.repository) }
            .map { "\($0.0) \($0.1)" }
            .subscribe(onNext: { [weak self] title in
                self?.title = title
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.sections }
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func bindAction(reactor: ListViewReactor){
        tableView.rx.modelSelected(GitIssueSectionItem.self)
            .map { item  -> (Int?, String?) in
                switch item {
                case .item(let reactor):
                    return (reactor.currentState.number, reactor.currentState.body)
                }
            }
            .subscribe(onNext: { [weak self] (num, body) in
                let detailViewReactor = DetailViewReactor(number: num ?? 0, body: body ?? "")
                let detailViewController = DetailViewController()
                detailViewController.reactor = detailViewReactor
                
                self?.navigationController?.pushViewController(detailViewController, animated: true)
            })
            .disposed(by: disposeBag)
    }
    
    @objc func tapSearch(){
        let alert = UIAlertController(title: "원하는 검색어를 입력해 주세요", message: "", preferredStyle: UIAlertController.Style.alert)
        
        alert.addTextField { (textField) in
            self.orgTextField = textField
        }
        
        alert.addTextField { (textField) in
            self.repoTextField = textField
        }
        
        alert.addAction(UIAlertAction(title: "Search", style: UIAlertAction.Style.default, handler: { [weak self] _ in
            let organization = self?.orgTextField.text
            let repository = self?.repoTextField.text
            
            self?.reactor?.action.onNext(.search(organization, repository))
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}
