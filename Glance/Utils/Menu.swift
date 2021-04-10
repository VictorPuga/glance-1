import Cocoa
import Foundation

let feedbackURL = URL(string: "https://chamburr.xyz")!
let licenseURL = URL(string: "https://github.com/chamburr/glance/blob/master/LICENSE.md")!
let privacyPolicyURL = URL(string: "https://github.com/chamburr/glance/blob/master/PRIVACY.md")!
let websiteURL = URL(string: "https://github.com/chamburr/glance")!

/// Used as a subclass for the menu item in Interface Builder
final class SupportedFilesMenuItem: NSMenuItem {
	required init(coder decoder: NSCoder) {
		super.init(coder: decoder)

		onAction = { _ in
			let supportedFilesWC = SupportedFilesWC(windowNibName: NSNib.Name("SupportedFilesWC"))
			supportedFilesWC.showWindow(nil)
		}
	}
}

/// Used as a subclass for the menu item in Interface Builder
final class FeedbackMenuItem: NSMenuItem {
	required init(coder decoder: NSCoder) {
		super.init(coder: decoder)

		onAction = { _ in
			feedbackURL.open()
		}
	}
}

/// Used as a subclass for the menu item in Interface Builder
final class LicenseMenuItem: NSMenuItem {
	required init(coder decoder: NSCoder) {
		super.init(coder: decoder)

		onAction = { _ in
			licenseURL.open()
		}
	}
}

/// Used as a subclass for the menu item in Interface Builder
final class PrivacyPolicyMenuItem: NSMenuItem {
	required init(coder decoder: NSCoder) {
		super.init(coder: decoder)

		onAction = { _ in
			privacyPolicyURL.open()
		}
	}
}

/// Used as a subclass for the menu item in Interface Builder
final class WebsiteMenuItem: NSMenuItem {
	required init(coder decoder: NSCoder) {
		super.init(coder: decoder)

		onAction = { _ in
			websiteURL.open()
		}
	}
}
