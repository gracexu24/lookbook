import SwiftUI

struct CustomViews: View {
    var body: some View {
        Text("Hello, World!")
    }
}


struct CustomTextField: View {
    var placeHolder: String
    var imageName: String
    var tOpacity: Double
    var bColor: String
    @Binding var value: String

    var body: some View {
        HStack {
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .padding(.leading, 20)
                .foregroundColor(Color(bColor).opacity(tOpacity))

            if placeHolder == "Password" || placeHolder == "Confirm Password" {
                ZStack(alignment: .leading) {
                    if value.isEmpty {
                        Text(placeHolder)
                            .foregroundColor(Color(bColor).opacity(tOpacity))
                            .padding(.leading, 12)
                            .font(.system(size: 20))
                    }

                    SecureField("", text: $value)
                        .padding(.leading, 12)
                        .font(.system(size: 20))
                        .frame(height: 45)
                }
            }

            else {
                ZStack(alignment: .leading) {
                    if value.isEmpty {
                        Text(placeHolder)
                            .padding(.leading, 12)
                            .font(.system(size: 20))
                    }

                    TextField("", text: $value)
                        .padding(.leading, 12)
                        .font(.system(size: 20))
                        .frame(height: 45)
                        .foregroundColor(Color(bColor))
                }
            }
        }
        .overlay(
            Divider()
                .overlay(
                    Color(bColor).opacity(tOpacity)

                ).padding(.horizontal, 20),
            alignment: .bottom
        )
    }
}
struct CustomButton: View {
    var title: String
    var bColor: String
    var body: some View {
        Text(title)
            .fontWeight(.bold)
            .foregroundColor(.white)
            .frame(height: 58)
            .frame(minWidth: 0, maxWidth: .infinity)
            .background(Color(bColor))
            .cornerRadius(15)

    }
}
struct TopBarView: View {
    var body: some View {
        Button(
            action: {},
            label: {
                Image("back")
                    .resizable()
                    .frame(width: 17.5, height: 28.5)
                    .padding(.horizontal, 20)
            })
    }
}

struct CustomViews_Previews: PreviewProvider {
    static var previews: some View {
        CustomViews()
    }
}
