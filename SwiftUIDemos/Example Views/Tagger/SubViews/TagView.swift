//
//  TagView.swift
//  SwiftUIDemos
//
//  Created by Alex Hay on 23/11/2020.
//

import SwiftUI

/// A subview of a tag shown in a list. When tapped the tag will be removed from the array
struct TagView: View {
	
	var tag: String
	@Binding var tags: [String]
	
	var body: some View {
		HStack {
			Text(tag.lowercased())
				.padding(.leading, 2)
			Image(systemName: "xmark.circle.fill")
				.opacity(0.4)
				.padding(.leading, -6)
		}
		.foregroundColor(.white)
		.font(.caption2)
		.padding(4)
		.background(Color.blue.cornerRadius(5))
		.padding(4)
		.onTapGesture {
			tags = tags.filter({ $0 != tag })
		}
	}
}

struct TagView_Previews: PreviewProvider {
    static var previews: some View {
		TagView(tag: "hello world", tags: .constant(["tag one", "tag two"]))
    }
}
