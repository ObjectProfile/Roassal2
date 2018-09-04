# Roassal2

Roassal2 is a visualization engine for the Pharo and VisualWorks programming language and environment.
Extensive documentation is available on http://AgileVisualization.com

---
## VisualWorks

The distribution of Roassal for VisualWorks is in the Cincom public store. Simply look for `roassal2-full` on the public store. Note that your need to have the Cairo libraries installed along with the VisualWorks installation.

---
## Pharo
The source code of Roassal2 is contained in this GitHub repository.

Execute the following code snippet to load Roassal2 in a fresh Pharo 7 image:
```Smalltalk
Metacello new
    baseline: 'Roassal2';
    repository: 'github://ObjectProfile/Roassal2/src';
    load.
```
You can also load Roassal2 from the Pharo Catalog browser.
