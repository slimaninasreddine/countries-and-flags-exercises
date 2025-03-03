Class {
	#name : 'EarthMap',
	#superclass : 'Object',
	#instVars : [
		'countries'
	],
	#category : 'CountryFlag-Core',
	#package : 'CountryFlag-Core'
}

{ #category : 'accessing' }
EarthMap >> countries [
    ^ countries
]

{ #category : 'initialization' }
EarthMap >> importCountriesFromFile: fileName [
    | xmlTree |
    xmlTree := self xmlTreeFromFile: fileName.
    xmlTree nodes first nodes do: [:node |
        (node isKindOf: XMLElement)
            ifTrue: [ self importCountryFromXMLNode: node ]].
]

{ #category : 'initialization' }
EarthMap >> importCountryFromXMLNode: aXMLElement [
    countries add: (EarthMapCountry new fromXML: aXMLElement).

]

{ #category : 'initialization' }
EarthMap >> initialize [
    super initialize.
    countries := OrderedCollection new.
]

{ #category : 'initialization' }
EarthMap >> openPopulatedCanvas [
    self populatedCanvas open.
]

{ #category : 'initialization' }
EarthMap >> populatedCanvas [
    ^ RSCanvas new
        addAll: (countries collect: [:country | country asRSShape]);
        yourself.
]

{ #category : 'initialization' }
EarthMap >> xmlTreeFromFile: fileName [
    "Load and parse an XML/SVG file"
    ^ (XMLDOMParser parse: (fileName asFileReference readStream contents)) document.
]
