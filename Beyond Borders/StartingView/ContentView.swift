import SwiftUI
import AVKit

struct ContentView: View {
    
    @State var numParticipants: Int
    @State var participants: [String]
    @State var numRounds: Int
    @State var turnDuration: Int
    @State private var isJumping = false
    @State private var widthAnimation = false
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
                    Text("Beyond Borders")
                        .font(.custom("Atma", fixedSize: 45))
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(.colorWritten))
                        .bold()
                    Spacer()

                    HStack {
                        Image("Alien_hi")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 250, height: 250)
                            .offset(y: isJumping ? -6 : 6)
                            .animation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: isJumping)
                            .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    isJumping = true
                                }
                            }
                    }
                    Image("Alien_Shadow")
                        .resizable()
                        .scaledToFill()
                        .frame(width: widthAnimation ? 230 : 280, height: 10)
                        .animation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: widthAnimation)
                        .onAppear {
                            widthAnimation = true
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
                            .font(.custom("Atma", fixedSize: 35))
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
