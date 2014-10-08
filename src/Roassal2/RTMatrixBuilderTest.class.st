Class {
	#name : #RTMatrixBuilderTest,
	#superclass : #RTTest,
	#category : #'Roassal2-Builder-Matrix'
}

{ #category : #'as yet unclassified' }
RTMatrixBuilderTest >> testBasic [

	| b |
	b := RTMatrixBuilder new.
	b inputCSV: 'FirstName,LastName,Title,ReportsTo.Email,Birthdate,Description
Tom,Jones,Senior Director,buyer@salesforcesample.com,1940-06-07Z,"Self-described as ""the top"" branding guru on the West Coast"
Ian,Dury,Chief Imagineer,cto@salesforcesample.com,,"World-renowned expert in fuzzy logic design. 
Influential in technology purchases."
'.
	b build
]
