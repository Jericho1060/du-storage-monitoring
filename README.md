# du-storage-monitoring
a simple storage monitoring for Dual Universe

![Img001]()

It's displaying on a screen the quantity and the percent fill of containers or hub.

To add a container to the system, you must rename it following that pattern: `<prefix>_<itemName>`
For a Hub, you must use that pattern: `<prefix>_<itemName>_<containserSize>_<amountOfContainers>`

- `<prefix>`: the prefix that enable monitoring, by default `MONIT`, see options to customize it
- `<itemName`: the real item name in english
- `<containerSize>`: if a hub, the size of the containers linked (default to XS)
- `<amountOfContainers>`: if a hub, the amount of containers linked

By default, the script is grouping all containers or hub that contains the same items on a single line and add the values. See option if you want to disable it.

# Installation

### required elements
 
 - screen : 1
 - programming bard : 1
 
### links

The programming board must be linked to the core and to the screen

### Options

By rightclicking on the board, advanced, edit lua parameters, you can customize these options:

- containerMonitoringPrefix: the prefix value to add to each containers that should be monitored. Default to `MONIT_`, you must keep the `_` in that option
- container_proficiency_lvl: Talent level for Container Proficiency
- container_fill_red_level: The percent fill below gauge will be red
- container_fill_yellow_level: The percent fill below gauge will be yellow
- groupByItemName: if enabled, this will group all entries with the same item name (enabled by default)