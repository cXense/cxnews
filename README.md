[![codebeat badge](https://codebeat.co/badges/3ce3bf3a-a3c3-4da3-b095-1eea1f655b27)](https://codebeat.co/projects/github-com-cxense-cxnews)

# CxNews
#### What CxNews is?

* It is a mobile client for CxNews website (http://cxnews.azurewebsites.net) 
* It is a sample application that was initially designed and implemented with two main objectives:
  * To demonstrate Cxense products on mobile platform in action
  * To show ways of working with Cxense mobile SDKs

#### What CxNews is not?

* It is not an application ready to be published and distributed in AppStore
* It is not place from which you should download Cxense mobile SDKs. **Attention**: this project contains obsolete builds of Cxense mobile SDKs only for demonstration purposes. In general case, **you should not** use them in your projects. Latest versions of SDKs with latest features and fixes can be downloaded from https://www.cxense.com or resolved from Cocoapods repository

---

#### How to run the app?

You will need an Xcode 7 and iOS simulators with iOS8+ versions. Before you can launch the app you need to do some manual operations. 

#### Project configuration

1) Open **Terminal** and navigate to project's root folder

2) Since application uses Cocoapods for managing dependencies, you will need to execute following command to resolve all dependencies:

`pod install`

3) Create file with name "*private_conf.plist*" by using following command:

`touch private_conf.plist`

4) Open it in any text editor and paste following text:

~~~~xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CXENSE_API_USERNAME</key>
	<string>#YOUR-CXENSE-API-USERNAME#</string>
	<key>CXENSE_API_KEY</key>
	<string>#YOUR-CXENSE-API-KEY#</string>
	<key>HOCKEY_API_KEY</key>
	<string>#YOUR-HOCKEY-API-KEY#</string>
</dict>
</plist>
~~~~

5) Replace placeholders (specified in '#' signs) by your own configuration

6) Save it.

After these actions you will be able to run the application on your device or in simulator.