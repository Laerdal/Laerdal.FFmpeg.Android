# Laerdal.Xamarin.FFmpeg.Android

> Xamarin.iOS package : <https://github.com/Laerdal/Laerdal.Xamarin.FFmpeg.iOS>
>
> Xamarin.Forms package : <https://github.com/Laerdal/Laerdal.Xamarin.FFmpeg>

Xamarin binding library around @tanersener's Mobile-FFmpeg library.

The native Android library can be found here: <https://github.com/tanersener/mobile-ffmpeg>

| Mobile FFmpeg Package | Laerdal.Xamarin.FFmpeg.Android |
|     :----    |     :----:    |
| Audio | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Audio)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Audio/) |
| Full | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Full)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Full/) |
| Full.Gpl | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Full.Gpl)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Full.Gpl/) |
| Https | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Https)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Https/) |
| Https.Gpl | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Https.Gpl)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Https.Gpl/) |
| Min | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Min)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Min/) |
| Min.Gpl | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Min.Gpl)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Min.Gpl/) |
| Video | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Video)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Video/) |

## External libraries

| Package | External libraries |
|     :----    | :----: |
| Audio | lame libilbc libvorbis opencore-amr opus shine soxr speex twolame vo-amrwbenc wavpack |
| Full | fontconfig freetype fribidi gmp gnutls kvazaar lame libaom libass libiconv libilbc libtheora libvorbis libvpx libwebp libxml2 opencore-amr opus shine snappy soxr speex twolame vo-amrwbenc wavpack |
| Full.Gpl | fontconfig freetype fribidi gmp gnutls kvazaar lame libaom libass libiconv libilbc libtheora libvorbis libvpx libwebp libxml2 opencore-amr opus shine snappy soxr speex twolame vid.stab vo-amrwbenc wavpack x264 x265 xvidcore |
| Https | gmp gnutls |
| Https.Gpl | gmp gnutls vid.stab x264 x265 xvidcore |
| Min | - |
| Min.Gpl | vid.stab x264 x265 xvidcore |
| Video | fontconfig freetype fribidi kvazaar libaom libass libiconv libtheora libvpx libwebp snappy |

## Folder structure

- Laerdal.Xamarin.FFmpeg.Android = Xamarin Java Binding Library project and nuget files
- Laerdal.Xamarin.FFmpeg.Android.Source = Source files from Github release
- Laerdal.Xamarin.FFmpeg.Android.Output = Build output from building *Laerdal.Xamarin.FFmpeg.Android*

## Local build

### Requirements

You'll need :

- Windows or Mac
  - with **gradle**
  - with **Xamarin.Android** (obviously)

### Steps to build

#### 1) Checkout

```bash
git clone https://github.com/Laerdal/Laerdal.Xamarin.FFmpeg.Android.git
```

#### 2) Run build script

Usage:

```bash
./build.sh [-p|--package [audio|full|full-gpl|https|https-gpl|min|min-gpl|video]] [-r|--revision build_revision] [-c|--clean-output] [-v|--verbose]
```

Parameters:

- -p | --package [audio|full|full-gpl|https|https-gpl|min|min-gpl|video]
  - Multiple -p paramaters can be added.
  - Everything will be built if no -p parameter is used.
  - See <https://github.com/tanersener/mobile-ffmpeg> for more information
- -r | --revision [build_revision]
  - Sets the revision number, default = mdd.hMMSS
- -c | --clean-output
  - Cleans the output before building
- -v | --verbose
  - Enable verbose build details from msbuild tasks
- -h | --help
  - Prints this message

To build only full and full-gpl, clean the output and run objective sharpie to update the ApiDefinitions :

```bash
./build.sh -p full -p full-gpl -c -s
```

To build everything :

```bash
./build.sh
```

#### Other scripts

- `./download.sh`
  - Downloads all the Github release files that would be needed in build.
