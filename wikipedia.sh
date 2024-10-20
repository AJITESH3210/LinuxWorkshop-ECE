#!/bin/bash

# Read URLs from url.txt
while IFS= read -r url; do
    # Get the page title from the URL (assuming the URL is a Wikipedia page) ---> Take content from last slash to last word
    title=$(echo "$url" | awk -F/ '{print $(NF)}' | sed 's/_/ /g')   #awk and sed to retrieve those commands; sed --> get that last part
    
    # Fetch the HTML content from the URL
    html_content=$(curl -s "$url")  #curl - a tool to send a request, asking server for a particular file (html file)

    # Extract the first paragraph using awk
    first_paragraph=$(echo "$html_content" | awk -v RS="<p>" -v ORS="" 'NR==2 {gsub("</?[^>]+>", "", $0); print $0}')

    # Save the first paragraph to a file named <TITLE>.txt
    echo "$first_paragraph" > "${title}.txt"
done < url.txt
