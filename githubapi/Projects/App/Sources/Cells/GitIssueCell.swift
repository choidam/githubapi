//
//  GitIssueCell.swift
//  App
//
//  Created by 최모지 on 2022/11/05.
//  Copyright © 2022 team.io. All rights reserved.
//

import UIKit

final class GitIssueCell: UITableViewCell, ReactorKit.View, Reusable {
    
    // MARK: UI
    
    private let numberLabel = UILabel().then {
        $0.text = "5555"
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
    private let titleLabel = UILabel().then {
        $0.text = "titletitlelkttktktkkkkdksdlkfjlasjflkssldkjfl"
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
    // MARK: Property
    
    var disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        initLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(reactor: GitIssueCellReactor) {
        bindState(reactor: reactor)
        bindAction(reactor: reactor)
    }
    
}

extension GitIssueCell {
    private func addViews(){
        addSubview(numberLabel)
        addSubview(titleLabel)
    }
    
    private func initLayout(){
        addViews()
                
        numberLabel.snp.makeConstraints {
            $0.leading.equalTo(15)
            $0.top.equalTo(10)
            $0.bottom.equalTo(-10)
            $0.width.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(numberLabel.snp.trailing).offset(10)
            $0.trailing.equalTo(-10)
            $0.centerY.equalTo(numberLabel.snp.centerY)
        }
    }
}

extension GitIssueCell {
    private func bindState(reactor: GitIssueCellReactor){
        
    }
    
    private func bindAction(reactor: GitIssueCellReactor){
        
    }
}
