input = getDirectory("Choose a Directory "); 
output = getDirectory("Choose Destination Directory");

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
	if (endsWith(filename, ".tif") && startsWith(filename,"AVG_")){
	open(input + filename);
	run("Median...", "radius=1");
	run("Enhance Contrast", "saturated=0.35");
	run("8-bit");	
	setMinAndMax(0, 360);
	run("Apply LUT");
	title1=getTitle();	
	//title1=getTitle();
title2="_Kmeans__"+substring(title1,4);
//title2="Final_"+substring(title1,4);
//title2="Neo_CTRL_"+substring(title1,4);
//title2="Bianco_"+substring(title1,4);
open(input + title2);
run("Descriptor-based registration (2d/3d)", "first_image=["+toString(title2)+"] second_image=["+toString(title1)+"] brightness_of=[Very low] approximate_size=[6 px] type_of_detections=[Maxima only] subpixel_localization=None transformation_model=[Translation (2d)] images_pre-alignemnt=[Not prealigned] number_of_neighbors=6 redundancy=1 significance=3 allowed_error_for_ransac=5 choose_registration_channel_for_image_1=1 choose_registration_channel_for_image_2=1 create_overlayed add_point_rois");
Stack.setDisplayMode("color");
makeRectangle(0, 0, 1280, 1080);
run("Crop");
//setThreshold(129, 255);
setThreshold(129, 255);
run("Convert to Mask", "method=Default background=Default black");
//title3="Fused "+substring(title2,0,lengthOf(title2)-4)+" & "+substring(title1,0,lengthOf(title1)-4);
//title3="Fused "+substring(title2,0,24)+" & "+substring(title1,0,11);
//title3="Fused "+substring(title2,0,16)+" & "+substring(title1,0,11); //AVG_GCaMP6f - 8freq - F5_100
//For the test serial
//title3="Fused "+substring(title2,0,19)+" & "+substring(title1,0,14);
title3 = title1;
index=indexOf(title3," ");
if (index>-1)
	title3 = substring(title1, 0, index);
index=lastIndexOf(title3,".");
if (index>0)
	title3 = substring(title3,0,index);
//title2="Bianco_"+substring(title3,4);
title2="_Kmeans__"+substring(title3,4);
title3="Fused "+title2+" & "+title3;
run("Split Channels");
selectWindow(title1);
run("Merge Channels...", "c1=[C1-"+toString(title3)+"] c2=[C2-"+toString(title3)+"] c3=[C3-"+toString(title3)+"] c4=["+toString(title1)+"] create");
//waitForUser("save as tiff");
saveAs("Tiff",output + "FinalRegistered_" +title1); 
close("*");	
	}
}

