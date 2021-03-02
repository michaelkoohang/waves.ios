//
//  HomeView.swift
//  Waves
//
//  Created by Michael Koohang on 2/28/21.
//

import SwiftUI

struct HomeView: View {
    @State var searchString: String = ""
    @State var friends: [String] = ["Logan", "Michael", "Tris", "Jack", "Max", "Isabel", "Jared", "Dylan"].sorted()
    @State var filteredFriends: [String] = []
    var columns: [GridItem] = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        let binding = Binding<String>(get: {
            self.searchString
        }, set: {
            self.searchString = $0
            if searchString == "" {
                filteredFriends = friends
            } else {
                filteredFriends.removeAll()
                for i in 0...friends.count-1 {
                    if (friends[i].contains(searchString)) {
                        filteredFriends.append(friends[i])
                    }
                }
            }
        })
        
        return NavigationView {
            ScrollView {
                TextField("Search", text: binding)
                    .padding(EdgeInsets(top: 12, leading: 18, bottom: 12, trailing: 12))
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(12)
                LazyVGrid(columns: columns) {
                    ForEach(filteredFriends, id: \.self) { name in
                        NavigationLink(destination: RadarView()) {
                            UserView(image: RandomImageManager.getImage(), name: name)
                                .padding()
                        }
                    }
                }
                .padding(EdgeInsets(top: 24, leading: 24, bottom: 0, trailing: 24))
                .animation(.default)
            }
            .padding(EdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16))
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
        }
        .statusBar(hidden: true)
        .onAppear() {
            filteredFriends = friends
            UITextField.appearance().clearButtonMode = .whileEditing
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
