Class {
	#name : #RTHTMLDragAndDrop,
	#superclass : #RTHTMLInteraction,
	#category : #'Roassal2-Exporter-HTML'
}

{ #category : #adding }
RTHTMLDragAndDrop >> addEventHandlers: aStream id: aString element: element center: aNumber [
	aStream
		nextPutAll: 'dragdrop '
]

{ #category : #adding }
RTHTMLDragAndDrop >> addFunctions: aStream [
	aStream
		nextPutAll: '		var SVGDocument = null;
		var SVGRoot = null;
		var TrueCoords = null;
		var GrabPoint = null;
		var BackDrop = null;
		var DragTarget = null;
		function GADInit(evt)
		{
			SVGDocument = evt.target.ownerDocument;
         		SVGRoot = evt.target;
         		TrueCoords = SVGRoot.createSVGPoint();
         		GrabPoint = SVGRoot.createSVGPoint();
         		BackDrop = SVGDocument.getElementById("BackDrop");
      		}
      		function Grab(evt)
      		{
        		if (!evt.target.classList.contains("dragdrop"))
            			return; 
         		var targetElement = evt.target;
         		if ( BackDrop != targetElement )
         		{
            			DragTarget = targetElement;
            			DragTarget.parentNode.appendChild( DragTarget );
            			DragTarget.setAttributeNS(null, ''pointer-events'', ''none'');
            			var transMatrix = DragTarget.getCTM();
            			GrabPoint.x = TrueCoords.x - Number(transMatrix.e);
            			GrabPoint.y = TrueCoords.y - Number(transMatrix.f);
        		 }
      		};

      		function Drag(evt)
      		{
         		GetTrueCoords(evt);
         		if (DragTarget)
         		{
            			var newX = TrueCoords.x - GrabPoint.x;
            			var newY = TrueCoords.y - GrabPoint.y;
            			DragTarget.setAttributeNS(null, ''transform'', ''translate('' + newX + '','' + newY + '')'');
         		}
      		};

      		function Drop(evt)
      		{
         		if ( DragTarget )
         		{
           		var targetElement = evt.target;
            		DragTarget.setAttributeNS(null, ''pointer-events'', ''all'');
            		DragTarget = null;
         		}
      		};

      		function GetTrueCoords(evt)
      		{
         		var newScale = SVGRoot.currentScale;
         		var translation = SVGRoot.currentTranslate;
         		TrueCoords.x = (evt.clientX - translation.x)/newScale;
         		TrueCoords.y = (evt.clientY - translation.y)/newScale;
      		};
'
]

{ #category : #adding }
RTHTMLDragAndDrop >> addGlobalHandlers: aStream [
	aStream
		nextPutAll: '
	onload="GADInit(evt)"
	onmousedown="Grab(evt)"
	onmousemove="Drag(evt)"
	onmouseup="Drop(evt)"
'
]

{ #category : #'as yet unclassified' }
RTHTMLDragAndDrop >> initialize [
	super initialize.
	contained := true.
	external := false.
]
