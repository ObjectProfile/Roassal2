Class {
	#name : #Recompilation,
	#superclass : #MacroBenchmark,
	#category : #'IntelPowerGadget-Benchmarks'
}

{ #category : #hooks }
Recompilation >> execute [
	10 timesRepeat: [
		((RPackageOrganizer default packages select: [ :p | p packageName beginsWith: 'Versionner' ]) flatCollect: #definedClasses) do: #recompile.
		((RPackageOrganizer default packages select: [ :p | p packageName beginsWith: 'Metacello' ]) flatCollect: #definedClasses) do: #recompile
	]
]
