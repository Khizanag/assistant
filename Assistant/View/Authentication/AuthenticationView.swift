//
//  AuthenticationView.swift
//  Assistant
//
//  Created by Giga Khizanishvili on 14.04.25.
//

import SwiftUI
import LocalAuthentication
import AuthenticationServices // For Sign in with Apple

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isAuthenticatingWithFaceID = false
    @State private var faceIDError: String?
    @State private var showPinLogin = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                // MARK: - Username
                TextField("Username", text: $username)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.username)
                    .autocapitalization(.none)

                // MARK: - Password
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .textContentType(.password)

                // MARK: - Forgot Password
                Button("Forgot Password?") {
                    // Handle forgot password logic
                }
                .font(.footnote)
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .trailing)

                // MARK: - Login Button
                Button("Login") {
                    // Handle standard login
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.accentColor)
                .foregroundColor(.white)
                .cornerRadius(10)

                // MARK: - Alternative Logins
                VStack(spacing: 16) {
                    if LAContext().canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil) {
                        Button {
                            authenticateWithFaceID()
                        } label: {
                            Label("Login with Face ID", systemImage: "faceid")
                        }
                        .disabled(isAuthenticatingWithFaceID)
                    }

                    Button {
                        showPinLogin = true
                    } label: {
                        Label("Login with PIN", systemImage: "keypad")
                    }
                }

                // MARK: - Social Logins
                VStack(spacing: 12) {
                    SignInWithAppleButton(
                        .signIn,
                        onRequest: { request in
                            request.requestedScopes = [.fullName, .email]
                        },
                        onCompletion: { result in
                            // Handle Apple Sign In result
                        }
                    )
                    .signInWithAppleButtonStyle(.black)
                    .frame(height: 45)

                    Button(action: {
                        // Trigger Google Sign-In flow
                    }) {
                        HStack {
                            Image(systemName: "globe")
                            Text("Sign in with Google")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                        )
                    }
                }

                if let error = faceIDError {
                    Text(error)
                        .font(.footnote)
                        .foregroundColor(.red)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Login")
            .sheet(isPresented: $showPinLogin) {
//                PinLoginView()
                Text("Pin Login View")
            }
        }
    }

    private func authenticateWithFaceID() {
        isAuthenticatingWithFaceID = true
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Log in with Face ID") { success, authError in
                DispatchQueue.main.async {
                    isAuthenticatingWithFaceID = false
                    if success {
                        // Proceed with login
                    } else {
                        faceIDError = authError?.localizedDescription ?? "Face ID authentication failed"
                    }
                }
            }
        } else {
            isAuthenticatingWithFaceID = false
            faceIDError = error?.localizedDescription ?? "Face ID not available"
        }
    }
}
