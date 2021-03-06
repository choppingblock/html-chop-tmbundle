#!/bin/bash

#-------------------------------------------------------------------------
#
# New Basic jQuery HTML Project 
# Version 0.1
# Created: June 20, 2013
# Creator: Matthew Richmond
#
# Initial build of HTML project.
#
#-------------------------------------------------------------------------

defaultProjectName="HTML5Basic_jQueryProject.tmproj";
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
	mkdir -p "$projectPath/$projectName/assets";
	mkdir -p "$projectPath/$projectName/assets/css";
	mkdir -p "$projectPath/$projectName/assets/images";	
	mkdir -p "$projectPath/$projectName/assets/js";	
	
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
	cp "styles.css" "$projectPath/$projectName/assets/css/styles.css";
	cp "jquery-1.10.1.min.js" "$projectPath/$projectName/assets/js/jquery-1.10.1.min.js";
		
	# Open the project in TextMate
	open -a "TextMate.app" "$projectPath/$projectName/$projectName.tmproj";
		
fi