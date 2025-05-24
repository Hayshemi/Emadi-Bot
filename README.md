# Emadi Bot v2

**Emadi Bot** is a versatile Discord webhook tool for scraping, spamming, checking, and managing webhooks.

> ⚠️ This tool is for **educational and testing** purposes only.

---

![Emadi Bot Interface](https://github.com/Hayshemi/Emadi-Bot/blob/main/assets/screenshot.png)
*Emadi Bot v2 — CLI Interface*

---

## 🔧 Features

- 🔍 **Webhook Scraping**: Extracts Discord webhook URLs from any public HTML page.
- 📄 **List Management**: Create, edit, view, and delete lists of webhooks.
- 💬 **Spam Function**: Send custom messages to one or multiple webhooks.
- ✅ **Single Webhook Checker**: Verify if a webhook exists in your saved list.
- 🗑️ **Delete Tools**: Remove webhooks or clear lists from storage.

---

## 🚀 New in Version 2.0

The new **webhook scraper** uses robust regex to scan and collect valid Discord webhook URLs from public HTML content. It supports:
- `discord.com/api/webhooks/...`
- `ptb.discord.com/...` and `canary.discord.com/...`

> It saves the results to a file of your choice — ideal for managing leaked or public-facing webhooks.

---

## 📦 Downloads

| Version | Type               | Description                      | Download |
|---------|--------------------|----------------------------------|--------------|
| v2.0    | Python-only         | New menu, webhook scraper, modern structure | [EXE](https://github.com/Hayshemi/Emadi-Bot/releases/tag/v2.0) |
| v1.1    | Hybrid (Batch+Py)   | Added Python utilities, partial automation | N/A |
| v1.0    | Batch-only          | Original release, basic UI       | [BAT](https://github.com/Hayshemi/Emadi-Bot/releases/tag/v1.0) |

**Source code can be found on the releases page**

---

## 🖼 Screenshots

![Webhook Scraper](https://github.com/Hayshemi/Emadi-Bot/blob/main/assets/scraper.png)
*Scraped webhooks saved to TXT*

![Webhook Spam](https://github.com/Hayshemi/Emadi-Bot/blob/main/assets/spammer.png)
*Custom spam message sent to multiple webhooks*

---

## 🛠 Usage

- Run the `.exe` or launch `main.py` in a terminal.
- Select an operation from the menu (scrape, spam, check, etc.)
- Follow on-screen prompts — it’s fully interactive.

> You can also edit lists manually by opening the TXT files it generates.

---

## 🤖 Built With

- Python 3.x
- Requests
- Regex
- ANSI/ASCII CLI styling

---

## 👤 Author

**[Hayshemi](https://github.com/Hayshemi)**  
Feel free to open issues or suggestions in the [Issues tab](https://github.com/Hayshemi/Emadi-Bot/issues).

---

## ⚠️ Disclaimer

> This tool is for **educational and testing purposes only**.  
> Misuse of this project can violate [Discord’s Terms of Service](https://discord.com/terms) and may result in account termination or legal consequences.  
> The developer is **not responsible** for any misuse.

*Last updated: May 2025*
