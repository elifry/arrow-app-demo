//
//  DashboardView.swift
//  Arrow App Exercise
//
//  Created by Elijah Fry on 8/23/22.
//

import SwiftUI

extension Array {
    func chunks(_ size: Int) -> [[Element]] {
        stride(from: 0, to: self.count, by: size).map { ($0 ..< Swift.min($0 + size, self.count)).map { self[$0] } }
    }
}

struct DashboardView: View {
    @StateObject var dashboardViewModel = DashboardViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(dashboardViewModel.profiles.chunks(2), id: \.self) { chunk in
                        HStack {
                            ForEach(chunk, id: \.self) { profile in
                                NavigationLink(destination: ProfileDetail(profile: profile, viewModel: ProfileDetailViewModel())) {
                                    VStack {
                                        URLImage(urlString: profile.imagepath)
                                        Text(profile.username)
                                    }
                                }
                                .buttonStyle(.plain)
                            }
                        }
                        .padding(2)
                    }
                }
            }
            .navigationTitle("Dashboard")
        }
        .onAppear {
            dashboardViewModel.fetch()
        }
        .refreshable {
            await dashboardViewModel.reload()
        }
    }
}
