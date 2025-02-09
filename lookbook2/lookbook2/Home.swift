import SwiftUI
import UIKit

struct Home: View {
    @State var selectedTab = "house"
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                VStack {
                    switch selectedTab {
                    case "house":
                        Feed()
                    case "plus.circle":
                        CreateNewPost()
                    case "magnifyingglass.circle":
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
