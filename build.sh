#!/bin/bash

repo=tanersener/mobile-ffmpeg
json=$(curl -s https://api.github.com/repos/$repo/releases/latest)

mobile_ffmpeg_version=$(echo "$json" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//')
version="$mobile_ffmpeg_version.0"

mobile_ffmpeg_source_folder="Laerdal.Xamarin.FFmpeg.Android.Source"

nuget_project_folder="Laerdal.Xamarin.FFmpeg.Android"
nuget_project_csproj="$nuget_project_folder/Laerdal.Xamarin.FFmpeg.Android.csproj"
nuget_output_folder="$nuget_project_folder.Output"

build_package()
{
    mobile_ffmpeg_package=$1
    nuget_package_variant_name=$2

    output_file="$nuget_output_folder/$nuget_project_folder.$nuget_package_variant_name.$version.nupkg"

    if [ -f "$output_file" ]; then
        echo "# '$output_file' already exists. Not building"
    else
        echo "# Building '$output_file'"

        rm -rf $nuget_project_folder/Jars/mobile-ffmpeg.aar

        cp $mobile_ffmpeg_source_folder/mobile-ffmpeg-$mobile_ffmpeg_package-$mobile_ffmpeg_version.aar $nuget_project_folder/Jars/mobile-ffmpeg.aar

        msbuild $nuget_project_csproj -t:Rebuild -restore:True -p:Configuration=Release -p:NugetPackageVariantName=$nuget_package_variant_name -p:PackageVersion=$version

        rm -rf $nuget_project_folder/Jars/mobile-ffmpeg.aar
    fi
}
# see https://github.com/tanersener/mobile-ffmpeg for more information
time build_package full Full
time build_package full-gpl Full.Gpl
time build_package https Https
time build_package https-gpl Https.Gpl
time build_package min Min
time build_package min-gpl Min.Gpl
time build_package video Video