Metacello new
    baseline: #PharoSprint;
    repository: 'github://JurajKubelka/PharoSprint:$BRANCH$/src';
    load.

"Smalltalk cleanUp: true except: #() confirming: false."
Smalltalk saveAs: 'PharoSprint-', SystemVersion current highestUpdate asString, '-$REVISION$'.
Smalltalk snapshot: true andQuit: true.
