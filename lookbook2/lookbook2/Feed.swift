import SwiftUI

// Model to match JSON response from API
struct Post: Codable, Identifiable {
    let id: Int
    let image: String
    let details: String
    let caption: String
    let username: String
}

struct Feed: View {
    @State private var isLiked = false
    @State private var isBookmarked = false
    
    // Store fetched posts
    @State private var posts: [Post] = []
    @State private var errorMessage = ""

    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    ProfileView()
                        .padding()
                    Spacer()
                    ForEach(posts) { post in
                        ZStack {
                            // Load image dynamically
                            AsyncImage(url: URL(string: post.image)) {image in
                                image.resizable()
                            } placeholder: {
                                ProgressView()
                            }
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 320, height: 340)
                            .cornerRadius(22)
                            .padding(.vertical, 50)
                            
                            // Overlay for text and details
                            VStack(alignment: .leading) {
                                Text("@user\(post.username)")
                                    .font(.system(size: 20, weight: .bold))
                                    .offset(x:-75, y:0)
                                Text(post.caption)
                                    .font(.system(size: 14))
                                    .offset(x:-75, y:0)
                                    .foregroundColor(.gray)
                                Text(post.details)
                                    .font(.system(size: 14))
                                    .foregroundColor(.black)
                                    .offset(x:-75, y:0)
                            }
                            HStack {
                               Spacer()
                               Button(action: {
                                  isLiked.toggle()
                            }) {
                               Image(systemName: isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                                      .font(.system(size: 25))
                                      .foregroundColor(.black)
                                                            }
                                                            
                                Button(action: {
                                    isBookmarked.toggle()
                                }) {
                                Image(systemName: isBookmarked ? "bookmark.fill" : "bookmark")
                                     .font(.system(size: 25))
                                     .foregroundColor(.black)
                                                            }
                                                            
                               Button(action: {
                                  }) {
                               Image(systemName: "ellipsis.circle")
                                 .font(.system(size: 25))
                                .foregroundColor(.black)
                               }
                             }
                             .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing, 60)
                             .offset(x: 0, y: 250)
                            .padding()
                            .background(.ultraThinMaterial)
                        }
                    }
                }
            }
            .onAppear(perform: fetchPosts)
    }
}

@ViewBuilder
func ProfileView()->some View{
    HStack {
        VStack(alignment: .leading, spacing: 4){
            HStack{
                Button(action: {
                    
                }, label: {
                    Image(systemName: "person")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.black)
                })
                Text("Vivian")
                    .font(.system(size: 30))
                    .fontWeight(.bold)
            }
        }
        VStack {
            Text("@viviaknee")
                .font(.system(size: 15))
                .fontWeight(.light)
                .foregroundColor(.gray)
                .offset(x: -75, y: 33)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        Image(systemName: "bell.badge.circle.fill")
            .font(.system(size: 33))
            .foregroundColor(.black.opacity(0.7))
    }
}


func fetchPosts() {
    guard let url = URL(string: "https://lookbook-iuwk.onrender.com/showPosts") else {
            errorMessage = "Invalid URL"
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
    if let error = error {
        DispatchQueue.main.async {
            errorMessage = "Error: \(error.localizedDescription)"
        }
        return
    }

    guard let data = data else {
        DispatchQueue.main.async {
            errorMessage = "No data received"
        }
        return
    }

    do {
        let decodedPosts = try JSONDecoder().decode([Post].self, from: data)
        DispatchQueue.main.async {
            self.posts = decodedPosts
        }
    } catch {
    DispatchQueue.main.async {
        errorMessage = "Error decoding data: \(error.localizedDescription)"
    }
}
}.resume()
    }
}


struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed()
    }
}
