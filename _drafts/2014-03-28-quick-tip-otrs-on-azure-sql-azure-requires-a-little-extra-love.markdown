---
layout: post
title: 'Quick Tip: OTRS on Azure + SQL Azure Requires a little Extra Love'
---
###Problem
I want to install OTRS (a fantastic ITIL software package for IT Service Management) on Windows Azure with an Azure SQL Database.

However, after I have the database configured, it seems that I can't login to OTRS. Upon checking the log files, I see the following message:

> `[Sat Mar 29 00:46:48 2014][Error][Kernel::System::XML::XMLHashAdd][142] [Microsoft][ODBC SQL Server Driver][SQL Server]Tables without a clustered index are not supported in this version of SQL Server. Please create a clustered index and try again. (SQL-42000), SQL: 'INSERT INTO xml_storage (xml_type, xml_key, xml_content_key, xml_content_value) VALUES (?, ?, ?, ?)'`

###Cause
It looks like OTRS has a table,  `xml_storage` which doesn't have any primary keys, etc.

This is normally fine, but SQL Azure isn't down with that.

###Solution
Create a primary key from the first three values -- `xml_type`, `xml_key`, and `xml_content_key`.

####Open the SQL Azure Database on the Azure Management Portal
* find the name of your database.
* head to `https://[yourdatabasename].database.windows.net`.
* click the `Design` section at the bottom left of the screen
* scroll down until you see the `xml_storage` table, and click `Edit` off to the right.
* for the three columns besides `xml_content_value`, check off the `In Primary Key` checkbox.
* Click `Save`

Now, when you login, you should be able to see things successfully.
