//
//  SearchView.swift
//  SwiftUIDemos
//
//  Created by Alex Hay on 23/11/2020.
//

import SwiftUI

// MARK: SEARCH BAR
/// Search box for filtering the list
struct SearchBarView: View {
	
	@Binding var searchQuery: String
	
	var body: some View {
		
		HStack {
			Spacer()
			TextField("Search", text: $searchQuery)
			.modifier(ClearButtonModifier(text: $searchQuery))
			.textFieldStyle(RoundedBorderTextFieldStyle())
			.frame(minWidth: nil, idealWidth: nil, maxWidth: 240, minHeight: nil, idealHeight: nil, maxHeight: nil, alignment: .center)
			Spacer()
		}
	}
}

// MARK: CLEAR BUTTON
/// Adds a button next to the search field that clears the search query when pressed
public struct ClearButtonModifier: ViewModifier {

	@Binding var text: String
	
	public func body(content: Content) -> some View {
		HStack {
			content
			Image(systemName: "multiply.circle.fill")
				.foregroundColor(.secondary)
				.opacity(text == "" ? 0 : 0.5)
				.onTapGesture {
					text = ""
				}
				.animation(.easeInOut(duration: 0.2))
		}
	}
}

struct SearchBarView_Previews: PreviewProvider {
	static var previews: some View {
		SearchBarView(searchQuery: .constant("hello world"))
		SearchBarView(searchQuery: .constant(""))
	}
}
