//
//  ToastOverlayView.swift
//  SwiftUIDemos
//
//  Created by Alex Hay on 24/11/2020.
//
// Adapted from this StackOverflow answer: https://stackoverflow.com/a/56550601/11685049

import SwiftUI

/// A convenience method on View for presenting a toast
extension View {
	func toast<Content>(isPresented: Binding<Bool>, content: @escaping () -> Content) -> some View where Content: View {
		Toast(isPresented: isPresented, presenter: { self }, content: content)
	}
}

struct Toast<Presenting, Content>: View where Presenting: View, Content: View {
	
	@Binding var isPresented: Bool
	let presenter: () -> Presenting // The view that will be "presenting" this toast
	let content: () -> Content // The toast overlay view
	let delay: TimeInterval = 1.5 // How long the toast will display before disappearing

	var body: some View {
		if isPresented {
			DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
				withAnimation {
					isPresented = false
				}
			}
		}

		return GeometryReader { geometry in
			ZStack(alignment: .bottom) {
				presenter()
				ZStack {
					RoundedRectangle(cornerRadius: 15)
						.foregroundColor(Color(UIColor.tertiarySystemBackground))
						.shadow(radius: 7)
					content()
				}
				.frame(width: geometry.size.width / 1.5, height: geometry.size.height / 13)
				.opacity(isPresented ? 1 : 0)
			}
		}
	}
}
