//
//  AppList.swift
//  AppStoreLike
//
//  Created by Mizuo Nagayama on 2021/05/23.
//

import Foundation

struct AppList: Decodable {
    let id: Int
    let type: String
    let title: String
    let subtitle: String
    let items: [App]
}
