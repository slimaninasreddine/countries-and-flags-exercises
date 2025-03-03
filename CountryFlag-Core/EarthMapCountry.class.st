Class {
	#name : 'EarthMapCountry',
	#superclass : 'Object',
	#instVars : [
		'svgPath',
		'name',
		'code'
	],
	#category : 'CountryFlag-Core',
	#package : 'CountryFlag-Core'
}

{ #category : 'instance creation' }
EarthMapCountry >> asRSShape [
    ^ RSSVGPath new
        svgPath: svgPath;
        color: Color blue;
        yourself.
]

{ #category : 'instance creation' }
EarthMapCountry >> fromXML: aXMLElement [
    svgPath := aXMLElement attributeAt: 'd'.
    name := aXMLElement attributeAt: 'title'.
    code := aXMLElement attributeAt: 'id'.
]

{ #category : 'instance creation' }
EarthMapCountry >> inspectorShape [
    <inspectorPresentationOrder: 0 title: 'Shape'>
    | canvas |
    canvas := RSCanvas new.
    canvas add: self asRSShape.
    canvas @ RSCanvasController.
    ^ SpRoassalInspectorPresenter new
        canvas: canvas;
        yourself.
]
