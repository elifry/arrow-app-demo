//
//  ProfileDetailImage.swift
//  Arrow App Exercise
//
//  Created by Elijah Fry on 8/21/22.
//

import SwiftUI

struct ProfileDetailImage: View {
    let urlString: String
    
    // Redraws when data updated
    @State var data: Data?
    
    // TODO: Implement caching layer
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: 400, maxHeight: 400)
                .background(Color.gray)
        }
        else {
            // If no data, show placeholder
            Image(systemName: "heart")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: 400, maxHeight: 400)
                .background(Color.gray)
                .onAppear{
                    fetchData()
                }
        }
    }
    
    private func fetchData() {
        guard let url = URL(string: urlString) else {
            return
        }
        
        // TODO: handle error and response
        let task = URLSession.shared.dataTask(with: url) { data, _, _ in
            self.data = data
        }
        task.resume()
    }
}

