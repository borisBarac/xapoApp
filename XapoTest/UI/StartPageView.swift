//
//  StartPageView.swift
//  XapoTest
//
//  Created by Boris Barac on 09.01.2022.
//

import Foundation
import SwiftUI
import Combine

struct StartPageView: View {
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass

    // we could put this a model, but i do not really think is worth the extra complexity for one flag, that is just a wrapper around user defaults
    @UserDefsStorage(key: "START_PAGE_FLAG")
    var showStartPageflag: Bool? {
        didSet {
            debugPrint("")
        }
    }

    @State
    private var isShowingSafariVC = false

    var body: some View {
        ZStack {
            Color
                .xapobackgroundWithOpacity
                .edgesIgnoringSafeArea(.all)

            if verticalSizeClass == .regular && horizontalSizeClass == .regular {
                GeometryReader { mainReader in
                    let mainFraime = mainReader.frame(in: .local)
                    mainContent
                        .shadow(radius: 5)
                        .border(Color.black.opacity(0.33), width: 4)
                        .cornerRadius(5)
                        .background(Color.black.opacity(0.33))
                        .padding(EdgeInsets(top: mainFraime.height * 0.2,
                                            leading: mainFraime.height * 0.2,
                                            bottom: mainFraime.height * 0.2,
                                            trailing: mainFraime.height * 0.2))
                }
            } else {
                mainContent
            }
        }
    }

    var mainContent: some View {
        GeometryReader { reader in
            let frame = reader.frame(in: .local)

            VStack(alignment: .center, spacing: frame.height / 25) {
                Button("Go To Xapo") {
                    isShowingSafariVC.toggle()
                }.sheet(isPresented: $isShowingSafariVC, onDismiss: nil, content: {
                    SafariView(url: URL(string: "https://www.xapo.com")!)
                })
                .padding(16)
                .foregroundColor(.white)
                .frame(width: frame.width, alignment: .trailing)

                Spacer()

                Image
                    .xapoLogo
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)

                Group {
                    Text("Welcome to iOS test")
                        .font(.largeTitle)

                    Text("iOS Test For Xapo Bank \n \(loremText)")
                        .font(.body)
                }
                .foregroundColor(.white)
                .multilineTextAlignment(.center)

                Spacer()

                Button("Enter the app") {
                    enterAppClick()

                }
                .frame(width: 256, height: 48)
                .background(Color.xapoOrange)
                .cornerRadius(30)
                .foregroundColor(.white)

                HStack(alignment: .center, spacing: 2) {
                    Group {
                        Text("Privacy policy")
                            .underline()
                        Text("and")
                        Text("Terms of use")
                            .underline()
                    }
                    .font(.footnote)
                    .foregroundColor(.white)

                }
            }.padding(.bottom, 25)
        }
    }

    func enterAppClick() {
        UIApplication.shared.windows.filter {
            $0.isKeyWindow
        }.first?.replaceRoot(viewController: UIHostingController(rootView: TrendingContainerView()), animated: true, completion: {
            showStartPageflag = false
        })
    }
}

private var loremText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas ut tempus quam, a volutpat neque. Donec at neque ornare,"

// MARK: - Previews

#if DEBUG

struct StartPageView_Previews : PreviewProvider {
    static var previews: some View {
        StartPageView()
            .previewInIphone12()

        StartPageView()
            .previewInIpadPro11inch()
    }
}

#endif

