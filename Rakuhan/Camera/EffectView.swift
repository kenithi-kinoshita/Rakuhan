//
//  EffectView.swift
//  MyCamera
//
//  Created by 木下健一 on 2021/10/26.
//

import SwiftUI
import UIKit

class EffectView: UIViewController {
    override func viewDidLoad(){
        super.viewDidLoad()
        
let vc: UIHostingController = UIHostingController(rootView: EffectView())
        self.addChild(vc)
        self.view.addSubview(vc.view)
        vc.didMove(toParent: self)
        print("goCameraView")
        
        vc.view.translatesAutoresizingMaskIntoConstraints = false
        vc.view.heightAnchor.constraint(equalToConstant: 320).isActive = true
        vc.view.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 16).isActive = true
        vc.view.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -16).isActive = true
        vc.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
}

// フィルタ名を列挙した配列
// 0.モノクロ
// 1.Chrome
// 2.Fade
// 3.Instant
// 4.Noir
// 5.Process
// 6.Tonal
// 7.Transfer
// 8.SepiaTone
let filterArray = ["CIPhotoEffectMono",
                   "CIPhotoEffectChrome",
                   "CIPhotoEffectFade",
                   "CIPhotoEffectInstant",
                   "CIPhotoEffectNoir",
                   "CIPhotoEffectProcess",
                   "CIPhotoEffectTonal",
                   "CIPhotoEffectTransfer",
                   "CISepiaTone",
]

// 選択中のエフェクト
var filterSelectNumber = 0
struct EffectView: View {
    // エフェクト編集画面（シート）の表示有無を管理する状態変数
    @Binding var isShowSheet: Bool
    // 撮影した写真
    let captureImage: UIImage
    // 表示する写真
    @State var showImage: UIImage?
    // シェア画面（UIActivityViewController)
    // 表示有無を管理する状態変数
    @State var isShowActivity = false
    
    var body: some View {
        VStack{
            Spacer()
            if let unwrapShowImage = showImage {
                // 表示する写真がある場合は画面に表示
                Image(uiImage: unwrapShowImage)
                // リサイズする
                    .resizable()
                // アスペクト比を維持して画面内に収まるようにする
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
            // エフェクトボタン
            Button(action: {
                // ボタンをタップした時のアクション
                // フィルタ名を指定
                let filterName = filterArray[filterSelectNumber]
                // 次回に適用するフィルタを決めておく
                filterSelectNumber += 1
                // 最後のフィルタまで適用した場合
                if filterSelectNumber == filterArray.count {
                    // 最後の場合は、最初のフィルタに戻す
                    filterSelectNumber = 0
                }
                // 元々の画像の回転速度を取得
                let rotate = captureImage.imageOrientation
                // UIImage形式の画像をCIImage形式に変換
                let inputImage = CIImage(image: captureImage)
                
                // フィルタの種別を引数で指定された種類を指定してCIFilterのインスタンスを取得
                guard let effectFilter = CIFilter(name: filterName) else {
                    return
                }
                
                // フィルタ加工のパラメータを初期化
                effectFilter.setDefaults()
                // インスタンスにフィルタ加工する元画像の設定
                effectFilter.setValue(inputImage, forKey: kCIInputImageKey)
                // フィルタ加工を行う情報を生成
                guard let outputImage = effectFilter.outputImage else {
                    return
                }
                // CIContestのインスタンスを取得
                let ciContext = CIContext(options: nil)
                // フィルタ加工後の画像をCIContext上に描画し、結果をcgImageとしてCGImage形式の画像を取得
                guard let cgImage = ciContext.createCGImage(outputImage, from: outputImage.extent) else {
                    return
                }
                // フィルタ加工後の画像をCGImage形式からUIImage形式に変換。その際に回転角度を指定。
                showImage = UIImage(cgImage: cgImage, scale: 1.0, orientation: rotate)
            }) {
                Text("エフェクト")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            } // エフェクトButton end
            .padding()
            // シェアボタン
            Button(action: {
                // ボタンをタップした時のアクション
                // UIActivityViewControllerをモーダル表示する
                isShowActivity = true
            }) {
                Text("シェア")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            } // シェアボタン end
            .sheet(isPresented: $isShowActivity) {
                // UIActivityViewControllerを表示する
                ActivityView(shareItems: [showImage!.resize()!])
            }
            .padding()
            // 閉じるボタン
            Button(action: {
                // ボタンをタップした時のアクション
                // エフェクト編集画面を閉じる
                isShowSheet = false
            }) {
                Text("閉じる")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            } // シェアボタン end
            .padding()
        } // VStack end
        // 写真が表示される時に実行される
        .onAppear {
            // 撮影した写真を表示する写真に設定
            showImage = captureImage
        } // .onAppear end
    } // body end
} // EffectView end

struct EffectView_Previews: PreviewProvider {
    static var previews: some View {
        EffectView(
            isShowSheet: Binding.constant(true),
            captureImage: UIImage(named:  "preview_use")!)
    }
}
