//
//  ToastExampleView.swift
//  SwiftUIDemos
//
//  Created by Alex Hay on 23/11/2020.
//

import SwiftUI

struct ToastExampleView: View {
	
	@State var textToCopy = "hello world"
	@State var showingToast = false
	
    var body: some View {
		VStack(alignment: .center) {
			TextField("Text To Copy", text: $textToCopy)
				.textFieldStyle(RoundedBorderTextFieldStyle())
			Button(action: {
				UIPasteboard.general.string = textToCopy
				showingToast = true
			}, label: {
				Text("Copy Text")
					.foregroundColor(.white)
					.padding(.horizontal)
					.padding(.vertical, 7)
					.background(Color.blue.cornerRadius(8))
					.padding()
			})
			Spacer()
		}
		.padding()
		.toast(isPresented: $showingToast) {
			HStack {
			  Image(systemName: "checkmark.circle")
				Text("Copied To Clipboard")
			}
		}
		.navigationBarTitle(Text("Toast"))
    }
}

struct ToastExampleView_Previews: PreviewProvider {
    static var previews: some View {
        ToastExampleView()
    }
}


