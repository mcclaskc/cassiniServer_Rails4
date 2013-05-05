Web API
=======

This is a basic HTTP request-response API. 

Send HTTP Requests to “cassini-spacecraft-viewer.herokuapp.com/api/[resource]”.  Replace the url with whatever domain you guys end up using.

##All responses are JSON and include
* **status** - http status code
* **details** - Can be “OK” or relevant error messages. 
* **content** - the actual data requested

##GET ephem
Retrieves the ephemeris position data for all bodies in the simulation for a given datetime or datetime range
####params:  
* datetime | 
* datetime_end (optional)

####response content: 
An array of position data, each item includes:
* timestamp 
* body 
* x 
* y
* z

##GET files
Retrieves data file locations (to download from in a separate process in the client) for a given date.   
####params:  
* date
* date_end (optional)
* file_type (ie “UVIS”)

####response content: 
An array of file meta data, each item includes:
* timestamp 
* body
* file_path

