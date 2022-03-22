"
A RTHTMLStringConverter is a class used to fix Strings before using them inside HTML elements. Since many characters need to be translated to its HTML standart encoding
"
Class {
	#name : #RTSVGStringConverter,
	#superclass : #RTHTMLStringConverter,
	#category : #'Roassal2-Exporter-SVG'
}

{ #category : #accessing }
RTSVGStringConverter >> initializeValues [

	convertions
		at: $" put: '&quot;';
		at: $' put: '&apos;';
		at: $& put: '&amp;';
		at: $< put: '&lt;';
		at: $> put: '&gt;';
		at: Character cr put: ''
]
