#!/usr/bin/env bash

# If you want to use #!/usr/bin/bash, remove or comment out the first line and use #!/usr/bin/bash instead.


set -euo pipefail # -e is fine since wget is inside an if/else structure, -e is useful for mkdir and zip

# Set this to true in order to to skip 1-03.mp3 (Drei Chinesen mit dem Kontrabass). 
skip_songbook1_song3=false

# Set this to true if you want to create a ZIP file at the end.
create_zip=true


# Creating directories
# Needed because for the downloads for the directory lass_uns_singen_1, wget -P (which would create a folder if it does not exist yet) is not used, unlike for the other three folders.

for folder in lass_uns_singen_1 lass_uns_singen_2 lass_uns_singen_3 lass_uns_singen_4; do
  mkdir -p "$folder"
done


# Downloading audio files for songbook 1.

# If you choose to skip the song, the number will not be skipped when creating the file name, so the filed named 1-04.mp3 in the source will be a file named 1-03.mp3 and so on (consecutive numbers) in your lass_uns_singen_1 directory. Mp3/ID3 metadata about the title will not be changed, though.  
# If a download fails, the number will not be skipped (resulting in non-sequential file numbers). 
# Example: If you set the skip_songbook1_song3 flag to true and the download of the file named 1-05.mp3 in the source succeeds, it will be named 1-04.mp3 in your local lass_uns_singen_1 directory. However, if it fails and the download of the next file (named 1-06.mp3 in source) suceeds, 1-06 will be named 1-05 locally and 1-04 will be missing.


for source_number in $(seq -w 1 15); do

  source_n=$((10#$source_number)) #converting to an integer so that substraction works

  if [[ "$skip_songbook1_song3" == true && "$source_number" == "03" ]]; then
    echo "Skipping 1-${source_number}.mp3 by choice"
    continue
  fi

  url="https://singende-kindergaerten.de/wp-content/uploads/2022/08/1-${source_number}.mp3"

  if [[ "$skip_songbook1_song3" == true && "$source_n" -gt 3 ]]; then
    output_number=$((source_n - 1))
  else
    output_number=$source_n
  fi

  printf -v output_i "%02d" "$output_number"  # converting back to a padded filename string
  output_file="lass_uns_singen_1/1-${output_i}.mp3"

  echo "Downloading $url as $output_file"

  if wget -O "$output_file" "$url"; then
    echo "Downloaded source 1-${source_number}.mp3 as 1-${output_i}.mp3"
  else
    echo "Skipping 1-${source_number}.mp3 — not found or download failed"
    rm -f "$output_file"
  fi
done

echo "Songs downloaded to: lass_uns_singen_1"


# For the next three songbook directories/folders (lass_uns_singen_2, lass_uns_singen_3, lass_uns_singen_4), the numbers in the file names will be the same as the numbering of the files in the source.
# So the following holds, too: If a download fails, the numbers in the file names in your folders/directory will not be sequential.

# Downloading audio files for songbook 2.

for i in $(seq -w 1 19); do
  url="https://singende-kindergaerten.de/wp-content/uploads/2022/08/2_${i}.mp3"

  echo "Downloading $url"

  if wget -P "lass_uns_singen_2" "$url"; then
    echo "Downloaded 2_${i}.mp3"
  else
    echo "Skipping 2_${i}.mp3 — not found or download failed"
  fi
done

echo "Songs downloaded to: lass_uns_singen_2"


# Downloading audio files for songbook 3.

for i in $(seq -w 1 28); do
  url="https://singende-kindergaerten.de/wp-content/uploads/2022/08/3-${i}.mp3"

  echo "Downloading $url"

  if wget -P "lass_uns_singen_3" "$url"; then
    echo "Downloaded 3-${i}.mp3"
  else
    echo "Skipping 3-${i}.mp3 — not found or download failed"
  fi
done

echo "Songs downloaded to: lass_uns_singen_3"


# Downloading audio files for songbook 4.

# 4-01 file is in .m4a format, the rest in .mp3 format like the rest of the audio files

url="https://singende-kindergaerten.de/wp-content/uploads/2022/09/4-01.m4a"

echo "Downloading $url"

if wget -P "lass_uns_singen_4" "$url"; then
  echo "Downloaded 4-01.m4a"
else
  echo "Skipping 4-01.m4a — not found or download failed"
fi

for i in $(seq -w 2 26); do
  url="https://singende-kindergaerten.de/wp-content/uploads/2022/09/4-${i}.mp3"

  echo "Downloading $url"

  if wget -P "lass_uns_singen_4" "$url"; then
    echo "Downloaded 4-${i}.mp3"
  else
    echo "Skipping 4-${i}.mp3 — not found or download failed"
  fi
done

echo "Songs downloaded to: lass_uns_singen_4"
echo "All downloads finished!"


# Create ZIP file if requested (meaning: if create_zip=true)

if [[ "$create_zip" == true ]]; then
  echo "Packing all folders into a ZIP..."

  zip -r lass_uns_singen.zip \
    lass_uns_singen_1 \
    lass_uns_singen_2 \
    lass_uns_singen_3 \
    lass_uns_singen_4

  echo "Done! Created lass_uns_singen.zip"
fi

