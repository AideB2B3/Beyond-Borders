import SwiftUI

struct InfoView: View {
    var body: some View {
        ZStack{
            Color(.beigeBack)
                .ignoresSafeArea()
            
            Image("Info")
                .resizable()
                .ignoresSafeArea()
        }
    }
}

#Preview {
    InfoView()
}
