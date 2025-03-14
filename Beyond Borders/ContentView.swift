import SwiftUI
import AVKit

struct ContentView: View {
    
    @State var numParticipants: Int
    @State var participants: [String]
    @State var numRounds: Int
    @State var turnDuration: Int
    var onStart: () -> Void
    var onHome: () -> Void
    
    @State private var isSettingsPresented = false
    @State private var showOnboarding = false
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                
                Color(.beigeBack)
//                                Color(red: 0.968, green: 1, blue: 0.96) // Azzurro chiaro polvere
                //                Color(red: 0.92, green: 0.92, blue: 0.92) // Grigio molto chiaro
                //                Color(red: 0.98, green: 0.95, blue: 0.90) // Beige chiaro
                    .ignoresSafeArea()
                
                VStack {
                    Text("\nWelcome in Beyond Borders")
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(.colorWritten))
                        .bold()
                    Spacer()
                    ZStack {
                        
                        Image("rettangolo bb")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .offset(x: 20, y: 30)
                        
                        Text("Hi!")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color(.colorWritten))
                            .multilineTextAlignment(.center)
                            .frame(width: 280)
                            .minimumScaleFactor(0.7)
                            .offset(x: 20, y: 30)
                    }
                    
                    HStack {
                        Image("Mascotte")
                            .resizable()
                            .frame(width: 170, height: 170)
                            .offset(x: -30, y: -20)
                    }
                    
                    Spacer()
                    
                    
                    Button(action: {
                        if !hasSeenOnboarding {
                            showOnboarding = true
                        } else {
                            isSettingsPresented = true
                        }
                    }) {
                        Text("Play")
                            .font(.title)
                            .padding()
                            .bold()
                            .frame(width: 150, height: 70)
                            .background(Color(.colorWritten))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                    .padding()
                    .fullScreenCover(isPresented: $showOnboarding, onDismiss: {
                        hasSeenOnboarding = true
                    }) {
                        OnBoardingView(isPresented: $showOnboarding)
                    }
                    .fullScreenCover(isPresented: $isSettingsPresented) {
                        SettingsView(numParticipants: numParticipants, participants: participants, numRounds: numRounds, turnDuration: turnDuration, onStart: onStart, onHome: onHome)
                    }
                    
                    NavigationLink(destination: InfoView()) {
                        Text("Info")
                            .font(.title)
                            .padding()
                            .bold()
                            .frame(width: 150, height: 65)
                            .background(Color(.colorWritten))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                    //                    .padding(.bottom, 50)
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: StoryView()) {
                        Image(systemName: "book")
                            .font(.title)
                            .foregroundColor(Color(.colorWritten))
                    }
                }
            }
        }
        //    .tint(Color(.colorWritten))
    }
}

#Preview {
    ContentView(
        numParticipants: 4,
        participants: ["Player 1", "Player 2", "Player 3", "Player 4"],
        numRounds: 1,
        turnDuration: 60,
        onStart: {},
        onHome: {}
    )
}

