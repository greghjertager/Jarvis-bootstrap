# Jarvis voice kit (Windows, optional)

Lets Jarvis answer out loud while you keep typing in your AI tool. It uses only the text-to-speech voices built into Windows: no downloads and no voice cloning.

## How it works
1. Your AI tool must be able to write a file on your computer (for example, through a desktop app that links the chat to a local folder).
2. Double-click **`Jarvis Voice On.bat`**. A window opens and the voice says it's on. Leave the window open.
3. With each reply, Jarvis also writes a short spoken version to `speak.txt` in this folder. The script notices the change and reads it aloud within a second or two.
4. Close the window to turn voice off.

## Choosing a voice
- Run **`List Jarvis Voices.bat`**. It writes `voices.txt` listing the voices installed on your PC.
- The script defaults to *Microsoft George* (English, UK). To add it: Settings → Time & language → Language & region → add English (United Kingdom) with text-to-speech selected.
- To use another voice, change `$VoiceName` at the top of `voice-watch.ps1` to part of its name.

## Pronunciation
If the voice says a name wrong, add a line to `pronounce.txt` (`Written = Say-it-like-this`), try a few spellings by ear, then restart the voice window. Jarvis can also spell the name phonetically when it writes `speak.txt`.

## Limits
- Turn-based, like a walkie-talkie: it speaks after each reply. It doesn't listen, and it can't be interrupted mid-sentence.
- Speaks only while the window is open and the AI tool can reach the folder.
- To talk instead of type, use Windows dictation (Windows key + H).
