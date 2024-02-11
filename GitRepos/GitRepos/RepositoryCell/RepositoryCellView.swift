//
//  DummyView.swift
//  GitRepos
//
//  Created by Leon Horvath on 09/02/2024.
//

import SwiftUI

struct RepositoryCellView: View {
    
    var repoItem: RepositoryItem
    
    var body: some View {
        HStack {
            VStack{
                Text(repoItem.fullName)
                    .font(.system(size: 12))
                HStack {
                    Text("Stargazers:\(repoItem.stargazersCount ?? 0)")
                        .font(.system(size: 8)).frame(alignment: .center)
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: 10, height: 10, alignment: .center)
                        .foregroundColor(.yellow)
                }.frame(width: 100, height: 15 )
            }
            Spacer()
            VStack {
                Text(repoItem.description ?? "Default Description")
                    .font((.system(size: 10)))
                    .multilineTextAlignment(.center)
                Text(repoItem.updatedAt?.toDisplayFormattedDate() ?? "N/A")
                    .foregroundStyle(.gray)
                    .font((.system(size: 8)))
                    .frame(alignment: .bottom)
            }.frame(width: 200)
        }
    }
}
