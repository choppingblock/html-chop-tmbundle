#!/bin/bash

#-------------------------------------------------------------------------
#
# New HTML Project 
# Version 1
#
# Initial build of HTML project.
#
#-------------------------------------------------------------------------

defaultProjectName="HTML5BasicProject.tmproj";
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
	mkdir -p "$projectPath/$projectName/images";	
	
	
	#Gather variables to be substituted.
	TM_NEW_FILE_BASENAME="$projectName";
	
	export TM_YEAR=`date "+%Y"`;
	export TM_DATE=`date "+%d.%m.%Y"`;
	
	# Customise file variables for the new project and rename files to match the project name
	perl -pe 's/\$\{([^}]*)\}/$ENV{$1}/g' < "Project.tmproj.xml" > "$projectPath/$projectName/$projectName.tmproj";
	perl -pe 's/\$\{([^}]*)\}/$ENV{$1}/g' < "index.html" > "$projectPath/$projectName/index.html";
	
	# cp for run project command compatibility
	# cp "$projectPath/$projectName/deploy/index.html" "$projectPath/$projectName/deploy/$projectName.html";
	
	#Copy static files.
	#cp "ie_lt8_fixes.css" "$projectPath/$projectName/assets/css/ie_lt8_fixes.css";
	#cp "print.css" "$projectPath/$projectName/assets/css/print.css";
	cp "styles.css" "$projectPath/$projectName/styles.css";
	

	cd "$projectPath/$projectName/";
	git init;
	git add *;
	git commit -m "Initial project version";
	
	# Open the project in TextMate
	open -a "TextMate.app" "$projectPath/$projectName/$projectName.tmproj";
		
fi