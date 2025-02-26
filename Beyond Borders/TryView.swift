//
//  TryView.swift
//  Beyond Borders
//
//  Created by Davide Bellobuono on 26/02/25.
//

import SwiftUI

struct TryView: View {
    var body: some View {
        ZStack {
            Color(red: 0.364, green: 0.635, blue: 0.443)
                .ignoresSafeArea()
            
            VStack {
                Text("Festivals / India")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                
                Rectangle()
                    .fill(Color(red: 1.0, green: 0.945, blue: 0.816)) // Interno color fff1d0
                    .frame(width: 350, height: 200)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(red: 0.176, green: 0.188, blue: 0.278), lineWidth: 4) // Bordo color 2d3047
                    )
                
                Spacer()
                
                Button("start") {
                    
                }
                .font(.title2)
                .bold()
                .frame(width: 100, height: 50)
                .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.bottom,50)
            }
        } // end ZStack
    }//end Body
}//end struct

#Preview {
    TryView()
}
