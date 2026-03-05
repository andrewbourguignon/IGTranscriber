# Transcriber Bot Skill (formerly IGTranscriber)

## Description
High-fidelity video transcription engine for macOS. Uses Apple's native Speech Recognition for privacy and speed. Supports Instagram Reels, YouTube Shorts, TikToks, and direct video links.

## Features
- Multi-Platform Support (YouTube, TikTok, Instagram, etc.)
- Native macOS Speech Recognition (Free, Private, No API logic required)
- Automated CLI interface for Agent workflows
- Direct transcript export to `.txt`

## Usage
- "Transcribe this video: [URL]"
- "Get the text from this TikTok: [URL]"
- "I need a transcript of [YouTube URL]"

## Implementation Details
- CLI entry: `swift run transcribe-cli [URL]`
- Location: `.agent/skills/ig-transcriber/`
