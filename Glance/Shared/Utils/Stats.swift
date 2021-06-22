import Foundation
import os.log

/// Class for reading and updating usage statistics. The values are stored in `UserDefaults` for the
/// application group (so they can be accessed by both the main app and Quick Look extension)
class Stats {
	private let dateCountsKey = "dateCount"
	private let extensionCountsKey = "extensionCount"
	private let totalCountKey = "totalCount"
	
	private let defaults: UserDefaults?
	
	init() {
		defaults = UserDefaults(suiteName: "group.TZ5YSJH8XE.com.VictorPuga.Glance")
		
		// createStatsFile()
		// let i = defaults?.integer(forKey: "testCount") ?? 0
		// defaults?.setValue(i + 1, forKey: "testCount")
		
		if defaults == nil {
			os_log(
				"Unable to initialize user defaults: Object is null",
				log: Log.general,
				type: .error
			)
		}
	}

	/// Returns the stored dictionary with number of previews generated per day
	func getDateCounts() -> [String: Int] {
		defaults!.dictionary(forKey: dateCountsKey) as? [String: Int] ?? [String: Int]()
	}

	/// Returns the stored dictionary with number of previews generated per file extension
	func getExtensionCounts() -> [String: Int] {
		defaults!.dictionary(forKey: extensionCountsKey) as? [String: Int] ?? [String: Int]()
	}

	/// Returns the total number of generated previews
	func getTotalCount() -> Int {
		defaults!.integer(forKey: totalCountKey)
	}

	/// Updates all statistics to record that a new preview has been generated
	func increaseStatsCounts(fileExtension: String) {
		let todayString = Date().toDateString()

		// Increase today's date count by 1
		var dateCounts = getDateCounts()
		dateCounts[todayString] = dateCounts[todayString, default: 0] + 1
		defaults!.set(dateCounts, forKey: dateCountsKey)

		// Increase file extension count by 1
		if !fileExtension.isEmpty { // Skip for files without extension (e.g. LICENSE, Dockerfile)
			var extensionCounts = getExtensionCounts()
			extensionCounts[fileExtension] = extensionCounts[fileExtension, default: 0] + 1
			defaults!.set(extensionCounts, forKey: extensionCountsKey)
		}

		// Increase total count by 1
		defaults!.set(getTotalCount() + 1, forKey: totalCountKey)
	}
	
	private func createStatsFile() {
		let appIdentifier = "TZ5YSJH8XE.group.com.VictorPuga.Glance"
		let fileManager = FileManager.default
		guard let container = fileManager.containerURL(forSecurityApplicationGroupIdentifier: appIdentifier) else { return }
		let directoryPath  = container.appendingPathComponent("Library/Application Support/Glance")
		do{
			var isDir: ObjCBool = false
			let path = directoryPath.path
			if fileManager.fileExists(atPath: path, isDirectory: &isDir)
			{
				if isDir.boolValue {
					// file exists and is a directory
				} else {
					// file exists and is not a directory
				}
			} else {
				// file or directory does not exist
				try fileManager.createDirectory(at: directoryPath, withIntermediateDirectories: false, attributes: nil)
			}
			
		} catch let error as NSError {
			print(error.description)
		}
		// let statsFolder = directory
		// 	.appendingPathComponent("Library/Application Support/Glance/TEST")
		let stats = directoryPath.appendingPathComponent("stats.json")
		var isDir: ObjCBool = false
		if (fileManager.fileExists(atPath: stats.path, isDirectory: &isDir))
		// if (try? Data.init(contentsOf: stats)) == nil
		{
			do {
				try "{}".write(to:stats , atomically: true, encoding: .utf8)
			} catch {
				print(error)
			}
		} else {
			do {
				let i = Int.random(in: 0...100)
				try "\(i)".write(to: stats, atomically: true, encoding: .utf8)
			} catch {
				print(error)
			}
		}
	}
}
