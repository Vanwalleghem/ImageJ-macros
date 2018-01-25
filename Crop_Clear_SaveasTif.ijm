macro "CropClearSaveasTiff [F2]" { 
title1=getTitle();

run("Crop");
//run("Clear Outside", "stack");
//saveAs("Tiff", "D:\\temp\\HindBrain\\"+ title1);
save();
/*
run("Enhance Contrast", "saturated=0.35");
run("8-bit");
run("Save");
*/
close();
}