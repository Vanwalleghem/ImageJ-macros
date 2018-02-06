dir = getDirectory("Choose a Directory ");
setBatchMode(true);
find(dir);
setBatchMode(false);

 function find(dir) { 
      list = getFileList(dir); 
      for (i=0; i<list.length; i++) {           
			if (endsWith(list[i], ".tif") & startsWith(list[i], "Zbrain")) { 
              open(""+dir+list[i]);              
              run("Size...", "width=960 height=810 depth=25 constrain average interpolation=Bilinear");              
              title1=list[i];
				title2=replace(list[i],"HS_mean","resized");
				title2=replace(title2,"hs_mean","resized");
			  save(dir + title2);
			  close();
			  print(list[i]);
			  print(title2);
          } 
      } 
  } 
