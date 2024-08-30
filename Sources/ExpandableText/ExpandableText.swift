//
//  Created by Alessio Moiso on 30/08/24.
//

import SwiftUI

public extension String {
	static let defaultCharactersLimit = 310
}

public struct ExpandableText<Content: View, ReadMoreButton: View>: View {
	@State private var isCropped = true
	@State private var visibleContent = ""
	
	let content: String
	let charactersLimit: Int
	
	@ViewBuilder let contentView: (String) -> Content
	@ViewBuilder let readMoreView: (@escaping () -> ()) -> ReadMoreButton
	
	public init(
		content: String,
		charactersLimit: Int = String.defaultCharactersLimit,
		@ViewBuilder contentView: @escaping (String) -> Content,
		@ViewBuilder readMoreView: @escaping (@escaping () -> ()) -> ReadMoreButton
	) {
		self.content = content
		self.charactersLimit = charactersLimit
		self.contentView = contentView
		self.readMoreView = readMoreView
	}
	
	public var body: some View {
		VStack(alignment: .leading, spacing: 8) {
			contentView(visibleContent)
				.onAppear {
					visibleContent = isCropped ? content.cropping(at: charactersLimit) : content
				}
			
			if needsCropping && isCropped {
				readMoreView() {
					withAnimation {
						visibleContent = content
						isCropped = false
					}
				}
			}
		}
	}
}

extension ExpandableText where Content == Text {
	public init(
		content: String,
		charactersLimit: Int = String.defaultCharactersLimit,
		@ViewBuilder readMoreView: @escaping (@escaping () -> ()) -> ReadMoreButton
	) {
		self.init(
			content: content,
			charactersLimit: charactersLimit,
			contentView: { Text($0) },
			readMoreView: readMoreView
		)
	}
}

private extension ExpandableText {
	var needsCropping: Bool {
		content.count > charactersLimit
	}
}

// MARK: - Preview
struct ExpandableText_Previews: PreviewProvider {
	static var previews: some View {
		List {
			ExpandableText(
				content: "The world is constantly evolving, and as we progress into the future, new technologies emerge, societies change, and ideas evolve. In recent years, we have witnessed remarkable advancements in artificial intelligence, robotics, and automation. These innovations have revolutionized various industries, from healthcare and transportation to finance and entertainment. Artificial intelligence, in particular, has become a driving force behind many groundbreaking developments. Machine learning algorithms have enabled computers to process and analyze massive amounts of data, leading to significant improvements in various fields. AI-powered systems have revolutionized healthcare by assisting in the diagnosis of diseases, predicting patient outcomes, and streamlining medical procedures. Automation has also played a pivotal role in reshaping industries and the labor market. Robotic process automation (RPA) has automated repetitive tasks, boosting efficiency and productivity in businesses. Industries such as manufacturing, logistics, and customer service have seen the integration of robots and automated systems, leading to increased accuracy, reduced costs, and improved safety. Furthermore, the rise of the Internet of Things (IoT) has connected countless devices and enabled them to communicate and share data. From smart homes and wearable devices to smart cities and autonomous vehicles, IoT has transformed the way we interact with our environment. It has enhanced convenience, efficiency, and sustainability across various aspects of our lives. However, with these advancements come new challenges and ethical considerations. Questions regarding data privacy, algorithmic biases, and the potential impact on the job market have emerged. As we embrace these technologies, it becomes crucial to strike a balance between progress and ensuring that the benefits are accessible to all. Looking ahead, the future holds even more exciting possibilities. Emerging technologies such as quantum computing, augmented reality, and genetic engineering are on the horizon. These innovations have the potential to reshape our world in ways we can only begin to imagine. In conclusion, the rapid pace of technological advancement is shaping our present and future. Artificial intelligence, robotics, automation, and the Internet of Things are transforming industries, improving efficiency, and enabling new opportunities. However, as we embrace these technologies, we must navigate the ethical implications and ensure that the benefits are inclusive and sustainable. The journey towards a technologically advanced future continues, and it is up to us to shape it responsibly.",
				readMoreView: {
					Button("Read More", action: $0)
					#if os(macOS)
						.buttonStyle(.link)
					#endif
				}
			)
		}
	}
}
