cassiniServer_Rails4
====================
Web application half of the [cassini-spacecraft-viewer project](https://github.com/mcclaskc/Cassini-Spacecraft-Viewer)
* **Live Site:** [http://cassini-spacecraft-viewer.herokuapp.com/](http://cassini-spacecraft-viewer.herokuapp.com/)
* **Web API** documentation (How the Unity code requests data): [WebAPI.md](WebAPI.md)
* **TODO List** and Possible Future Features: [TODO.md](TODO.md) 

Contents of this README
-----------------------
* [System Dependencies](https://github.com/mcclaskc/cassiniServer_Rails4#system-dependencies)
* [Environment Setup](https://github.com/mcclaskc/cassiniServer_Rails4#environment-setup)
 * [Source Control](https://github.com/mcclaskc/cassiniServer_Rails4#source-control)
 * [Installing RVM and Ruby](https://github.com/mcclaskc/cassiniServer_Rails4#installing-rvm-and-ruby)
 * [Installing PostgreSQL](https://github.com/mcclaskc/cassiniServer_Rails4#installing-postgresql)
 * [Installing Rails](https://github.com/mcclaskc/cassiniServer_Rails4#installing-ruby-on-rails)
  * [General Tips](https://github.com/mcclaskc/cassiniServer_Rails4#general-tips)
 * [Running a Local Server](https://github.com/mcclaskc/cassiniServer_Rails4#running-a-local-server)
 * [Running the Rails console](https://github.com/mcclaskc/cassiniServer_Rails4#running-the-rails-console)
* [Adding the Unity Web Player to Rails](https://github.com/mcclaskc/cassiniServer_Rails4#adding-the-unity-web-player-object-to-rails)
* [Testing](https://github.com/mcclaskc/cassiniServer_Rails4#testing)
* [Code Documentation](https://github.com/mcclaskc/cassiniServer_Rails4#documentation)
* [Deployment](https://github.com/mcclaskc/cassiniServer_Rails4#deployment)

System Dependencies
-----------------
* RVM
* Ruby 2.0.0p0 
* PostgreSQL 

Environment Setup
-----------------
#### This is not very pedantic.  I have installed Rails on several machines of my own and helped with others.  Each installation experience has been a little different, especially depending on what OS your using.  
### Source Control
* Git
* Github Repository: https://github.com/mcclaskc/cassiniServer_Rails4
* Github cloning instructions: https://help.github.com/articles/fork-a-repo

### Installing RVM and Ruby
* RVM installation documention: https://rvm.io/rvm/install/
* Ruby 2 installation: http://blog.arvidandersson.se/2012/10/29/installing-ruby-2-0-with-rvm

### Installing PostgreSQL
* Install guide: http://wiki.postgresql.org/wiki/Detailed_installation_guides

### Installing Ruby on Rails
* Latest Guide for installing Ruby 2 and Rails 4: http://railsapps.github.io/installing-rails.html
* General Documentation for Rails 4: http://edgeguides.rubyonrails.org/4_0_release_notes.html

##### General Tips
  * Google, StackOverFlow, and the Rails documentation sites listed above are your friends.
  * There are some fancy install packages for Windows and Mac out there. I have not found any that install Ruby 2 and Rails 4, which is what this application uses.

### Running a Local Server 
Once you have Ruby and Rails installed, navigate to the cloned directory.
* Install the necessary gems (ruby libraries) for the project 
```$ bundle install```
* Start the server.  This starts a server on localhost:3000 (default
```$ rails server```
* Start the interactive rails console (it's like a Ruby shell, but inside the Rails App's environment)

### Running the Rails Console
It's a ruby shell, but is inside your app's scope and thus has access to your libraries, models, lib, etc.  It's a handy way to test out new code manually or access your development database via Rails instead of SQL.
```$ rails console```

Adding the Unity Web Player object to Rails
-------------------------------------------
* The Unity Web Player requires it's own javascripts and css, naturally.  However, when I tried to refactor them into the asset pipeline, the web player would no longer render.
So because of this, the Web Player exists in it's own HTML page: ```/public/play.html``` which is separate from the styling and layouts from the rest of the app. The original html page, "webplayer.html", that Unity spits out is in this directory as well, which I use for reference.
* The Unity build file should be located in this public directory as well.  This allows play.html to access it and download it to new users.
* The build file is loaded by the webplayer here: https://github.com/mcclaskc/cassiniServer_Rails4/blob/master/public/play.html#L59
```javascript
u.initPlugin(jQuery("#unityPlayer")[0], "build2.unity3d");
```

Where "build2.unity3d" is the current name of the build file.

Testing
-------
The test files are found under the test directory.
To run the test suite, run 
```$ rake test```
Rails testing documentation: http://guides.rubyonrails.org/testing.html

Documentation
-------------
RDOC is JAVADOC for Ruby. 
To generate or update your rdoc for rails: 
```$rake doc:app```
This will place the documentation in ```doc/app/```, and can be accessed locally.
The comments I have made around classes and methods should be good templates
for what rdoc wants.

Deployment
----------
I am currently deploying to my personal Heroku account.  I'm assuming LASP will want to handle this themselves.






