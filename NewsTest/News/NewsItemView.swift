//
//  NewsItemView.swift
//  NewsTest
//
//  Created by mac on 9.10.23.
//

import SwiftUI

struct NewsItemView: View {
    let news: Article
    
    // MARK: - Building View
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            ZStack {
                AsyncImage(url: URL(string: news.urlToImage ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 110, height: 110)
                } placeholder: {
                    ProgressView()
                }
            }
            .cornerRadius(8)
            .frame(width: 110, height: 110)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(news.author ?? "")
                    .font(.system(size: 18))
                    .foregroundColor(.blue)
                    .multilineTextAlignment(.leading)
                
                makeInfoRow(title: news.title, iconName: "newspaper")
                makeInfoRow(title: news.publishedAt, iconName: "calendar.badge.clock")
                makeInfoRow(title: news.source.name, iconName: "info")
            }
            .padding(.vertical, 0)
        }
    }
    
    private func makeInfoRow(title: String, iconName: String) -> some View {
        HStack(alignment: .top, spacing: 8) {
            Image(systemName: iconName)
            
            Text(title)
        }
        .font(.system(size: 14))
        .foregroundColor(.blue)
    }
}

struct NewsItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewsItemView(news: Article(source: Source(id: "1", name: "BBC"),
                                   author: "Tom",
                                   title: "title",
                                   articleDescription: "articleDescription",
                                   url: "url",
                                   urlToImage: "urlToImage",
                                   publishedAt: "publishedAt",
                                   content: "content"))
    }
}
