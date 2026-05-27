# Awesome Yocto Project

A curated list of resources for the Yocto Project and OpenEmbedded build system.

## Official Documentation

- [Yocto Project Documentation](https://docs.yoctoproject.org/) new_textComplete official docs
- [Yocto Project Quick Build](https://docs.yoctoproject.org/brief-yoctoprojectqs/index.html) new_textOfficial quick start
- [BitBake User Manual](https://docs.yoctoproject.org/bitbake/index.html) new_textBitBake reference
- [Yocto Project Reference Manual](https://docs.yoctoproject.org/ref-manual/index.html) new_textVariables, tasks, classes
- [Yocto Project Development Tasks Manual](https://docs.yoctoproject.org/dev-manual/index.html) new_textHow-to guides
- [Yocto Project Board Support Package (BSP) Developer's Guide](https://docs.yoctoproject.org/bsp-guide/index.html)
- [Toaster Manual](https://docs.yoctoproject.org/toaster-manual/index.html) new_textWeb-based build interface

## Training & Courses

- [Bootlin Yocto Project Training](https://bootlin.com/training/yocto/) new_textFree slides and lab materials
- [Bootlin Yocto Training Materials (PDF)](https://bootlin.com/doc/training/yocto/) new_textDownloadable slides
- [Bootlin Yocto Labs](https://bootlin.com/doc/training/yocto/yocto-labs.pdf) new_textHands-on exercises
- [Linaro Connect Presentations](https://connect.linaro.org/) new_textEmbedded Linux and Yocto talks
- [Yocto Project Summit Recordings](https://www.youtube.com/@YoctoProject) new_textYouTube channel

## Books

- *Embedded Linux Systems with the Yocto Project* new_textRudolf Streif (Prentice Hall)
- *Embedded Linux Development Using Yocto Project* new_textOtavio Salvador, Daiane Angolini
- *Yocto Project Complete Documentation Set* new_textAvailable at docs.yoctoproject.org

## Layer Index & Repositories

- [OpenEmbedded Layer Index](https://layers.openembedded.org/) new_textSearch for layers and recipes
- [Yocto Project Git Repositories](https://git.yoctoproject.org/) new_textOfficial source repos
- [meta-openembedded](https://github.com/openembedded/meta-openembedded) new_textCommunity layers (meta-oe, meta-networking, meta-python, etc.)
- [meta-raspberrypi](https://github.com/agherzan/meta-raspberrypi) new_textRaspberry Pi BSP
- [meta-ti](https://git.yoctoproject.org/meta-ti) new_textTexas Instruments BSP
- [meta-arm](https://git.yoctoproject.org/meta-arm) new_textArm reference platforms
- [meta-security](https://git.yoctoproject.org/meta-security) new_textSecurity recipes and hardening
- [meta-virtualization](https://git.yoctoproject.org/meta-virtualization) new_textDocker, containers, VMs

## Tools

- [repo](https://gerrit.googlesource.com/git-repo/) new_textMulti-repository management
- [devtool](https://docs.yoctoproject.org/ref-manual/devtool-reference.html) new_textRecipe development workflow
- [recipetool](https://docs.yoctoproject.org/dev-manual/new-recipe.html) new_textAuto-generate recipes
- [Toaster](https://docs.yoctoproject.org/toaster-manual/index.html) new_textWeb UI for builds
- [CROPS](https://github.com/crops) new_textCross-platform Yocto builds via containers
- [kas](https://github.com/siemens/kas) new_textBuild configuration tool for Yocto
- [bitbake-layers](https://docs.yoctoproject.org/bsp-guide/bsp.html) new_textLayer management commands

## Presentations & Talks

- [Yocto Project Summit 2024](https://wiki.yoctoproject.org/wiki/Yocto_Project_Summit) new_textLatest summit
- [Embedded Linux Conference Talks](https://www.youtube.com/playlist?list=PLbzoR-pLrL6oyIqpMYBGmxKMb3JNHZY0K) new_textELC recordings
- [Bootlin Conference Talks](https://bootlin.com/community/talks/) new_textEmbedded Linux presentations
- [Linaro Tech Days](https://www.linaro.org/events/) new_textArm ecosystem talks

## Blogs & Articles

- [Yocto Project Blog](https://www.yoctoproject.org/blog/) new_textOfficial blog
- [Bootlin Blog](https://bootlin.com/blog/) new_textEmbedded Linux articles
- [Konsulko Group Blog](https://www.konsulko.com/blog/) new_textYocto consulting insights
- [Joshua Watt's Blog](https://joshuawatt.com/) new_textAdvanced Yocto topics

## Community

- [Yocto Project Mailing Lists](https://www.yoctoproject.org/community/mailing-lists/) new_textyocto@lists.yoctoproject.org
- [#yocto on Libera.Chat](https://web.libera.chat/#yocto) new_textIRC channel
- [Yocto Project Wiki](https://wiki.yoctoproject.org/) new_textCommunity wiki
- [Stack Overflow - yocto tag](https://stackoverflow.com/questions/tagged/yocto) new_textQ&A

## Release Information

| Release | Codename | Status |
|---------|----------|--------|
| 5.0 | Scarthgap | Current LTS (Apr 2024) |
| 5.1 | Styhead | Latest (Oct 2024) |
| 4.0 | Kirkstone | Previous LTS |
| 3.1 | Dunfell | EOL |

## Tips & Best Practices

- Always pin your layer revisions to a specific release branch (e.g., `scarthgap`)
- Use `SSTATE_DIR` and `DL_DIR` outside your build directory to share across builds
- Use `devtool` for iterative recipe development
- Run `bitbake-layers show-layers` to verify your layer configuration
- Use `bitbake -e <recipe> | grep ^VARIABLE=` to debug variable values
- Keep custom layers separate from upstream layers for easy updates
