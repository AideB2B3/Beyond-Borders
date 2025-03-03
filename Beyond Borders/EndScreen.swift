import SwiftUI

struct EndScreen: View {
    
    var onRestart: () -> Void
    var onHome: () -> Void
    
    var body: some View {
        
        ZStack {
            Color(red: 1.0, green: 0.945, blue: 0.816)
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 20) {
                
                Spacer()
                
                Text("Coming Soon...")
                    .font(.largeTitle)
                    .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                    .bold()

                Spacer()
                
                HStack {
                    
                    Button(action: onRestart) {
                        Label("Round", systemImage: "arrow.clockwise")
                            .font(.title3)
                            .padding()
                            .bold()
                            .frame(maxWidth: 150)
                            .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                    .padding(.horizontal)
                    
                    Button(action: onHome) {
                        Label("Home", systemImage: "house.fill")
                            .font(.title3)
                            .padding()
                            .bold()
                            .frame(maxWidth: 150)
                            .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                    .padding(.horizontal)
                }
            }
            .padding(.bottom, 40)
        }
    }
}

struct EndScreen_Previews: PreviewProvider {
    static var previews: some View {
        EndScreen(
            onRestart: {},
            onHome: {}
        )
    }
}
