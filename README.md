# Chopping Block TextMate Bundle for HTML Development

To download and install the zipped files:

	# Download the files using the *ZIP* button above.
	## If possible you might have to tell your browser to NOT automatically unzip your downloads, you want the zipped archive.
	# Rename the downloaded file (html-chop-tmbundle-master.zip) to be html-chop.tmbundle
	# Install TextMate <http://macromates.com>
	# If you opened it: Close TextMate
	# Locate the "Application Support" folder
	## [hard drive]:Users:[username]:Library:Application Support
	## if you need help getting to the Library folder, hit Shift-Command-G and enter "~/Library"
	# If you do not already have a TextMate folder there, make one.
	# If you do not already have a Bundles folder inside the TextMate folder, make one.
	# Open TextMate, you should now have the "HTML Chop" bundle installed. You can fid it at: File > New From Template > HTML Chop
	

To install with Git:

    mkdir -p ~/Library/Application\ Support/TextMate/Bundles
    cd ~/Library/Application\ Support/TextMate/Bundles
    git clone git://github.com/choppingblock/html-chop-tmbundle.git "HTML Chop.tmbundle"
    osascript -e 'tell app "TextMate" to reload bundles'


To install without Git:

    mkdir -p ~/Library/Application\ Support/TextMate/Bundles
    cd ~/Library/Application\ Support/TextMate/Bundles
    wget http://github.com/choppingblock/html-chop-tmbundle/tarball/master
    tar zxf choppingblock-html-chop-tmbundle*.tar.gz
    rm choppingblock-html-chop-tmbundle*.tar.gz
    mv choppingblock-html-chop-tmbundle* "HTML Chop.tmbundle"
    osascript -e 'tell app "TextMate" to reload bundles'
