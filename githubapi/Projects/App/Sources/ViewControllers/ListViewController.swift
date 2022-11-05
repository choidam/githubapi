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

class ListViewController: UIViewController, ReactorKit.View {
    
    // MARK: Property
    
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
    private func addViews(){
        
    }
    
    private func initLayout(){
        addViews()
        view.backgroundColor = .yellow
    }
}

extension ListViewController {
    private func bindState(reactor: ListViewReactor){
        
    }
    
    private func bindAction(reactor: ListViewReactor){
        
    }
}
