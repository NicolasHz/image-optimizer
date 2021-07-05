# image-optimizer
shopt -s globstar;
for i in **/*.jpg; 
do fileName=$(basename "$i")&&
filePath=$(dirname "$i") &&
newFilePath="$filePath"/"${fileName%.*}".compressed.jpg &&
ffmpeg -i "$i" "$newFilePath" && rm -f "$i" &&
mv "$newFilePath" "${newFilePath%%.compressed.jpg}.jpg";
done;

\\ the above should be for jpg and jpeg I need to tweak that regex on the for in loop


shopt -s globstar;
for i in **/*.png; 
do fileName=$(basename "$i") && 
filePath=$(dirname "$i") && 
newFilePath="$filePath"/"${fileName%.*}".compressed.png &&
compressedPalleteFileName="$filePath"/"${fileName%.*}".compressed-pallete.png &&
ffmpeg -i "$i" -vf palettegen=max_colors=256:stats_mode=single -y "$compressedPalleteFileName" &&
ffmpeg -i "$i" -i "$compressedPalleteFileName" -lavfi "[0][1:v] paletteuse" -pix_fmt pal8 -y "$newFilePath" &&
rm -f "$i" "$compressedPalleteFileName" && mv "$newFilePath" "${newFilePath%%.compressed.png}.png";
done;

svgo *.svg -o ../path/to/folder/with/svg/output
