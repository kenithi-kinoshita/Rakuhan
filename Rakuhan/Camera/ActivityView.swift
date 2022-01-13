//
//  ActivityView.swift
//  MyCamera
//
//  Created by 木下健一 on 2021/10/23.
//

import SwiftUI

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
