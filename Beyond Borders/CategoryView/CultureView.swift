import SwiftUI
import AVFoundation
import AudioToolbox

struct CultureView: View {
    
    @Binding var participants: [String]
    @Binding var numParticipants: Int
    @Binding var numRounds: Int
    @Binding var turnDuration: Int
    
    var onHome: () -> Void
    
    @State private var remainingTime: Int
    @State private var currentTurn: Int = 0
    @State private var completedRounds: Int = 0
    @State private var timer: Timer?
    
    @State private var showEndScreen = false
    @State private var showTransitionScreen = false
    
    @State private var extraRound = false
    @State private var turnOrder: [[String]] = []
    
    let selectedCountry: Country
    private var culturequestions: [String] = []
    
    @State private var randomQuestion: String = ""
    @State private var showStart = true // Controlla la visibilità del pulsante Start
    @State private var showNo = false
    @State private var showYes = false
    @State private var showTimer = false
    
    private func getRandomQuestion() -> String {
        return culturequestions.randomElement() ?? "No questions available"
    }
    
    init(numParticipants: Binding<Int>,
         participants: Binding<[String]>,
         numRounds: Binding<Int>,
         turnDuration: Binding<Int>,
         onHome: @escaping () -> Void,
         selectedCountry: Country) {
        
        self._numParticipants = numParticipants
        self._participants = participants
        self._numRounds = numRounds
        self._turnDuration = turnDuration
        self.onHome = onHome
        self.selectedCountry = selectedCountry  // 🔹 Ora viene inizializzato correttamente!
        
        self.culturequestions = [
                "Family remains the cornerstone of society in \(selectedCountry.name), shaping traditions and daily life.",
                "In \(selectedCountry.name), great emphasis is placed on showing respect to elders in both speech and actions.",
                "Traditional festivals and celebrations in \(selectedCountry.name) are deeply rooted in history and widely observed.",
                "Gatherings and parties are an integral part of social life in \(selectedCountry.name), strengthening community bonds.",
                "A deep sense of national pride influences cultural expressions and daily interactions in \(selectedCountry.name).",
                "Traditional art, music, and dance in \(selectedCountry.name) continue to thrive as symbols of cultural identity.",
                "Special occasions in \(selectedCountry.name) are marked by the wearing of traditional clothing and specific dress codes.",
                "Hospitality is a defining cultural trait in \(selectedCountry.name), with guests warmly welcomed into homes.",
                "Religious practices play a fundamental role in the daily lives of people in \(selectedCountry.name).",
                "In \(selectedCountry.name), personal space is a key consideration in social interactions and public settings.",
                "Older traditions and customs in \(selectedCountry.name) are highly respected and passed down through generations.",
                "Punctuality is regarded as an essential social norm in \(selectedCountry.name), reflecting discipline and respect.",
                "Greetings in \(selectedCountry.name) follow unique cultural customs that differ from those of other nations.",
                "Public holidays in \(selectedCountry.name) are closely tied to cultural and religious traditions.",
                "In \(selectedCountry.name), people switch between formal and informal speech depending on social context.",
                "Maintaining strong family connections is a cultural priority in \(selectedCountry.name), influencing daily interactions.",
                "The people of \(selectedCountry.name) are renowned for their openness and hospitality towards guests.",
                "Younger generations in \(selectedCountry.name) actively engage in preserving traditional cultural practices.",
                "National pride in \(selectedCountry.name) is reflected in public behavior and traditional dress.",
                "A strong sense of community and collective responsibility defines social interactions in \(selectedCountry.name)."
            ]


        // Inizializzazione delle variabili di stato
        _remainingTime = State(initialValue: turnDuration.wrappedValue)
        _randomQuestion = State(initialValue: culturequestions.randomElement() ?? "No questions available")
    }

    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.286, green: 0.678, blue: 0.635)
                    .ignoresSafeArea()
                
                if showEndScreen {
                    EndScreen(onRestart: restartGame, onHome: handleHome)
                } else if showTransitionScreen {
                    if let currentParticipant = currentTurnSafe() {
                        TransitionScreen(
                            nextParticipant: currentParticipant,
                            onTap: {
                                startTimer()
                                showTransitionScreen = false
                            },
                            backgroundColor: Color(red: 0.286, green: 0.678, blue: 0.635)  // Culture View's background color
                        )
                    }
                } else {
                    
                    VStack {
                        Text("Culture - \(selectedCountry.name)")
                            .font(.largeTitle)
                            .bold()
                            .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .padding(.top, 50)
                        
                        ZStack {
                            Rectangle()
                                .fill(Color(red: 1.0, green: 0.945, blue: 0.816))
                                .frame(width: 350, height: 200)
                                .cornerRadius(20)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(red: 0.176, green: 0.188, blue: 0.278), lineWidth: 4)
                                )
                            
                            Text(randomQuestion)
                                .font(.system(size: 25, weight: .bold))
                                .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                                .frame(width: 320)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        
                        Spacer()
                        
                        if showStart {
                            Button(action: {
                                showStart = false // Nasconde il pulsante Start e mostra nuovi elementi
                            }) {
                                Text("Start")
                                    .font(.title)
                                    .padding()
                                    .bold()
                                    .frame(width: 130, height: 70)
                                    .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                                    .foregroundColor(.white)
                                    .cornerRadius(30)
                            }
                            .padding()
                        } else {
                            // Qui puoi aggiungere il nuovo contenuto che comparirà dopo aver premuto Start
                            VStack(spacing: 20) {
                                
                                Spacer()
                                
                                if let currentParticipant = currentTurnSafe() {
                                    Text("\(currentParticipant)")
                                        .font(.title)
                                        .bold()
                                        .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                                    
                                    //                        Text("Round \(currentRound)")
                                    //                            .font(.title3)
                                    //                            .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                                    //                            .bold()
                                }
                                else {
                                    Text("Re open the app")
                                }
                                
                                
                                Spacer()
                                
                                if !showTimer{
                                    Text("Do you agree?")
                                        .font(.title)
                                        .bold()
                                        .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                                    
                                    
                                    
                                    
                                    HStack {
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            showTimer = true // Nasconde il pulsante Start e mostra nuovi elementi
                                        })
                                        {
                                            Text("Yes")
                                                .font(.title)
                                                .padding()
                                                .bold()
                                                .frame(width: 130, height: 70)
                                                .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                                                .foregroundColor(.white)
                                                .cornerRadius(30)
                                        }
                                        Spacer()
                                        
                                        Button(action: {
                                            showTimer = true // Nasconde il pulsante Start e mostra nuovi elementi
                                        })
                                        {
                                            Text("No")
                                                .font(.title)
                                                .padding()
                                                .bold()
                                                .frame(width: 130, height: 70)
                                                .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                                                .foregroundColor(.white)
                                                .cornerRadius(30)
                                            
                                            
                                        }
                                        
                                        Spacer()
                                        
                                    }
                                    .padding()
                                    
                                } //End IF
                                else{
                                    
                                    VStack{
                                        ZStack {
                                            // Rettangolo grigio di sfondo
                                            Rectangle()
                                                .fill(Color.gray.opacity(0.3))
                                                .frame(width: 320, height: 70)
                                                .cornerRadius(30)
                                            
                                            // Rettangolo blu che si svuota da destra a sinistra
                                            HStack(spacing: 0) {
                                                Rectangle()
                                                    .fill(Color(red: 0.176, green: 0.188, blue: 0.278))
                                                    .frame(width: CGFloat(remainingTime) / CGFloat(turnDuration) * 320, height: 70) // La larghezza diminuisce nel tempo
                                                
                                                Spacer(minLength: 0)
                                            }
                                            .frame(width: 320, height: 70)
                                            .cornerRadius(30)
                                            .animation(.linear(duration: 1), value: remainingTime)
                                            
                                            Text(formatTime(remainingTime))
                                                .font(.largeTitle)
                                                .foregroundColor(.white)
                                                .bold()
                                        }
                                        .padding(.top, 160)
                                        .frame(width: 250, height: 50)
                                        Spacer()
                                        
                                        Button(action: endTurn)
                                        {
                                            Text("Skip")
                                                .font(.title)
                                                .padding()
                                                .bold()
                                                .frame(width: 130, height: 70)
                                                .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                                                .foregroundColor(.white)
                                                .cornerRadius(30)
                                        }
                                        .padding(.horizontal)
                                        .fullScreenCover(isPresented: $showTransitionScreen){
                                            TransitionScreen(
                                                nextParticipant: participants[Int.random(in: 0..<participants.count)],
                                                onTap: {},
                                                backgroundColor: Color(red: 0.286, green: 0.678, blue: 0.635)  // Culture View's background color
                                            )
                                        }
                                        
                                    }
                                    .padding()
                                    .transition(.opacity) // Effetto di transizione
                                    .onAppear {
                                        startTimer()
                                    }
                                    .onDisappear {
                                        stopTimer()
                                    }
                                    
                                }
                            }
                            //                        .transition(.opacity) // Effetto di transizione
                            
                        }
                    }
                }
            }
            .onAppear {
                // Ensure turn order is generated when view appears
                if turnOrder.isEmpty {
                    generateTurnOrder()
                }
            }
        }// End Nav Stack
        
    }
     

