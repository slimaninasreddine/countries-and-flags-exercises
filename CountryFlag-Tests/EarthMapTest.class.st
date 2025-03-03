Class {
	#name : 'EarthMapTest',
	#superclass : 'TestCase',
	#category : 'CountryFlag-Tests',
	#package : 'CountryFlag-Tests'
}

{ #category : 'tests' }
EarthMapTest >> testImportCountriesFromFile [
    | map fileRef |
    map := EarthMap new.
    fileRef := FileSystem workingDirectory / 'resources' / 'world.svg'.
    map importCountriesFromFile: fileRef.
    self assert: map countries size > 0.
]
