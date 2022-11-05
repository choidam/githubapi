//
//  DetailViewController.swift
//  App
//
//  Created by 최모지 on 2022/11/05.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit

final class DetailViewController: UIViewController, ReactorKit.View {
    
    private let bodyLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textColor = .black
    }
    
    // MARK: Property
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initLayout()
    }
    
    func bind(reactor: DetailViewReactor) {
        bindState(reactor: reactor)
        bindAction(reactor: reactor)
    }
}

extension DetailViewController {
    static func create(number: Int, body: String) -> DetailViewController? {
        let detailViewReactor = DetailViewReactor(number: number, body: body)
        let detailViewController = DetailViewController()
        detailViewController.reactor = detailViewReactor
        
        return detailViewController
    }
    
    private func setNavigationBar(){
        view.backgroundColor = .white
    }
    
    private func addViews(){
        view.addSubview(bodyLabel)
    }
    
    private func initLayout(){
        setNavigationBar()
        addViews()
        
        bodyLabel.snp.makeConstraints {
            $0.top.leading.equalTo(20)
            $0.trailing.bottom.equalTo(-20)
        }
    }
}

extension DetailViewController {
    private func bindState(reactor: DetailViewReactor){
        reactor.state
            .map { $0.number }
            .map { "#\($0)" }
            .subscribe(onNext: { [weak self] title in
                self?.title = title
            })
            .disposed(by: disposeBag)
        
        reactor.state
            .map { $0.body }
            .bind(to: bodyLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    private func bindAction(reactor: DetailViewReactor){
        
    }
}
