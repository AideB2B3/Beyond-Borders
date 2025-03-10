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
    @State private var showNextButton = false
    @State private var isPlaying = false
    @State private var isSoundPlaying = false
    @State private var selectedCountry: Country = Country(name: "", flagImage: "")
    
    @State private var isCategoriesPresented = false
    
    let countries: [Country] = [
        
        Country(name: "Afghanistan", flagImage: "flags_afghanistan"),
        Country(name: "Albania", flagImage: "flags_albania"),
        Country(name: "Bangladesh", flagImage: "flags_bangladesh"),
        Country(name: "Brazil", flagImage: "flags_brazil"),
        Country(name: "Bulgaria", flagImage: "flags_bulgaria"),
        Country(name: "China", flagImage: "flags_china"),
        Country(name: "Colombia", flagImage: "flags_colombia"),
        Country(name: "Congo", flagImage: "flags_congo"),
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
            
            VStack(spacing: 20) {
 
                if showText {
//                    VStack(spacing: 10) {
//                        Image("rettangolo bb")
//                            .resizable()
//                            .scaledToFit()
//                            .frame(width: 300, height: 180)
//                            .overlay(
                                Text("Tap the world to choose a country")
                                    .font(.largeTitle)
                                    .bold()
                                    .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                                    .multilineTextAlignment(.center)
//                                    .frame(width: 260)
                                    .padding(5)
//                            )
                        
//                        HStack {
//                            Image("yellowEnemy")
//                                .resizable()
//                                .scaledToFit()
//                                .frame(width: 120, height: 120)
//                            Spacer()
//                            
//                        }
//                    }
                    .transition(.opacity)
//                    .animation(.easeInOut, value: showText)
                }
                
                Spacer()

                ZStack {
                    if !showFlag {
                    
                        LottieView(animation: .named("world_pin"))
                            .playbackMode(isPlaying ? .playing(.toProgress(1, loopMode: .loop)) : .paused)
                            .animationSpeed(1.5)
                            .frame(width: 350, height: 350)
                            .onTapGesture {
                                guard !isSoundPlaying else { return }
                                
                                isPlaying = true
                                showText = false
                                isSoundPlaying = true
                                playSound()
                                
                                selectedCountry = countries.randomElement() ?? Country(name: "", flagImage: "")
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.85) {
                                    withAnimation {
                                        showFlag = true
                                    }
                                    withAnimation(.easeIn(duration: 0.5)) {
                                        showNextButton = true
                                    }
                                    isSoundPlaying = false
                                }
                            }
                            .transition(.opacity)
                    } else {
                        VStack(spacing: 20) {
//                            Image("rettangolo bb")
//                                .resizable()
////                                .scaledToFit()
//                                .frame(width: 350, height: 200)
//                                .overlay(
                            Spacer()
                            
                                    Text("Has been selected: \n\n\(selectedCountry.name)")
                                        .font(.largeTitle)
                                        .bold()
                                        .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                                        .multilineTextAlignment(.center)
                                        .frame(width: 260)
                                        .padding()
//                                )
                            
//                            HStack(spacing: 30) {
//                                Spacer()
//                                Image("yellowEnemy")
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: 120, height: 120)
//                                Spacer()
                                Image(selectedCountry.flagImage)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 250, height: 200)
                                    .shadow(radius: 10)
                                Spacer()
//                            }
//                            .padding(.horizontal)
                        }
                        .transition(.opacity)
                    }
                }
                
                Spacer()
                
                if showNextButton {
                    Button(action: {
                        isCategoriesPresented = true
                    }) {
                        Text("Next")
                            .font(.title)
                            .padding()
                            .bold()
                            .frame(width: 130, height: 70)
                            .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                    .transition(.opacity)
                    .padding(.bottom, 30)
                    .fullScreenCover(isPresented: $isCategoriesPresented){
                        CategoriesView(numParticipants: $numParticipants, participants: $participants, numRounds: $numRounds, turnDuration: $turnDuration, onHome: onHome, selectedCountry: selectedCountry)
                    }
                }
            }
            .padding()
        }//End ZStack
    } // End Body
    
    func playSound() {
        if let path = Bundle.main.path(forResource: "AnimationSound", ofType: "mp3") {
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
