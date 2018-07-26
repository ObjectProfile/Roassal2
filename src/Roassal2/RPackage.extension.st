Extension { #name : #RPackage }

{ #category : #'*Roassal2' }
RPackage >> dependentPackages [
	"
	Return the list of packages that I depend on
	
	(RPackageOrganizer default packageNamed: 'Trachel') dependentPackages
	"
	^ (self definedClasses flatCollect: #dependentClasses) collect: #package as: Set
]

{ #category : #'*Roassal2' }
RPackage >> dependentPackagesWithOccurences [
	"
	Return the list of packages that I depend on
	
	(RPackageOrganizer default packageNamed: 'Trachel') dependentPackagesWithOccurences
	"
	^ (self definedClasses flatCollect: #dependentClassesWithOccurences as: OrderedCollection) collect: #package
]
