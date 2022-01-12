//
//  ActivityView.swift
//  MyCamera
//
//  Created by 木下健一 on 2021/10/23.
//
import UIKit
import SwiftUI

//class AV: UIViewController {
//    override func viewDidLoad(){
//        super.viewDidLoad()
//
//let vc: UIHostingController = UIHostingController(rootView: ActivityView())
//        self.addChild(vc)
//        self.view.addSubview(vc.view)
//        vc.didMove(toParent: self)
//        print("goCameraView")
//
//        vc.view.translatesAutoresizingMaskIntoConstraints = false
//        vc.view.heightAnchor.constraint(equalToConstant: 320).isActive = true
//        vc.view.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
//        vc.view.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
//        vc.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//    }
//}

struct ActivityView: UIViewControllerRepresentable {
    
    // UIActivityViewControllerでシェアする写真
    let shareItems: [Any]
    
    // 表示するViewを生成するときに実行
    func makeUIViewController(context: Context) -> UIActivityViewController {
        
        // UIActivityViewControllerでシェアする機能を生成
        let controller = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        
        // UIActivityViewControllerを返す
        return controller
    }

    // Viewが更新されたときに実行
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityView>)
    {
         //処理なし
    }
}
