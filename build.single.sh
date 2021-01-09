#!/bin/bash

usage(){
    echo "usage: ./build.single.sh [-p|--package [audio|full|full-gpl|https|https-gpl|min|min-gpl|video]] [-r|--revision build_revision] [-v|--verbose]"
    echo "parameters:"
    echo "  -p | --package [audio|full|full-gpl|https|https-gpl|min|min-gpl|video]    REQUIRED, See https://github.com/tanersener/mobile-ffmpeg for more information"
    echo "  -r | --revision [build_revision]                                          Sets the revision number, default = mdd.hMMSS"
    echo "  -v | --verbose                                                            Enable verbose build details from msbuild tasks"
    echo "  -h | --help                                                               Prints this message"
    echo
}

while [ "$1" != "" ]; do
    case $1 in
        -p | --package )        shift
                                package_variant=$1
                                ;;
        -r | --revision )       shift
                                build_revision=$1
                                ;;
        -v | --verbose )        verbose=1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     echo
                                echo "### Wrong parameter: $1 ###"
                                echo
                                usage
                                exit 1
    esac
    shift
done

# Required variables
if [ -z "$package_variant" ]; then
    usage
    exit 1
fi

if [ -z "$build_revision" ]; then
    build_revision=`date +%-m%d.%-H%M%S`
fi

# find the latest ID here : https://api.github.com/repos/tanersener/mobile-ffmpeg/releases/latest
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

echo ""
echo "### INFORMATION ###"
echo ""

# Set version
github_tag_name=`cat $github_info_file | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' | sed 's/v//'`
github_short_version=`echo "$github_tag_name" | sed 's/.LTS//'`
build_version=$github_short_version.$build_revision
echo "##vso[build.updatebuildnumber]$build_version"
if [ -z "$github_short_version" ]; then
    echo "Failed : Could not read Version"
    cat $github_info_file
    exit 1
fi

# see https://github.com/tanersener/mobile-ffmpeg for more information
package_libraries="?"
[ "$package_variant" = "audio" ] && package_libraries="lame libilbc libvorbis opencore-amr opus shine soxr speex twolame vo-amrwbenc wavpack"
[ "$package_variant" = "full" ] && package_libraries="fontconfig freetype fribidi gmp gnutls kvazaar lame libaom libass libiconv libilbc libtheora libvorbis libvpx libwebp libxml2 opencore-amr opus shine snappy soxr speex twolame vo-amrwbenc wavpack"
[ "$package_variant" = "full-gpl" ] && package_libraries="fontconfig freetype fribidi gmp gnutls kvazaar lame libaom libass libiconv libilbc libtheora libvorbis libvpx libwebp libxml2 opencore-amr opus shine snappy soxr speex twolame vid.stab vo-amrwbenc wavpack x264 x265 xvidcore"
[ "$package_variant" = "https" ] && package_libraries="gmp gnutls"
[ "$package_variant" = "https-gpl" ] && package_libraries="gmp gnutls vid.stab x264 x265 xvidcore"
[ "$package_variant" = "min" ] && package_libraries="-"
[ "$package_variant" = "min-gpl" ] && package_libraries="vid.stab x264 x265 xvidcore"
[ "$package_variant" = "video" ] && package_libraries="fontconfig freetype fribidi kvazaar libaom libass libiconv libtheora libvpx libwebp snappy"

nuget_variant="$package_variant"
[ "$package_variant" = "audio" ] && nuget_variant="Audio"
[ "$package_variant" = "full" ] && nuget_variant="Full"
[ "$package_variant" = "full-gpl" ] && nuget_variant="Full.Gpl"
[ "$package_variant" = "https" ] && nuget_variant="Https"
[ "$package_variant" = "https-gpl" ] && nuget_variant="Https.Gpl"
[ "$package_variant" = "min" ] && nuget_variant="Min"
[ "$package_variant" = "min-gpl" ] && nuget_variant="Min.Gpl"
[ "$package_variant" = "video" ] && nuget_variant="Video"

# Static configuration
nuget_project_folder="Laerdal.Xamarin.FFmpeg.Android"
nuget_project_name="Laerdal.Xamarin.FFmpeg.Android"
nuget_output_folder="$nuget_project_name.Output"
nuget_csproj_path="$nuget_project_folder/$nuget_project_name.csproj"
nuget_filename="$nuget_project_name.$nuget_variant.$build_version.nupkg"
nuget_output_file="$nuget_output_folder/$nuget_filename"

