//
//  ProfileDetail.swift
//  Arrow App Exercise
//
//  Created by Elijah Fry on 8/21/22.
//

import SwiftUI
import AVKit

class SoundManager : ObservableObject {
    var audioPlayer: AVPlayer?

    func playSound(sound: String){
        if let url = URL(string: sound) {
            self.audioPlayer = AVPlayer(url: url)
        }
    }
}

struct ProfileDetail: View {
    let profile: Profile
    
    @StateObject var viewModel: ProfileDetailViewModel
    
    @State var audioClip = false
    @StateObject private var soundManager = SoundManager()
    
//    @State var audioPlayer: AVAudioPlayer!

    var body: some View {
        VStack {
            Text(profile.username)

            ProfileDetailImage(urlString: profile.imagepath)

            Spacer()

            HStack(alignment: .center, spacing: 12) {
                Image(systemName: audioClip ? "pause.circle.fill": "play.circle.fill")
                    .font(.system(size: 30))
                    .padding(.trailing)
                    .onTapGesture {
                        soundManager.playSound(sound: profile.audiopath)
                        audioClip.toggle()
                        
                        if audioClip{
                            soundManager.audioPlayer?.play()
                        } else {
                            soundManager.audioPlayer?.pause()
                        }
                }
                Text("0:00")
                Slider(value: $viewModel.slider, in: 0...100)
                Text("1:34")
            }.padding(.horizontal, 45)

            Text("(requires silent mode off, excuse the hasty demo - also ignore the slider lol)")
                .padding(.horizontal, 40)

            Spacer()
        }
        Spacer()
    }
}

struct ProfileDetail_Previews: PreviewProvider {
    static var previews: some View {
        ProfileDetail(profile: Profile(profileid: 0, username: "Eli", imagepath: "https://storage.googleapis.com/arrow-demo-360300.appspot.com/images/Eli.jpg", audiopath: "https://storage.googleapis.com/arrow-demo-360300.appspot.com/audio/Eli.mp3"), viewModel: ProfileDetailViewModel())
    }
}
