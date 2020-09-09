//
//  SearchBarView.swift
//  iTunes albums search
//
//  Created by Михаил Вилкин on 07.09.2020.
//  Copyright © 2020 Михаил Вилкин. All rights reserved.
//

import SwiftUI

struct SearchBar: View {
    
    @ObservedObject var viewModel: SearchAlbumsViewModel
    
    @Binding var text: String
    
    @State var action: () -> Void
    
    @State private var isEditing = false    
    
    var body: some View {
        
        HStack {
            
            TextField("Search Albums", text: $text) {
                
                // Sim action when return button tapped
                self.action()
            }
                .keyboardType(.webSearch)
                .padding(7)
                .padding(.horizontal, 25)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .overlay(
                    HStack {

                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 8)

                        if isEditing {

                            Button(action: {

                                self.text = ""

                            }) {

                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            }
                        }
                    }
                )
                .padding(.horizontal, 10)
                .onTapGesture {
                    self.isEditing = true
                }

            if isEditing {

                Button(action: {
                    self.isEditing = false
                    self.text = ""
                    self.viewModel.clearAlbumsList()

                    // Dismiss the keyboard
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }) {

                    Text("Cancel")
                }
                .padding(.trailing, 10)
                .transition(.move(edge: .trailing))
                .animation(.default)
            }

        }.padding(10)
        
    }
}
