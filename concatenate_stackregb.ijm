dir = getDirectory("Choose a Directory ");
setBatchMode(true);
find(dir);
setBatchMode(false);

 function find(dir) { 
      list = getFileList(dir); 
      for (i=0; i<list.length; i++) {           
			if (endsWith(list[i], "m.tif")) { 
              open(""+dir+list[i]);
              title1=getTitle();
              title2=replace(title1,".tif","_1.tif");
              title3=replace(title1,".tif","_2.tif");
              open(""+dir+title1);
              open(""+dir+title2);
              open(""+dir+title3);
              run("Concatenate...", "  title=["+toString(title1)+"] image1=["+toString(title1)+"] image2=["+toString(title2)+"] image3=["+toString(title3)+"]"); 			  
              //waitForUser( "Pause","Crop");
              run("Align slices in stack...", "method=5 windowsizex="+toString(500)+" windowsizey="+toString(500)+" x0="+toString(600)+" y0="+toString(300)+" swindow=0 subpixel=true itpmethod=0 ref.slice=1 show=true");
              title3=replace(title1,".tif","_c.tif");
			  save(dir + title3);
			  close();
			  call("java.lang.System.gc");
          } 
      } 
  } 
