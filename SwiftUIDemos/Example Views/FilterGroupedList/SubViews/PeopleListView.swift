//
//  PeopleListView.swift
//  SwiftUIDemos
//
//  Created by Alex Hay on 23/11/2020.
//

import SwiftUI

// MARK: PEOPLE LIST
struct PeopleListView: View {
	
	var people: [Person]
	var showDepartmentName: Bool
	
	var body: some View {
		ForEach(people, id: \.id) { person in
			Label(
				title: {
					VStack(alignment: .leading) {
						Text(person.name)
						if showDepartmentName {
							Text(person.department.rawValue)
								.foregroundColor(.secondary)
								.font(.caption)
						}
					}
				},
				icon: {
					Image(systemName: getIconName(forDepartment: person.department))
					.foregroundColor(.primary)
				}
			)
			.padding(.vertical, 6)
		}
	}
	
	// Retrieves a different SFSymbol name for each department
	func getIconName(forDepartment department: Departments) -> String {
		switch department {
			case .design:
				return "paintbrush.pointed"
			case .development:
				return "curlybraces.square"
			case .marketing:
				return "bubble.left"
			case .sales:
				return "dollarsign.circle"
		}
	}
}

struct PeopleListView_Previews: PreviewProvider {
    static var previews: some View {
		List {
			PeopleListView(people: DummyData.shared.people, showDepartmentName: true)
		}
		.listStyle(InsetGroupedListStyle())
		List {
			PeopleListView(people: DummyData.shared.people, showDepartmentName: false)
		}
		.listStyle(InsetGroupedListStyle())
    }
}
