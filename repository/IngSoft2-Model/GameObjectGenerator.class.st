Class {
	#name : #GameObjectGenerator,
	#superclass : #Object,
	#instVars : [
		'distribution',
		'objectsToGenerate',
		'objectsToUse'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #validation }
GameObjectGenerator class >> checkAmountOfObjects: anAmountOfObjects [
	
	(anAmountOfObjects <= 0) ifTrue: [ Error signal: 'Amount of objects cannot be 0 or lower' ]
]

{ #category : #validation }
GameObjectGenerator class >> checkDistribution: someDistribution [
	((someDistribution sum) = 100) ifFalse: [ Error signal: 'Distribution must add up 100%' ].
]

{ #category : #validation }
GameObjectGenerator class >> checkThereAreObjectsToGenerate: someObjects [

	(someObjects isEmpty ) ifTrue:[Error signal: 'Cannot generate without any type of object']
]

{ #category : #Generation }
GameObjectGenerator >> generateNumber [
	^ 100 atRandom.
]

{ #category : #Generation }
GameObjectGenerator >> generateObjects [

	| squares squareSelector floor ceiling |
	squares := OrderedCollection new.
	objectsToGenerate timesRepeat: [ 
		floor := 1.
		ceiling := 0.
		squareSelector := self generateNumber.
		distribution withIndexDo: [ :currentDistribution :generatedIndex | 
			ceiling := ceiling + currentDistribution.
			(squareSelector between: floor and: ceiling) ifTrue: [ 
				squares add: (objectsToUse at: generatedIndex) ].
			floor := floor + currentDistribution ] ].
	^ squares
]

{ #category : #initialization }
GameObjectGenerator >> initializeWith: anAmountOfSquares of: someSquares using: someDistribution [

	objectsToGenerate := anAmountOfSquares.
	objectsToUse := someSquares.
	distribution := someDistribution.
]
