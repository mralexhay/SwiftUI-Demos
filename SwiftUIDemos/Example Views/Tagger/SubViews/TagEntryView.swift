//
//  TagEntryView.swift
//  SwiftUIDemos
//
//  Created by Alex Hay on 23/11/2020.
//

import SwiftUI

/// A subview that contains the text-entry field for entering new tags
struct TagEntryView: View {
	
	@Binding var newTag: String
	@Binding var tags: [String]
	@Binding var showingError: Bool
	@Binding var errorString: String
	
	var body: some View {
		HStack {
			TextField("Add Tags", text: $newTag, onCommit: {
				addTag(newTag)
			})
			.textFieldStyle(RoundedBorderTextFieldStyle())
			.autocapitalization(.none)
			Spacer()
			Image(systemName: "plus.circle")
				// Entry button is blue if the tag is a valid entry
				.foregroundColor((isTagValid(newTag) == .IsValid) ? .blue : .secondary)
				.onTapGesture {
					addTag(newTag)
				}
		}
		.onChange(of: newTag, perform: { value in
			if value.contains(",") {
				newTag = value.replacingOccurrences(of: ",", with: "")
				if value != "," { // Don't enter a tag if the user just types ","
					// Try to add the tag if user types a comma
					addTag(newTag)
				}
			}
		})
	}
	
	/// Checks if the entered text is valid as a tag
	private func isTagValid(_ tag: String) -> ErrorCode {
		// Invalid tags:
		// - empty strings
		// - tags already in the tag array
		let lowerTag = tag.lowercased()
		if lowerTag == "" {
			return .Empty
		} else if tags.contains(lowerTag) {
			return .Duplicate
		} else {
			return .IsValid
		}
	}
	
	/// If the tag is valid, it is added to an array, otherwise the error message is shown
	private func addTag(_ tag: String) {
		let code = isTagValid(tag)
		switch code {
			case .Duplicate, .Empty:
				showError(code)
			case .IsValid:
				tags.append(newTag.lowercased())
				newTag = ""
		}
	}
	
	/// Shows error text above the tag entry field
	private func showError(_ code: ErrorCode) {
		errorString = code.rawValue
		showingError = true
	}
	
	enum ErrorCode: String {
		case Empty = "Tag can't be empty"
		case Duplicate = "Tag can't be a duplicate"
		case IsValid = ""
	}
}

struct TagEntryView_Previews: PreviewProvider {
    static var previews: some View {
		VStack {
			TagEntryView(newTag: .constant(""), tags: .constant(["tag one", "tag two"]), showingError: .constant(false), errorString: .constant("Tag can't be a duplicate"))
				.padding()
			TagEntryView(newTag: .constant("hello world"), tags: .constant(["tag one", "tag two"]), showingError: .constant(true), errorString: .constant("Tag can't be a duplicate"))
				.padding()
		}
    }
}
