import SwiftUI
import Lottie
import AVFoundation

struct CountryView: View {
    
    @Binding var numParticipants: Int
    @Binding var participants: [String]
    @Binding var numRounds: Int
    @Binding var turnDuration: Int
    var onHome: () -> Void
    
    @State private var audioPlayer: AVAudioPlayer?
    @State private var showText = true
    @State private var showFlag = false
    @State private var showStartButton = false
    @State private var isPlaying = false
    @State private var selectedCountry: (flag: String, name: String) = ("🇮🇹", "Italia")
    
    let countries: [(flag: String, name: String)] = [
        ("🇮🇹", "Italia"),
        ("🇫🇷", "Francia"),
        ("🇩🇪", "Germania"),
        ("🇪🇸", "Spagna"),
        ("🇬🇧", "Regno Unito")
    ]
    
    var body: some View {
        ZStack {
            Color(red: 1.0, green: 0.945, blue: 0.816)
                .ignoresSafeArea()
            
            VStack {

                if showText {
                    Text("Tap to choose a country")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                        .padding(.top, 40)
                        .transition(.opacity)
                }
                
                Spacer()
                
                if !showFlag {
                    LottieView(animation: .named("Worldsimple"))
                        .playbackMode(isPlaying ? .playing(.toProgress(1, loopMode: .loop)) : .paused)
                        .animationSpeed(5)
                        .frame(width: 350, height: 350)
                        .onTapGesture {
                            isPlaying = true
                            showText = false
                            playSound()
                            
                            selectedCountry = countries.randomElement() ?? ("🇮🇹", "Italia")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    showFlag = true
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    withAnimation {
                                        showStartButton = true
                                    }
                                }
                            }
                        }
                        .transition(.opacity)
                } else {
                    // Flag + Nome del Paese
                    VStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color.white)
                            .frame(width: 200, height: 200)
                            .shadow(radius: 5)
                            .overlay(
                                VStack {
                                    Text(selectedCountry.flag)
                                        .font(.largeTitle)
                                        .bold()
                                    
                                    Text(selectedCountry.name)
                                        .font(.title)
                                        .bold()
                                }
                            )
                    }
                    .transition(.opacity)
                }
                
                Spacer()

                if showStartButton {
                    NavigationLink(destination: FoodView(numParticipants: $numParticipants, participants: $participants, numRounds: $numRounds, turnDuration: $turnDuration, onHome: onHome)) {
                        Text("Next")
                            .font(.title3)
                            .padding()
                            .bold()
                            .frame(maxWidth: 150)
                            .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                    .padding(.bottom, 30) // Spazio dal bordo inferiore
                }
            } // end VStack
            .padding(.horizontal, 20) // Margini laterali
        } // end ZStack
    } // End Body
    
    func playSound() {
        if let path = Bundle.main.path(forResource: "Rotation", ofType: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch {
                print("Errore nel caricamento del suono: \(error.localizedDescription)")
            }
        }
    }
}

struct CountryView_Previews: PreviewProvider {
    static var previews: some View {
        CountryView(
            numParticipants: .constant(3),
            participants: .constant(["Alice", "Bob", "Charlie"]),
            numRounds: .constant(5),
            turnDuration: .constant(60),
            onHome: {}
        )
    }
}
