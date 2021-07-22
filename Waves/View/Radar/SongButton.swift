//
//  SongButton.swift
//  Waves
//
//  Created by Michael Koohang on 3/27/21.
//

import SwiftUI

struct SongButton: View {
    @State var name: String
    @State var artists: String
    @Binding var currentSong: String
    @Binding var playing: Bool
    @State var action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack {
                HStack {
                    VStack(alignment: .leading, spacing: 0) {
                        Text(name)
                            .foregroundColor(name == currentSong ? Color(.systemGreen) : .primary)
                        Text(artists)
                            .foregroundColor(.secondary)
                    }
                    .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 0))
                    Spacer()
                    if currentSong == name {
                        Button(action: {
                            if playing {
                                SpotifyManager.shared.pause()
                            } else {
                                SpotifyManager.shared.resume()
                            }
                            playing = !playing
                        }) {
                            if playing {
                                Image(systemName: "pause.fill")
                                    .resizable()
                                    .foregroundColor(Color(.systemGreen))
                                    .frame(width: 15, height: 18, alignment: .center)
                            } else {
                                Image(systemName: "play.fill")
                                    .resizable()
                                    .foregroundColor(Color(.systemGreen))
                                    .frame(width: 15, height: 18, alignment: .center)
                            }
                            
                        }
                    }
                }
                .padding(EdgeInsets(top: 8, leading: 24, bottom: 0, trailing: 24))
                Divider()
            }
        }
    }
}

//struct SongButton_Previews: PreviewProvider {
//    static var previews: some View {
//        SongButton(name: "Rubberband", artists: "Tate McRae", playing: true)
//    }
//}
