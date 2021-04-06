close("*");
input = getDirectory("Choose a Directory "); 
output = getDirectory("Choose Destination Directory");

list = getFileList(input);
for (i = 0; i < list.length; i++) {	
	action(input, output, list[i]);
	if (isOpen("Exception")) {
     selectWindow("Exception");
     run("Close");
     }
}


function action(input, output, filename) {
	if (endsWith(filename, ".tif") && startsWith(filename, "G") )  {
	open(input + filename);
	title1=getTitle(); 
	run("Z Project...", "stop=200 projection=[Average Intensity]");
	wait(300);
	selectWindow("AVG_"+title1);
	saveAs("Tiff", output+"AVG_"+title1);
	run("Morphological Segmentation");
	wait(600);
	call("inra.ijpb.plugins.MorphologicalSegmentation.setInputImageType", "object");
	call("inra.ijpb.plugins.MorphologicalSegmentation.setGradientRadius", "1");
	call("inra.ijpb.plugins.MorphologicalSegmentation.segment", "tolerance=20", "calculateDams=true", "connectivity=4");
	call("inra.ijpb.plugins.MorphologicalSegmentation.setDisplayFormat", "Catchment basins");
	wait(3000);
	call("inra.ijpb.plugins.MorphologicalSegmentation.createResultImage");
	title2=replace(title1,".tif","-catchment-basins.tif");
	wait(600);
	selectWindow("AVG_"+title2);
	run("Remove Largest Label");
	run("Kill Borders");
	run("Label Size Opening", "min=8");
	saveAs("Tiff", output+"Mask_"+title1);
	close("*");
	}
}
