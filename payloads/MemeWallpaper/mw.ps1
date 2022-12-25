function Set-Wallpaper {
    param (
        [string]$Path,
        [ValidateSet('Tile', 'Center', 'Stretch', 'Fill', 'Fit', 'Span')]
        [string]$Style = 'Fill'
    )

    begin {
        try {
            Add-Type @"
                using System;
                using System.Runtime.InteropServices;
                using Microsoft.Win32;
                namespace Wallpaper
                {
                    public enum Style : int
                    {
	                    Tile, Center, Stretch, Fill, Fit, Span, NoChange
                    }

                    public class Setter
                    {
	                    public const int SetDesktopWallpaper = 20;
	                    public const int UpdateIniFile = 0x01;
	                    public const int SendWinIniChange = 0x02;
	                    [DllImport( "user32.dll", SetLastError = true, CharSet = CharSet.Auto )]
	                    private static extern int SystemParametersInfo ( int uAction, int uParam, string lpvParam, int fuWinIni );
	                    public static void SetWallpaper ( string path, Wallpaper.Style style )
                        {
		                    SystemParametersInfo( SetDesktopWallpaper, 0, path, UpdateIniFile | SendWinIniChange );
		                    RegistryKey key = Registry.CurrentUser.OpenSubKey( "Control Panel\\Desktop", true );
		                    switch( style )
		                    {
			                    case Style.Tile :
			                    key.SetValue( @"WallpaperStyle", "0" ) ;
			                    key.SetValue( @"TileWallpaper", "1" ) ;
			                    break;
			                    case Style.Center :
			                    key.SetValue( @"WallpaperStyle", "0" ) ;
			                    key.SetValue( @"TileWallpaper", "0" ) ;
			                    break;
			                    case Style.Stretch :
			                    key.SetValue( @"WallpaperStyle", "2" ) ;
			                    key.SetValue( @"TileWallpaper", "0" ) ;
			                    break;
			                    case Style.Fill :
			                    key.SetValue( @"WallpaperStyle", "10" ) ;
			                    key.SetValue( @"TileWallpaper", "0" ) ;
			                    break;
			                    case Style.Fit :
			                    key.SetValue( @"WallpaperStyle", "6" ) ;
			                    key.SetValue( @"TileWallpaper", "0" ) ;
			                    break;
			                    case Style.Span :
			                    key.SetValue( @"WallpaperStyle", "22" ) ;
			                    key.SetValue( @"TileWallpaper", "0" ) ;
			                    break;
			                    case Style.NoChange :
			                    break;
		                    }
		                    key.Close();
	                    }
                    }
                }
"@
        } catch {}

        $StyleNum = @{
            Tile = 0
            Center = 1
            Stretch = 2
            Fill = 3
            Fit = 4
            Span = 5
        }
    }

    process {
        [Wallpaper.Setter]::SetWallpaper($Path, $StyleNum[$Style])
        sleep -Milliseconds 200
        [Wallpaper.Setter]::SetWallpaper($Path, $StyleNum[$Style])
    }
}

$response = iwr "https://meme-api.com/gimme"
$image = ($response.Content | ConvertFrom-Json).url
$file = Split-Path -Path $image -Leaf
$extension = [System.IO.Path]::GetExtension($file)
$filename = $env:TEMP + "\" + "meme" + $extension
iwr $image -OutFile $filename
Set-Wallpaper -Path $filename -Style Tile