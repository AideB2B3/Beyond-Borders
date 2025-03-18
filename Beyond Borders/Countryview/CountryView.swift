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
    @State private var floatEffect: CGFloat = -5
    @State private var displayedText = ""
    @State private var index = 0
    @State private var isJump = false
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
            
            Color(.beigeBack)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                if showText {
                    VStack() {
                        Text("Tap the world to extract a random country")
                            .font(.custom("Atma-Bold", fixedSize: 35))
                            .foregroundColor(Color(.colorWritten))
                            .multilineTextAlignment(.center)
                            .minimumScaleFactor(0.7)
                            .padding(.horizontal, 15)
                    }
                    .padding(.horizontal, 20)
                    .transition(.opacity.combined(with: .scale))
                    .animation(.easeInOut(duration: 0.5), value: showText)
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
                        VStack() {
                            
                            Spacer()
                            
                            
                            Image("Spaceship_flash")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 350, height: 350)
                                .padding(.bottom,-25)
                            //    .offset(y: isJump ? -8 : 8)
//                                .animation(Animation.easeInOut(duration: 0.6).repeatForever(autoreverses: true), value: isJump)
//                                .onAppear {
//                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//                                        isJump = true
//                                    }
//                                }

                            Image(selectedCountry.flagImage)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 150, height: 100)
                                .shadow(radius: 5)
                            
                            Text(displayedText)
                                .font(.custom("Atma-Bold", fixedSize: 35))
                                .padding()
                                .foregroundColor(.colorWritten)
                                .cornerRadius(10)
                                .onAppear {
                                    displayedText = ""
                                    index = 0
                                    Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                                        if index < selectedCountry.name.count {
                                            displayedText.append(selectedCountry.name[selectedCountry.name.index(selectedCountry.name.startIndex, offsetBy: index)])
                                            index += 1
                                        } else {
                                            timer.invalidate()
                                        }
                                    }
                                }
                            
                        }
                        .transition(.opacity)
                        .padding(.bottom, 70)
                    }
                }
                
                Spacer()
                
                if showNextButton {
                    HStack(spacing: 20) {
                        
                        Spacer()
                        
                        Button(action: {
                            guard !isSoundPlaying else { return }
                            
                            isPlaying = true
                            showText = false
                            isSoundPlaying = true
                            showFlag = false
                            showNextButton = false
                            playSound()
                            
                            selectedCountry = countries.randomElement() ?? Country(name: "", flagImage: "")
                            
                            // Dopo il tempo dell'animazione, mostra la bandiera e il pulsante Next
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.85) {
                                withAnimation {
                                    showFlag = true
                                }
                                withAnimation(.easeIn(duration: 0.5)) {
                                    showNextButton = true
                                }
                                isSoundPlaying = false
                            }
                        }) {
                            Text("Re-tap")
                                .font(.custom("Atma-Bold", fixedSize: 30))
                                .padding()
                                .frame(width: 150, height: 70)
                                .background(Color(.colorWritten))
                                .foregroundColor(.white)
                                .cornerRadius(30)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            isCategoriesPresented = true
                        }) {
                            Text("Next")
                                .font(.custom("Atma-Bold", fixedSize: 30))
                                .padding()
                                .frame(width: 150, height: 70)
                                .background(Color(.colorWritten))
                                .foregroundColor(.white)
                                .cornerRadius(30)
                        }
                        .fullScreenCover(isPresented: $isCategoriesPresented) {
                            CategoriesView(numParticipants: $numParticipants, participants: $participants, numRounds: $numRounds, turnDuration: $turnDuration, onHome: onHome, selectedCountry: selectedCountry)
                        }
                        
                        Spacer()
                        
                    }
                    .transition(.opacity)
                    .padding(.bottom, 30)
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
            numRounds: .constant(1),
            turnDuration: .constant(5),
            onHome: {}
        )
    }
}
