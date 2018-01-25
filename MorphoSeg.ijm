//This script requires the morphological segmentation plugin from http://imagej.net/MorphoLibJ

close("*");
input = getDirectory("Choose a Directory to read from"); //put in the average (or max) intensity projections of your time series. This is also only for 2D data
output = getDirectory("Choose Destination Directory to save results");

list = getFileList(input);
for (i = 0; i < list.length; i++) {	
	action(input, output, list[i]);
	if (isOpen("Exception")) {
     selectWindow("Exception");
     run("Close");
     }
}

function action(input, output, filename) {
	if (endsWith(filename, ".tif") )  { //by default reads all tif files, you can also refine the automated choice by adding : && startsWith(filename, "Whatever")
	open(input + filename);
	title1=getTitle(); 
	//run("Z Project...", "stop=200 projection=[Average Intensity]");    //Uncomment these if you are reading time series and not the average projection
	//wait(300);
	//selectWindow("AVG_"+title1);
	//saveAs("Tiff", output+"AVG_"+title1);
	run("Select All");
	run("Measure");
	mean = getResult('Mean', nResults-1);
	max = getResult('Max', nResults-1);
	tolerance=(max-mean)/50; //Automatically choose a tolerance that works well enough in my opinion. You can play around with the ratio or define a given tolerance
	tolerance=floor(tolerance);	
	run("Morphological Segmentation");
	wait(600);
	call("inra.ijpb.plugins.MorphologicalSegmentation.setInputImageType", "object");
	call("inra.ijpb.plugins.MorphologicalSegmentation.setGradientRadius", "1");
	call("inra.ijpb.plugins.MorphologicalSegmentation.segment", "tolerance="+toString(tolerance)+"", "calculateDams=true", "connectivity=4");
	call("inra.ijpb.plugins.MorphologicalSegmentation.setDisplayFormat", "Catchment basins");
	wait(3000);
	call("inra.ijpb.plugins.MorphologicalSegmentation.createResultImage");
	title2=replace(title1,".tif","-catchment-basins.tif");
	wait(600);	
	selectWindow(title2);
	//selectWindow("AVG_"+title2); //same as above, if not reading average intensity projections, uncomment this and comment the line above
	run("Remove Largest Label"); //usually is the background
	run("Kill Borders");
	run("Label Size Opening", "min=8"); //define a minimum size for your neurons to avoid too small areas being there.
	saveAs("Tiff", output+"Mask_"+title1);
	close("*");
	}
}