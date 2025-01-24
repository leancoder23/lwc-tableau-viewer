#Summary

A Lightning Web Component that provides a wrapper for Tableau Embedded UI JavaScript Library, enabling developers and admins to display Tableau reports (both from Tableau Cloud and Tableau Server) in Salesforce without requiring user to login into tableau environment.  


#Description

The component implements Tableau Embedded API providing options for developer to integrate Tableau reports in salesforce programatically for enhanced integration scenarios which are not provided by standard Tableau Viewer Component.

It manages users authentication seamlessly by dynamically generating JWT token for the current salesforce user based on given configuration enabling single sign on experience for the end user.

This component provides initial implementation base for developers to implement an enhanced integration experience based on their client need.

Used Tableau Embedding API documentation is:
https://help.tableau.com/current/api/embedding_api/en-us/index.html
