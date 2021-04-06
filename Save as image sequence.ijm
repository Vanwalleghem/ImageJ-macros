dir = getDirectory("Choose a Directory ");
output = getDirectory("Destination Directory to save results");
setBatchMode(true);
counter=1;
find(dir)

function find(dir) { 
	list = getFileList(dir); 
	for (i=0; i<list.length; i++) {           
		if (endsWith(list[i], ")/")) {
			print(dir+list[i]);
			find(""+dir+list[i]);		
		}	
		else if (endsWith(list[i], ".tif")) {
			open(""+dir+list[i]);			
			title1=getTitle();   
			print(title1); 
			newDir=output+"/"+toString(counter)+"/";
			File.makeDirectory(newDir); 
			run("Image Sequence... ", "format=TIFF digits=4 save=["+newDir+toString(title1)+".tif"+"]");
			selectWindow(title1);
			close();
			call("java.lang.System.gc"); 
			counter++;
		}
		
	} 
} 
print("done");
setBatchMode(false);
