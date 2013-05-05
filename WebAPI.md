Web API
======

This is a basic HTTP request-response API. 

Send HTTP Requests to “cassini-spacecraft-viewer.herokuapp.com/api/[resource]”.  Replace the url with whatever domain you guys end up using.

##All responses are JSON and include
* **status** - http status code
* **details** - Can be “OK” or relevant error messages. 
* **content** - the actual data requested

##GET ephem
Retrieves the ephemeris position data for all bodies in the simulation for a given datetime or datetime range
####params:  
* datetime 
* datetime_end (optional)

example: ```GET [domain]/api/ephem?datetime=2009-06-22%2012:00:00``` 
####response content: 
An array of position data, each item includes:
* timestamp 
* body 
* x 
* y
* z

example: 
```JSON
{ "status":200,
  "details":"OK",
  "content": {
                "ephems":[
                    {"timestamp":"2009-06-22T12:00:00.000Z","body":"Cassini","x":-177.2,"y":40.2,"z":132.7},
                    {"timestamp":"2009-06-22T12:00:00.000Z","body":"Cassini","x":-43.4,"y":14.8,"z":202.7}
                ]
              }
}
```

##GET files
Retrieves data file locations (to download from in a separate process in the client) for a given date.   
####params:  
* date
* date_end (optional)
* file_type (ie “UVIS”)

example: ```GET [domain]/api/files?date=2013-05-05&file_type=UVIS```
####response content: 
An array of file meta data, each item includes:
* timestamp 
* body
* file_path

example: 
```JSON
{ "status":200,
  "details":"OK",
  "content": {
                "files":[
                    {"file_date":"2013-05-05","body":"titan","file_type":"uvis","path":"public/files/file1.dat"}
                ]
              }
}
```
