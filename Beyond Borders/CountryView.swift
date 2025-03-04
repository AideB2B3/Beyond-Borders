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
        Country(name: "Afghanistan", flagImage: "flags_afghanistan"),
        Country(name: "Albania", flagImage: "flags_albania"),
        Country(name: "Bangladesh", flagImage: "flags_bangladesh"),
        Country(name: "Brazil", flagImage: "flags_brazil"),
        Country(name: "Bulgaria", flagImage: "flags_bulgaria"),
        Country(name: "China", flagImage: "flags_china"),
        Country(name: "Colombia", flagImage: "flags_colombia"),
        Country(name: "Congo (DRC)", flagImage: "flags_congo"),
        Country(name: "Egypt", flagImage: "flags_egypt"),
        Country(name: "Germany", flagImage: "flags_germany"),
        Country(name: "Greece", flagImage: "flags_greece"),
        Country(name: "India", flagImage: "flags_india"),
        Country(name: "Iran", flagImage: "flags_iran"),
        Country(name: "Italy", flagImage: "flags_italy"),
        Country(name: "Kenya", flagImage: "flags_kenya"),
        Country(name: "Mexico", flagImage: "flags_mexico"),
        Country(name: "Morocco", flagImage: "flags_morocco"),
        Country(name: "Nepal", flagImage: "flags_nepal"),
        Country(name: "Nigeria", flagImage: "flags_nigeria"),
        Country(name: "Pakistan", flagImage: "flags_pakistan"),
        Country(name: "Portugal", flagImage: "flags_portugal"),
        Country(name: "Romania", flagImage: "flags_romania"),
        Country(name: "Saudi Arabia", flagImage: "flags_saudiarabia"),
        Country(name: "South Africa", flagImage: "flags_southafrica"),
        Country(name: "Spain", flagImage: "flags_spain"),
        Country(name: "Sri Lanka", flagImage: "flags_srilanka"),
        Country(name: "Turkey", flagImage: "flags_turkey"),
        Country(name: "Vietnam", flagImage: "flags_vietnam")

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
                    .padding(.bottom, 30)
                }
            } // end VStack
            .padding(.horizontal, 20)
        } // end ZStack
        .navigationBarBackButtonHidden(true) // leva il tasto back
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
