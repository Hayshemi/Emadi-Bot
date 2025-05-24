import os
import requests
import re
os.system("title Emadi Bot v2 - By Hayshemi")


# if u want new colors add them here (ANSI)
RED = "\033[91m"
GREEN = "\033[92m"
YELLOW = "\033[93m"
CYAN = "\033[96m"
MAGENTA = "\033[95m"
RESET = "\033[0m"

TITLE = f"""
{MAGENTA}
 _____                     _ _   ____        _           ____  
| ____|_ __ ___   __ _  __| (_) | __ )  ___ | |_  __   _|___ \ 
|  _| | '_ ` _ \ / _` |/ _` | | |  _ \ / _ \| __| \ \ / / __) |
| |___| | | | | | (_| | (_| | | | |_) | (_) | |_   \ V / / __/ 
|_____|_| |_| |_|\__,_|\__,_|_| |____/ \___/ \__|   \_/ |_____|
                                       
{RESET}
"""

# core functions, don't suggest changing anything unless you know what ur doing
def scrape_webhook(url, filename):
    try:
        response = requests.get(url)
        response.raise_for_status()
        webhooks = re.findall(r"https://(?:canary\.|ptb\.)?discord(?:app)?\.com/api/webhooks/\d+/[\w-]+", response.text)
        with open(filename, 'w', encoding='utf-8') as file:
            for webhook in webhooks:
                file.write(webhook + '\n')
        print(f"{GREEN}[✓] Scraped {len(webhooks)} webhook(s) to {filename}{RESET}")
    except requests.exceptions.RequestException as e:
        print(f"{RED}[!] Error scraping: {e}{RESET}")

def create_list(filename):
    items = []
    print(f"{CYAN}Enter webhooks (type 'done' to finish):{RESET}")
    while True:
        item = input("Webhook > ")
        if item.lower() == 'done':
            break
        items.append(item)
    with open(filename, 'w', encoding='utf-8') as file:
        for item in items:
            file.write(f"{item}\n")
    print(f"{GREEN}[✓] Webhook list saved to {filename}{RESET}")

def check_txt(filename):
    if not os.path.exists(filename):
        print(f"{RED}[!] {filename} not found.{RESET}")
        return
    with open(filename, 'r', encoding='utf-8') as file:
        print(f"{YELLOW}[Contents of {filename}]{RESET}")
        print(file.read())

def check_list(filename):
    if not os.path.exists(filename):
        print(f"{RED}[!] {filename} not found.{RESET}")
        return
    with open(filename, 'r', encoding='utf-8') as file:
        print(f"{CYAN}Webhooks in {filename}:{RESET}")
        for line in file:
            print(f"- {line.strip()}")

def check_single(filename):
    if not os.path.exists(filename):
        print(f"{RED}[!] {filename} not found.{RESET}")
        return
    term = input("Enter webhook to search: ")
    with open(filename, 'r', encoding='utf-8') as file:
        lines = file.readlines()
    found = any(term == line.strip() for line in lines)
    print(f"{GREEN if found else RED}[{'✓' if found else '!'}] {'Found' if found else 'Not found'}: {term}{RESET}")

def spam_list(filename):
    if not os.path.exists(filename):
        print(f"{RED}[!] {filename} not found.{RESET}")
        return
    message = input("Enter message to spam: ")
    try:
        count = int(input("How many times to send it to each webhook: "))
    except ValueError:
        print(f"{RED}[!] Invalid count.{RESET}")
        return
    with open(filename, 'r', encoding='utf-8') as file:
        webhooks = [line.strip() for line in file if line.strip()]
    for webhook in webhooks:
        for i in range(count):
            response = requests.post(webhook, data={'content': message})
            if response.status_code == 204:
                print(f"{GREEN}[✓] Sent to {webhook} ({i+1}/{count}){RESET}")
            else:
                print(f"{RED}[!] Failed ({response.status_code}) for {webhook} ({i+1}/{count}){RESET}")

