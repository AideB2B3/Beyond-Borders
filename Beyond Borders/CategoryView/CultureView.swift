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
    @State private var audioPlayer: AVAudioPlayer?
    
    @State private var responses: [(name: String, answer: String)] = []
    
    @State private var showEndScreen = false
    @State private var showTransitionScreen = false
    
    @State private var extraRound = false
    @State private var turnOrder: [[String]] = []
    
    @State private var selectedCountry: Country
    private var culturequestions: [String] = []
    
    @State private var randomQuestion: String = ""
    @State private var showStart = true
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
         selectedCountry: Country,
         responses: [(name: String, answer: String)] = []) {
        
        self._numParticipants = numParticipants
        self._participants = participants
        self._numRounds = numRounds
        self._turnDuration = turnDuration
        self.onHome = onHome
        self.selectedCountry = selectedCountry
        self.responses = responses
        
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
        
        _remainingTime = State(initialValue: turnDuration.wrappedValue)
        _randomQuestion = State(initialValue: culturequestions.randomElement() ?? "No questions available")
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.colorCulture)
                    .ignoresSafeArea()
                
                if showEndScreen {
                    EndScreen(onRestart: restartGame, onHome: handleHome,numParticipants: $numParticipants,
                              participants: $participants,
                              numRounds: $numRounds,
                              turnDuration: $turnDuration,
                              responses: responses)
                } else if showTransitionScreen {
                    if let currentParticipant = currentTurnSafe() {
                        TransitionScreen(
                            nextParticipant: currentParticipant,
                            onTap: {
                                startTimer()
                                showTransitionScreen = false
                            },
                            backgroundColor: Color(.colorCulture)
                        )
                    }
                } else {
                    
                    VStack {
                        Text("Culture - \(selectedCountry.name)")
                            .font(.custom("Atma-Bold", fixedSize: 35))
                            .foregroundColor(Color(.colorWritten))
                            .padding(.top, 10)
                        
                        ZStack {
                            
                            Image("rettangolo bb")
                                .resizable()
                                .scaledToFit( )

                            Text(randomQuestion)
                                .font(.custom("Atma-SemiBold", fixedSize: 23))
                                .foregroundColor(Color(.colorWritten))
                                .frame(width: 320)
                                .multilineTextAlignment(.center)
                                .padding()
                        }
                        
                        AlienSpeakingView(hasAnswered: showTimer)
                            .frame(width: 170, height: 170)
                            .offset(x: -130, y: -20)
                            
                        Spacer()
                        
                        if showStart {
                            Button(action: {
                                showStart = false
                            }) {
                                Text("Play")
                                    .font(.custom("Atma", fixedSize: 30))
                                    .padding()
                                    .bold()
                                    .frame(width: 130, height: 70)
                                    .background(Color(.colorWritten))
                                    .foregroundColor(.white)
                                    .cornerRadius(30)
                            }
                            .padding()
                        } else {
                            VStack(spacing: 20) {

                                if let currentParticipant = currentTurnSafe() {
                                    Text("\(currentParticipant)")
                                        .font(.custom("Atma-Bold", fixedSize: 30))
                                        .foregroundColor(Color(.colorWritten))
                                }
                                else {
                                    Text("Re open the app")
                                        .font(.custom("Atma", fixedSize: 25))
                                        .foregroundColor(Color(.colorWritten))
                                }
                                
                                Spacer()
                                
                                if !showTimer{
                                    Text("Do you agree?")
                                        .font(.custom("Atma-Bold", fixedSize: 30))
                                        .foregroundColor(Color(.colorWritten))
                                    
                                    HStack {
                                        
                                        Spacer()
                                        
                                        Button(action: {
                                            responses.append((name: currentTurnSafe() ?? "Unknown", answer: "Yes"))
                                            showTimer = true
                                        }) {
                                            Text("Yes")
                                                .font(.custom("Atma-Bold", fixedSize: 30))
                                                .padding()
                                                .frame(width: 150, height: 70)
                                                .background(Color(.colorWritten))
                                                .foregroundColor(.white)
                                                .cornerRadius(30)
                                        }
                                        Spacer()
                                        
                                        Button(action: {
                                            responses.append((name: currentTurnSafe() ?? "Unknown", answer: "No"))
                                            showTimer = true
                                        }) {
                                            Text("No")
                                                .font(.custom("Atma-Bold", fixedSize: 30))
                                                .padding()
                                                .frame(width: 150, height: 70)
                                                .background(Color(.colorWritten))
                                                .foregroundColor(.white)
                                                .cornerRadius(30)
                                        }

                                        Spacer()
                                        
                                    }
                                } //End IF
                                else{
                                    VStack{
                                        ZStack {
                                            // Rettangolo grigio di sfondo
                                            Rectangle()
                                                .fill(Color.gray.opacity(0.3))
                                                .frame(width: 320, height: 65)
                                                .cornerRadius(30)
                                            
                                            // Rettangolo blu che si svuota da destra a sinistra
                                            HStack(spacing: 0) {
                                                Rectangle()
                                                    .fill(Color(.colorWritten))
                                                    .frame(width: CGFloat(remainingTime) / CGFloat(turnDuration) * 320, height: 65) // La larghezza diminuisce nel tempo
                                                
                                                Spacer(minLength: 0)
                                            }
                                            .frame(width: 320, height: 65)
                                            .cornerRadius(30)
                                            .animation(.linear(duration: 1), value: remainingTime)
                                            
                                            Text(formatTime(remainingTime))
                                                .font(.largeTitle)
                                                .foregroundColor(.white)
                                                .bold()
                                        }
                                        .padding(.bottom,80)
                                        .frame(width: 250, height: 50)
                                        Spacer()
                                        
                                        Button(action: endTurn)
                                        {
                                            Text("Skip")
                                                .font(.custom("Atma-Bold", fixedSize: 30))
                                                .padding()
                                                .frame(width: 150, height: 70)
                                                .background(Color(.colorWritten))
                                                .foregroundColor(.white)
                                                .cornerRadius(30)
                                        }
                                        .padding(.horizontal)
                                        .fullScreenCover(isPresented: $showTransitionScreen){
                                            TransitionScreen(
                                                nextParticipant: participants[Int.random(in: 0..<participants.count)],
                                                onTap: {},
                                                backgroundColor: Color(.colorCulture)
                                            )
                                        }
                                    }
                                    .padding()
                                    .transition(.opacity)
                                    .onAppear {
                                        startTimer()
                                    }
                                    .onDisappear {
                                        stopTimer()
                                    }
                                }
                            }
                            .transition(.opacity)
                        }
                    }
                }
            }
            .onAppear {
                if turnOrder.isEmpty {
                    generateTurnOrder()
                }
            }
        }// End Nav Stack
    }

    struct AlienSpeakingView: View {

        var hasAnswered: Bool = false
        @State private var showFirstImage = true
        let timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
        
        var body: some View {
            Group {
                if hasAnswered {
                    Image("Alien_Timer")
                        .resizable()
                        .scaledToFill()
                } else {
                    if showFirstImage {
                        Image("Alien")
                            .resizable()
                            .scaledToFill()
                    } else {
                        Image("Alien_BA")
                            .resizable()
                            .scaledToFill()
                    }
                }
            }
            .onReceive(timer) { _ in
                if !hasAnswered {
                    showFirstImage.toggle()
                }
            }
        }
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
        if let path = Bundle.main.path(forResource: "TimerSound", ofType: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.play()
            } catch {
                print("Errore nel caricamento del suono: \(error.localizedDescription)")
            }
        }
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
            numRounds: .constant(1),
            turnDuration: .constant(5),
            onHome: {},
            selectedCountry: Country(name: "Italy", flagImage: "flags_italy")
        )
    }
}


