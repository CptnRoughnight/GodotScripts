#####################################################
##
##	class QuadTree
## 
##  builds a quadtree with variant objects
##	the object has to define a func
##	get_position() wich has to return a Vector2
##
#####################################################


extends Node

class_name QuadTree

var dimension : Rect2
var divideThreshold : int
var nodes : QuadNode = QuadNode.new()

func create(dim:Rect2,div:int):
	dimension = dim
	divideThreshold = div
	nodes.create(dimension,divideThreshold)

func insert(n):
	nodes.insert(n)

func query(r:Rect2):
	var result = []
	if (dimension.intersects(r)):
		nodes.query(r,result)
	return result
		

#####################################################
##
##	class QuadNode
## 
##  einzelnes Node im Quadtree
##
#####################################################
class QuadNode:
	var nw : QuadNode
	var ne : QuadNode
	var se : QuadNode
	var sw : QuadNode
	
	var divideThreshold : int
	var nodes = []
	var dimension : Rect2
	var divided : bool = false
	
	func create(dim:Rect2,div:int):
		divideThreshold = div
		dimension = dim
		
	func insert(n):
		if dimension.has_point(n.get_position())==false:
			return
		
		if nodes.size()>divideThreshold:
			if divided==false:
				divide()
			nw.insert(n)
			ne.insert(n)
			sw.insert(n)
			se.insert(n)
			print("divide")
		else:
			nodes.append(n)
		
	func divide():
		var rnw = Rect2(dimension.position.x,dimension.position.y,dimension.size.x/2,dimension.size.y/2)
		var rne = Rect2(dimension.position.x+dimension.size.x/2,dimension.position.y,dimension.size.x/2,dimension.size.y/2)
		var rsw = Rect2(dimension.position.x,dimension.position.y+dimension.size.y/2,dimension.size.x/2,dimension.size.y/2)
		var rse = Rect2(dimension.position.x+dimension.size.x/2,dimension.position.y+dimension.size.y/2,dimension.size.x/2,dimension.size.y/2)
		
		nw = QuadNode.new()
		ne = QuadNode.new()
		sw = QuadNode.new()
		se = QuadNode.new()
		nw.create(rnw,divideThreshold)
		ne.create(rne,divideThreshold)
		sw.create(rsw,divideThreshold)
		se.create(rse,divideThreshold)
		
		divided = true
		
	func query(r:Rect2,result):
		if (dimension.intersects(r)):
			for n in nodes:
				if r.has_point(n.get_position()):
					result.append(n)
			if divided:
				nw.query(r,result)
				ne.query(r,result)
				sw.query(r,result)
				se.query(r,result)
#####################################################

