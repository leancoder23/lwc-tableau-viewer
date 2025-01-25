## Summary

A Lightning Web Component that provides a wrapper for Tableau Embedded UI JavaScript Library, enabling developers and admins to display Tableau reports (both from Tableau Cloud and Tableau Server) in Salesforce without requiring the user to login into tableau environment. 


## Description

The component implements Tableau Embedded API providing options for developer to integrate Tableau reports in salesforce programmatically for enhanced integration scenarios which are not provided by standard Tableau Viewer Component.
It manages user authentication seamlessly by dynamically generating JWT token for the current salesforce user based on given configuration enabling single sign on experience for the end user.
This component provides an initial implementation base for developers to implement an enhanced integration experience based on their client needs.
Used Tableau Embedding API documentation is: 

https://help.tableau.com/current/api/embedding_api/en-us/index.html


## Compatibility
**Salesforce API version 62.0 or greater** 

## Required Configurations

### Tableau Cloud
The component requires a direct connected app configured at Tableau Cloud. This provides the following information that requires it to be saved in a custom setting **"TableauViewerSetting"**. This information is used by the LWC component to generate JWT token on the behalf of current salesforce users who need to access the Tableau report enabling a single sign one experience while accessing the report.

* Client ID
* Client Secret ID
* Client Secret


**NOTE** Please also grant required permission for the users who will access the tableau reports or dashboard from Salesforce

### TableauViewerSetting
Create a tableauViewerSetting records at the organization level and set the following information

| TableauViewerSetting Field | Description |
|----------------------------|--------|
| Tableau Client ID | Client ID provided by Tableau Cloud Connected App | 
| Tableau Client Secret ID | Client Secret ID provided by Tableau Cloud Connected App | 
| Tableau Client Secret | Client Secret provided by Tableau Cloud Connected App | 
| Tableau User Name Field | Salesforce User Object Field API name which hold value of Tableau user name | 


### User Permissions

Add "Custom Tableau Viewer Permissionset" to the user which grants necessary permission to the specific user in addition to this make sure users also have read permission on the Salesforce User Object Field hold value of Tableau user name.

### Component attributes
| Attribute | Description | Default |
|-----------|-------------|---------|
|Tableau Dashboard or Report URL| Valid URL of the dashboard or report user want to view | N/A |
|Height|Height of the container component| 800 | 
|Width|Width of the container component| N/A  | 
|Hide toolbar| When set true then tableau toolbar will not be shown| false|
|Hide tab| When set true then tableau dashboard or report tabs will not be shown| false|
|Device| Applies provided device form factor|Desktop|


## Disclaimer

***This component provides a basic implementation to demonstrate how tableau embedded API can be utilized for providing enhanced integration which needs specific criteria or interactions that cannot be fulfilled via standard components provided by Salesforce. Tableau embedded API provides a large set of features that can be used to implement these specific use cases.***. 
