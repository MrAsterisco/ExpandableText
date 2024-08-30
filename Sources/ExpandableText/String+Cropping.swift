//
//  Created by Alessio Moiso on 30/08/24.
//

import Foundation

public extension String {
	func cropping(at limit: Int) -> String {
		if count <= limit {
			return self
		} else {
			let index = index(startIndex, offsetBy: 310)
			var result = ""
			if let spaceIndex = self[..<index].lastIndex(of: " ") {
				result = String(self[..<spaceIndex])
			} else {
				result = String(self[..<index])
			}
			
			return "\(result)…"
		}
	}
}
