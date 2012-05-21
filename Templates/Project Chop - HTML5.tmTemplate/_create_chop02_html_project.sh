#!/bin/bash

#-------------------------------------------------------------------------
#
# New HTML Project 
# Version 1
#
# Initial build of HTML project.
#
#-------------------------------------------------------------------------

defaultProjectName="HTML5Project.tmproj";
defaultClassPath="org.domain";

fullProjectPath=$(CocoaDialog filesave \
			--text "Please name your project and select a folder to save it into" \
			--title "Create New Project" \
			--with-extensions .tmproj \
			--with-file "$defaultProjectName");

if [ -n "$fullProjectPath" ]; then
	
	fullProjectPath=$(tail -n1 <<<"$fullProjectPath");
	projectName=`basename "$fullProjectPath" ".tmproj"`;
	projectPath=`dirname "$fullProjectPath"`;

	#Create our project directory structure.
	mkdir -p "$projectPath/$projectName/assets/css";
	mkdir -p "$projectPath/$projectName/assets/images";	
	mkdir -p "$projectPath/$projectName/assets/js";
	mkdir -p "$projectPath/$projectName/assets/js/libs";
	mkdir -p "$projectPath/$projectName/assets/swf";
	mkdir -p "$projectPath/$projectName/assets/xml";	
	
	# this recursively creates all source code folders, creating any missing directories along the way
	# mkdir -p "$classPathDirectory/ui";
	
	#Gather variables to be substituted.
	TM_NEW_FILE_BASENAME="$projectName";
	
	# export TM_NEW_FILE_URI="$projectPath/$projectName/src/$projectName.fla";
	export TM_YEAR=`date "+%Y"`;
	export TM_DATE=`date "+%d.%m.%Y"`;
	
	# Customise file variables for the new project and rename files to match the project name
	perl -pe 's/\$\{([^}]*)\}/$ENV{$1}/g' < "Project.tmproj.xml" > "$projectPath/$projectName/$projectName.tmproj";
	perl -pe 's/\$\{([^}]*)\}/$ENV{$1}/g' < "index.html" > "$projectPath/$projectName/index.html";
	
	# cp for run project command compatibility
	# cp "$projectPath/$projectName/deploy/index.html" "$projectPath/$projectName/deploy/$projectName.html";
	
	#Copy static files.
	cp "404.html" "$projectPath/$projectName/404.html";
	cp "apple-touch-icon-57x57-precomposed.png" "$projectPath/$projectName/apple-touch-icon-57x57-precomposed.png";
	cp "apple-touch-icon-72x72-precomposed.png" "$projectPath/$projectName/apple-touch-icon-72x72-precomposed.png";
	cp "apple-touch-icon-114x114-precomposed.png" "$projectPath/$projectName/apple-touch-icon-114x114-precomposed.png";
	cp "apple-touch-icon-precomposed.png" "$projectPath/$projectName/apple-touch-icon-precomposed.png";
	cp "apple-touch-icon.png" "$projectPath/$projectName/apple-touch-icon.png";
	cp "crossdomain.xml" "$projectPath/$projectName/crossdomain.xml";
	cp "handheld.css" "$projectPath/$projectName/assets/css/handheld.css";
	cp "style.css" "$projectPath/$projectName/assets/css/style.css";
	cp "favicon.ico" "$projectPath/$projectName/favicon.ico";
	cp "humans.txt" "$projectPath/$projectName/humans.txt";
	cp "dd_belatedpng.js" "$projectPath/$projectName/assets/js/libs/dd_belatedpng.js";
	cp "jquery-1.5.1.js" "$projectPath/$projectName/assets/js/libs/jquery-1.7.2.min.js";
	cp "modernizr-1.7.min.js" "$projectPath/$projectName/assets/js/libs/modernizr-2.5.3.js";
	cp "plugins.js" "$projectPath/$projectName/assets/js/plugins.js";
	cp "script.js" "$projectPath/$projectName/assets/js/script.js";
	cp "robots.txt" "$projectPath/$projectName/robots.txt";
		
	# Open the project in TextMate
	open -a "TextMate.app" "$projectPath/$projectName/$projectName.tmproj";
		
fi