import SwiftUI

struct Home: View {
    @State var selectedTab = "house"
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("TabBG")
                    .ignoresSafeArea()
                
                VStack {
                    switch selectedTab {
                    case "house":
                        ContentView()
                    case "plus.circle":
                        CreateNewPost()
                    case "magnifyingglass.circle"
                        Search()
                    default:
                        Text("Page Not Found")
                    }
                }
                
                // Custom Tab Bar
                VStack {
                    Spacer()
                    CustomTabBar(selectedTab: $selectedTab)
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
