import SwiftUI
import AVFoundation
import AudioToolbox

struct OffensiveView: View {
    
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
    private var offensivequestions: [String] = []
    
    @State private var randomQuestion: String = ""
    @State private var showStart = true // Controlla la visibilità del pulsante Start
    @State private var showNo = false
    @State private var showYes = false
    @State private var showTimer = false
    
    private func getRandomQuestion() -> String {
        return offensivequestions.randomElement() ?? "No questions available"
    }
    
    init(numParticipants: Binding<Int>, participants: Binding<[String]>, numRounds: Binding<Int>, turnDuration: Binding<Int>,onHome: @escaping () -> Void,selectedCountry: Country) {
        self._numParticipants = numParticipants
        self._participants = participants
        self._numRounds = numRounds
        self._turnDuration = turnDuration
        self.onHome = onHome
        self.selectedCountry = selectedCountry  // 🔹 Ora viene inizializzato correttamente!
        
        self.offensivequestions = [
            "People in \(selectedCountry.name) are often stereotyped as being rude or unfriendly.",
            "It is commonly believed that people in \(selectedCountry.name) are overly nationalistic.",
            "There are rumours that people in \(selectedCountry.name) are always involved in corruption.",
            "Many outsiders think that the people in \(selectedCountry.name) are hostile towards foreigners.",
            "People in \(selectedCountry.name) are often accused of being intolerant of other cultures.",
            "Some say that the people in \(selectedCountry.name) are untrustworthy in business dealings.",
            "People in \(selectedCountry.name) are often wrongly believed to be unfriendly to outsiders.",
            "There are common misconceptions that people in \(selectedCountry.name) have a bad sense of humor.",
            "People in \(selectedCountry.name) are often thought to be lazy or unwilling to work hard.",
            "Many people believe that the people in \(selectedCountry.name) are overly conservative.",
            "Outsiders often think that people in \(selectedCountry.name) are too materialistic.",
            "There are rumours that people in \(selectedCountry.name) are extremely closed-minded.",
            "It is often said that people in \(selectedCountry.name) are obsessed with social status and wealth.",
            "People in \(selectedCountry.name) are sometimes unfairly labelled as being violent or aggressive.",
            "There is a belief that people in \(selectedCountry.name) are intolerant towards immigrants.",
            "Some people think that people in \(selectedCountry.name) are excessively traditional.",
            "People in \(selectedCountry.name) are often said to be resistant to change or progress.",
            "People from \(selectedCountry.name) are sometimes unfairly seen as unsophisticated or unrefined.",
            "There are rumours that people in \(selectedCountry.name) are always suspicious of outsiders.",
            "People in \(selectedCountry.name) are often portrayed as being obsessed with rules and regulations."
        ]

        // Inizializzazione delle variabili di stato
        _remainingTime = State(initialValue: turnDuration.wrappedValue)
        _randomQuestion = State(initialValue: offensivequestions.randomElement() ?? "No questions available")
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.588, green: 0.447, blue: 0.584)
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
                            backgroundColor: Color(red: 0.588, green: 0.447, blue: 0.584)  // Culture View's background color
                        )
                    }
                } else {
                    
                    VStack {
                        Text("Offensive / \(selectedCountry.name)")
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
                                                backgroundColor: Color(red: 0.588, green: 0.447, blue: 0.584)  // Culture View's background color
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

struct OffensiveView_Previews: PreviewProvider {
    static var previews: some View {
        OffensiveView(
            numParticipants: .constant(3),
            participants: .constant(["Alice", "Bob", "Charlie"]),
            numRounds: .constant(3),
            turnDuration: .constant(60),
            onHome: {},
            selectedCountry: Country(name: "Italy", flagImage: "flags_italy")
        )
    }
}


