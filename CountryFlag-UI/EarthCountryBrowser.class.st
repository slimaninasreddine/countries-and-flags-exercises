Class {
	#name : 'EarthCountryBrowser',
	#superclass : 'SpPresenterWithModel',
	#instVars : [
		'countryList',
		'countryCode',
		'countryFlag'
	],
	#category : 'CountryFlag-UI',
	#package : 'CountryFlag-UI'
}

{ #category : 'initialization' }
EarthCountryBrowser >> connectPresenters [
    countryList whenSelectedItemChangedDo: [:country |
        countryCode text: country code.
        countryFlag image: (self flagForCountryCode: country code)
    ].
]

{ #category : 'initialization' }
EarthCountryBrowser >> defaultLayout [
    ^ SpBoxLayout newTopToBottom
        add: (SpBoxLayout newLeftToRight
                add: countryList expand: true;
                add: countryCode width: 60);
        add: countryFlag height: 300;
        yourself.
]

{ #category : 'initialization' }
EarthCountryBrowser >> flagForCountryCode: aCode [
    | request pngData |
    request := ZnClient new.
    request get: 'https://flagcdn.com/w320/', aCode asLowercase, '.png'.
    request isSuccess ifTrue: [
        pngData := request response contents.
        ^ ImageReadWriter formFromStream: (ReadStream on: pngData)
    ].
    ^ nil.
]

{ #category : 'initialization' }
EarthCountryBrowser >> initializePresenters [
    super initializePresenters.
    
    "Create a drop list to display country names"
    countryList := self newDropList.
    countryList display: [:item | item name].
    countryList items: self model countries.  "Ensure self model is an EarthMap instance"
    
    "Create a text input to show the country code"
    countryCode := self newTextInput.
    countryCode editable: false.
    
    "Create an image widget for the flag"
    countryFlag := self newImage.  "Use newImage if newImagePresenter is undefined"
]
