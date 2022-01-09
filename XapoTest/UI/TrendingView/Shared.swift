//
//  Shared.swift
//  XapoTest
//
//  Created by Boris Barac on 06.01.2022.
//

import SwiftUI
import SwURL

struct ProjectList: View {

    var items: [ProjectItem]
    var cellTap: ((ProjectItem) -> ())?

    @ViewBuilder
    private var list: some View {
        if UIDevice.isIphone() {
            List {
                Section(header: ListHeader()) {
                    ForEach(items) { item in
                        makeProjectListItem(item)
                    }
                }
            }
            .listStyle(.automatic)
        } else if UIDevice.isIpad() {
            List(items) { item in
                makeProjectListItem(item)
            }
            .listStyle(.automatic)
        }
    }

    @ViewBuilder
    private func makeProjectListItem(_ item: ProjectItem) -> some View {
        ProjectListItem(item: item)
            .onTapGesture {
                cellTap?(item)
            }
            .listRowBackground(Color.xapobackgroundWithOpacity)
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

    var item: ProjectItem
    var xButtonClick: (() -> Void)?

    var imageAvatar: some View {
        Group {
            if isNotRunningIsPreviewMode {
                RemoteImageView(url: item.owner.avatar_image_url,
                                placeholderImage: Image(systemName: "photo.fill"),
                                transition: .custom(transition: .opacity, animation: .easeOut))

            } else {
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFit()
            }
        }
    }

    var body: some View {
        VStack(alignment: .leading) {
            HStack(alignment: .center, spacing: 5) {
                imageAvatar
                    .frame(width: 60, height: 60)
                VStack(alignment: .leading) {
                    Text(item.full_name)
                    Text(item.owner.login)
                        .font(.subheadline)
                }
                Spacer()
                Button(action: {
                    xButtonClick?()
                }, label: {
                    Image(systemName: "xmark.circle")
                        .resizable()
                        .scaledToFit()
                })
                    .frame(width: 22, height: 22)
                    .offset(x: -8, y: -8)
                    .conditionallyShow(xButtonClick != nil)

            }
            Text(item.description)
                .font(.footnote)
                .lineLimit(2)
                .truncationMode(.tail)
        }.foregroundColor(.white)
    }
}

struct DetailView: View {
    @Binding
    var item: ProjectItem?
    var xButtonClick: (() -> Void)?

    var body: some View {
        if let item = item, let webViewUrl = URL(string: item.html_url) {
            ZStack {
                VStack(alignment: .leading, spacing: 8) {
                    ProjectListItem(item: item, xButtonClick: xButtonClick)
                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                    WebView(url: webViewUrl)
                        .conditionallyShow(isNotRunningIsPreviewMode)
                    Color(.red)
                        .conditionallyShow(isRunningIsPreviewMode)
                }
            }
        } else {
            ZStack {
                Color.xapobackgroundWithOpacity
                    .edgesIgnoringSafeArea(.all)
                Text("NO DATA 🤨")
            }
        }
    }
}


// MARK: - Previews

#if DEBUG

struct ProjectList_Previews : PreviewProvider {
    static var previews: some View {
        ProjectList(items: previewList)
            .previewInIphone12()

        ProjectList(items: previewList)
            .previewInIpadPro11inch()
    }
}

struct DetailView_Previews : PreviewProvider {
    static var previews: some View {
        TrendingView(model: TrendingModel(items: previewList), showingDetails: true)
            .previewInIphone12()
    }
}

#endif

