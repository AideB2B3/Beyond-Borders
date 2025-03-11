import SwiftUI

struct InfoView: View {
    var body: some View {
        
        ZStack {
            Color(red: 1.0, green: 0.945, blue: 0.816)
                .ignoresSafeArea()
            
            VStack {
                Text("Credits:")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                
                Text("\nChristian Ciriello\nDavide BelloBuono\nFabrizio Vollaro\nIrem Nur Arslaner\nMichele Mariniello\nSupriya Palle")
                    .font(.title2)
                    .bold()
                    .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
            }

        }
    }
}

#Preview {
    InfoView()
}
