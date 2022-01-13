//
//  RakuhanApp.swift
//  Rakuhan
//
//  Created by 木下健一 on 2022/01/12.
//

import SwiftUI

@main
struct RakuhanApp: App {
    init() {
        let coloredNavAppearance = UINavigationBarAppearance()
        coloredNavAppearance.configureWithOpaqueBackground()
        coloredNavAppearance.backgroundColor = UIColor.init(red: 85/255, green: 132/255, blue: 172/255, alpha: 1.0)
        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
