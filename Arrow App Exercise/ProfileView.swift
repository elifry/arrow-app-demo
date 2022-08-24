//
//  ProfileView.swift
//  Arrow App Exercise
//
//  Created by Elijah Fry on 8/23/22.
//

import SwiftUI
import UIKit

// IN PROGRESS

struct ImageOverlay: View {
    var body: some View {
        ZStack {
            Text("Upload Image")
                .font(.callout)
                .padding(6)
                .foregroundColor(.white)
        }.background(Color.black)
        .opacity(0.8)
        .cornerRadius(10.0)
        .padding(6)
    }
}

struct ProfileView: View {
    @StateObject var profileViewModel = ProfileViewModel() // IN PROGRESS
    
    @State private var nameComponents = PersonNameComponents()
    
    @State private var image: Image? = Image("")
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    
    @State var currentlyRecording = false
    
    var body: some View {
        VStack {
            Text("Create Profile")
                .font(.title)
                .fontWeight(.bold)
//            if profileViewModel.ownProfile != Profile(profileid: 0, username: "", imagepath: "", audiopath: "") {
//                Text("Loaded")
//                Text(String(profileViewModel.ownProfile.profileid))
//                Text(profileViewModel.ownProfile.username)
//                Text(profileViewModel.ownProfile.audiopath)
//                Text(profileViewModel.ownProfile.imagepath)
//            }
            TextField(
                "Proper name",
                value: $nameComponents,
                format: .name(style: .medium)
            )
            .onSubmit {
//                validate(components: nameComponents)
            }
            .disableAutocorrection(true)
            .border(.secondary)
            Text(nameComponents.debugDescription)
                .padding(.bottom)
            
//            Spacer()
            
            image!
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: 400, maxHeight: 400)
                .background(Color.gray)
                .overlay(image == Image("") ? ImageOverlay() : nil, alignment: .center)
                .onTapGesture { self.shouldPresentActionScheet = true }
                .sheet(isPresented: $shouldPresentImagePicker) {
                                SUImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary, image: self.$image, isPresented: self.$shouldPresentImagePicker)
                }.actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
                            ActionSheet(title: Text("Choose mode"), message: Text("Please choose your preferred mode to set your profile image"), buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                                self.shouldPresentImagePicker = true
                                self.shouldPresentCamera = true
                            }), ActionSheet.Button.default(Text("Photo Library"), action: {
                                self.shouldPresentImagePicker = true
                                self.shouldPresentCamera = false
                            }), ActionSheet.Button.cancel()])
                        }
            
            Spacer()
            
            HStack(alignment: .center, spacing: 12) {
                Text("Record an audio clip")
                Image(systemName: currentlyRecording ? "pause.circle.fill": "play.circle.fill")
                    .font(.system(size: 30))
                    .padding(.trailing)
                    .onTapGesture {
                        currentlyRecording.toggle()
                    }
            }
//            .padding(.horizontal, 45)
            Spacer()
            
            if image != Image("") {
                Button("Create profile") {
                    print("Button tapped!")
                    // TODO: Send data to backend and upload to bucket
                }
                
                Spacer()
            }
            
        }
        .padding(.horizontal, 45)
        .onAppear {
            ProfileViewModel.load { result in
                switch result {
                case .failure(let error):
                    fatalError(error.localizedDescription)
                case .success(let ownProfile):
                    profileViewModel.ownProfile = ownProfile
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
