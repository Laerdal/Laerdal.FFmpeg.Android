#!/bin/bash

# find the latest ID here : https://api.github.com/repos/tanersener/mobile-ffmpeg/releases/latest
github_repo_owner=tanersener
github_repo=mobile-ffmpeg
github_release_id=28895129
github_info_file="$github_repo_owner.$github_repo.$github_release_id.info.json"

if [ ! -f "$github_info_file" ]; then
    echo ""
    echo "### DOWNLOAD GITHUB INFORMATION ###"
    echo ""
    github_info_file_url=https://api.github.com/repos/$github_repo_owner/$github_repo/releases/$github_release_id
    echo "Downloading $github_info_file_url to $github_info_file"
    curl -s $github_info_file_url > $github_info_file
fi

package_aar_folder="Laerdal.Xamarin.FFmpeg.Android.Source"

# Set version
github_tag_name=`cat $github_info_file | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//'`
github_short_version=`echo "$github_tag_name" | sed 's/.LTS//'`
if [ -z "$github_short_version" ]; then
    echo "Failed : Could not read Version"
    cat $github_info_file
    exit 1
fi

package_aar_file_name_pattern="mobile-ffmpeg-.*-$github_tag_name.aar"

echo ""
echo "### INFORMATION ###"
echo ""

echo "github_repo_owner = $github_repo_owner"
echo "github_repo = $github_repo"
echo "github_release_id = $github_release_id"
echo "github_info_file = $github_info_file"
echo "github_tag_name = $github_tag_name"
echo "github_short_version = $github_short_version"
echo ""
echo "package_aar_folder = $package_aar_folder"
echo "package_aar_file_name_pattern = $package_aar_file_name_pattern"

echo ""
echo "### DOWNLOAD ALL GITHUB RELEASE FILES ###"
echo ""

mkdir -p $package_aar_folder
echo "Files matching '$package_aar_file_name_pattern' :"
cat $github_info_file | grep "browser_download_url.*$package_aar_file_name_pattern" | cut -d : -f 2,3 | tr -d \"
cat $github_info_file | grep "browser_download_url.*$package_aar_file_name_pattern" | cut -d : -f 2,3 | tr -d \" | wget -q -nc -P $package_aar_folder -i -

echo ""
echo "### DONE ###"
echo ""

echo "Files in '$package_aar_folder' :"
ls $package_aar_folder
echo ""