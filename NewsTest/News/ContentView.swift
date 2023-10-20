//
//  ContentView.swift
//  NewsTest
//
//  Created by mac on 8.10.23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = NewsViewModel(apiManager: NetworkServiceManager())
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    @State private var isDarkModeOn = false
    @State var isOn = true
    
    private var ToggleThemeView: some View {
        Toggle("Theme color", isOn: $isDarkModeOn).onChange(of: isDarkModeOn) { state  in
            changeDarkMode(state: state)
        }.labelsHidden()
    }
    
    // MARK: - Building view
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 12) {
                    ForEach(viewModel.breeds, id: \.urlToImage) { breed in
                        NavigationLink {
                            NewsDescriptionContentView(news: breed)
                        } label: {
                            NewsItemView(news: breed)
                        }
                    }
                    LoaderView(isFailed: viewModel.isRequestFailed)
                        .onAppear {
                            Task {
                                await viewModel.load()
                            }
                        }
                        .onTapGesture {
                            Task {
                                await onTapLoadView()
                            }
                        }
                        .padding(.horizontal, 16)
                }
            }
            .navigationBarTitle(Text(verbatim: "News"), displayMode: .inline)
            .navigationBarItems(trailing: ToggleThemeView)
            .onAppear(perform: {
                setAppTheme()
            })
        }
    }
    
    private func onTapLoadView() async {
        if viewModel.isRequestFailed {
            viewModel.isRequestFailed = false
            await viewModel.load()
        }
    }
    
    private func setAppTheme() {
        
        isDarkModeOn = UserDefaultsUtils.shared.getDarkMode()
        changeDarkMode(state: isDarkModeOn)
        
        if colorScheme == .dark {
            isDarkModeOn = true
        } else {
            isDarkModeOn = false
        }
        changeDarkMode(state: isDarkModeOn)
    }
    
    private func changeDarkMode(state: Bool) {
        (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first!.overrideUserInterfaceStyle = state ? .dark : .light
        UserDefaultsUtils.shared.setDarkMode(enable: state)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
