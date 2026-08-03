<p align="center">
  <img src="icon.svg" width="72" alt="LLM Selection Translate icon">
</p>

<h1 align="center">LLM Selection Translate</h1>

<p align="center">A quiet translation layer for the Zotero Reader.</p>

<p align="center">
  <a href="https://github.com/JasperYep/zotero-llm-selection-translate/releases/latest">Download XPI</a>
  ·
  <a href="https://github.com/JasperYep/zotero-llm-selection-translate/issues">Issues</a>
</p>

## Features

- Translate selected academic text through an OpenAI-compatible API.
- Explain difficult passages with a plain-text Summary mode.
- Cache successful translations and summaries locally.
- Stream responses when supported by the endpoint.
- Press `P` to toggle Zotero's native Highlight tool.

## Install

1. Download `llm-selection-translate-for-zotero.xpi` from [Releases](https://github.com/JasperYep/zotero-llm-selection-translate/releases/latest).
2. Open **Zotero → Tools → Add-ons**.
3. Choose **Install Add-on From File…** from the gear menu.
4. Select the XPI and restart Zotero.

## Configure

Open **Zotero Preferences → LLM Selection Translate** and set:

- API endpoint
- API token
- Model
- Target language
- Translation and Summary prompts

The Summary output is normalized to plain text because the popup does not render Markdown.

## Shortcut

| Key | Action |
| --- | --- |
| `P` | `pointer` ↔ `highlight` |

When Highlight is active, selected text is annotated with Zotero's current highlight color. Press `P` again to return to text selection and translation.

The shortcut is ignored while typing in an editable field.

## Cache

Successful results are stored in the Zotero profile as:

```text
llm-selection-translate-cache.json
```

Cache keys include the mode, endpoint, model, target language, prompt template, and selected text. Failed or empty responses are not cached.

## Build

```bash
./build.sh
```

Output:

```text
dist/llm-selection-translate-for-zotero.xpi
```

The runtime is currently shipped as a bundled JavaScript file. API tokens and local cache files are not part of this repository.

## License

No license has been assigned yet.
