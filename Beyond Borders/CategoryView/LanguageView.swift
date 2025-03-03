import SwiftUI

struct LanguageView: View {
    var body: some View {
        ZStack {
            Color(red: 0.365, green: 0.635, blue: 0.443)
                .ignoresSafeArea()
            
            VStack {
                
                Text("Language / Turkey")
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
                                .stroke(Color(red: 0.176, green: 0.188, blue: 0.278), lineWidth: 4)
                        )
                    Text("Which is the most common language spoken in Turkey?")
                        .font(.system(size: 25, weight: .bold))
                        .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                        .frame(width: 320) // Larghezza massima
                        .multilineTextAlignment(.center) // Centra le righe
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
    LanguageView()
}
