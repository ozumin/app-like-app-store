//
//  App.swift
//  AppStoreLike
//
//  Created by Mizuo Nagayama on 2021/05/23.
//

import Foundation

struct App: Decodable, Hashable {
    let id: Int
    let tagline: String
    let name: String
    let subheading: String
    let image: String
    let iap: Bool
}
