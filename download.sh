#!/bin/bash

repo=tanersener/mobile-ffmpeg
json=$(curl -s https://api.github.com/repos/$repo/releases/latest)
version=$(echo "$json" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//')

aar_folder_path="Laerdal.Xamarin.FFmpeg.Android.Source"
mkdir -p $aar_folder_path
echo "$json" | grep "browser_download_url.*-$version.aar" | cut -d : -f 2,3 | tr -d \" | wget -q --show-progress -nc -P $aar_folder_path -i -