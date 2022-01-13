//
//  ContentView.swift
//  Rakuhan
//
//  Created by 木下健一 on 2022/01/12.
//

import SwiftUI

struct ContentView: View {
    var body: some View {

        NavigationView{
//            WebView(loadUrl: "https://www.google.com/?hl=ja")
//            WebView(loadUrl: "https://twitter.com/home?lang=ja")
//            WebView(loadUrl: "https://cookpad.com/category/list")
//            WebView(loadUrl: "http://www.yoshikei-dvlp.co.jp/")
            WebView(loadUrl: "https://www.instagram.com/")
                .toolbar {
                    ToolbarItemGroup(placement: .bottomBar) {
                        Button("トップ", role: nil, action: {
                            _ = WebView(loadUrl: "https://www.instagram.com/")
                        })
                        Spacer()
                        NavigationLink(destination: CameraView()){
                        Text("シェア")
                        }
                        .navigationTitle("Top View")
                        Spacer()
                        Button("記録") {}
                        Spacer()
                        Button("設定") {}
                        Spacer()
                        
                    }
                    
                    
                }
                .navigationTitle("Navigation View")
        }
    }
}

func Reset(){
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
