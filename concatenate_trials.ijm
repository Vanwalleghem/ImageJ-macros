dir = getDirectory("Choose a Directory ");
output = getDirectory("Choose Destination Directory to save results");
find(dir)

 function find(dir) { 
      list = getFileList(dir); 
      for (i=0; i<list.length; i++) {           
          if (endsWith(list[i], "/")) 
              find(""+dir+list[i]); 
          else if ((endsWith(list[i], "um.tif")) && !(startsWith(list[i],"M"))) { 
              open(""+dir+list[i]);
              title1=getTitle();
              title2=replace(title1,".tif","_1.tif");
              title3=replace(title1,".tif","_2.tif");
              open(""+dir+title2);
              open(""+dir+title3);
              run("Concatenate...", "  title=["+toString(title1)+"] image1=["+toString(title1)+"] image2=["+toString(title2)+"] image3=["+toString(title3)+"]"); 			  
              waitForUser("select region to register against");
			  getSelectionBounds(x0, y0, width, height);
              run("Align slices in stack...", "method=5 windowsizex="+toString(width)+" windowsizey="+toString(height)+" x0="+toString(x0)+" y0="+toString(y0)+" swindow=0 subpixel=true itpmethod=0 ref.slice=1 show=true");
              waitForUser( "Pause","Crop");
              //run("Bin...", "x=2 y=2 z=1 bin=Average");
              //title2 = replace(dir, "Fish", "@"); 
			  //parts=split(title2, "@");
 	          //parts=split(parts[1]," ");
			  save(output + title1);
			  close();
			  call("java.lang.System.gc");
          } 
      } 
  } 
