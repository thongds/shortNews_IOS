//
//  GoogleAnalyticHelpper.swift
//  shortNewIOS
//
//  Created by SSd on 3/14/17.
//  Copyright © 2017 SSd. All rights reserved.
//

import Foundation

class GoogleAnalyticHelpper{
    
    static func sendScreen(screenName : ScreenName){
        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
        tracker.set(kGAIScreenName, value: screenName.rawValue)
        
        guard let builder = GAIDictionaryBuilder.createScreenView() else { return }
        tracker.send(builder.build() as [NSObject : AnyObject])
    }
    
    static func sendAction(withCategory : Category,action: Action,label : String){
        guard let tracker = GAI.sharedInstance().defaultTracker else { return }
        guard let builder = GAIDictionaryBuilder.createEvent(withCategory: withCategory.rawValue, action: action.rawValue, label: label, value: nil) else {return}
        tracker.send(builder.build() as [NSObject : AnyObject])
    }
}

enum ScreenName : String {
    case home = "home"
    case news = "new"
    case social = "social"
}

enum Action : String {
    case click = "click"
    case clickNews = "click_news"
    case clickSocial = "click_social"
    case clickNewTitle = "click_new_title"
    case clickVideo = "click_video"
}

enum Category : String{
    case global = "global"
    case newsEvents = "newsEvents"
}
enum Label : String {
    case news = "news"
    case social = "social"
    case newsTitle = "news Title"
}
