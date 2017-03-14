//
//  ClickCellEvent.swift
//  shortNewIOS
//
//  Created by SSd on 3/14/17.
//  Copyright © 2017 SSd. All rights reserved.
//

import Foundation

protocol ClickNewsCellEvent {
    func clickTitle(id : Int)
    func clickVideo(id : Int)
    func clickAds(adsCode : String)
}
