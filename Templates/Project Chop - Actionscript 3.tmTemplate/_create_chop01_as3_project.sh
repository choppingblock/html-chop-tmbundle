#!/bin/bash

#-------------------------------------------------------------------------
#
# New AS3 Project 
# Version 5
#
# Updated HTML
# Added funtionality to create the .flv file and update it's profile settings.
#
#-------------------------------------------------------------------------

defaultProjectName="AS3Project.tmproj";
defaultClassPath="org.domain";

#token=$("$DIALOG" nib --load ~/Desktop/Test2.nib --center --model '{ classPath = "bar" }' --parameters '{}');
#"$DIALOG" nib --wait $token;
#"$DIALOG" nib --dispose $token;

fullProjectPath=$(CocoaDialog filesave \
			--text "Please name your project and select a folder to save it into" \
			--title "Create New Project" \
			--with-extensions .tmproj \
			--with-file "$defaultProjectName");

if [ -n "$fullProjectPath" ]; then
	
	fullProjectPath=$(tail -n1 <<<"$fullProjectPath");
	projectName=`basename "$fullProjectPath" ".tmproj"`;
	projectPath=`dirname "$fullProjectPath"`;
	lowercaseProjectName=`echo "$projectName" | tr "[:upper:]" "[:lower:]"`;

	# now ask them what they want the class path to be, this will be used to create default directories
	fullClassPath=$(CocoaDialog standard-inputbox \
				--title "Project Class Path" \
				--text "$defaultClassPath.$lowercaseProjectName" \
				--informative-text "Enter the project class path:");
	
	if [ -n "$fullClassPath" ]; then
		classPath=$(tail -n1 <<<"$fullClassPath");
		classPath=`echo $classPath | tr '.' '/'`;
		classPathDirectory="$projectPath/$projectName/src/$classPath/";
		
		#Create our project directory structure.
		mkdir -p "$projectPath/$projectName/deploy/assets/css";
		mkdir -p "$projectPath/$projectName/deploy/assets/images";	
		mkdir -p "$projectPath/$projectName/deploy/assets/js";
		mkdir -p "$projectPath/$projectName/deploy/assets/swf";
		mkdir -p "$projectPath/$projectName/deploy/assets/xml";
		mkdir -p "$projectPath/$projectName/lib";
		mkdir -p "$projectPath/$projectName/src";	
		
		# this recursively creates all source code folders, creating any missing directories along the way
		mkdir -p "$classPathDirectory/ui";
		
		#Gather variables to be substituted.
		TM_NEW_FILE_BASENAME="$projectName";
		
		export TM_NEW_FILE_URI="$projectPath/$projectName/src/$projectName.fla";
		export TM_YEAR=`date "+%Y"`;
		export TM_DATE=`date "+%d.%m.%Y"`;
		
		# Customise file variables for the new project and rename files to match the project name
		perl -pe 's/\$\{([^}]*)\}/$ENV{$1}/g' < "Project.tmproj.xml" > "$projectPath/$projectName/$projectName.tmproj";
		perl -pe 's/\$\{([^}]*)\}/$ENV{$1}/g' < "index.html" > "$projectPath/$projectName/deploy/index.html";
		perl -pe 's/\$\{([^}]*)\}/$ENV{$1}/g' < "index_fullscreen.html" > "$projectPath/$projectName/deploy/index_fullscreen.html";
		perl -pe 's/\$\{([^}]*)\}/$ENV{$1}/g' < "Project-config.xml" > "$projectPath/$projectName/src/$projectName-config.xml";
		perl -pe 's/\$\{([^}]*)\}/$ENV{$1}/g' < "Project.as" > "$projectPath/$projectName/src/$projectName.as";
		perl -pe 's/\$\{([^}]*)\}/$ENV{$1}/g' < "Project.fla" > "$projectPath/$projectName/src/$projectName.fla";
		perl -pe 's/\$\{([^}]*)\}/$ENV{$1}/g' < "project.xml" > "$projectPath/$projectName/deploy/assets/xml/projectData.xml";
		perl -pe 's/\$\{([^}]*)\}/$ENV{$1}/g' < "configPublishProfileSettings.jsfl" > "$projectPath/$projectName/configPublishProfileSettings.jsfl";
		
		# cp for run project command compatibility
		# cp "$projectPath/$projectName/deploy/index.html" "$projectPath/$projectName/deploy/$projectName.html";
		
		#Copy static files.
		cp "expressInstall.swf" "$projectPath/$projectName/deploy/assets/swf/expressInstall.swf";
		cp "swfobject.js" "$projectPath/$projectName/deploy/assets/js/swfobject.js";
		cp "ie_lt8_fixes.css" "$projectPath/$projectName/deploy/assets/css/ie_lt8_fixes.css";
		cp "print.css" "$projectPath/$projectName/deploy/assets/css/print.css";
		# cp "reset-min.css" "$projectPath/$projectName/deploy/assets/css/reset-min.css";
		cp "styles.css" "$projectPath/$projectName/deploy/assets/css/styles.css";
		

		# Run the config jsfl file
		# osascript -e 'tell application "Adobe Flash CS5" to open posix file "$projectPath/$projectName/configPublishProfileSettings.jsfl"';
		open -a "/Applications/Adobe Flash CS5/Adobe Flash CS5.app" "$projectPath/$projectName/configPublishProfileSettings.jsfl";
		
		# Open the project in TextMate
		open -a "TextMate.app" "$projectPath/$projectName/$projectName.tmproj";
		
	fi

fi