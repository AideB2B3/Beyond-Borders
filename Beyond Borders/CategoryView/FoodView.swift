import SwiftUI
import AVFoundation
import AudioToolbox

struct FoodView: View {
    
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
    
    @State private var showEndScreen = false
    @State private var showTransitionScreen = false
    
    @State private var extraRound = false
    @State private var turnOrder: [[String]] = []
    
    @State private var selectedCountry: Country
    
    private var foodquestions: [String] = []
    
    @State private var responses: [(name: String, answer: String)] = []
    
    @State private var randomQuestion: String = ""
    
    @State private var showStart = true
    @State private var showNo = false
    @State private var showYes = false
    @State private var showTimer = false
    
    private func getRandomQuestion() -> String {
        return foodquestions.randomElement() ?? "No questions available"
    }
    
    init(numParticipants: Binding<Int>, participants: Binding<[String]>, numRounds: Binding<Int>, turnDuration: Binding<Int>,onHome: @escaping () -> Void,selectedCountry: Country,
         responses: [(name: String, answer: String)] = []) {
        self._numParticipants = numParticipants
        self._participants = participants
        self._numRounds = numRounds
        self._turnDuration = turnDuration
        self.onHome = onHome
        self.selectedCountry = selectedCountry
        self.responses = responses
        
        self.foodquestions = [
            "Food in \(selectedCountry.name) is known for being very spicy.",
            "Rice and bread are staple foods in \(selectedCountry.name).",
            "Street food is a significant part of the food culture in \(selectedCountry.name).",
            "Meat is commonly used in traditional dishes in \(selectedCountry.name).",
            "Vegetarian or vegan diets are widely accepted in \(selectedCountry.name).",
            "There is one dish considered to be the national food in \(selectedCountry.name).",
            "Seafood is a significant part of the cuisine in \(selectedCountry.name).",
            "Breakfast is considered the most important meal of the day in \(selectedCountry.name).",
            "Meals in \(selectedCountry.name) are often served with a variety of sauces or dips.",
            "Fast food culture is very popular in \(selectedCountry.name).",
            "People in \(selectedCountry.name) often eat together as a family or community.",
            "Large feast or celebration meals are a common tradition in \(selectedCountry.name).",
            "Food in \(selectedCountry.name) is typically served in large portions.",
            "Desserts and sweet treats are unique to the cuisine of \(selectedCountry.name).",
            "Herbs and spices are frequently used to enhance food in \(selectedCountry.name).",
            "Local food in \(selectedCountry.name) is often prepared with fresh, locally-sourced ingredients.",
            "Food in \(selectedCountry.name) is often cooked or served in a way that emphasizes grilling or roasting.",
            "A particular type of fruit or vegetable is widely grown and consumed in \(selectedCountry.name).",
            "The food culture in \(selectedCountry.name) has been influenced by other countries or regions.",
            "Meals in \(selectedCountry.name) are often accompanied by alcoholic beverages like wine or beer."
        ]
        
        _remainingTime = State(initialValue: turnDuration.wrappedValue)
        _randomQuestion = State(initialValue: foodquestions.randomElement() ?? "No questions available")
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.colorFood)
                    .ignoresSafeArea()
                
                if showEndScreen {
                    EndScreen(onRestart: restartGame, onHome: handleHome, numParticipants: $numParticipants,
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
                            backgroundColor: Color(.colorFood)
                        )
                    }
                } else {
                    
                    VStack {
                        Text("Food - \(selectedCountry.name)")
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
                                            Rectangle()
                                                .fill(Color.gray.opacity(0.3))
                                                .frame(width: 320, height: 65)
                                                .cornerRadius(30)
                                            
                                            HStack(spacing: 0) {
                                                Rectangle()
                                                    .fill(Color(.colorWritten))
                                                    .frame(width: CGFloat(remainingTime) / CGFloat(turnDuration) * 320, height: 65)
                                                
                                                Spacer(minLength: 0)
                                            }
                                            .frame(width: 320, height: 65)
                                            .cornerRadius(30)
                                            .animation(.linear(duration: 1), value: remainingTime)
                                            
                                            Text(formatTime(remainingTime))
                                                .font(.custom("Atma", fixedSize: 25))
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
                                                backgroundColor: Color(.colorFood)
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

                    Image("Beybo")
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

struct FoodView_Previews: PreviewProvider {
    static var previews: some View {
        FoodView(
            numParticipants: .constant(3),
            participants: .constant(["Alice", "Bob", "Charlie"]),
            numRounds: .constant(1),
            turnDuration: .constant(60),
            onHome: {},
            selectedCountry: Country(name: "Italy", flagImage: "flags_italy")
        )
    }
}
