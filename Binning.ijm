close("*");
input = getDirectory("Choose a Directory "); 
output = getDirectory("Choose Destination Directory");

list = getFileList(input);
setBatchMode(true);
for (i = 0; i < list.length; i++) {	
	action(input, output, list[i]);
	if (isOpen("Exception")) {
     selectWindow("Exception");
     run("Close");
     }
}

function action(input, output, filename) {
	if (endsWith(filename, ".tif")) {
	open(input + filename);
	title1=getTitle(); 
	run("Bin...", "x=2 y=2 z=1 bin=Sum");
	saveAs("Tiff", output+"bin_"+title1);
	close("*");
	}
}