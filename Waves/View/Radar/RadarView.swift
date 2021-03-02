//
//  RadarView.swift
//  Waves
//
//  Created by Michael Koohang on 2/28/21.
//

import SwiftUI

struct RadarView: View {
    @State var songs: [String] = ["Funny Thing", "Best Day Ever", "Surfaces"]
    
    var body: some View {
        VStack {
            UserView(image: "Hand", name: "Logan", imageWidth: 125, imageHeight: 125)
            VStack(alignment: .leading) {
                ForEach(songs, id: \.self) { name in
                    WavesButton(text: name, color: .green) {
                        print()
                    }
                }.padding(5)
            }
            .frame(maxWidth: .infinity)
            .padding(EdgeInsets(top: 24, leading: 16, bottom: 0, trailing: 16))
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct RadarView_Previews: PreviewProvider {
    static var previews: some View {
        RadarView()
    }
}
