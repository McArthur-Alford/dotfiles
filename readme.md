# Structure
The flake has a bunch of systems that can be built. For each you specify a user, host, system, desktop, etc. These each brake the flake into nicer modules than I previously had it:
- host
  - the host machine. Handles packages that I want systemwide/cant be installed by home manager. Also does all the correct hardware configuration for each host machine.
- user
  - the user. Useful for home manager. Lets me set user specific things that are consistent accross machines, e.g. my terminal layout, theming, certain packages, etc.
- desktop
  - controls the desktop environment. For now only the hyprland one exists.
