//
//  ContentView.swift
//  Arrow App Exercise
//
//  Created by Elijah Fry on 8/17/22.
//

import SwiftUI

struct Profile: Hashable, Codable {
    let profileid: Int
    let username: String
    let imagepath: String
    let audiopath: String
}

class ViewModel: ObservableObject {
    @Published var profiles: [Profile] = []
    
    func fetch() {
        guard let url = URL(string: "http://localhost:3000/api/profiles") else {
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
}

extension Array {
    func chunks(_ size: Int) -> [[Element]] {
        stride(from: 0, to: self.count, by: size).map { ($0 ..< Swift.min($0 + size, self.count)).map { self[$0] } }
    }
}

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
//    @Environment(\.managedObjectContext) private var viewContext
//
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
//        animation: .default)
//    private var items: FetchedResults<Item>
    
//    var data = [
//        Profile(profileid:1,username:"Eli",imagepath:"/1/1.jpg",audiopath:"/1/1.m4a"),
//        Profile(profileid:3,username:"Eli Fry",imagepath:"/1/1.jpg",audiopath:"/1/1.m4a"),
//        Profile(profileid:1,username:"Eli",imagepath:"/1/1.jpg",audiopath:"/1/1.m4a"),
//        Profile(profileid:3,username:"Eli Fry",imagepath:"/1/1.jpg",audiopath:"/1/1.m4a"),
//        Profile(profileid:1,username:"Eli",imagepath:"/1/1.jpg",audiopath:"/1/1.m4a"),
//        Profile(profileid:3,username:"Eli Fry",imagepath:"/1/1.jpg",audiopath:"/1/1.m4a"),
//        Profile(profileid:1,username:"Eli",imagepath:"/1/1.jpg",audiopath:"/1/1.m4a"),
//        Profile(profileid:3,username:"Eli Fry",imagepath:"/1/1.jpg",audiopath:"/1/1.m4a"),
//        Profile(profileid:1,username:"Eli",imagepath:"/1/1.jpg",audiopath:"/1/1.m4a"),
//        Profile(profileid:3,username:"Eli Fry",imagepath:"/1/1.jpg",audiopath:"/1/1.m4a"),
//        Profile(profileid:1,username:"Eli",imagepath:"/1/1.jpg",audiopath:"/1/1.m4a"),
//        Profile(profileid:3,username:"Eli Fry",imagepath:"/1/1.jpg",audiopath:"/1/1.m4a"),
//    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    ForEach(viewModel.profiles.chunks(3), id: \.self) { chunk in
                        HStack {
                            ForEach(chunk, id: \.self) { profile in
                                VStack {
                                    Image("")
                                        .frame(width: 100, height: 100)
                                        .aspectRatio(contentMode: .fit)
                                        .background(Color.gray)
                                    Text(profile.username)
//                                    Text(profile.imagepath)
//                                    Text(profile.audiopath)
                                }
                            }
                        }
                        .padding(2)
                    }
                }
            }
            .navigationTitle("Dashboard")
        }
        .onAppear {
            viewModel.fetch()
        }
    }

//    var body: some View {
//        NavigationView {
//            List {
////                ForEach(items) { item in
////                    NavigationLink {
////                        Text("Item at \(item.timestamp!, formatter: itemFormatter)")
////                    } label: {
////                        Text(item.timestamp!, formatter: itemFormatter)
////                    }
////                }
////                .onDelete(perform: deleteItems)
//                ForEach(viewModel.profiles, id: \.self) { profile in
//
//                }
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//            .onAppear {
//                viewModel.fetch()
//            }
//            Text("Select an item")
//        }
//    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(context: viewContext)
//            newItem.timestamp = Date()
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }

//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            offsets.map { items[$0] }.forEach(viewContext.delete)
//
//            do {
//                try viewContext.save()
//            } catch {
//                // Replace this implementation with code to handle the error appropriately.
//                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
//                let nsError = error as NSError
//                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//            }
//        }
//    }
}

//private let itemFormatter: DateFormatter = {
//    let formatter = DateFormatter()
//    formatter.dateStyle = .short
//    formatter.timeStyle = .medium
//    return formatter
//}()

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            //.environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
