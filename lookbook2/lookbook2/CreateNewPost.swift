import SwiftUI

struct CreateNewPost: View {
    @State private var caption: String = ""
    @State private var details: String = ""
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker: Bool = false
    @State private var tags: [String] = []

    var body: some View {
        VStack {
            HStack {
                Button("Cancel") {
                    // Handle cancel action
                }
                Spacer()
                Button("Post") {
                    // Handle post action
                }
                .disabled(selectedImage == nil)
            }
            .padding()

            Button(action: {
                showImagePicker = true
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                        .frame(height: 200)
                        .padding()

                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                            .cornerRadius(10)
                            .padding()
                    } else {
                        Text("Tap to add an image")
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()

            TextField("Add a caption...", text: $caption)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            // Add Tags Button
            Button("Add Tag") {
                let newTags = processLinks(details: details)
                tags.append(contentsOf: newTags)
                details = ""  // Optionally clear the details field after processing
            }
            .padding()

            // Tags view - showing tags as individual text blobs below the image box
            VStack(alignment: .leading) {
                ForEach(tags, id: \.self) { tag in
                    Text(tag)
                        .padding(8)
                        .background(Color.blue.opacity(0.2))
                        .cornerRadius(12)
                        .foregroundColor(.blue)
                        .font(.body)
                        .padding(.bottom, 4) // Space between the tags
                }
            }
            .padding([.leading, .trailing])

            // TextEditor for details input (acts as a container for tags)
            TextEditor(text: $details)
                .frame(height: 50)
                .border(Color.gray, width: 1)
                .padding()

            Spacer()
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $selectedImage)
        }
        .padding()
    }

    func processLinks(details: String) -> [String] {
        // Simple regex to find links in the text
        let regex = try! NSRegularExpression(pattern: "(https?://[a-zA-Z0-9./?=_-]+)", options: [])
        let nsString = details as NSString
        let results = regex.matches(in: details, options: [], range: NSRange(location: 0, length: nsString.length))

        // Extract the links as an array
        var tags: [String] = []
        for result in results {
            let link = nsString.substring(with: result.range)
            tags.append(link)
        }

        return tags
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.image = selectedImage
            }
            picker.dismiss(animated: true)
        }
    }
}

struct CreateNewPost_Previews: PreviewProvider {
    static var previews: some View {
        CreateNewPost()
    }
}
