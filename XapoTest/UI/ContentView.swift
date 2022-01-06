//
//  ViewController.swift
//  XapoTest
//
//  Created by Boris Barac on 02.01.2022.
//

import SwiftUI
import UIKit

struct ContentView: View {

    @State var showingDetails: Bool = false

    private var animation: Animation {
        .easeIn(duration: 0.3)
    }

    var body: some View {
        ZStack {
            Color
                .xapobackgroundWithOpacity
                .edgesIgnoringSafeArea(.all)
                .zIndex(0)

            if showingDetails == false {
                ProjectList()
                    .onTapGesture {
                        withAnimation(animation) {
                            showingDetails.toggle()
                        }
                    }
                    .zIndex(1)
            } else {
                DetailView()
                    .gesture(
                        DragGesture()
                            .onEnded { _ in
                                withAnimation(animation) {
                                    showingDetails.toggle()
                                }
                            }
                    )
                    .zIndex(2)
                    .transition(.stripes(number: 11))
            }
        }
    }

}

struct ProjectList: View {
    var body: some View {
        ZStack {
            List(0..<5) { item in
                ProjectListItem()
                    .listRowBackground(Color.xapobackgroundWithOpacity)
            }
        }.onAppear {
            UITableView.appearance().backgroundColor = .clear
        }
    }
}

struct ProjectListItem: View {
    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 5) {
                Image(systemName: "photo")
                    .frame(width: 60, height: 60)
                VStack(alignment: .leading) {
                    Text("Simon Ng")
                    Text("Founder of AppCoda")
                        .font(.subheadline)
                }
                Spacer()
            }
            Text("This is the main Description that is gonna go here")
                .font(.footnote)
                .lineLimit(2)
                .truncationMode(.tail)
        }.foregroundColor(.white)
    }
}

struct DetailView: View {
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 8) {
                ProjectListItem()
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))

                WebView(url: URL(string: "https://github.com/gonzalezreal/MarkdownUI/blob/main/README.md")!)
                    .conditionallyShow(isNotRunningIsPreviewMode)
                Color(.red)
                    .conditionallyShow(isRunningIsPreviewMode)
            }
        }
    }
}

// MARK: - Previews

#if DEBUG

struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewInIphone12()
    }
}

struct DetailView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView(showingDetails: true)
            .previewInIphone12()
    }
}

struct ProjectList_Previews : PreviewProvider {
    static var previews: some View {
        ProjectList()
            .previewInIphone12()

        ProjectListItem()
            .background(Color.black)
            .previewInIphone12()
    }
}

#endif

