import SwiftUI

struct TransitionScreen: View {
    
    var nextParticipant: String
    var onTap: () -> Void
    var backgroundColor: Color  // New parameter to receive the background color
    
    var body: some View {
        VStack {
            Text("Next turn: \(nextParticipant)")
                .font(.largeTitle)
                .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
                .bold()
                .padding()
            
            Text("Tap to Start the Turn")
                .font(.title2)
                .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
            
            Image(systemName: "hand.tap.fill")
                .font(.system(size: 40))
                .padding(.top, 10)
                .foregroundColor(Color(red: 0.176, green: 0.188, blue: 0.278))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(backgroundColor)
        .onTapGesture {
            onTap()
        }
    }
}

struct TransitionScreen_Previews: PreviewProvider {
    static var previews: some View {
        TransitionScreen(
            nextParticipant: "Alice",
            onTap: {},
            backgroundColor: Color(red: 0.176, green: 0.188, blue: 0.278)
        )
    }
}
