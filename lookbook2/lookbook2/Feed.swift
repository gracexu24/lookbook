import SwiftUI

// Model to match JSON response from API
struct Post: Codable, Identifiable {
    let id: Int
    let image: String
    let details: String
    let caption: String
    let username: String
}

// ViewModel to handle individual post state
class PostViewModel: ObservableObject, Identifiable {
    let post: Post
    @Published var isLiked = false
    @Published var isBookmarked = false
    @Published var isPopupVisible = false

    init(post: Post) {
        self.post = post
    }
}

struct Feed: View {
    @State private var posts: [PostViewModel] = []
    @State private var errorMessage = ""

    var body: some View {
        ScrollView {
            VStack {
                ProfileView()
                    .padding()
                Spacer()
                ForEach(posts) { postViewModel in
                    PostView(postViewModel: postViewModel)
                }
            }
        }
        .onAppear(perform: fetchPosts)
    }

    func fetchPosts() {
        guard let url = URL(string: "https://lookbook-iuwk.onrender.com/showPosts") else {
            errorMessage = "Invalid URL"
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
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
                    self.posts = decodedPosts.map { PostViewModel(post: $0) }
                }
            } catch {
                DispatchQueue.main.async {
                    errorMessage = "Error decoding data: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

struct PostView: View {
    @ObservedObject var postViewModel: PostViewModel

    var body: some View {
        ZStack {
            AsyncImage(url: URL(string: postViewModel.post.image)) { image in
                image.resizable()
            } placeholder: {
                ProgressView()
            }
            .aspectRatio(contentMode: .fill)
            .frame(width: 320, height: 340)
            .cornerRadius(22)
            .padding(.top, 100)
            .padding(.bottom, 150)
            VStack{
                                           
            }
           .padding(100)
           .frame(width:320, height: 150)
           .background(.ultraThinMaterial)
           .cornerRadius(22)
           .offset(x: 0, y: 180)
            VStack {
                Text("@\(postViewModel.post.username)")
                    .font(.system(size: 20))
                    .fontWeight(.bold)
                    .frame(width: 220, alignment: .leading)
                    .padding(.leading, 85)
                    .offset(x: -75, y: 150)

                Text(postViewModel.post.caption)
                    .font(.system(size: 10))
                    .frame(width: 220, alignment: .leading)
                    .lineLimit(nil)
                    .padding(.leading, 85)
                    .fontWeight(.bold)
                    .offset(x: -70, y: 155)
            }

            HStack {
                Spacer()
                Button(action: {
                    postViewModel.isLiked.toggle()
                }) {
                    Image(systemName: postViewModel.isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
                        .font(.system(size: 25))
                        .foregroundColor(.black)
                }

                Button(action: {
                    postViewModel.isBookmarked.toggle()
                }) {
                    Image(systemName: postViewModel.isBookmarked ? "bookmark.fill" : "bookmark")
                        .font(.system(size: 25))
                        .foregroundColor(.black)
                }

                Button(action: {
                    postViewModel.isPopupVisible.toggle()
                }) {
                    Image(systemName: "ellipsis.circle")
                        .font(.system(size: 25))
                        .foregroundColor(.black)
                }
            }
            .frame(maxWidth: .infinity, alignment: .trailing)
            .padding(.trailing, 60)
            .offset(x: 0, y: 220)
            .padding()

            if postViewModel.isPopupVisible {
                VStack {
                    Spacer()
                    VStack {
                        Button(postViewModel.post.details) {}
                            .padding()
                        Divider()
                        Button("X") {
                            postViewModel.isPopupVisible = false
                        }
                        .padding()
                    }
                    .frame(width: 250)
                    .background(Color.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
                    .padding()
                    Spacer()
                }
                .onTapGesture {
                    postViewModel.isPopupVisible = false
                }
            }
        }
    }
}

@ViewBuilder
func ProfileView() -> some View {
    HStack {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Button(action: {}) {
                    Image(systemName: "person")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                        .foregroundColor(.black)
                }
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

struct Feed_Previews: PreviewProvider {
    static var previews: some View {
        Feed()
    }
}
