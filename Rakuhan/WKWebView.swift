//
//  WKWebView.swift
//  Rakuhan
//
//  Created by 木下健一 on 2022/01/24.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    @Binding var dynamicHeight: CGFloat
    private let webView = WKWebView()

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        // ページを表示したら自分自身のサイズを計算する
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, error) in
                DispatchQueue.main.async {
                    self.parent.dynamicHeight = height as! CGFloat
                }
            })
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView  {
        webView.scrollView.isScrollEnabled = false
        webView.navigationDelegate = context.coordinator
        
        let htmlStart = "<HTML><HEAD><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, shrink-to-fit=no\"></HEAD><BODY>"
        let htmlEnd = "</BODY></HTML>"
        let htmlContent = """
                        <p>WebViewで表示したいコンテンツです</p>
                        <p>HTMLタグを読み込めるので<a href="https://himaratsu.com">このようなリンク</a>も表示できます</p>
                        <p>スクロールビューの中に入れる場合、WebViewの高さを設定する必要があります。</p>
                        """
        let htmlString = "\(htmlStart)\(htmlContent)\(htmlEnd)"
        webView.loadHTMLString(htmlString, baseURL:  nil)
        
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }
}
