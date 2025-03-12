import SwiftUI

struct InfoView: View {
    var body: some View {
        NavigationStack {
            
            ZStack {
                Color(red: 1.0, green: 0.945, blue: 0.816)
                    .ignoresSafeArea()
                
                VStack {
                    
                    ZStack {
                        Image("rettangolo bb")
                            .resizable()
                        
                        Text("If you don't know how the app is structured or want to find out who developed it, you're in the right place")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .multilineTextAlignment(.center)
                            .frame(width: 280)
                            .minimumScaleFactor(0.7)
                            .padding(.horizontal, 10)
                    }
                    
                    HStack {
                        Image("Mascotte")
                            .resizable()
                            .frame(width: 170, height: 170)
                            .offset(x: -90, y: -30)
                    }
                    
                    Spacer()
                    
                    NavigationLink(destination: RulesView()){
                        Text("Rules")
                            .font(.title)
                            .padding()
                            .bold()
                            .frame(width: 350, height: 60)
                            .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                    //                    .padding()
                    NavigationLink(destination: CreditsView()){
                        Text("Credits")
                            .font(.title)
                            .padding()
                            .bold()
                            .frame(width: 350, height: 60)
                            .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                    .padding()
                    
                }
                
            }
        }
        .tint(Color(red: 0.176, green: 0.188, blue: 0.278))
    }
}

#Preview {
    InfoView()
}

