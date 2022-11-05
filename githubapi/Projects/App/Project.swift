//
//  Project.swift
//  ProjectDescriptionHelpers
//
//  Created by 최모지 on 2022/11/05.
//

import ProjectDescription
import ProjectDescriptionHelpers

private let projectName = "App"
private let iOSTargetVersion = "13.0"

let infoPlistPath: String = "Resources/App.plist"

let project = Project.app(name: projectName,
                          platform: .iOS,
                          iOSTargetVersion: iOSTargetVersion,
                          infoPlist: infoPlistPath,
                          dependencies: [
                            .external(name: "SnapKit"),
                            .external(name: "Then"),
                            .external(name: "ReactorKit"),
                            .external(name: "RxSwift"),
                            .external(name: "RxCocoa"),
                            .external(name: "Moya"),
                            .external(name: "RxMoya"),
                            .external(name: "Reusable"),
                            .external(name: "RxDataSources"),
                          ])
