//
//  ProfileViewModel.swift
//  Arrow App Exercise
//
//  Created by Elijah Fry on 8/23/22.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var ownProfile: Profile =  Profile(profileid: 0, username: "", imagepath: "", audiopath: "")
    
    private static func fileURL() throws -> URL {
        try FileManager.default.url(for: .documentDirectory,
                                       in: .userDomainMask,
                                       appropriateFor: nil,
                                       create: false)
            .appendingPathComponent("profile.data")
    }
    
    static func load(completion: @escaping (Result<Profile, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let fileURL = try fileURL()
                guard let file = try? FileHandle(forReadingFrom: fileURL) else {
                    DispatchQueue.main.async {
                        completion(.success(Profile(profileid: 0, username: "", imagepath: "", audiopath: "")))
                    }
                    return
                }
                let foundProfile = try JSONDecoder().decode(Profile.self, from: file.availableData)
                DispatchQueue.main.async {
                    completion(.success(foundProfile))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
    static func save(ownProfile: Profile, completion: @escaping (Result<Int, Error>)->Void) {
        DispatchQueue.global(qos: .background).async {
            do {
                let data = try JSONEncoder().encode(ownProfile)
                let outfile = try fileURL()
                try data.write(to: outfile)
                DispatchQueue.main.async {
                    completion(.success(0))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
    
}

