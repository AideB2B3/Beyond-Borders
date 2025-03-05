import SwiftUI

struct FoodView: View {
    @Binding var numParticipants: Int
    @Binding var participants: [String]
    @Binding var numRounds: Int
    @Binding var turnDuration: Int
    var onHome: () -> Void
    
    let foodquestions: [String] = ["A","B","C","D","E","F","G","H","I","L","M","N","O","P","Q","R","S","T","U","V"]
    
    // State variable to store the random question
    @State private var randomQuestion: String = ""
    
    // Function to get a random question
    private func getRandomQuestion() -> String {
        return foodquestions.randomElement() ?? "No questions available"
    }
    
     //Initialize the random question when the view appears
    init(numParticipants: Binding<Int>, participants: Binding<[String]>, numRounds: Binding<Int>, turnDuration: Binding<Int>, onHome: @escaping () -> Void) {
        self._numParticipants = numParticipants
        self._participants = participants
        self._numRounds = numRounds
        self._turnDuration = turnDuration
        self.onHome = onHome
        
        // Initialize with a random question
        let initialQuestion = foodquestions.randomElement() ?? "No questions available"
        self._randomQuestion = State(initialValue: initialQuestion)
        
    }

    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 1.0, green: 0.647, blue: 0.274)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Food / China")
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
                    
                    Text("Nome partecipante")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                    Text("E' vero o non è vero?")
                        .font(.title)
                        .bold()
                        .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))

                    
                    Spacer()
                    
                    HStack {
                        
                        Spacer()
                        
                        Button("V"){
                            
                        }
                        .font(.title3)
                        .padding(30)
                        .bold()
                        .frame(maxWidth: 80)
                        .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                        .foregroundColor(.white)
                        .cornerRadius(50)
                        
                        Spacer()
                        
                        Button("X"){
                            
                        }
                        .font(.title3)
                        .padding(30)
                        .bold()
                        .frame(maxWidth: 80)
                        .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                        .foregroundColor(.white)
                        .cornerRadius(50)
                        
                        Spacer()
                        
                    }
                    
                    
                    
                    
                    Spacer()
                    NavigationLink(destination: TimerScreen(participants: $participants, totalRounds: numRounds, timerDuration: turnDuration, onHome: onHome)) {
                        Text("Start")
                            .font(.title3)
                            .padding()
                            .bold()
                            .frame(maxWidth: 150)
                            .background(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .foregroundColor(.white)
                            .cornerRadius(30)
                    }
                    .padding()
                }
                .padding(.bottom, 35)
            }
            .navigationBarBackButtonHidden(true) // leva il tasto back
        }
    }
}

struct FoodView_Previews: PreviewProvider {
    static var previews: some View {
        FoodView(
            numParticipants: .constant(3),
            participants: .constant(["Alice", "Bob", "Charlie"]),
            numRounds: .constant(3),
            turnDuration: .constant(60),
            onHome: {}
        )
    }
}

