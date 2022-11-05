//
//  DetailViewController.swift
//  App
//
//  Created by 최모지 on 2022/11/05.
//  Copyright © 2022 team.io. All rights reserved.
//

final class DetailViewController: UIViewController, ReactorKit.View {
    
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
    static func create() -> DetailViewController? {
        let detailViewReactor = DetailViewReactor()
        let detailViewController = DetailViewController()
        detailViewController.reactor = detailViewReactor
        
        return detailViewController
    }
    
    private func setNavigationBar(){
        view.backgroundColor = .white
    }
    
    private func addViews(){
        
    }
    
    private func initLayout(){
        setNavigationBar()
        addViews()
    }
}

extension DetailViewController {
    private func bindState(reactor: DetailViewReactor){
        
    }
    
    private func bindAction(reactor: DetailViewReactor){
        
    }
}
