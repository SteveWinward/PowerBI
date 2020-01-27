# Integrating ArcGIS Enterprise
This write up describes how to integrate ESRI ArcGIS Enterpise with Power BI.

## Requirements
* ESRI ArcGIS Enterprise Server that is accessible to the end users that will consume Power BI reports
* Will not work when ESRI ArcGIS Enterprise is setup with IWA and PKI/Smartcard authentication
* To date (1/27/2020) this only works with Power BI Desktop (Nov 2019 release or later) and Power BI the service in O365.  This does not work with Power BI Report Server

## Additional Documentation
[Supported Environments ESRI Docs](https://doc.arcgis.com/en/maps-for-powerbi/get-started/supported-env.htm)

## Creating the Demo
First you need to get the URL of your ESRI ArcGIS Enterprise environment.  The URL you need to use with Power BI will end with "/portal".  For example "https://arcgis.contoso.com/portal".

Open up Power BI Desktop (not Power BI Desktop for Report Server).  In the ribbon click on "Enter Data". Create a simple table like below,

![Enter Sample Data](Images/arc-gis-enter-data.jpg)

Next, add the ArcGIS visual to your report,

![Add ArcGIS Visual](Images/arc-gis-add-visual.jpg)

Edit the visual to add your organizations ArcGIS Enterprise URL (the one that ends with portal).

![Configure ArcGIS Enterprise URL](Images/arc-gis-set-url.jpg)

Click on the arrow next to the URL.  You will be prompted for your ArcGIS Enterprise credentials.

![Bind Data to ArcGIS Visual](Images/arc-gis-set-data.jpg)

You should now see the two sample data points rendering in the ArcGIS visual as below,

![Web Connection Screenshot](Images/arc-gis-final-visual.jpg)
