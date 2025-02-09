import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State var isLinkActive = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                VStack {
                    VStack(spacing: 40) {
                        ZStack {
                            Text("Welcome \nBack to LookBook.")
                                .foregroundColor(.black)
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20)
                                .padding(.top, 150)
                        }
                        VStack(spacing: 30) {
                            VStack(spacing: 30) {
                                CustomTextField(
                                    placeHolder: "Email",
                                    imageName: "envelope",
                                    tOpacity: 0.6,
                                    bColor: "textColor1",
                                    value: $email
                                )

                                CustomTextField(
                                    placeHolder: "Password",
                                    imageName: "lock",
                                    tOpacity: 0.6,
                                    bColor: "textColor1",
                                    value: $password
                                )
                            }
                        }
                        VStack(alignment: .trailing) {
                            Text("Forgot Password")
                                .fontWeight(.medium)
                            
                            NavigationLink(destination: SignUpView(), isActive: $isLinkActive) {
                                CustomButton(title: "SIGN IN", bColor: "color1")
                            }
                        }
                        .padding(.horizontal, 20)
                    }

                    Spacer()

                    HStack {
                        Text("Don't have an account?")
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                            .font(.system(size: 18))

                        Button(action: {}, label: {
                            Text("SIGN UP")
                                .font(.system(size: 18))
                                .foregroundColor(Color("color1"))
                                .fontWeight(.bold)
                        })
                    }
                    .frame(height: 63)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color("color2"))
                    .ignoresSafeArea()
                } // ✅ Closing `VStack`

                TopBarView() // ✅ Placed inside `ZStack`, ensuring correct hierarchy
            } // ✅ Closing `ZStack`
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true) // ✅ Now properly inside `NavigationView`
        } // ✅ Closing `NavigationView`
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
