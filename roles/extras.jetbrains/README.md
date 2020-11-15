Ansible Role: Jetbrains IDE support
=====================

This Ansible role currently supports the following JetBrains IDEs:
 - IntelliJ IDEA Community Edition
 - IntelliJ IDEA Ultimate Edition
 - PHPStorm
 - RubyMine

Requirements
------------

If you choose to run any IDE with JetBrains Agent, you should enter the content
of `/opt/JetBrains/jetbrains-agent/ACTIVATION_CODE.txt` manually into the IDE 
you want to run unlicensed. This code activates a perpetual license. If you want
to get rid on this license, first set `java.agent.enable` to `no` and then enter
an activation code that you got from JetBrains into the `Register` window.

Role variables
--------------

Available variables are listed below, along with default values (see 
`defaults/main.yml`)

### RubyMine

```yaml
jetbrains:
  ruby:
    enable: no
```

Set it to `yes` if you want to install RubyMine

```yaml
jetbrains:
  ruby:
    version: 2019.3.3
```

The current supported version of RubyMine. (Note: if it's outdated, please 
report it to this repo!)

### PHPStorm

```yaml
jetbrains:
  php:
    enable: no
```

Set it to `yes` if you want to install PHPStorm

```yaml
jetbrains:
  php:
    version: 2019.3.3
```

The current supported version of PHPStorm. (Note: if it's outdated, please 
report it to this repo!)

This variable is a required and connected to `jetbrains.php.build`. **Do not 
modify this variable without updatind `jetbrains.php.build` and vice versa!**

```yaml
jetbrains:
  php:
    build: 181.5281.19
```

This variable is a required and connected to `jetbrains.php.version`. **Do not 
modify this variable without updatind `jetbrains.php.version` and vice versa!**

### IntelliJ IDEA

IntelliJ support is a bit tricky. I merged the Communnity and Ultimate Edition
into a single configuration entry.

```yaml
jetbrains:
  java:
    license:
```

The playbook decides to install Community or Ultimate Edition based on this value.
Community Edition is installed only if this variable set to something else than
free.

```yaml
jetbrains:
  java:
    version: 2019.3.3
```

The current supported version of PHPStorm. (Note: if it's outdated, please 
report it to this repo!)

This variable is a required and connected to `jetbrains.java.build`. **Do not 
modify this variable without updatind `jetbrains.java.build` and vice versa!**

```yaml
jetbrains:
  java:
    build: 181.5281.19
```

This variable is a required and connected to `jetbrains.java.version`. **Do not 
modify this variable without updatind `jetbrains.java.version` and vice versa!**



Known bugs & issues
-------------------

- This role supports opt-in installing Jetbrains Agent, which is provides a way
  to run any JetBrains IDE unlicensed without time limits. 
  This is not a supported way to run a JetBrains IDE and you **should not** 
  report IDE-related issues to JetBrains or to this repo while Java Agent is
  enabled. Please only use this feature only if you really know what you do!