nuget_jars_folder="$nuget_project_folder/Jars"

package_aar_folder="Laerdal.Xamarin.FFmpeg.Android.Source"
package_aar_file_name="mobile-ffmpeg-$package_variant-$github_tag_name.aar"
package_aar_file="$package_aar_folder/$package_aar_file_name"

# Generates variables
echo "build_version = $build_version"
echo ""
echo "github_repo_owner = $github_repo_owner"
echo "github_repo = $github_repo"
echo "github_release_id = $github_release_id"
echo "github_info_file = $github_info_file"
echo "github_tag_name = $github_tag_name"
echo "github_short_version = $github_short_version"
echo ""
echo "package_variant = $package_variant"
echo "package_libraries = $package_libraries"
echo "package_aar_folder = $package_aar_folder"
echo "package_aar_file_name = $package_aar_file_name"
echo "package_aar_file = $package_aar_file"
echo ""
echo "nuget_variant = $nuget_variant"
echo "nuget_project_folder = $nuget_project_folder"
echo "nuget_output_folder = $nuget_output_folder"
echo "nuget_project_name = $nuget_project_name"
echo "nuget_jars_folder = $nuget_jars_folder"
echo "nuget_csproj_path = $nuget_csproj_path"
echo "nuget_filename = $nuget_filename"
echo "nuget_output_file = $nuget_output_file"

echo ""
echo "### DOWNLOAD GITHUB RELEASE FILES ###"
echo ""

mkdir -p $package_aar_folder

echo "Files matching '$package_aar_file_name' :"
cat $github_info_file | grep "browser_download_url.*$package_aar_file_name" | cut -d : -f 2,3 | tr -d \"

wget_parameters="${wget_parameters} -q" # Quiet
if [ "$verbose" = "1" ]; then
    wget_parameters="${wget_parameters} --show-progress"
fi
wget_parameters="${wget_parameters} -nc"
wget_parameters="${wget_parameters} -P $package_aar_folder"
wget_parameters="${wget_parameters} -i"
wget_parameters="${wget_parameters} -"
echo ""
echo "wget_parameters = $wget_parameters"
cat $github_info_file | grep "browser_download_url.*$package_aar_file_name" | cut -d : -f 2,3 | tr -d \" | wget $wget_parameters

if [ ! -f "$package_aar_file" ]; then
    echo "Failed : Can't find '$package_aar_file'"
    exit 1
fi

echo ""
echo "### COPY AAR FILE ###"
echo ""

echo "Copying $package_aar_file to $nuget_project_folder/Jars/mobile-ffmpeg.aar"
rm -rf $nuget_project_folder/Jars/mobile-ffmpeg.aar
mkdir -p $nuget_project_folder/Jars/
cp $package_aar_file $nuget_project_folder/Jars/mobile-ffmpeg.aar

echo ""
echo "### MSBUILD ###"
echo ""

msbuild_parameters=""
if [ ! "$verbose" = "1" ]; then
    msbuild_parameters="${msbuild_parameters} -nologo -verbosity:quiet"
fi
msbuild_parameters="${msbuild_parameters} -t:Rebuild"
msbuild_parameters="${msbuild_parameters} -restore:True"
msbuild_parameters="${msbuild_parameters} -p:Configuration=Release"
msbuild_parameters="${msbuild_parameters} -p:NugetPackageVariantName=$nuget_variant"
msbuild_parameters="${msbuild_parameters} -p:PackageVersion=$build_version"
msbuild_parameters="${msbuild_parameters} -p:ExternalLibraries=\"$package_libraries\""
echo "msbuild_parameters = $msbuild_parameters"
echo ""

rm -rf $nuget_project_folder/bin
rm -rf $nuget_project_folder/obj
msbuild $nuget_csproj_path $msbuild_parameters

if [ -f "$nuget_output_file" ]; then
    echo "Created :"
    echo "  - $nuget_output_file"
    echo ""
    rm -rf $nuget_project_folder/Jars/mobile-ffmpeg.aar
else
    echo "Failed : Can't find '$nuget_output_file'"
    exit 1
fi