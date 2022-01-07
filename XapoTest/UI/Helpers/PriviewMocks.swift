//
//  PriviewMocks.swift
//  XapoTest
//
//  Created by Boris Barac on 08.01.2022.
//

import Foundation

#if DEBUG

var previewList: [ProjectItem]  {
    var items = [ProjectItem]()
    for id in 0..<100 {
        items.append(ProjectItem(id: Int64(id),
                                 full_name: "TEST TEST",
                                 description: "TEST DESCRIPTION",
                                 owner: BERepoData.Owner(id: id, login: "OWNER TEST", avatar_url: ""),
                                 url: "",
                                 homepage: nil,
                                 forks: id))
    }

    return items
}

#endif
