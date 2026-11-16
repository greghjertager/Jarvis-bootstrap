# Getting started with Jarvis (no experience needed)

This guide walks you through setting up your own Jarvis, one click at a time. You don't need to know anything about coding or GitHub. It takes about 15 minutes.

**What Jarvis is:** an AI coworker with a consistent personality and a memory you can read. He runs inside the AI you already use (ChatGPT, Claude, Copilot, and others). You're not installing a program; you're giving your AI a set of instructions and a place to keep its notes.

---

## What you'll need

- A computer (Windows or Mac). A phone works for chatting later, but setup is easier on a computer.
- An account with an AI tool: ChatGPT, Claude, Copilot, or similar.
- Your AI needs to accept file uploads for the quickest method. Some free plans limit this. If yours won't take the file, use the copy-and-paste method in Part 3 instead.

---

## Part 1: Download Jarvis

1. Go to **github.com/greghjertager/Jarvis-bootstrap** in your web browser.
2. Near the top of the page, click the green button that says **Code**.
3. In the menu that opens, click **Download ZIP**.
4. A file named something like `Jarvis-bootstrap-main.zip` downloads to your computer, usually into your **Downloads** folder.

That's it for downloading. You don't need to open the ZIP for the next part.

---

## Part 2: Set up Jarvis (the quick way)

1. Open your AI tool and **start a new chat**.
2. Find the button for attaching a file. It's usually a **paperclip** or a **+** next to the box where you type.
3. Choose the ZIP file from your **Downloads** folder.
4. In the message box, type exactly:

   > **Install Jarvis from this zip. Start with START_HERE.md.**

5. Press **Enter** (or click **Send**).
6. Jarvis will introduce himself and ask you a few questions:
   - your name;
   - whether he should call you **sir** or **ma'am**;
   - a first name he can use now and then;
   - how dry his humor should be, from 1 (none) to 5 (dry most of the time). 3 is a good start.

   Answer each one in plain words.
7. At the end, Jarvis gives you a **setup report**. It tells you what he set up and what you need to do. Most people will see one or both of these:
   - **A file to download** (his memory, called the "vault"). Click it to download, and save it somewhere you'll find it again, such as your **Documents** folder.
   - **A short piece of text** to paste into your AI's settings, so Jarvis loads by himself in every new chat. The report tells you where it goes. If you can't find the right place, see "Use a Project" below.

> **Why a download?** ChatGPT and Claude in a web browser work in a temporary space in the cloud, not on your computer. So Jarvis builds his memory there and hands it to you to keep. If you use a tool that works directly on your computer (such as Codex or Claude Code), he can create the files for real, and he'll tell you where.

---

## Part 3: If the quick way doesn't work (copy and paste)

Use this if your AI won't accept the ZIP file.

1. Find the ZIP in your **Downloads** folder and unzip it:
   - **Windows:** right-click the ZIP, choose **Extract All**, then **Extract**.
   - **Mac:** double-click the ZIP. A folder appears next to it.
2. Open the new folder. Open **JARVIS_SETUP_PROMPT.txt** (it opens in Notepad or TextEdit).
3. Select everything **below the dashed line** (`-----`) and copy it.
4. Start a new chat in your AI and paste it in. **Don't send it yet.**
5. Go back to the folder and open **JARVIS_CHARTER_TEMPLATE.md**. If your computer asks which app to use, choose Notepad (Windows) or TextEdit (Mac). Select all of it and copy it.
6. In the chat, click after the text you already pasted, press Enter to start a new line, and paste the Charter underneath.
7. Now press **Send**, and continue from step 6 of Part 2.

---

## Use a Project (recommended, if your AI has them)

ChatGPT and Claude both offer **Projects**: a space where your files and instructions load automatically in every chat. This is the easiest way to keep Jarvis being Jarvis.

1. In your AI tool, create a new **Project** and call it "Jarvis".
2. Add these files to the project: **JARVIS_CHARTER_TEMPLATE.md**, **JARVIS_SETUP_PROMPT.txt**, and, once you have it, the **vault** file Jarvis gave you.
3. If the project has a place for **instructions**, paste in the short text from Jarvis's setup report.
4. Start every Jarvis chat **inside the project**.

---

## Part 4: Test him

1. Start a **new chat** (inside your project, if you made one).
2. Type: **Jarvis Posture Check**
3. A good answer:
   - calls you sir or ma'am, whichever you chose;
   - says briefly what he can and can't access;
   - sounds like a calm, composed coworker, not a customer-service bot.

If he answers like a normal assistant, he hasn't loaded his instructions. See Troubleshooting below.

---

## Part 5: Using Jarvis day to day

- Talk to him like a coworker. Ask for help with whatever you're working on.
- **"Brief me"** gets a short status of where things stand.
- **"Save to the vault"** at the end of a session tells him to update his notes. In a web-browser AI, he gives you an updated vault file. Download it and replace your old copy (or re-upload it to your project), so he remembers next time.
- **"Dry wit to 2"** (or any number from 1 to 5) changes how dry his humor is.
- **"Call me ma'am"** or **"Call me sir"** changes how he addresses you.

---

## Optional extras (Windows only)

These are in the folder you unzipped in Part 3.

- **Control Center:** a small window with sliders for Jarvis's humor, how much he says, and how formal he is. It needs Jarvis's vault as a folder on your computer, which happens when you use a tool that works on your computer (such as Codex or Claude Code). Copy the **control** folder into your vault folder, then double-click **Jarvis Control Center.bat**.
- **Spoken replies:** the **voice** folder lets Jarvis read his answers aloud with a voice built into Windows. See the README inside that folder.

> If Windows shows **"Windows protected your PC"** when you double-click a `.bat` file, that's Windows being cautious about files from the internet. If you downloaded it from the GitHub page above, click **More info**, then **Run anyway**.

---

## Troubleshooting

- **"I can't open zip files" or "I can't read that file."** Use the copy-and-paste method in Part 3.
- **He's acting like a normal assistant.** Type: *Read START_HERE.md and follow it.* If you used copy and paste, check that you pasted both the setup prompt and the Charter.
- **He forgets everything in a new chat.** He needs his instructions and vault each time. The easiest fix is a Project (see above). Otherwise, upload the vault file at the start of each chat and say *Load the vault.*
- **He says he saved something, but there's no file.** Ask him: *Where exactly is that file?* Jarvis is designed to be honest about this. If he can't show you the file, it wasn't saved.
- **The Control Center doesn't open.** It's for Windows only and needs the vault as a folder on your computer.

---

## A few sensible rules

- **Never put passwords, bank details, or ID numbers into Jarvis's vault.** He's designed never to ask for them.
- **Don't paste confidential work material** into a personal AI account. Follow your employer's rules on AI tools.
- **The vault isn't encrypted** unless you encrypt it yourself. Keep that in mind when deciding what goes in it.

---

Questions or problems? Open an issue on the GitHub page, or reach out to Greg on LinkedIn: [linkedin.com/in/ghjertager](https://www.linkedin.com/in/ghjertager).
