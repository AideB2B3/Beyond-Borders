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
//                Color(.background)
                Color(red: 0.84, green: 0.89, blue: 0.95) // Azzurro chiaro polvere

//                Color(red: 0.92, green: 0.92, blue: 0.92) // Grigio molto chiaro
//                Color(red: 0.98, green: 0.95, blue: 0.90) // Beige chiaro


                    .ignoresSafeArea()
                
                VStack {
                    HStack{
                        Spacer()
                        
                        NavigationLink(destination: InfoView()){
                            Label("", systemImage: "info.circle")
                                .font(.largeTitle)
                                .padding()
                                .bold()
                                .frame(width: 200, height: 60)
                                .background(.clear)
                                .foregroundColor(Color(.colorDarkBlue))
                                .cornerRadius(30)
                        }
                    }
                    .padding(.trailing, -50)
                    
                    ZStack {
                        Image("rettangolo bb")
                            .resizable()
                        
                        Text("Welcome in Beyond Borders")
                            .font(.title)
                            .bold()
                            .foregroundColor(Color(.colorDarkBlue))
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
                            .frame(width: 200, height: 60)
                            .background(Color(.colorDarkBlue))
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
                    
                    NavigationLink(destination: StoryView()) {
                        Text("Our Story")
                            .font(.title)
                            .padding()
                            .bold()
                            .frame(width: 160, height: 50)
                            .background(Color(.colorDarkBlue))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
//                    .padding(.bottom, 50)
                }
                .padding()
            }
        }
//        .tint(Color(.white))
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

