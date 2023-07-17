Class {
	#name : #CardGenerator,
	#superclass : #GameObjectGenerator,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
CardGenerator class >> checkTypesOfCards: someCards [

	| card |
	card := Card new.
	(someCards anySatisfy: [ :aCard | (card equals: aCard) not ]) 
		ifTrue: [ Error signal: 'Cannot Generate non card objects' ]
]

{ #category : #'instance creation' }
CardGenerator class >> with: anAmountOfCards of: someCards using: someDistribution [
	self checkAmountOfObjects: anAmountOfCards.
	self checkDistribution:  someDistribution.
	self checkThereAreObjectsToGenerate: someCards.
	self checkTypesOfCards:  someCards.
	^ ((self new) initializeWith: anAmountOfCards of: someCards using: someDistribution).
]