def spam_single():
    webhook_url = input("Enter webhook URL: ")
    message = input("Enter message to spam: ")
    try:
        count = int(input("How many times to send it: "))
    except ValueError:
        print(f"{RED}[!] Invalid count.{RESET}")
        return
    for i in range(count):
        response = requests.post(webhook_url, data={'content': message})
        if response.status_code == 204:
            print(f"{GREEN}[✓] Sent {i + 1}/{count}{RESET}")
        else:
            print(f"{RED}[!] Failed {i + 1}/{count} (Status {response.status_code}){RESET}")

def delete_list(filename):
    if not os.path.exists(filename):
        print(f"{RED}[!] {filename} not found.{RESET}")
        return
    with open(filename, 'r', encoding='utf-8') as file:
        webhooks = [line.strip() for line in file if line.strip()]
    for webhook in webhooks:
        response = requests.delete(webhook)
        if response.status_code in [200, 204]:
            print(f"{GREEN}[✓] Deleted {webhook}{RESET}")
        else:
            print(f"{RED}[!] Failed to delete {webhook} ({response.status_code}){RESET}")

def delete_single(filename):
    if not os.path.exists(filename):
        print(f"{RED}[!] {filename} not found.{RESET}")
        return
    term = input("Enter webhook to delete from list and remove from file: ")
    with open(filename, 'r', encoding='utf-8') as file:
        lines = file.readlines()
    with open(filename, 'w', encoding='utf-8') as file:
        for line in lines:
            if line.strip() != term:
                file.write(line)
    response = requests.delete(term)
    if response.status_code in [200, 204]:
        print(f"{GREEN}[✓] Deleted {term} and removed from file{RESET}")
    else:
        print(f"{RED}[!] Failed to delete {term} ({response.status_code}){RESET}")

# Menu
def main_menu():
    while True:
        os.system("cls" if os.name == "nt" else "clear")
        print(TITLE)
        print(f"{YELLOW}Webhook Options:{RESET}")

        print(f"\n{CYAN}📥 Webhook Scraping:{RESET}")
        print(f"  1. Scrape Webhooks to TXT")

        print(f"\n{CYAN}📋 Webhook Checking:{RESET}")
        print(f"  2. Check TXT File")
        print(f"  3. Check Webhook List")
        print(f"  4. Check Single Webhook")

        print(f"\n{CYAN}🚀 Webhook Spamming:{RESET}")
        print(f"  5. Create Webhook List")
        print(f"  6. Spam Webhook List")
        print(f"  7. Spam Single Webhook")

        print(f"\n{CYAN}🗑️ Webhook Deletion:{RESET}")
        print(f"  8. Delete Webhook List")
        print(f"  9. Delete Single Webhook")

        print(f"\n{RED}  10. Exit{RESET}")

        choice = input(f"\n{YELLOW}Enter choice (1-10): {RESET}")
        if choice == '1':
            url = input("Webhook URL to scrape: ")
            filename = input("Save as filename (e.g., scraped.txt): ")
            scrape_webhook(url, filename)
        elif choice == '2':
            filename = input("Filename to check: ")
            check_txt(filename)
        elif choice == '3':
            filename = input("Filename to view: ")
            check_list(filename)
        elif choice == '4':
            filename = input("Filename: ")
            check_single(filename)
        elif choice == '5':
            filename = input("Filename for new webhook list: ")
            create_list(filename)
        elif choice == '6':
            filename = input("List filename: ")
            spam_list(filename)
        elif choice == '7':
            spam_single()
        elif choice == '8':
            filename = input("Filename containing webhooks to delete: ")
            delete_list(filename)
        elif choice == '9':
            filename = input("Filename: ")
            delete_single(filename)
        elif choice == '10':
            print(f"{GREEN}[✓] Exiting Emadi Bot v2. Goodbye!{RESET}")
            break
        else:
            print(f"{RED}[!] Invalid choice.{RESET}")

        input(f"\n{YELLOW}Press Enter to return to menu...{RESET}")

if __name__ == "__main__":
    main_menu()
