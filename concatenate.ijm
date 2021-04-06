dir = getDirectory("Choose a Directory ");
find(dir)

 function find(dir) { 
      list = getFileList(dir); 
      for (i=0; i<list.length; i++) {           
          if (endsWith(list[i], "/")) 
              find(""+dir+list[i]); 
          else if ((endsWith(list[i], ".tif")) && !(startsWith(list[i],"M"))) { 
              open(""+dir+list[i]);
              title1=getTitle();
              open(""+dir+"MMStack_Pos0_1.ome.tif");
              run("Concatenate...", "  title=["+toString(title1)+"] image1=["+toString(title1)+"] image2=MMStack_Pos0_1.ome.tif image3=[-- None --]"); 			  
              //waitForUser( "Pause","Crop");
              run("Bin...", "x=2 y=2 z=1 bin=Average");
              title2 = replace(dir, "Fish", "@"); 
			  parts=split(title2, "@");
 	          parts=split(parts[1]," ");
			  save(dir + parts[0] +"_" + title1);
			  close();
			  call("java.lang.System.gc");
          } 
      } 
  } 
