# Chopping Block TextMate Bundle for HTML Development

To download and install the zipped files:

	# Download the files using the *ZIP* button above.



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
