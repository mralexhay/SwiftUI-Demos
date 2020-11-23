//
//  ErrorMessageView.swift
//  SwiftUIDemos
//
//  Created by Alex Hay on 23/11/2020.
//

import SwiftUI

/// A subview that displays a message when an error occurs
struct ErrorMessageView: View {
	
	@Binding var showingError: Bool
	@Binding var errorString: String
	
	var body: some View {
		HStack {
			Image(systemName: "exclamationmark.triangle.fill")
				.foregroundColor(.orange)
			Text(errorString)
				.foregroundColor(.secondary)
				.padding(.leading, -6)
		}
		.font(.caption)
		.opacity(showingError ? 1 : 0)
		.animation(.easeIn(duration: 0.3))
	}
}

struct ErrorMessageView_Previews: PreviewProvider {
    static var previews: some View {
		ErrorMessageView(showingError: .constant(true), errorString: .constant("Tag can't be a duplicate"))
    }
}
