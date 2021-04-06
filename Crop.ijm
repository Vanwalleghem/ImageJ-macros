dir = getDirectory("Choose a Directory ");
setBatchMode(true);
find(dir);
setBatchMode(false);

function find(dir) { 
      list = getFileList(dir); 
      for (i=0; i<list.length; i++) {           
         if (endsWith(list[i], ".tif")) { 
              open(""+dir+list[i]);
              title1=getTitle();
              makeRectangle(66, 0, 366, 478);
              run("Select All");
              run("Crop");
              save(dir + title1);
              close();
              call("java.lang.System.gc");
          } 
      } 
  }