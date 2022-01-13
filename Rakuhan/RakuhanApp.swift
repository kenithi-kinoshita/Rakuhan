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
        coloredNavAppearance.backgroundColor = UIColor.init(red: 41/255, green: 199/255, blue: 50/255, alpha: 1.0)
        UINavigationBar.appearance().standardAppearance = coloredNavAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredNavAppearance
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
