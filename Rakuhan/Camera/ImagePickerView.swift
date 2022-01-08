//
//  ImagePickerView.swift
//  MyCamera
//
//  Created by 木下健一 on 2021/10/22.
//

import SwiftUI

struct ImagePickerView: UIViewControllerRepresentable {
    // UImagePickerControllerが表示されているか
    @Binding var isShowSheet: Bool
    // 撮影した写真
    @Binding var captureImage: UIImage?
    
    // Coordinatorでコントローラのdelegateを管理
    class Coordinator: NSObject,
        UINavigationControllerDelegate,
        UIImagePickerControllerDelegate {
        // ImagePickerView型の定数を用意
        let parent: ImagePickerView
        // イニシャライザ
        init(_ parent: ImagePickerView) {
            self.parent = parent
        }
        // 撮影が終わった時に呼ばれるdelegateメソッド
        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info:
            [UIImagePickerController.InfoKey : Any]) {
            
                // 撮影した写真をcaptureImageに保存
                if let originalImage =
                    info[UIImagePickerController.InfoKey.originalImage]
                    as? UIImage {
                    parent.captureImage = originalImage
                }
                // sheetを閉じない
                parent.isShowSheet = true
        }
        // キャンセルボタンを選択された時に呼ばれる
        // delegateメソッド
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            // sheetを閉じる
            parent.isShowSheet = false
        }
    } // Coordnator end
    // Cordinatorを生成、SwiftUIによって自動的に呼び出し
    func makeCoordinator() -> Coordinator {
        // Coordinatorクラスのインスタンスを生成
        Coordinator(self)
    }
    // Viewを生成するときに実行
    func makeUIViewController(
        context: UIViewControllerRepresentableContext<ImagePickerView>) ->
    UIViewController {
        // UIImagePickerControllerのインスタンスを生成
        let myImagePicerController = UIImagePickerController()
        // sourceTypeにcameraを設定
        myImagePicerController.sourceType = .camera
        // delegate設定
        myImagePicerController.delegate = context.coordinator
        // UIImagePickerControllerを返す
        return myImagePicerController
    }
    // Viewが更新されたときに実行
    func updateUIViewController(
        _ uiViewController: UIViewController,
        context:UIViewControllerRepresentableContext<ImagePickerView>) {
        // 処理なし
    }
} // ImagePickerView end
