//
//  ViewModel.swift
//  Arrow App Exercise
//
//  Created by Elijah Fry on 8/21/22.
//

import Foundation

struct Profile: Hashable, Codable {
    let profileid: Int
    let username: String
    let imagepath: String
    let audiopath: String
}

class DashboardViewModel: ObservableObject {
    @Published var profiles: [Profile] = []
    
    func fetch() {
        guard let url = URL(string: "https://arrow-demo-360300.ue.r.appspot.com/api/profiles") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            // Convert to JSON
            do {
                let profiles = try JSONDecoder().decode([Profile].self, from: data)
                DispatchQueue.main.async {
                    self?.profiles = profiles
                }
            } catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    func reload() async {
        fetch()
    }
}
