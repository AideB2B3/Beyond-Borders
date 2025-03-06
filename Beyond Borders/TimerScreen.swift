import SwiftUI
import AVFoundation
import AudioToolbox

struct TimerScreen: View {
    
    @Binding var participants: [String]
    var totalRounds: Int
    var timerDuration: Int
    var onHome: () -> Void
    
    @State private var remainingTime: Int
    @State private var currentTurn: Int = 0
    @State private var completedRounds: Int = 0
    @State private var timer: Timer?
    @State private var showEndScreen = false
    @State private var showTransitionScreen = false
    @State private var extraRound = false
    @State private var turnOrder: [[String]] = []
    
    init(participants: Binding<[String]>,
         totalRounds: Int,
         timerDuration: Int,
         onHome: @escaping () -> Void) {
        self._participants = participants
        self.totalRounds = totalRounds
        self.timerDuration = timerDuration
        self.onHome = onHome
        self._remainingTime = State(initialValue: timerDuration)
    }
    
    var currentRound: Int {
        completedRounds + (currentTurn / participants.count) + 1
    }
    
    
    var body: some View {
        ZStack {
            Color(red: 1.0, green: 0.647, blue: 0.274)
                .edgesIgnoringSafeArea(.all)
            
            if showEndScreen {
                EndScreen(onRestart: restartGame, onHome: handleHome)
            } else if showTransitionScreen {
                if let currentParticipant = currentTurnSafe() {
                    TransitionScreen(nextParticipant: currentParticipant) {
                        startTimer()
                        showTransitionScreen = false
                    }
                }
            } else {
                VStack() {
                    
                    //                    Spacer()
                    
                    Text("Food / China")
                        .font(.largeTitle)
                        .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                        .bold()
                        .padding(.top, 40)
                    ZStack {
                        Rectangle()
                            .fill(Color(red: 1.0, green: 0.945, blue: 0.816)) // Interno color fff1d0
                            .frame(width: 350, height: 200)
                            .cornerRadius(20)
                            .overlay(
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(red: 0.176, green: 0.188, blue: 0.278), lineWidth: 4) // Bordo color 2d3047
                            )
                        Text("currentQuestion")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .frame(width: 320)
                            .multilineTextAlignment(.center)
                            .padding()
                        
                    }
                    Spacer()
                    if let currentParticipant = currentTurnSafe() {
                        Text("\(currentParticipant)")
                            .font(.largeTitle)
                            .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .bold()
                        
//                        Text("Round \(currentRound)")
//                            .font(.title3)
//                            .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
//                            .bold()
                    } else {
                        ProgressView()
                    }
                    
                    Spacer()
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
                                .frame(width: CGFloat(remainingTime) / CGFloat(timerDuration) * 320, height: 70) // La larghezza diminuisce nel tempo
                            
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
                    .frame(width: 250, height: 50)
                    Spacer()
                    
                    Button(action: endTurn) {
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
                   
                }
                .padding(.bottom, 40)
            }
        }
        .onAppear {
            if turnOrder.isEmpty {
                generateTurnOrder()
            }
            startTimer()
        }
        .onDisappear {
            stopTimer()
        }
    }
    
    func handleHome() {
        stopTimer()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            onHome()
        }
    }
    
    func stopTimer() {
        if let timer = timer {
            timer.invalidate()
            self.timer = nil
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
    
    func startTimer() {
        timer?.invalidate()
        remainingTime = timerDuration
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
        
        if currentTurn + 1 < (extraRound ? participants.count : totalRounds * participants.count) {
            currentTurn += 1
            showTransitionScreen = true
        } else {
            showEndScreen = true
        }
        
    }
    
    func playSound() {
        AudioServicesPlaySystemSound(1005)
    }
    
    func restartGame() {
        if extraRound {
            completedRounds += 1
        }else{
            completedRounds = totalRounds
            extraRound = true
        }
        currentTurn = 0
        showEndScreen = false
        showTransitionScreen = false
        extraRound = true
        generateTurnOrder()
        startTimer()
    }
    
    func generateTurnOrder() {
        turnOrder = []
        var lastParticipant = ""
        
        for _ in 0..<(extraRound ? 1 : totalRounds) {
            var order: [String]
            
            repeat {
                order = participants.shuffled()
            } while !turnOrder.isEmpty && order.first == lastParticipant
            
            lastParticipant = order.last ?? ""
            turnOrder.append(order)
        }
    }
    
    func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let secs = seconds % 60
        return String(format: "%d:%02d", minutes, secs)
    }
    
}

struct TimerScreen_Previews: PreviewProvider {
    static var previews: some View {
        TimerScreen(
            participants: .constant(["Alice", "Bob", "Charlie"]),
            totalRounds: 3,
            timerDuration: 10,
            onHome: {}
        )
    }
}
