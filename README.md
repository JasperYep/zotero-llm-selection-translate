# LLM Selection Translate for Zotero

A lightweight Zotero Reader plugin for translating selected academic text through an OpenAI-compatible Chat Completions API.

## Features

- Translate selected text in the Zotero PDF/EPUB Reader.
- Plain-text `Summary` mode for explaining difficult academic text in simple language.
- Persistent local cache for successful translations and summaries.
- Separate cache entries for translation and summary results.
- Streaming responses.
- Configurable endpoint, model, target language, prompts, and additional request JSON.
- Minimal icon-based popup UI.
- Press `P` in the Zotero Reader to toggle the text annotation mode between highlight and underline.

## Installation

1. Build or download `dist/llm-selection-translate-for-zotero.xpi`.
2. In Zotero, open **Tools → Add-ons**.
3. Open the gear menu and choose **Install Add-on From File…**.
4. Select the XPI file and restart Zotero completely.
5. Confirm that the installed version matches the version in `manifest.json`.

## Build

Requirements: macOS/Linux, Bash, and the `zip` command.

```bash
./build.sh
```

The generated package is written to:

```text
dist/llm-selection-translate-for-zotero.xpi
```

The XPI contains only the runtime files:

- `bootstrap.js`
- `manifest.json`
- `prefs.js`
- `chrome/content/preferences.xhtml`
- `chrome/content/scripts/llmselectiontranslate.js`

## Configuration

Open Zotero Preferences and select **LLM Selection Translate**.

The plugin supports an OpenAI-compatible Chat Completions endpoint. API tokens are stored in Zotero preferences and are not committed to this repository.

The summary prompt is required to produce plain text because the popup uses a text-oriented display. Markdown-like output is also cleaned before display.

## Keyboard shortcut

In the Zotero Reader, press `P` without modifiers to toggle the persistent text annotation mode:

```text
highlight ↔ underline
```

The shortcut is ignored while typing in an input, textarea, select, or editable field. It applies to the Reader's outer window and PDF/EPUB subviews.

## Local cache

Successful results are persisted in the Zotero profile as:

```text
llm-selection-translate-cache.json
```

Cache keys include the mode, endpoint, model, target language, prompt template, and selected text. Translation and summary results therefore do not collide. Failed or empty responses are not valid cache entries.

## Development notes

The current runtime script is a bundled JavaScript file. The repository does not currently include the original TypeScript/source-module project used to generate it.

Zotero loads bootstrap extensions at startup. After replacing an installed XPI, fully quit Zotero with `Cmd+Q` and reinstall the XPI from **Add-ons → Install Add-on From File…** rather than relying on a hot reload.

## Repository

GitHub: <https://github.com/JasperYep/zotero-llm-selection-translate>