func stopTimer() {
    if let timer = timer {
        timer.invalidate()
        self.timer = nil
    }
}

func startTimer() {
    timer?.invalidate()
    remainingTime = turnDuration
    timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
        if remainingTime > 0 {
            remainingTime -= 1
        } else {
            endTurn()
        }
    }
}

func endTurn() {
    timer?.invalidate()
    playSound()
    
    if currentTurn + 1 < (extraRound ? participants.count : numRounds * participants.count) {
        currentTurn += 1
        showTransitionScreen = true
        showTimer = false
    } else {
        showEndScreen = true
    }
    
}

func playSound() {
    AudioServicesPlaySystemSound(1005)
}

func currentTurnSafe() -> String? {
    guard !turnOrder.isEmpty,
          currentTurn / participants.count < turnOrder.count,
          currentTurn % participants.count < turnOrder[currentTurn / participants.count].count else {
        return nil
    }
    return turnOrder[currentTurn / participants.count][currentTurn % participants.count]
}

func formatTime(_ seconds: Int) -> String {
    let minutes = seconds / 60
    let secs = seconds % 60
    return String(format: "%d:%02d", minutes, secs)
}

func generateTurnOrder() {
    turnOrder = []
    var lastParticipant = ""
    for _ in 0..<(extraRound ? 1 : numRounds) {
        var order: [String]
        repeat {
            order = participants.shuffled()
        } while !turnOrder.isEmpty && order.first == lastParticipant
        
        lastParticipant = order.last ?? ""
        turnOrder.append(order)
    }
    
    // Debug print to verify turn order generation
    print("Generated Turn Order: \(turnOrder)")
}
    
func handleHome() {
        stopTimer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            onHome()
        }
    }
    
func restartGame() {
    if extraRound {
        completedRounds += 1
    }else{
        completedRounds = numRounds
        extraRound = true
    }
    currentTurn = 0
    showEndScreen = false
    showTransitionScreen = false
    extraRound = true
    generateTurnOrder()
    startTimer()
}


}

struct CultureView_Previews: PreviewProvider {
    static var previews: some View {
        CultureView(
            numParticipants: .constant(3),
            participants: .constant(["Alice", "Bob", "Charlie"]),
            numRounds: .constant(3),
            turnDuration: .constant(60),
            onHome: {},
            selectedCountry: Country(name: "Italy", flagImage: "flags_italy")
        )
    }
}


