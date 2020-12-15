//
//  Constants.swift
//  News
//
//  Created by hager gamal on 12/13/20.
//

import Foundation

let kSetting = "User_Settings"
let kApiKey = "55354d8d61b3491bb859d6b2c33772c8"

enum SingleViewType {
    case country
    case language
}
enum Category  : String ,CaseIterable , Codable {
    case business
    case entertainment
    case general
    case health
    case science
    case sports
    case technology
}
enum Language : String ,CaseIterable , Codable{
    case ar
    case de
    case en
    case es
    case fr
    case he
    case it
    case nl
    case no
    case pt
    case ru
    case se
    case ud
    case zh
}
enum Country : String ,CaseIterable , Codable {
    case ae
    case ar
    case at
    case au
    case be
    case bg
    case br
    case ca
    case ch
    case cn
    case co
    case cu
    case cz
    case de
    case eg
    case fr
    case gb
    case gr
    case hk
    case hu
    case id
    case ie
    case il
    case it
    case jp
    case kr
    case lt
    case lv
    case ma
    case mx
    case my
    case ng
    case nl
    case no
    case nz
    case ph
    case pl
    case pt
    case ro
    case rs
    case ru
    case sa
    case se
    case sg
    case si
    case sk
    case th
    case tr
    case tw
    case ua
    case us
    case ve
    case za
}
