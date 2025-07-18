The Integrative Genomics Viewer (IGV) is a high-performance, interactive tool for visualizing large-scale genomic data. It supports a wide range of data types, including sequence alignments, gene annotations, and variant calls, making it especially useful for tasks such as quality control, variant validation, and identifying structural variations. Its intuitive interface and real-time data rendering help researchers quickly interpret complex genomic datasets.


Introductory information can be found [here](https://igv.org/doc/desktop/#)


#### Prior to downloading see if your laptop environment meets following requirments: ##

IGV requires Java 21 or greater as of IGV 2.19.1. If you download one of the IGV versions that does not include Java, make sure you have Java 21 installed and in your path. 

If for some reson you do not want to install IGV version with Java 21 included, here are described steps how to check the Java version on your computer and install the required one.


#### For windows:

Press win+R , type ‘cmd’ and press Enter.

In opened command line type java -version

The output should look like this:
```
java version "21.0.1" 2023-10-17 LTS
Java(TM) SE Runtime Environment ...
```
If your version is not 21.0.1 do the following:

- Close command line and open Windows PowerShell (win+S then type PowerShell)
- In the shell place the following command 
```
Invoke-WebRequest -Uri "https://corretto.aws/downloads/latest/amazon-corretto-21-x64-windows-jdk.msi" -OutFile "corretto-21.msi"
```
After it is finished type 
```
Start-Process .\corretto-21.msi
``` 
Then installation starts. After it is installed, open cmd again and type command java -version to check that new 21.0.1 version is used

#### For mac users the IGV Mac apps require MacOS 11 (Big Sur) or greater.
#### The IGV for Linux download includes AdoptOpenJDK (now Eclipse Temurin) version 21 for x64 Linux.  

You can download IGV browser [here](https://igv.org/doc/desktop/#DownloadPage/)

For successful installation on Windows it is recommended to turn of SmartScreen defender in your privacy settings:

Start Menu → Windows Security → App & browser control → Reputation-based protection settings →
-  Check apps and files → Off
-  SmartScreen for Microsoft Edge → Off
-   otentially unwanted app blocking → Off
-   SmartScreen for Microsoft Store apps → Off
