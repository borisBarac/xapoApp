//
//  Shared.swift
//  XapoTest
//
//  Created by Boris Barac on 06.01.2022.
//

import SwiftUI

struct ProjectList: View {
    @ViewBuilder
    private var list: some View {
        if UIDevice.isIphone() {
            List {
                Section(header: ListHeader()) {
                    ForEach(0..<99) { _ in
                        ProjectListItem()
                            .listRowBackground(Color.xapobackgroundWithOpacity)
                    }
                }
            }
            .listStyle(.automatic)
        } else if UIDevice.isIpad() {
            List(0..<99) { item in
                ProjectListItem()
                    .listRowBackground(Color.xapobackgroundWithOpacity)
            }
            .listStyle(.automatic)
        }
    }

    var body: some View {
        ZStack {
            list
        }.onAppear {
            UITableView.appearance().backgroundColor = .clear
        }
    }
}

extension ProjectList {
    struct ListHeader: View {
        var body: some View {
            HStack {
                Image(systemName: "map")
                Text("Trending")
            }
            .foregroundColor(.white)
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

struct ProjectList_Previews : PreviewProvider {
    static var previews: some View {
        ProjectList()
            .previewInIphone12()

        ProjectList()
            .previewInIpadPro11inch()
    }
}

struct DetailView_Previews : PreviewProvider {
    static var previews: some View {
        TrendingView(items: previewList, showingDetails: true)
            .previewInIphone12()
    }
}

#endif

