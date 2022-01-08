//
//  ViewController.swift
//  Rakuhan
//
//  Created by 木下健一 on 2022/01/06.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    let colors = Colors()
    var top = UILabel()
    var camera = UILabel()
    var webView: WKWebView!
    var myTabBar: UITabBarController!
    // adjust SafeArea top space
    // portrait のみを想定
    var topPadding:CGFloat = 0
    var bottomPadding:CGFloat = 0
    var headerPadding:CGFloat = 60
 
    override func viewDidLoad(){
        super.viewDidLoad()

        // Header
        if #available(iOS 11.0, *) {
            // 'keyWindow' was deprecated in iOS 13.0: Should not be used for applications
            let scenes = UIApplication.shared.connectedScenes
            let windowScene = scenes.first as? UIWindowScene
            let window = windowScene?.windows.first
            topPadding = window!.safeAreaInsets.top
            bottomPadding = window!.safeAreaInsets.bottom
        }
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: topPadding, width: view.frame.size.width, height: headerPadding)
        gradientLayer.colors = [colors.bluePurple.cgColor, colors.blue.cgColor,]
        gradientLayer.startPoint = CGPoint.init(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint.init(x: 1, y: 1)
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        setUpContent()
        
//        // Footer
//        let footerLayer = CAGradientLayer()
//        footerLayer.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: 60)
//        footerLayer.colors = [colors.bluePurple.cgColor, colors.blue.cgColor,]
//        footerLayer.startPoint = CGPoint.init(x: 0, y: 0)
//        footerLayer.endPoint = CGPoint.init(x: 1, y: 1)
//        view.layer.insertSublayer(footerLayer, at: 0)
        

        let uiView = UIView()
        uiView.frame = CGRect(x: 0, y: view.frame.size.height - headerPadding, width: view.frame.size.width, height: 167)
        uiView.layer.cornerRadius = 10
        uiView.backgroundColor = .white
        uiView.layer.shadowColor = colors.black.cgColor
        uiView.layer.shadowOffset = CGSize(width: 0, height: 2 )
        uiView.layer.shadowOpacity = 0.4
        uiView.layer.shadowRadius = 10
        view.addSubview(uiView)
        
        setUpImageButton("reload", x: 35).addTarget(self, action: #selector(reladAction), for: .touchDown)
        setUpImageButton("reload", x: 100).addTarget(self, action: #selector(reladAction), for: .touchDown)
        bottomLabel(uiView, top,0.32, 25, text: "TOP", size: 10, weight: .bold, color: colors.black)
        bottomLabel(uiView, camera,0.67, 25, text: "カメラ", size: 10, weight: .bold, color: colors.black)


    }
    func setUpImageButton(_ name: String, x: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: name), for: .normal)
        button.frame.size = CGSize(width: 30, height: 30)
        button.tintColor = .blue
        button.frame.origin = CGPoint(x: x, y: view.frame.size.height - 48)
        view.addSubview(button)
        return button
    }
    @objc func reladAction() {
        loadView()
        viewDidLoad()
    }
    func setUpContent(){
        //        print("viewDidAppear")
                let screenWidth:CGFloat = view.frame.size.width
                let screenHeight:CGFloat = view.frame.size.height
                
                // iPhone X , X以外は0となる

         
                // Webページの大きさを画面に合わせる
                let rect = CGRect(x: 0, y: headerPadding, width: screenWidth, height: screenHeight)
                let webConfiguration = WKWebViewConfiguration()
                webView = WKWebView(frame: rect, configuration: webConfiguration)
         
        //        let webUrl = URL(string: "https://yoshikei-dvlp.co.jp/recipe/")!
        //        let webUrl = URL(string: "https://i-app-tec.com/")!
            
                let webUrl = URL(string: "https://cookpad.com/category/list")!
                let myRequest = URLRequest(url: webUrl)
                webView.load(myRequest)
         
                // インスタンスをビューに追加する
                self.view.addSubview(webView)
    }
    
    func bottomLabel(_ parentView: UIView, _ label: UILabel, _ x: CGFloat, _ y: CGFloat, text: String, size: CGFloat, weight: UIFont.Weight, color: UIColor) {
        
        label.text = text
        label.textColor = color
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.font = .systemFont(ofSize: size, weight: weight)
        label.frame = CGRect(x: 0, y: y, width: parentView.frame.size.width / 3.5, height: 50)
        label.center.x = view.center.x * x - 10
        parentView.addSubview(label)
        
    }
    
}
 
