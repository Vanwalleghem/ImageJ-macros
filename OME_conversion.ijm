output = getDirectory("Choose Destination Directory to save results");
dir = getDirectory("Choose a Directory ");
setBatchMode(true);
counter=1;
find(dir)


function find(dir) { 
	list = getFileList(dir); 
	for (i=0; i<list.length; i++) {           
		if (endsWith(list[i], ")/")) 
		find(""+dir+list[i]);			
		else if (endsWith(list[i], ".tif")) {
			open(""+dir+list[i]);
			//getDimensions(w, h, channels, slices, frames);
			title1=getTitle();  			
			//title2=replace(title1,".tif",".OME.tif");
			title2="/dir"+toString(counter)+"/";
			title3=replace(title1,".tif","_1_0000.tif");
			run("16-bit");
			//run("OME-TIFF...", "save=["+output+toString(title2)+"] compression=Uncompressed");			
			run("Image Sequence... ", "format=TIFF save=["+output+toString(title2)+toString(title3)+"]");
			selectWindow(title1);			
			close();
			counter++;
		}

	}

}
