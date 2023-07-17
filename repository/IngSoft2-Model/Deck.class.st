Class {
	#name : #Deck,
	#superclass : #Object,
	#instVars : [
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
Deck class >> with: aSetOfCards [ 
	^ (self new) initializeWith: aSetOfCards.
]

{ #category : #adding }
Deck >> add: aCard [ 
	cards add: aCard.
]

{ #category : #'drawing cards' }
Deck >> draw [
	^ cards removeFirst.
]

{ #category : #initialization }
Deck >> initializeWith: aSetOfCards [
	
	cards := aSetOfCards.
]

{ #category : #testing }
Deck >> isEmpty [

	^ cards isEmpty.
]

{ #category : #shuffling }
Deck >> shuffle [

	cards := cards shuffle.
]

{ #category : #accessing }
Deck >> size [

	^ cards size.
]
