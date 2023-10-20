//
//  LoaderView.swift
//  NewsTest
//
//  Created by mac on 9.10.23.
//

import SwiftUI

struct LoaderView: View {
    let isFailed: Bool
    var body: some View {
        Text(isFailed ? "Failed. Tap to retry." : "Loading..")
            .foregroundColor(isFailed ? .red : .green)
            .padding()
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView(isFailed: false)
    }
}
