# du-storage-monitoring
a simple storage monitoring for Dual Universe

![Img001](https://github.com/Jericho1060/du-storage-monitoring/blob/main/du-storage-monitoring.png?raw=true)

# Discord Server

You can join me on Discord for help or suggestions or requests by folowing that link : https://discord.jericho1060.com

#Description
It's displaying on a screen the quantity and the percent fill of containers or hub.

It can support up to 9 screens and chose what is display on each (group feature)

To add a container to the system, you must rename it following that pattern: `<prefix>_<itemName>`
For a Hub, you must use that pattern: `<prefix>_<itemName>_<containserSize>_<amountOfContainers>`

- `<prefix>`: the prefix that enable monitoring, by default `MONIT`, see options to customize it
- `<itemName`: the real item name in english
- `<containerSize>`: if a hub, the size of the containers linked (default to XS)
- `<amountOfContainers>`: if a hub, the amount of containers linked

By default, the script is grouping all containers or hub that contains the same items on a single line and add the values. See option if you want to disable it.

By default, the list is sorted by item tier and then by name

# Installation

### required elements
 
 - screen : 1 (up to 9)
 - programming bard : 1
 
### links

The programming board must be linked to the core and to the screen

### installing the script

Copy the content of the file config.json then right clik on the board, chose advanced and click on "Paste Lua configuraton from clipboard"

### Options

By rightclicking on the board, advanced, edit lua parameters, you can customize these options:

- `containerMonitoringPrefix_screen1`: the prefix value to add to each containers that should be monitored and display on the 1st screen. Default to `MONIT_`, you must keep the `_` in that option
- `containerMonitoringPrefix_screen2`: the prefix value to add to each containers that should be monitored and display on the 2nd screen. Default to `s2_`, you must keep the `_` in that option
- `containerMonitoringPrefix_screen3`: the prefix value to add to each containers that should be monitored and display on the 3rd screen. Default to `s3_`, you must keep the `_` in that option
- `containerMonitoringPrefix_screen4`: the prefix value to add to each containers that should be monitored and display on the 4th screen. Default to `s4_`, you must keep the `_` in that option
- `containerMonitoringPrefix_screen5`: the prefix value to add to each containers that should be monitored and display on the 5th screen. Default to `s5_`, you must keep the `_` in that option
- `containerMonitoringPrefix_screen6`: the prefix value to add to each containers that should be monitored and display on the 6th screen. Default to `s6_`, you must keep the `_` in that option
- `containerMonitoringPrefix_screen7`: the prefix value to add to each containers that should be monitored and display on the 7th screen. Default to `s7_`, you must keep the `_` in that option
- `containerMonitoringPrefix_screen8`: the prefix value to add to each containers that should be monitored and display on the 8th screen. Default to `s8_`, you must keep the `_` in that option
- `containerMonitoringPrefix_screen9`: the prefix value to add to each containers that should be monitored and display on the 9th screen. Default to `s9_`, you must keep the `_` in that option
- `container_proficiency_lvl`: Talent level for Container Proficiency
- `container_fill_red_level`: The percent fill below gauge will be red
- `container_fill_yellow_level`: The percent fill below gauge will be yellow
- `groupByItemName`: if enabled, this will group all entries with the same item name (enabled by default)


# Support or donation

if you like it, [<img src="https://github.com/Jericho1060/DU-Industry-HUD/blob/main/ressources/images/ko-fi.png?raw=true" width="150">](https://ko-fi.com/jericho1060)