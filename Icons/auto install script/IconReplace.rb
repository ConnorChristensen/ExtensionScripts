require 'fileutils'
require 'sudo'

# this program reads in from a text file in the same directory called paths.txt
# this text file takes the format of one line per app icon
# [icon name]=[path to original icon]

# in the example paths.txt, I have an icon called photoshop.icns, and the file
# path to the original photoshop icon with wild cards included

File.open('./paths.txt', 'r') do |f|
  f.each_line do |line|
    # take off the ending newline and split by the equals sign
    options = line.chomp.split("=")
    # if the path exists on the users machine
    # look for any items in that dir that match the wild cards
    if !Dir.glob(options[1]).empty?
      # get our icon from the wild cards
      Dir.glob(options[1]) do |icon|
        # replace our icon
        Sudo::Wrapper.run do |sudo|
          sudo[FileUtils].cp("#{options[0]}.icns", icon)
        end
      end
    end
  end
end
