#!/bin/bash

echo starting ToC transformation
 
inputDir="data/pdf/"
outputDir="data/xml/"

rm -r -f $outputDir

echo generating Dir File List

configFile='<?xml version="1.0" encoding="UTF-8"?>'

dirList='<ul class="directory-list">'

echo $configFile $dirList

for dirname in $inputDir*; do
   name=$(basename "$dirname")
   echo $name    
   dirList+='<li>'
   dirList+="$name"   

   if [ -d "$dirname" ]; then
      dirList+="<ul>"
      for filename in $dirname/*.pdf; do
         name=$(basename "$filename" .pdf)
         
         if [[ ($name == *"pages"*) && ($name != *"pages-"*) ]]; then
            echo $name            
            dirList+='<li>'
            start='<a href="'
            end='.pdf">'
            line="$start$name$end"
            dirList+="$line"
            dirList+="$name"
            dirList+="</a>"
            dirList+='</li>'
         fi          

      done
      dirList+="</ul>"
   fi

   dirList+='</li>'
done

dirList+="</ul>"
echo $dirList

configFile+="$dirList"
echo $configFile

mkdir $outputDir

echo "$configFile" > "$outputDir"dirFileList.xml

echo transformation was successfull

