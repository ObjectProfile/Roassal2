# Roassal2

Roassal2 is a visualization engine for the Pharo and VisualWorks programming language and environment.
Extensive documentation is available on http://AgileVisualization.com

---
## VisualWorks

The distribution of Roassal for VisualWorks is in the Cincom public store. Simply look for `roassal2-full` on the public store. Note that your need to have the Cairo libraries installed along with the VisualWorks installation.

---
## Pharo 8

Execute the following code snippet to load Roassal2 in a fresh Pharo 8 image:

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
