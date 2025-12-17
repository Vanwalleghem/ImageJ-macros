input = getDirectory("Input Directory "); 
output = getDirectory("Destination Directory");
setBatchMode(true);
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
	title2=replace(title1,".tif","_resized.nrrd");
	//title2=title1+"_resized";
	run("Size...", "width=512 height=512 depth=174 constrain average interpolation=Bilinear");	
	wait(200); 
	run("Nrrd ... ", "nrrd="+output + title2);	
	close("*");
	}
}