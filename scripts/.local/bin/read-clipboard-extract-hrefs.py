#!/usr/bin/env python3

import subprocess
import re

def get_clipboard_content():
    # Read clipboard content using wl-paste
    try:
        result = subprocess.run(['wl-paste'], capture_output=True, text=True, check=True)
        return result.stdout
    except subprocess.CalledProcessError as e:
        print(f"Error reading clipboard: {e}")
        return None

def extract_hrefs(html_content):
    # Regular expression to match href attributes
    href_pattern = re.compile(r'href="([^"]+)"')
    hrefs = href_pattern.findall(html_content)
    return hrefs

def copy_to_clipboard(content):
    try:
        process = subprocess.Popen(['wl-copy'], stdin=subprocess.PIPE)
        process.communicate(input=content.encode())
        print("Links copied to clipboard.")
    except Exception as e:
        print(f"Error copying to clipboard: {e}")

def main():
    clipboard_content = get_clipboard_content()
    if clipboard_content:
        links = extract_hrefs(clipboard_content)
        if links:
            links_string = ' '.join(links)
            copy_to_clipboard(links_string)
            print("Extracted links:")
            for link in links:
                print(link)
        else:
            print("No links found in clipboard content.")
    else:
        print("Clipboard is empty or could not be read.")

if __name__ == "__main__":
    main()
