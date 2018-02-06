dir = getDirectory("Choose a Directory ");
find(dir)

 function find(dir) { 
      list = getFileList(dir); 
      for (i=0; i<list.length; i++) {           
          if (endsWith(list[i], "/")) 
              find(""+dir+list[i]); 
          else if (endsWith(list[i], ".tif")) { 
              open(""+dir+list[i]);
              title1=getTitle();
              savename=dir + substring(title1,0,lengthOf(title1)-4) + ".avi";
              run("AVI... ", "compression=JPEG frame=20 save=["+toString(savename)+"]");
			  close();
			  call("java.lang.System.gc");
          } 
      } 
  } 
