import Foundation
import IGTranscriberCore

@main
struct TranscribeCLI {
    static func main() {
        let arguments = CommandLine.arguments
        guard arguments.count > 1 else {
            print("Usage: transcribe-cli <video-url>")
            exit(1)
        }
        
        let videoURLString = arguments[1]
        guard let url = URL(string: videoURLString) else {
            print("Error: Invalid URL '\(videoURLString)'")
            exit(1)
        }
        
        Task {
            let downloader = VideoDownloadService()
            let transcriber = VideoTranscriptionService()
            
            do {
                print("--- Starting Transcription ---")
                
                let downloadedVideo = try await downloader.downloadVideo(from: url) { message in
                    print("[Download] \(message)")
                }
                
                defer {
                    // Cleanup temp directory
                    try? FileManager.default.removeItem(at: downloadedVideo.temporaryDirectoryURL)
                }
                
                let transcript = try await transcriber.transcribeVideo(at: downloadedVideo.fileURL) { message in
                    print("[Transcription] \(message)")
                }
                
                print("\n--- TRANSCRIPT START ---")
                print(transcript)
                print("--- TRANSCRIPT END ---\n")
                
                // Auto-save to Downloads/Transcriptions
                let fileManager = FileManager.default
                let downloadsURL = fileManager.urls(for: .downloadsDirectory, in: .userDomainMask).first!
                let transcriptionsDir = downloadsURL.appendingPathComponent("Transcriptions")
                
                try fileManager.createDirectory(at: transcriptionsDir, withIntermediateDirectories: true)
                
                let safeTitle = (downloadedVideo.videoTitle ?? "Untitled")
                    .components(separatedBy: CharacterSet.alphanumerics.inverted)
                    .joined(separator: "_")
                    .prefix(50)
                
                let dateString = ISO8601DateFormatter().string(from: Date()).replacingOccurrences(of: ":", with: "-")
                let filename = "\(safeTitle)_\(dateString).txt"
                let saveURL = transcriptionsDir.appendingPathComponent(filename)
                
                let fullContent = """
                Source URL: \(videoURLString)
                Title: \(downloadedVideo.videoTitle ?? "Unknown")
                Date: \(Date().description)
                
                --- TRANSCRIPT ---
                \(transcript)
                """
                
                try fullContent.write(to: saveURL, atomically: true, encoding: .utf8)
                print("✅ Transcript auto-saved to: \(saveURL.path)")
                
                exit(0)
            } catch {
                print("\n❌ Error: \(error.localizedDescription)")
                exit(1)
            }
        }
        
        dispatchMain()
    }
}
