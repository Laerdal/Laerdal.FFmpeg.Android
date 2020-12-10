# Laerdal.Xamarin.FFmpeg.Android

Xamarin binding library around @tanersener's Mobile-FFmpeg library. The native Android library is located here: https://github.com/tanersener/mobile-ffmpeg

Mobile FFmpeg Package | Laerdal.Xamarin.FFmpeg.iOS | Laerdal.Xamarin.FFmpeg.Android |
|     :----    |     :----:    |     :----:    |
Full | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.iOS.Full)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.iOS.Full/) | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Full)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Full/) |
Full.Gpl | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.iOS.Full.Gpl)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.iOS.Full.Gpl/) | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Full.Gpl)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Full.Gpl/) |
Https | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.iOS.Https)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.iOS.Https/) | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Https)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Https/) |
Https.Gpl | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.iOS.Https.Gpl)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.iOS.Https.Gpl/) | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Https.Gpl)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Https.Gpl/) |
Min | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.iOS.Min)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.iOS.Min/) | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Min)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Min/) |
Min.Gpl | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.iOS.Min.Gpl)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.iOS.Min.Gpl/) | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Min.Gpl)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Min.Gpl/) |
Video | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.iOS.Video)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.iOS.Video/) | [![NuGet Badge](https://buildstats.info/nuget/Laerdal.Xamarin.FFmpeg.Android.Video)](https://www.nuget.org/packages/Laerdal.Xamarin.FFmpeg.Android.Video/) |

## Folder structure

- Laerdal.Xamarin.FFmpeg.Android = Xamarin Java Binding Library project and nuget files
- Laerdal.Xamarin.FFmpeg.Android.Output = Build output from building *Laerdal.Xamarin.Dfu.Android*

## Local build

### Requirements

You'll need :

- Windows or Mac
  - with **gradle**
  - with **Xamarin.Android** (obviously)

### Steps to build

#### 1) Checkout

```bash
git clone https://github.com/Laerdal/Laerdal.Xamarin.Dfu.Android.git
```

#### 2) Download latest Release from [tanersener/mobile-ffmpeg](https://github.com/tanersener/mobile-ffmpeg/releases)

```bash
./download.sh
```

#### 3) Build all Nuget packages

```bash
./build.sh
```