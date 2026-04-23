macro "CropClearSaveasTiff [F2]" { 
title1=getTitle();
run("Crop");
run("Nrrd ... ", "nrrd="+title1);
close();
}