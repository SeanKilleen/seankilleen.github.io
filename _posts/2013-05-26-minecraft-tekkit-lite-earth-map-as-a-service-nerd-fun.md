---
 
title: Minecraft Tekkit Lite Earth Map as a Service [Nerd Fun]
date: 2013-05-26 13:35:00.000000000 -04:00

redirect_from: 
 - /2013/05/minecraft-tekkit-lite-earth-map-as.html

---
I have a little time to kill this holiday weekend and wanted to try something fun (at least before it gets warm enough to go outside for the rest of the day). Some friends and I have been playing [Tekkit Lite] off and on, and being the resident IT geek, I'm hosting the server.

I'm going to set up my own Tekkit Lite server, using the 1:1500 Earth Map, and running as a service on my machine.

### Before You Begin

* **Lock down your machine**. This is important. If you're hosting on your own server, it's going to have to involve some port forwarding and letting the internet into your machine. Lock it down with appropriate firewall knowledge. If you don't do this, then you're going to have a terrible time at some point.
* **Get a [FreeDNS account at afraid.org][Afraid]**. Your machine has an IP that might change, and if you're not paying for a domain name, getting one of their free subdomains is an easy way to allow access to your machine without having to give our your IP every time it changes.
* **Do all of the proper port forwarding**. I'm not going to explain that here, as it's different for every ISP/router. If you don't know how to port forward and port trigger, look it up elsewhere first (unless you want to just play by yourself. Which is a little sad.)

### Obtaining the Software

* [**The Tekkit Lite Server Files**][Tekkit Lite]. Head to the link and click "Download latest Tekkit Lite Server".
* [**The 1:500 Earth Map files**][Earth Map Link]. This is a huge download, so you may want to kick it off early.
* [**YAJSW (Yet Another Java Service Wrapper)**][YAJSW]. Download the code from SourceForge. It's a handy little utility to configure your Java Install as a Windows Service.

### Initial Setup

* Extract the LetLente! Earth maps. This will take a while.
* Extract the Tekkit Lite Server Files. Use 7-Zip or Windows to Extract the Zip files.
* Extract the yajsw files.
* Rename the Tekkit Lite folder to the name of your server (I called mine `MinecraftServer_EarthMap`)
* In the root of the Tekkit Lite folder, there is a `server.properties` file. Configure it according to however you'd like the world to be. See [this wiki page][Server wiki] as a starting guide.
* I suggest at least setting your player handle as an op in the `ops.txt` file as well.
* If you have multiple servers running, be sure to set the `server-port` option in `server.properties`.
* In your server folder, create a folder called `world`.
* Copy the Earth map files into that `world` folder.
* Create a folder called `service`.
* Copy the yajsw files into the `service` folder. (I recommend copying the files so that you can go `service > yajsw > [files]`. Remove the second layer of 'yajsw' folder that gets extracted.)
* Run `launch.bat` to start up the server. Make sure there aren't any fatal errors.
* Open your Technic Launcher and try to connect to `localhost:25565` (the default port). You should be able to see the world and connect to it.
* Once you can connect to the world, exit it but **don't shut down the launch.bat window**.

### The Server Becomes the Service

Now that we have a working installation, we want to make this a legitimate service that runs all the time in the background.

* **Copy your server files to "Program Files"**. I do this because it's a really good way to ensure that you don't delete them when you clear out your downloads folder.
* **Find the PID of your server**. I recommend using a tool like [procexp](https://docs.microsoft.com/en-us/sysinternals/downloads/process-explorer) to view all your processes. You need to find the `java.exe` process that is running the Tekkit Lite server. It will likely be something like `java  -Xmx3G -Xms2G -jar TekkitLite.jar nogui`. The PID for this will be a number (procexp is helpful and lists it for you).
* **Generate your wrapper.conf file**. Open a command prompt and navigate to the `yajsw\bat` directory. (e.g. `your minecraft server\service\yajsw\bat`). Run `genConfig [pid]`, where you replace `[pid]` with the process ID.
  * e.g. if the PID you found was 1234, you'd run "genConfig 1234".
* This will create the wrapper.conf file that you need.

#### Edit your generated wrapper.conf file

In the yajsw folder, find the `conf` directory and edit the `wrapper.conf` file. You need to make the following changes:

* **Memory Levels:** At the end of the file, you'll see `wrapper.java.additional.1` = `-Xmx3G` or some variant. `-Xmx` is the maximum memory. `-Xms` is the minimum memory. the 3G, 2G etc. represent x GB of memory (hence the G). Adjust these to your desired values.
* **No GUI**: Ensure that the `wrapper.app.parameter.1 = nogui` is present. This is what will stop a window from needing to show up when the service is running.
* **Working Directory**: Make sure that `wrapper.working.dir` is set to the directory of your server (it normally is by default since the generator does it for you.)
  * For example, with my server called `MinecraftServer_EarthMap`, the line reads `wrapper.working.dir=C:\Program Files\MinecraftServer_EarthMap\`
* **Service Name**: This is what will appear on your "Services" screen.
  * Change `wrapper.ntservice.name=yajsw` to the name of your server. e.g. `wrapper.ntservice.name=MinecraftServer_EarthMap`
  * Change `wrapper.ntservice.displayname` as well.
  * Change `wrapper.ntservice.description` as well.
* **Auto Start**: If you want to set the service to auto start (and I did), un-comment the `wrapper.netservice.starttype` line, which will set it to auto-start.
  * To un-comment, just remove the pound (`#`) sign and space in front of the line.

#### Finishing the Service Installation

* Open a new command prompt.
* Navigate to your `service\yajsw\bat` folder and run `installService.bat`. It should complete without errors.

### Starting it up!

* Open the services window. You can do this via control panel or typing `services.msc` into your start window.
* Find your service name.
* Right-click the service and select `Start`.
* Open your client and connect.

If you try this, let me know how it works out for you in the comments. Happy gaming!

[Tekkit Lite]: https://www.technicpack.net/modpack/tekkitlite
[Afraid]: http://freedns.afraid.org/
[Earth Map Link]: http://letslente.weebly.com/the-earth.html
[YAJSW]: http://sourceforge.net/projects/yajsw/
[Server wiki]: http://www.minecraftwiki.net/wiki/Server.properties
