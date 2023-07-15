Class {
	#name : #SquareGenerator,
	#superclass : #GameObjectGenerator,
	#category : #'IngSoft2-Model'
}

{ #category : #'as yet unclassified' }
SquareGenerator class >> checkTypesOfSquares: someSquares [

	| square |
	square := Square new.
	(someSquares anySatisfy: [ :aSquare | (square equals: aSquare) not ]) 
		ifTrue: [ Error signal: 'Cannot Generate non square objects' ]
]

{ #category : #'instance creation' }
SquareGenerator class >> with: anAmountOfSquares of: someSquares using: someDistribution [
	self checkAmountOfObjects: anAmountOfSquares.
	self checkDistribution:  someDistribution.
	self checkThereAreObjectsToGenerate: someSquares.
	self checkTypesOfSquares:  someSquares.
	^ ((self new) initializeWith: anAmountOfSquares of: someSquares using: someDistribution).
]
