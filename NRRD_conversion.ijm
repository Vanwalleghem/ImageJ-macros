output = getDirectory("Choose Destination Directory to save results");
dir = getDirectory("Choose a Directory ");
setBatchMode(true);
find(dir)

function find(dir) { 
	list = getFileList(dir); 
	for (i=0; i<list.length; i++) {           
		if (endsWith(list[i], ")/")) 
		find(""+dir+list[i]);			
		else if (endsWith(list[i], ".tif")) {
			open(""+dir+list[i]);
			getDimensions(w, h, channels, slices, frames);
			title1=getTitle();  
			run("Properties...", "channels=1 slices="+toString(slices)+" frames=1 unit=micron pixel_width=1.5 pixel_height=1.5 voxel_depth=10 global");
			title2=replace(title1,".tif",".nrrd");
			run("Nrrd ... ", "nrrd="+output+toString(title2));
			selectWindow(title1);			
			close();
		}

	}

}