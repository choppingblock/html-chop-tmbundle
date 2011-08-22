// fileURI is the full path to the Flash file
// asVersion is 2 or 3
function setPublishProfileSettings(fileURI)
{
	
		//fl.trace( "setPublishProfileSettings" );
		//fl.trace( "fileURI is " + fileURI );
		//fl.trace( "fl.fileExists(fileURI) is " + fl.fileExists(fileURI) );
		
        // does flash file exist
        if (fl.fileExists(fileURI))
        {
                var xml, from, to, delta;
				var asVersion = 3;

                // open the flash file
                fl.openDocument(fileURI);

                // separate the file name from its folder path
                var fileName = fileURI.split("/").pop();
				//fl.trace( "fileName is " + fileName );
                var folderPath = fileURI.split(fileName)[0]/*.join("/")*/;
				//fl.trace( "folderPath is " + folderPath );
                fileName = fileName.split(".")[0];

                // export the profile and read it in
                var pPath = folderPath + "/_Profile_.xml";
                fl.getDocumentDOM().exportPublishProfile(pPath);
                xml = FLfile.read(pPath);

                // override default names to 0
                from = xml.indexOf("<defaultNames>");
                to = xml.indexOf("</defaultNames>");
                delta = xml.substring(from, to);
                xml = xml.split(delta).join("<defaultNames>0");

                // override flash default name to 0
                from = xml.indexOf("<flashDefaultName>");
                to = xml.indexOf("</flashDefaultName>");
                delta = xml.substring(from, to);
                xml = xml.split(delta).join("<flashDefaultName>0");

                // replace the publish path for swf
                from = xml.indexOf("<flashFileName>");
                to = xml.indexOf("</flashFileName>");
                delta = xml.substring(from, to);
                var parentPath = "../";
                if (fileName.indexOf("/") > -1)
                {
                        var splitPath = fileName.split("/");
                        splitPath.length--;
                        var i = splitPath.length;
                        while (i--)
                        {
                                parentPath += "../";
                        }
                }
                xml = xml.split(delta).join("<flashFileName>" + parentPath + "deploy/" + fileName + ".swf");

                // and the rest
                var types = {};
                types.generatorFileName = "swt";
                types.projectorWinFileName = "exe";
                types.projectorMacFileName = "hqx";
                types.htmlFileName = "html";
                types.gifFileName = "gif";
                types.jpegFileName = "jpg";
                types.pngFileName = "png";
                types.qtFileName = "mov";
                types.rnwkFileName = "smil";

                for (var n in types) 
				{
					from = xml.indexOf("<" + n + ">");
					to = xml.indexOf("</" + n + ">");
					if (from > -1 && to > -1)
					{
						delta = xml.substring(from, to);
						xml = xml.split(delta).join("<" + n + ">" + fileName + "." + types[n]);
					}
				}

				// add the document class
				from = xml.indexOf("<DocumentClass>");
                to = xml.indexOf("</DocumentClass>");
                delta = xml.substring(from, to);
                xml = xml.split(delta).join("<DocumentClass>" + fileName);
				
				/*
                // make sure package paths look in ./classes, and classes export in frame 1
                from = xml.indexOf("<ActionScriptVersion>");
                to = xml.indexOf("</ActionScriptVersion>");
                delta = xml.substring(from, to);
                xml = xml.split(delta).join("<ActionScriptVersion>" + asVersion);

                from = xml.indexOf("<PackageExportFrame>");
                to = xml.indexOf("</PackageExportFrame>");
                delta = xml.substring(from, to);
                xml = xml.split(delta).join("<PackageExportFrame>1");

                // set package paths based on AS version
                if (asVersion == 2)
                {
                        from = xml.indexOf("<PackagePaths>");
                        to = xml.indexOf("</PackagePaths>");
                }
                else
                {
                        from = xml.indexOf("<AS3PackagePaths>");
                        to = xml.indexOf("</AS3PackagePaths>");
                }
                delta = xml.substring(from, to);
                var classPath = "./";
                if (fileName.indexOf("/") > -1)
                {
                        classPath = "";
                        var splitPath = fileName.split("/");
                        splitPath.length--;
                        var i = splitPath.length;
                        while (i--)
                        {
                                classPath += "../";
                        }
                }
                if (asVersion == 2)
                {
                        xml = xml.split(delta).join("<PackagePaths>" + classPath + "classes");
                }
                else
                {
                        xml = xml.split(delta).join("<AS3PackagePaths>" + classPath + "classes");
                }
				*/

                // write the modified profile and import it
                FLfile.write(pPath, xml);
                fl.getDocumentDOM().importPublishProfile(pPath);

                // save and publish the fla
                fl.saveDocument(fl.getDocumentDOM(), fileURI);
                fl.getDocumentDOM().publish();

                // delete the publish profile xml (no longer needed)
                FLfile.remove(pPath);
				FLfile.remove(folderPath + "/configPublishProfileSettings.jsfl");

        }
}

// run
setPublishProfileSettings( "file://${TM_NEW_FILE_URI}");