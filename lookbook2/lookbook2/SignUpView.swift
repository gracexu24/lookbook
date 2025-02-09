import SwiftUI

struct SignUpView: View {
    @State private var name: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var cpassword: String = ""
    @State var isLinkActive = false

    var body: some View {
        NavigationView {
            ZStack(alignment: .topLeading) {
                VStack {
                    VStack(spacing: 40) {
                        ZStack {
                            Text("Create \nAccount")
                                .foregroundColor(.black)
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20)
                                .padding(.top, 100)
                        }

                        VStack(spacing: 20) {
                            VStack(spacing: 20) {
                                CustomTextField(
                                    placeHolder: "Name",
                                    imageName: "envelope",
                                    tOpacity: 1.0,
                                    bColor: "textColor2",
                                    value: $name
                                )
                                CustomTextField(
                                    placeHolder: "Email",
                                    imageName: "lock",
                                    tOpacity: 1.0,
                                    bColor: "textColor2",
                                    value: $email
                                )
                                CustomTextField(
                                    placeHolder: "Password",
                                    imageName: "envelope",
                                    tOpacity: 1.0,
                                    bColor: "textColor2",
                                    value: $password
                                )
                                CustomTextField(
                                    placeHolder: "Confirm Password",
                                    imageName: "lock",
                                    tOpacity: 1.0,
                                    bColor: "textColor2",
                                    value: $cpassword
                                )
                            }

                            VStack(alignment: .trailing) {
                                Button(
                                    action: {},
                                    label: {
                                        CustomButton(title: "SIGN UP", bColor: "color2")
                                    }
                                )
                            }
                            .padding(.horizontal, 20)
                        }
                    }

                    Spacer()

                    HStack {
                        Text("Already have an account?")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .font(.system(size: 18))

                        NavigationLink(destination: LoginView(), isActive: $isLinkActive) {
                            Text("SIGN IN")
                                .font(.system(size: 18))
                                .foregroundColor(Color("color1"))
                                .fontWeight(.bold)
                        }
                    }
                    .frame(height: 63)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(Color("color2"))
                    .ignoresSafeArea()
                }
                
                TopBarView()
            }
            .edgesIgnoringSafeArea(.bottom)
            .navigationBarHidden(true) // ✅ Now inside NavigationView
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
