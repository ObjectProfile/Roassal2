
# Roassal2
[![Test P8](https://github.com/ObjectProfile/Roassal2/actions/workflows/runOnPharo8.yml/badge.svg)](https://github.com/ObjectProfile/Roassal2/actions/workflows/runOnPharo8.yml)
[![Test P9](https://github.com/ObjectProfile/Roassal2/actions/workflows/runTestPharo9.yml/badge.svg)](https://github.com/ObjectProfile/Roassal2/actions/workflows/runTestPharo9.yml)

Roassal2 is a visualization engine for the Pharo and VisualWorks programming language and environment.
Extensive documentation is available on http://AgileVisualization.com

---
## VisualWorks

The distribution of Roassal for VisualWorks is in the Cincom public store. Simply look for `roassal2-full` on the public store. Note that your need to have the Cairo libraries installed along with the VisualWorks installation.

---
## Pharo 8 & Pharo 9

Execute the following code snippet to load Roassal2 in a fresh Pharo 8 or Pharo 9 image:

```Smalltalk
Metacello new
    baseline: 'Roassal2';
    repository: 'github://ObjectProfile/Roassal2/src';
    load.
```

You can also load Roassal2 from the Pharo Catalog browser.

If you have a local copy of Roassal, you can do the following:

```Smalltalk
Metacello new
  baseline: 'Roassal2';
  repository: 'gitlocal:///Users/alexandrebergel/Dropbox/GitRepos/Roassal2' ;
  lock;
  load.
```

If you wish to set a dependency to Roassal2 in your application, you simply need to add in your baseline:

```Smalltalk
spec baseline: 'Roassal2' with: [ 
				spec repository: 'github://ObjectProfile/Roassal2/src' ].
```

---
## Pharo 7

Roassal2 is frozen for Pharo 7. You can load it using:

```Smalltalk
Metacello new 
    baseline: 'Roassal2'; 
    repository: 'github://ObjectProfile/Roassal2:pharo7/src'; 
    load
```  

---
## Pharo 6.1

You can load Roassal in Pharo 6.1 using the following script:

```Smalltalk
Gofer it
    smalltalkhubUser: 'ObjectProfile' project: 'Roassal2';
    configurationOf: 'Roassal2';
    loadVersion: '1.59'
```
