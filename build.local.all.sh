#!/bin/bash

clean_output=0
build_revision=`date +%-m%d.%-H%M%S`
nuget_project_name="Laerdal.Xamarin.FFmpeg.Android"
nuget_output_folder="$nuget_project_name.Output"

usage(){
    echo "### Wrong parameters ###"
    echo "usage: ./build.local.all.sh [-r build_revision] [-c|--clean-output]"
}

while [ "$1" != "" ]; do
    case $1 in
        -r | --revision )       shift
                                build_revision=$1
                                ;;
        -c | --clean-output )   clean_output=1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

if [ $clean_output = 1 ]; then
    echo ""
    echo "### CLEANING OUTPUT ###"
    echo ""

    rm -rf $nuget_output_folder
    echo "Deleted : $nuget_output_folder"
fi

for package_variant in audio full full-gpl https https-gpl min min-gpl video
do 
    . ./build.local.sh --package $package_variant --revision $build_revision
done