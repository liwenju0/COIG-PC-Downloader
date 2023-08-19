#!/bin/bash

# Function to download a file

download_file() {
   url="$1"
   file_name="$(echo "$url" | sed 's/.*\///')"
   token="Your huggingface token"
   if [ ! -f "data/${file_name}" ]; then
        echo "Downloading ${file_name}..."
        while ! curl -q --header "Cookie: token=${token}" "$url" -o "data/${file_name}" -L; do
            sleep 1
        done
        echo "${file_name} Download completed"
   fi
}
if [ ! -d "data" ]; then
    mkdir data
# Read the txt file line by line
while read -r line; do
   # Check if the line is not empty
   if [ -n "$line" ]; then
       # Download the file in a separate process
       download_file "$line" &
   fi
done < data_links.txt

# Wait for all downloads to complete
wait

echo "All downloads are complete."