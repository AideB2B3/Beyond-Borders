//
//  CategoryView.swift
//  Beyond Borders
//
//  Created by Davide Bellobuono on 26/02/25.
//

import SwiftUI

struct CategoryView: View {
    var body: some View {
        ZStack{
            Color(red: 1.0, green: 0.945, blue: 0.816)
                .ignoresSafeArea()
            
            
            VStack{
                Text("Choose Your Category!")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                
                
                Spacer()
                
                
                Button("language") {
                    
                }
                .font(.title2)
                .bold()
                .frame(width:350, height: 60)
                .background(Color(red: 0.364, green: 0.635, blue: 0.443))
                .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                .cornerRadius(50)
                .padding()
                
                Button("food") {
                    
                }
                .font(.title2)
                .bold()
                .frame(width:350, height: 60)
                .background(Color(red: 1, green: 0.647, blue:0.274))
                .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                .cornerRadius(50)
                .padding()
                
                Button("festivals") {
                    
                }
                .font(.title2)
                .bold()
                .frame(width:350, height: 60)
                .background(Color(red: 0.286, green: 0.678, blue: 0.635))
                .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                .cornerRadius(50)
                .padding()
                
                Button("offensive rumors") {
                    
                }
                .font(.title2)
                .bold()
                .frame(width:350, height: 60)
                .background(Color(red: 0.588, green: 0.447, blue: 0.584))
                .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                .cornerRadius(50)
                .padding()
                
                Spacer()
            }
        }
    }
}

#Preview {
    CategoryView()
}

