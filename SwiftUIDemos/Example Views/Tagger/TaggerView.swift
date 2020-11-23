//
//  TaggerView.swift
//
//  Created by Alex Hay on 21/11/2020.
//
// Simple interface for adding tags to an array in SwiftUI
// Example video: https://imgur.com/gallery/CcA1IXp
// alignmentGuide code from Asperi @ https://stackoverflow.com/a/58876712/11685049

import SwiftUI

/// The main  view to add tags to an array
struct TaggerView: View {
	
	@State var newTag = ""
	@State var tags = ["example","hello world"]
	@State var showingError = false
	@State var errorString = "x" // Can't start with empty string or view will pop as size changes
	
	var body: some View {
		VStack(alignment: .leading) {
			ErrorMessageView(showingError: $showingError, errorString: $errorString)
			TagEntryView(newTag: $newTag, tags: $tags, showingError: $showingError, errorString: $errorString)
			TagListView(tags: $tags)
		}
		.padding()
		.onChange(of: showingError, perform: { value in
			if value {
				// Hide the error message after a delay
				DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
					showingError = false
				}
			}
		})
		.navigationBarTitle(Text("Tagger"))
	}
}

struct TaggerView_Previews: PreviewProvider {
	static var previews: some View {
		TaggerView()
	}
}
