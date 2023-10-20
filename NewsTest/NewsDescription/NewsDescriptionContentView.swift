//
//  NewsDescriptionContentView.swift
//  NewsTest
//
//  Created by mac on 9.10.23.
//

import SwiftUI

struct NewsDescriptionContentView: View {
    let news: Article
    let imageSize: CGFloat = 300
    
    // MARK: - Build View
    var body: some View {
        ZStack(alignment: .topLeading) {
            
            ScrollView {
                ScrollView {
                    VStack {
                        if news.urlToImage != nil {
                            AsyncImage(url: URL(string: news.urlToImage ?? "")) { phase in
                                if let image = phase.image {
                                    image.resizable()
                                        .scaledToFit()
                                        .frame( height: imageSize)
                                        .clipped()
                                    
                                } else if phase.error != nil {
                                    
                                    Text(phase.error?.localizedDescription ?? "error")
                                        .foregroundColor(Color.pink)
                                        .frame(width: imageSize, height: imageSize)
                                } else {
                                    ProgressView()
                                        .frame(width: imageSize, height: imageSize)
                                }
                            }
                        } else {
                            Color.gray.frame(height: imageSize)
                        }
                        
                        VStack(alignment: .leading, spacing: 15) {
                            
                            Text(news.publishedAt)
                                .font(.headline)
                            Text(news.articleDescription ?? "")
                                .font(.footnote)
                            Text(news.content ?? "")
                            
                            HStack {
                                Text("Author")
                                Spacer()
                                Text(news.author ?? "")
                            }
                            Spacer()
                        }.padding(.leading, 10)
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
            }
        }
    }
}
