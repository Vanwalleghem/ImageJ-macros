dir = getDirectory("Choose a Directory ");
setBatchMode(true);
find(dir)
setBatchMode(false);

 function find(dir) { 
      list = getFileList(dir); 
      for (i=0; i<list.length; i++) {           
          if (endsWith(list[i], "/")) 
              find(""+dir+list[i]); 
          else if ((endsWith(list[i], ".tif")) && !(startsWith(list[i],"M"))) { 
          	  run("Collect Garbage");
              open(""+dir+list[i]);
              title1=getTitle();
              print(title1);
              open(""+dir+"MMStack_Pos0.ome_1.tif");
              run("Concatenate...", "  title=["+toString(title1)+"] image1=["+toString(title1)+"] image2=MMStack_Pos0.ome_1.tif image3=[-- None --]"); 			  
              call("java.lang.System.gc");
              //waitForUser( "Pause","Crop");
              //run("Bin...", "x=2 y=2 z=1 bin=Average");
              //title2 = replace(dir, "Fish", "@"); 
			  //parts=split(title2, "@");
 	          //parts=split(parts[1]," ");
 	          run("Align slices in stack...", "method=5 windowsizex=300 windowsizey=300 x0=600 y0=300 swindow=0 subpixel=true itpmethod=0 ref.slice=1 show=true");
			  save(dir + title1); 
			  title2="AVG_"+title1;
		      run("Z Project...", "projection=[Average Intensity]");
			  save(dir + title2);
			  close();
			  call("java.lang.System.gc");
          } 
      } 
  } 
