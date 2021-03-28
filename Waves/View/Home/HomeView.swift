//
//  HomeView.swift
//  Waves
//
//  Created by Michael Koohang on 2/28/21.
//

import SwiftUI

struct HomeView: View {
    @State var searchString: String = ""
    @State var friends: [Friend] = []
    @State var filteredFriends: [Friend] = []
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
                    if (friends[i].name.contains(searchString)) {
                        filteredFriends.append(friends[i])
                    }
                }
            }
        })
        
        return NavigationView {
            ScrollView {
                HStack {
                    TextField("Search", text: binding)
                        .padding(EdgeInsets(top: 18, leading: 24, bottom: 18, trailing: 18))
                        .background(Color(UIColor.systemGray6))
                        .cornerRadius(40)
                }
                .padding(EdgeInsets(top: 8, leading: 18, bottom: 0, trailing: 18))
                LazyVGrid(columns: columns) {
                    ForEach(filteredFriends, id: \.self) { friend in
                        NavigationLink(destination: RadarView(user: friend)) {
                            UserView(image: RandomImageManager.getImage(), name: friend.name)
                                .padding()
                        }
                    }
                }
                .padding(EdgeInsets(top: 16, leading: 24, bottom: 0, trailing: 24))
                .animation(.default)
            }
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .navigationBarBackButtonHidden(true)
            .navigationTitle("Waves")
        }
        .statusBar(hidden: true)
        .onAppear() {
            ApiManager.getFriends { res in
                switch res {
                case .success(let data):
                    friends = data
                    filteredFriends = data
                case .failure(let err):
                    print(err.localizedDescription)
                }
            }
            UITextField.appearance().clearButtonMode = .whileEditing
        }
        
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
