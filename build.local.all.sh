#!/bin/bash

build_revision=`date +%m%d.%H%M%S`

usage(){
    echo "### Wrong parameters ###"
    echo "usage: ./build.local.all.sh [-r build_revision]"
}

while [ "$1" != "" ]; do
    case $1 in
        -r | --revision )       shift
                                build_revision=$1
                                ;;
        -h | --help )           usage
                                exit
                                ;;
        * )                     usage
                                exit 1
    esac
    shift
done

for package_variant in audio full full-gpl https https-gpl min min-gpl video
do 
    . ./build.local.sh --package $package_variant --revision $build_revision
done