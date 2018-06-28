echo "Enter the name of the application icon you are building: "
read file

mkdir $file.iconset
mv *.png $file.iconset
iconutil -c icns $file.iconset
rm -rf $file.iconset
