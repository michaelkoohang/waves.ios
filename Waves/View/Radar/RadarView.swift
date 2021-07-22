//
//  RadarView.swift
//  Waves
//
//  Created by Michael Koohang on 2/28/21.
//

import SwiftUI

struct RadarView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var user: Friend
    @State var songs: [Song] = []
    @State var currentSong: String = ""
    @State var playing: Bool = false

    var imageWidth = CGFloat(150.0)
    var imageHeight = CGFloat(150.0)
    
    var body: some View {
        ScrollView {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .shadow(radius: 5)
                Image(RandomImageManager.getImage())
                    .resizable()
                    .frame(width: imageWidth * 0.7, height: imageHeight * 0.7)
            }
            .frame(width: imageWidth, height: imageHeight)
            .padding(EdgeInsets(top: 36, leading: 0, bottom: 0, trailing: 0))
            VStack(alignment: .leading) {
                Text("Top Songs")
                    .font(Font.system(size: 24, weight: .bold, design: .default))
                    .padding()
                Divider()
                ForEach(songs, id: \.self) { song in
                    SongButton(name: song.name, artists: song.artists, currentSong: $currentSong, playing: $playing) {
                        SpotifyManager.shared.play(uri: song.uri)
                        currentSong = song.name
                        playing = true
                    }
                }
            }
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 24, leading: 0, bottom: 0, trailing: 0))
            Spacer()
        }
        .navigationTitle(user.name)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {presentationMode.wrappedValue.dismiss()}) {
                    Image(systemName: "arrow.left")
                        .resizable()
                        .foregroundColor(.green)
                        .frame(width: 25, height: 20)
                }
            }
        }
        .onAppear() {
            ApiManager.getRadar(username: user.username) { res in
                switch res {
                case .success(let data):
                    withAnimation {
                        songs = data
                    }
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
            UITextField.appearance().clearButtonMode = .whileEditing
        }
    }
}
//
//struct RadarView_Previews: PreviewProvider {
//    static var previews: some View {
//        RadarView()
//    }
//}
