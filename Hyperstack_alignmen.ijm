title1=getTitle();
output = getDirectory("Choose Save Directory");
getDimensions(w, h, channels, slices, frames);
setBatchMode(true); 
for (i=1; i<=slices; i++) {
	Stack.setSlice(i);
	run("Reduce Dimensionality...", "frames keep");
	//setTool("rectangle");
	//waitForUser("select region to register against - Use a rectangle ROI"); //if you always use the same region, you can move this out of the loop to define it at the beginning
	//getSelectionBounds(x0, y0, width, height);
	//run("Align slices in stack...", "method=5 windowsizex="+toString(width)+" windowsizey="+toString(height)+" x0="+toString(x0)+" y0="+toString(y0)+" swindow=0 subpixel=true itpmethod=0 ref.slice=1 show=true");
	saveAs("Tiff", output+"Slice"+toString(i)+"_"+title1);
	selectWindow(title1);
	close("\\Others");
}
setBatchMode(false);
