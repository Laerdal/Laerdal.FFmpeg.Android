#!/bin/bash

# GITHUB INFORMATION
github_repo_owner=tanersener
github_repo=mobile-ffmpeg
github_release_id=28895129
github_info_file="$github_repo_owner.$github_repo.$github_release_id.info.json"

if [ ! -f "$github_info_file" ]; then
    echo ""
    echo "### DOWNLOADING GITHUB INFORMATION ###"
    echo ""
    github_info_file_url=https://api.github.com/repos/$github_repo_owner/$github_repo/releases/$github_release_id
    echo "Downloading $github_info_file_url to $github_info_file"
    curl -s $github_info_file_url > $github_info_file
fi

package_zip_folder="Laerdal.Xamarin.FFmpeg.iOS.Source"

# Set version
github_tag_name=`cat $github_info_file | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//'`
if [ ! -z "$github_tag_name" ]; then
    echo "Failed : Could not read Version"
    cat $github_info_file
    exit 1
fi

# Generates variables
echo ""
echo "github_repo_owner = $github_repo_owner"
echo "github_repo = $github_repo"
echo "github_release_id = $github_release_id"
echo "github_info_file = $github_info_file"
echo "package_zip_folder = $package_zip_folder"
echo "github_tag_name = $github_tag_name"

echo ""
echo "### DOWNLOAD ALL GITHUB RELEASE FILES ###"
echo ""

mkdir -p $package_zip_folder
package_zip_file_name_pattern="mobile-ffmpeg-.*-$github_tag_name-ios-framework.zip"
echo "Files matching '$package_zip_file_name_pattern' :"
cat $github_info_file | grep "browser_download_url.*$package_zip_file_name_pattern" | cut -d : -f 2,3 | tr -d \"
cat $github_info_file | grep "browser_download_url.*$package_zip_file_name_pattern" | cut -d : -f 2,3 | tr -d \" | wget -q --show-progress -nc -P $package_zip_folder -i -

echo ""
echo "### DONE ###"
echo ""