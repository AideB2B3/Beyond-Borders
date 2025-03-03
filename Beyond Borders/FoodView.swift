import SwiftUI

struct FoodView: View {
    @Binding var numParticipants: Int
    @Binding var participants: [String]
    @Binding var numRounds: Int
    @Binding var turnDuration: Int
    var onHome: () -> Void
    var body: some View {
        NavigationStack{
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
                        Text("Is chinese food considered spicy?")
                            .font(.system(size: 25, weight: .bold))
                            .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                            .frame(width: 320)
                            .multilineTextAlignment(.center)
                            .padding()
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
            } // end ZStack
    //        .navigationBarBackButtonHidden(true)
        }

    }//end Body
    
}//end struct

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
