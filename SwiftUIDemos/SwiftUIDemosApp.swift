//
//  SwiftUIDemosApp.swift
//  SwiftUIDemos
//
//  Created by Alex Hay on 23/11/2020.
//

import SwiftUI

@main
struct SwiftUIDemosApp: App {
    var body: some Scene {
        WindowGroup {
			IndexView()
        }
    }
}

struct IndexView: View {
	
	var body: some View {
		NavigationView {
			List {
				NavigationLink(
					destination: TaggerView(),
					label: {
						Image(systemName: "tag")
						Text("Tagger")
					}
				)
				NavigationLink(
					destination: GroupedListView(),
					label: {
						Image(systemName: "rectangle.grid.1x2")
						Text("Grouped List")
					}
				)
				NavigationLink(
					destination: ToastExampleView(),
					label: {
						Image(systemName: "rectangle.bottomthird.inset.fill")
						Text("Toast")
					}
				)
			}
			.listStyle(InsetGroupedListStyle())
			.navigationBarTitle(Text("Example Views"))
		}
	}
}

struct IndexView_Previews: PreviewProvider {
	static var previews: some View {
		IndexView()
	}
}
