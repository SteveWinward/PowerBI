[![Build Status](https://dev.azure.com/stevewi2019/stevewi/_apis/build/status/SteveWinward.PowerBI?branchName=master)](https://dev.azure.com/stevewi2019/stevewi/_build/latest?definitionId=1&branchName=master)

# Power BI Resources
Power BI training resources, presentations and downloads

[Power BI in Government](https://powergi.blog/)

# Power BI Training Links
[Power BI Guided Learning](https://docs.microsoft.com/en-us/power-bi/guided-learning/)

[Guy in a Cube](https://www.youtube.com/channel/UCFp1vaKzpfvoGai0vE5VJ0w)

[edX Power BI Course](https://www.edx.org/course/analyzing-and-visualizing-data-with-power-bi-0)

[Power BI Training Content](https://aka.ms/PBITraining)

[Power BI Dashboard in an Hour Lab](https://aka.ms/pbi-diah)

# Excel Training Resources
[Power Query](https://templates.office.com/en-us/power-query-tutorial-tm11414620)

[Make Your First Pivot Table](https://templates.office.com/en-us/pivottable-tutorial-tm16400647)

[Get More out of Pivot Tables](https://templates.office.com/en-us/get-more-out-of-pivottables-tm16410255)

[Going Beyond Pie Charts](https://templates.office.com/en-us/beyond-pie-charts-tutorial-tm45299826)

[Tips and Tricks](https://templates.office.com/en-us/tips-tricks-tm22725512)

[50 Time-saving Excel Shortcuts](https://templates.office.com/en-us/50-time-saving-excel-shortcuts-tm67670278)

# DC Area Power BI Training Events
|Event Date|Event City|Event State|Registration URL|
|---|---|---|---|
|12/13/2019|Reston|Virginia|[Register](https://www.microsoftevents.com/profile/form/index.cfm?PKformID=0x79217850001&ch=x4)|
|1/13/2020|Reston|Virginia|[Register](https://www.microsoftevents.com/profile/form/index.cfm?PKformID=0x88481680001&ch=x4)|
|1/29/2020|Reston|Virginia|[Register](https://www.microsoftevents.com/profile/form/index.cfm?PKformID=0x88529560001&ch=x4)|
|2/12/2020|Reston|Virginia|[Register](https://www.microsoftevents.com/profile/form/index.cfm?PKformID=0x87163080001&ch=x4)|
|2/25/2020|Reston|Virginia|[Register](https://www.microsoftevents.com/profile/form/index.cfm?PKformID=0x88530890001&ch=x4)|
|3/11/2020|Reston|Virginia|[Register](https://www.microsoftevents.com/profile/form/index.cfm?PKformID=0x88488140001&ch=x4)|
|3/24/2020|Reston|Virginia|[Register](https://www.microsoftevents.com/profile/form/index.cfm?PKformID=0x88489470001&ch=x4)|


# Presentations
[Power BI Developer Scenarios](https://aka.ms/steve-pbi-dev)

# Python Setup
First, check out the online docs for Power BI and Python integration [here](https://docs.microsoft.com/en-us/power-bi/desktop-python-scripts).

Then, see the [PythonSetup.ps1](/Python/PythonSetup.ps1) file for specific Python module requirements.

# Power BI Report Server
## D3.js Visual Demo
Using the awesome [D3.js custom visual](https://appsource.microsoft.com/en-us/product/power-bi-visuals/WA104381354?tab=Overview), I recreated the sample file to work with Power BI Report Server for various release versions. 

You can download the sample files below

* [August, 2018](/Misc/d3js_report_server_aug_2018.pbix)
* [January, 2019](/Misc/d3js_report_server_jan_2019.pbix)
* [May, 2019](/Misc/d3js_report_server_may_2019.pbix)

## Visuals Marketplace Bulk Download
I created a PowerShell script that allows you to download all Power BI visuals from the marketplace at one time.  The script can be found [here](/Misc/VisualsBulkDownloadTool.ps1).

## Comparing Power BI service (O365) to Power BI Report Server (on premise)
[Comparison Table](https://docs.microsoft.com/en-us/power-bi/report-server/compare-report-server-service#features-of-power-bi-report-server-and-the-power-bi-service)

# Shape Maps
Here's the link to Microsoft's online docs for Power BI Shape Maps,

[Power BI Shape Maps Documentation](https://docs.microsoft.com/en-us/power-bi/visuals/desktop-shape-map)

Below are some custom TopoJSON files I have built,

* [US District Attorneys Map](/ShapeMaps/US_DistrictAttorneys_CONUS.json)
* [US Trustees Program Regions Map](/ShapeMaps/USTP_Regions_Map_CONUS.json)

Mapshaper is a great website to convert existing shapefiles into TopoJSON format,

[Mapshaper](https://mapshaper.org/)

Build your own custom world map with select countries with this awesome site!

https://geojson-maps.ash.ms/

Edit TopoJSON files to include additional properties,

http://geojson.io


# Write Ups
## Splunk Integration
Summarizes how to integrate Splunk search results with Power BI,

[Power BI and Splunk](/WriteUps/splunk.md)

## Shape Map World Map
Here's a write up on creating a world map with the shape map visual,

[World Map Shape Map Example](/WriteUps/world-map.md)

## PowerShell for US Government Environments
Here are some samples on connecting to US Government environments with various PowerShell modules,

[PowerShell for US Government](/WriteUps/powershell.md)
