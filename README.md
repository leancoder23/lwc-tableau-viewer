## Summary

A Lightning Web Component that provides a wrapper for Tableau Embedded UI JavaScript Library, enabling developers and admins to display Tableau reports (both from Tableau Cloud and Tableau Server) in Salesforce without requiring user to login into tableau environment.  


## Description

The component implements Tableau Embedded API providing options for developer to integrate Tableau reports in salesforce programatically for enhanced integration scenarios which are not provided by standard Tableau Viewer Component.

It manages users authentication seamlessly by dynamically generating JWT token for the current salesforce user based on given configuration enabling single sign on experience for the end user.

This component provides initial implementation base for developers to implement an enhanced integration experience based on their client need.

Used Tableau Embedding API documentation is:
https://help.tableau.com/current/api/embedding_api/en-us/index.html


## Compatibility
**Salesforce API version 62.0 or greater** 

## Required Configurations

### Tableau Cloud
The component requires a direct connected app configured at Tableau Cloud. This provide following information that requires to be saved in a custom setting **"TableauViewerSetting"**. These informations are used by the LWC component to generate JWT token on the behalf of current salesforce user who needs to access the Tableau report enabling a single sign one experience while accessing the report. 

* Client ID
* Client Secrete ID
* Client Secrete

**NOTE** Please also grant required permission for the users who will access the tableau reports or dashboard from Salesforce

### TableauViewerSetting
Create a tableauViewerSetting records at the orgnaization level and set the following information

| TableauViewerSetting Field | Description |
|----------------------------|--------|
| Tableau Client ID | Client ID provided by Tableau Cloud Connected App | 
| Tableau Client Secret ID | Client Secret ID provided by Tableau Cloud Connected App | 
| Tableau Client Secret | Client Secret provided by Tableau Cloud Connected App | 
| Tableau User Name Field | Salesforce User Object Field API name which hold value of Tableau user name | 


### User Permissions

Add "Custom Tableau Viewer Permissionset" to the user which grant necessary permission to the specific user in addition to this make sure user also have read permission on the Salesforce User Object Field hold value of Tableau user name.


## Disclaimer

***This component provides a basic implemention to demonstrate how tableau embedded API can be utilized for providing enhanced integration which needs specific criteria or interations that cannot be fullfiled via standard component provided by Salesforce. Tableau embedded API provides large set of features that can be used to implement these specific use cases***. 
