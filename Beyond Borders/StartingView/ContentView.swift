import SwiftUI
import AVKit

struct ContentView: View {
    
    @State var numParticipants: Int
    @State var participants: [String]
    @State var numRounds: Int
    @State var turnDuration: Int
    @State private var isJumping = false
    var onStart: () -> Void
    var onHome: () -> Void
    
    @State private var isSettingsPresented = false
    @State private var showOnboarding = false
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    var body: some View {
        NavigationStack {
            
            ZStack {
                
                Color(.beigeBack)
                    .ignoresSafeArea()
                
                VStack {
                    Text("\nBeyond Borders")
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(.colorWritten))
                        .bold()
                    Spacer()

                    HStack {
                        Image("Alien_hi")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 250, height: 250)
                            .offset(y: isJumping ? -8 : 8)
                            .animation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: isJumping)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    isJumping = true
                                }
                            }
                    }
                    
                    Spacer()

                    Button(action: {
                        if !hasSeenOnboarding {
                            showOnboarding = true
                        } else {
                            isSettingsPresented = true
                        }
                    }) {
                        Text("Start")
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
                }
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink(destination: InfoView()) {
                        Image(systemName: "info.circle")
                            .font(.title)
                            .foregroundColor(Color(.colorWritten))
                    }
                }
            }
        }
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
