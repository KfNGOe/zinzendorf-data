#!/bin/bash
echo start collect data
 
inputDir="data/pdf/"
outputDirTmp="data/tmp/"
outputDirTmpPdf="data/tmp/pdf/"

mkdir -p $outputDirTmpPdf

echo generate File List to zip

for dirname in $inputDir*; do
   name=$(basename "$dirname")
   echo $name    

   if [ -d "$dirname" ]; then
      
      for filename in $dirname/*.pdf; do
         #echo $filename
         name=$(basename "$filename" .pdf)
         
         if [[ ($name == *"pages"*) && ($name != *"pages-"*) ]]; then
            echo $name                        
            cp "$filename" $outputDirTmpPdf            
         fi          

      done
      
   fi
   
done

echo collect data successfull

echo zipp data

if  test -f "data/data.zip"; 
then
    echo "removing zip data"
    rm "data/data.zip"
else 
    echo "no zip file of data"    
fi

if [ "$(ls -A data/)" ]; 
then    
    cp -r data/meta $outputDirTmp
    cp -r data/xml $outputDirTmp
    
    echo "zip data"
    cd $outputDirTmp
    zip -r ../../data/data.zip *
else
    echo "no data to zip"
    exit
fi

cd ../..
rm -r $outputDirTmp

echo zip data successfull
