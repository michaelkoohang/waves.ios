//
//  RadarView.swift
//  Waves
//
//  Created by Michael Koohang on 2/28/21.
//

import SwiftUI

struct RadarView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var songs: [String] = ["Funny Thing", "Best Day Ever", "Surfaces"]
    
    var body: some View {
        ZStack {
            ScrollView {
                UserView(image: RandomImageManager.getImage(), name: "Logan", imageWidth: 125, imageHeight: 125)
                    .padding(EdgeInsets(top: 36, leading: 0, bottom: 0, trailing: 0))
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
            
            VStack {
                HStack(alignment: .center) {
                    Button(action: {presentationMode.wrappedValue.dismiss()}) {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .foregroundColor(.green)
                            .frame(width: 25, height: 20)
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding(EdgeInsets(top: 16, leading: 24, bottom: 16, trailing: 24))
                .background(Color.clear)
                Spacer()
            }
            
        }
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(true)
        
    }
}

struct RadarView_Previews: PreviewProvider {
    static var previews: some View {
        RadarView()
    }
}
