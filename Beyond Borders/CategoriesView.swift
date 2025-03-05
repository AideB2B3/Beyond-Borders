import SwiftUI

struct CategoriesView: View {
    @Binding var numParticipants: Int
    @Binding var participants: [String]
    @Binding var numRounds: Int
    @Binding var turnDuration: Int
    var onHome: () -> Void
    var totalRounds: Int
    var timerDuration: Int

    var body: some View {

        NavigationStack {
            ZStack {
                Color(red: 1.0, green: 0.945, blue: 0.816)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Choose The Category!")
                        .font(.largeTitle)
                        .bold()
                        .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                        .padding(.top, 50)
                    
                    Spacer()
                    
                    NavigationLink(destination: LanguageView()) {
                        Text("Language")
                            .font(.title2)
                            .bold()
                            .frame(width: 350, height: 60)
                            .background(Color(red: 0.364, green: 0.635, blue: 0.443))
                            .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .cornerRadius(50)
                    }
                    .padding()
                    
                    NavigationLink(destination: FoodView(numParticipants: $numParticipants, participants: $participants, numRounds: $numRounds, turnDuration: $turnDuration, totalRounds: totalRounds, timerDuration: timerDuration, onHome: onHome)) {
                        Text("Food")
                            .font(.title2)
                            .bold()
                            .frame(width: 350, height: 60)
                            .background(Color(red: 1, green: 0.647, blue: 0.274))
                            .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .cornerRadius(50)
                    }
                    .padding()
                    
                    NavigationLink(destination: FestivalsView()) {
                        Text("Festivals")
                            .font(.title2)
                            .bold()
                            .frame(width: 350, height: 60)
                            .background(Color(red: 0.286, green: 0.678, blue: 0.635))
                            .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .cornerRadius(50)
                    }
                    .padding()
                    
                    NavigationLink(destination: OffensiveView()) {
                        Text("Offensive Rumors")
                            .font(.title2)
                            .bold()
                            .frame(width: 350, height: 60)
                            .background(Color(red: 0.588, green: 0.447, blue: 0.584))
                            .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .cornerRadius(50)
                    }
                    .padding()
                    
                    Spacer()
                }
            }
        }
        .tint(Color(red: 0.176, green: 0.188, blue: 0.278)) //Per colorare tasto back
        .navigationBarBackButtonHidden(true) // leva il tasto back
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(
            numParticipants: .constant(3),
            participants: .constant(["Alice", "Bob", "Charlie"]),
            numRounds: .constant(3),
            turnDuration: .constant(60),
            onHome: {},
            totalRounds: 3, // Aggiunto
            timerDuration: 60// Aggiunto
            
        )
    }
}

