This bash script downloads the .mp3 files (and one .m4a file, the first song of the fourth book - 4-01.m4a) of the songs in the songbooks 1-4 of "Lasst uns singen". (Given the initiative does not change anything about their set-up regarding where the source files are and how accessible they are. ;-) )

The script creates four directories (one for each songbook) into which the files are downloaded.

If the `create_zip` flag is set to `true`, an (additional) zip file containing all four folders will be created after the downloads are finished.

The folder containing the songs of songbook 1 will have 15 instead of 14 files/songs if `skip_songbook1_song3 is set to `false. 
That is because 1-03.mp3 contains the (culturally and racially insensitive) song "Drei Chinesen mit dem Kontrabass", which does not appear in the player's playlist displayed on the website. 
If you want to skip the download of this song, please set skip_songbook1_song3=true.

The song in audio file 3-23.mp3 ("Spannenlanger Hansel") is not in the songbook either. It is embedded in the audio player and its playlist, though.

The ID3 tags/metadata do not correspond to the file names. For example, song 3-07, "Heile, heile Gänschen" has the title "Titel 10" displayed by my audio player. (Maybe, maybe changing that will be an idea for a script that I could attempt to come up with on another day. Maybe.)
