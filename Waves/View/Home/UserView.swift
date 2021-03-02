//
//  UserView.swift
//  Waves
//
//  Created by Michael Koohang on 3/1/21.
//

import SwiftUI

struct UserView: View {
    var image: String
    var name: String
    var imageWidth: CGFloat = 100
    var imageHeight: CGFloat = 100
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            ZStack {
                Circle()
                    .fill(Color.white)
                    .shadow(radius: 5)
                Image(image)
                    .resizable()
                    .frame(width: imageWidth * 0.7, height: imageHeight * 0.7)
            }
            .frame(width: imageWidth, height: imageHeight)
            Text(name)
                .bold()
                .foregroundColor(.green)
        }
        
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(image: "Hand", name: "Logan")
    }
}
