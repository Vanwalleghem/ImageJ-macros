input = getDirectory("Choose a Directory "); 
output = getDirectory("Choose Destination Directory");

list = getFileList(input);
for (i = 0; i < list.length; i++) {
	if (i==0){
		open(input + list[i]);
		waitForUser("select region to register against");
		getSelectionBounds(x0, y0, width, height);
		close();
		//setBatchMode(true);
	}
	action(input, output, list[i],x0, y0, width, height);
	if (isOpen("Exception")) {
     selectWindow("Exception");
     run("Close");
     }
     call("java.lang.System.gc");
}
setBatchMode(false);

function action(input, output, filename,x0,y0,width,height) {
	if (endsWith(filename, ".tif")) {
	open(input + filename);
	title1=getTitle(); 
	run("Align slices in stack...", "method=5 windowsizex="+toString(width)+" windowsizey="+toString(height)+" x0="+toString(x0)+" y0="+toString(y0)+" swindow=0 subpixel=true itpmethod=0 ref.slice=1 show=true");
	//save(output + title1); 
	title2="AVG_"+title1;
	run("Z Project...", "projection=[Average Intensity]");
	wait(200);
	//save(output + title2); //optional save of the average intensity projection of the time serie.
	run("moco ", "value=20 downsample_value=1 template=["+toString(title2)+"] stack=["+toString(title1)+"] log=None plot=[No plot]");
	wait(200); 
	selectWindow("New Stack");
	run("Align slices in stack...", "method=5 windowsizex="+toString(width)+" windowsizey="+toString(height)+" x0="+toString(x0)+" y0="+toString(y0)+" swindow=0 subpixel=true itpmethod=0 ref.slice=1 show=true");
	save(output + title1); 
	selectWindow(title2);
	save(output + title2); 
	close("*");
	}
}
