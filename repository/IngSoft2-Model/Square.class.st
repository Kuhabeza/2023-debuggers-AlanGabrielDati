Class {
	#name : #Square,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #comparing }
Square >> equals: anotherSquare [

	^ anotherSquare isKindOf: self class.
]
