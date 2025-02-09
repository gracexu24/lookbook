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
                            Text("Welcome \nBack")
                                .foregroundColor("black")
                                .font(.system(size: 35))
                                .fontWeight(.bold)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 20)
                        }
                        VStack(spacing: 30) {
                            VStack (spacing: 30) {
                                CustomTextField(
                                    placeHolder: "Email", imageName: "envelope",
                                    bColor: "textColor1",
                                    tOpacity:
                                        .6, value: $email)
                                CustomTextField(
                                    placeHolder: "Password", imageName: "lock",
                                    bColor: "textColor1",
                                    tOpacity:
                                        .6, value: $password)
                            }

                            VStack (alignment: .trailing) {
                                Text("Forgot Password")
                                    .fontWeight(.medium)
                                
                                NavigationLink(destination: SignUpView(), isLinkActive: $isLinkActive){
                                Button(action: {
                                    self.isLinkActive = true
                                }, label: {
                                    CustomButton(title:"SIGN IN", bgColor: "color1")
                                })

                                }
                            }.padding(.horizontal, 20)

            }
        }
        Spacer()

                            HStack{
                                Text("Don't have an account?")
                                    .fontWEight(.bold)
                                    .foregroundColor(.white)
                                    .font(.system(size:18))

                                Button(action: {}, lable : {
                                    Text("SIGN UP")
                                        .font(.system(size: 18))
                                        .foregroundColor(Color("color1"))
                                        .fontWeight(.bold)
                                })
                            }

                            .frame(height:63)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color("color2"))
                            .ignoreSafeArea()
                            
                        }
                        TopBarView()
                    }

                    .edgesIgnoringSafeArea(.bottom)
                }
                navigationBarHidden(true)
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
    }
}