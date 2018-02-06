input = getDirectory("Choose a Directory "); 
output = getDirectory("Choose Destination Directory");

//setBatchMode(true);
list = getFileList(input);
for (i = 0; i < list.length; i++) {
	action(input, output, list[i]);
	if (isOpen("Exception")) {
     selectWindow("Exception");
     run("Close");
     }
	call("java.lang.System.gc");
}
setBatchMode(false);

function action(input, output, filename) {
	if (endsWith(filename, ".tif")) {
	open(input + filename);
	title1=getTitle();
	title2="AVG_"+title1;
	run("Z Project...", "projection=[Average Intensity]");
	wait(200); 
	run("moco ", "value=20 downsample_value=1 template=["+toString(title2)+"] stack=["+toString(title1)+"] log=None plot=[No plot]");
	wait(200); 
	selectWindow("New Stack");
	save(output + title1); 
	close("*");
	call("java.lang.System.gc");
	}
}
