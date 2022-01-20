//
//  ContentView.swift
//  Rakuhan
//
//  Created by 木下健一 on 2022/01/12.
//

import SwiftUI
import GoogleMobileAds

private weak var AdmobBannerView: GADBannerView!

struct ContentView: View {
    
    init() {
        UITabBar.appearance().barTintColor = .systemBackground
    }
    
    @State var selectedIndex = 0
    @State var shouldShowModal = false
    // 撮影する写真を保持する状態変数
    @State var captureImage: UIImage? = nil
    // 撮影画面のsheet
    @State var isShowSheet = false
    // シェア画面のsheet
    @State var isShowActivity = false
    // フォトライブラリーかカメラかを保持する状態変数
    @State var isPhotolibrary = false
    // ActionSheetモディファイアでの表示有無を管理する状態変数
    @State var isShowAction = false
    
    let tabBarImageNames = ["chevron.left", "person", "camera", "pencil", "gear"]
    
    var body: some View {
        VStack {
            
            ZStack {
                AdView().frame(width: 320, height: 50)
                Spacer()
                    .fullScreenCover(isPresented: $shouldShowModal, content: {
                        Button(action:{shouldShowModal.toggle()}, label: {
                            Text("Fullscreen cover")
                        })
                    })
                
                switch selectedIndex {
                case 0:
                    NavigationView {
                        Text("First Tab")
                            .navigationTitle("First Tab")
                    }
                case 1:
                    NavigationView {
                        WebView(loadUrl: "https://www.instagram.com/")
//                        WebView(loadUrl: "https://www.google.com/?hl=ja")
//                        WebView(loadUrl: "https://twitter.com/home?lang=ja")
//                        WebView(loadUrl: "https://cookpad.com/category/list")
//                        WebView(loadUrl: "http://www.yoshikei-dvlp.co.jp/")
                        Text("TEST")
                }
                default:
                    Text("Remaining tabs")
                }
            }
            Spacer()
            
            HStack {
                ForEach(0..<5) { num in
                    Button(action: {
                        
                        if num == 2 {
                            // ボタンをタップした時のアクション
                            // 撮影写真を初期化する
                            captureImage = nil
                            // ActionSheet を表示する
                            isShowAction = true
                        } else {
                            selectedIndex = num
                        }

                    }, label: {
                    Spacer()
                    Image(systemName: tabBarImageNames[num])
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(selectedIndex == num ? Color(.black) : .init(white: 0.8))
                    Spacer()
                    })
                    // isPresentedで指定した状態変数がtrueのとき実行
                    .sheet(isPresented: $isShowSheet) {
                        if let unwrapCaptureImage = captureImage{
                            // 撮影した写真がある→EffectViewを表示する
                            EffectView(isShowSheet: $isShowSheet, captureImage: unwrapCaptureImage)
                            
                        } else {
                        // フォトライブラリーが選択された
                            if isPhotolibrary {
                            // PHPickerViewController（フォトライブラリー）を表示
                                PHPickerView (
                                    isShowSheet: $isShowSheet,
                                    captureImage: $captureImage)
                            } else {
                                // UIImagePickerController（写真撮影）を表示
                                ImagePickerView(
                                    isShowSheet: $isShowSheet,
                                    captureImage: $captureImage)
                            }
                        }
                    }// カメラ起動Button sheet end
                    // 状態変数：$isShowActionに変化があったら実行
                    .actionSheet(isPresented: $isShowAction) {
                        // ActionSheet を表示する
                        ActionSheet(title: Text("画像選択確認"),
                                    message: Text("画像を選択"),
                                    buttons: [
                                        .default(Text("カメラで撮影"), action: {
                                            // カメラを選択
                                            isPhotolibrary = false
                                            // カメラが利用可能がチェック
                                            if UIImagePickerController.isSourceTypeAvailable(.camera){
                                                print("カメラが利用できます")
                                                // カメラが使えるなら、isShowSheetを true
                                                isShowSheet = true
                                            } else {
                                                print("カメラが利用できません")
                                            }
                                                
                                        }),
                                        .default(Text("アルバムから選択"), action:  {
                                            // フォトライブラリーを選択
                                            isPhotolibrary = true
                                            // isShowSheetをtrue
                                            isShowSheet = true
                                        }),
                                        // キャンセル
                                        .cancel(),
                                    ]) // ActionSheet end
                    } // .actionSheet end
                }
            }
        }
    }
}

struct AdView: UIViewRepresentable {
    func makeUIView(context: Context) -> GADBannerView {
        let banner = GADBannerView(adSize: GADAdSizeBanner)

        // 下記はテスト専用広告ユニットID（バナー広告）。
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        banner.rootViewController = windowScene?.windows.first?.rootViewController
        banner.load(GADRequest())
        return banner
    }

    func updateUIView(_ uiView: GADBannerView, context: Context) {
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
