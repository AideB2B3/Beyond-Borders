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
    @State private var selectedCountry: Country = Country(name: "Italia", flagImage: "flag_italia")
    
    struct Country {
        let name: String
        let flagImage: String
    }
    
    let countries: [Country] = [
        Country(name: "India", flagImage: "flag_india"),
        Country(name: "China", flagImage: "flag_china"),
        Country(name: "Nigeria", flagImage: "flag_nigeria"),
        Country(name: "Pakistan", flagImage: "flag_pakistan"),
        Country(name: "Bangladesh", flagImage: "flag_bangladesh"),
        Country(name: "Egypt", flagImage: "flag_egypt"),
        Country(name: "Brazil", flagImage: "flag_brazil"),
        Country(name: "Mexico", flagImage: "flag_mexico"),
        Country(name: "South Africa", flagImage: "flag_southafrica"),
        Country(name: "Kenya", flagImage: "flag_kenya"),
        Country(name: "Vietnam", flagImage: "flag_vietnam"),
        Country(name: "Turkey", flagImage: "flag_turkey"),
        Country(name: "Iran", flagImage: "flag_iran"),
        Country(name: "Colombia", flagImage: "flag_colombia"),
        Country(name: "Morocco", flagImage: "flag_morocco"),
        Country(name: "Afghanistan", flagImage: "flag_afghanistan"),
        Country(name: "Nepal", flagImage: "flag_nepal"),
        Country(name: "Congo", flagImage: "flag_congo"),
        Country(name: "Sri Lanka", flagImage: "flag_srilanka"),
        Country(name: "Saudi Arabia", flagImage: "flag_saudiarabia")
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
                    LottieView(animation: .named("world_pin"))
                        .playbackMode(isPlaying ? .playing(.toProgress(1, loopMode: .loop)) : .paused)
                        .animationSpeed(1.5)
                        .frame(width: 350, height: 350)
                        .onTapGesture {
                            isPlaying = true
                            showText = false
                            playSound()
                            
                            selectedCountry = countries.randomElement() ?? Country(name: "Italia", flagImage: "flag_italia")
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
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
                    // Bandiera + Nome del Paese
                    VStack {
                        Image(selectedCountry.flagImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 250, height: 200)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .shadow(radius: 5)
                        
                        Text(selectedCountry.name)
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
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
