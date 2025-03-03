import SwiftUI

struct OffensiveView: View {
    var body: some View {
        ZStack {
            Color(red: 0.588, green: 0.447, blue: 0.584)
                .ignoresSafeArea()
            
            VStack {
                
                Text("Offensive / Romania")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                    .padding(.top, 50)
                ZStack {
                    Rectangle()
                        .fill(Color(red: 1.0, green: 0.945, blue: 0.816))
                        .frame(width: 350, height: 200)
                        .cornerRadius(20)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(Color(red: 0.176, green: 0.188, blue: 0.278), lineWidth: 4) // Bordo color 2d3047
                        )
                    Text(" Is touching someone's head considered disrespectful in Romania?")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                        .frame(width: 320)
                        .multilineTextAlignment(.center)
                        .padding()
                }
   
                Spacer()
                Button("start") {
                    
                }
                .font(.title3)
                .padding()
                .bold()
                .frame(maxWidth: 150)
                .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                .foregroundColor(.white)
                .cornerRadius(30)
            }
            .padding(.bottom, 35)
        } // end ZStack
//        .navigationBarBackButtonHidden(true)
    }//end Body
}//end struct

#Preview {
    OffensiveView()
}
