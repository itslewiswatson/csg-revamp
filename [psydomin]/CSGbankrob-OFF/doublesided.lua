dim = 1

function START_DOUBLE_SIDED_TRANSACTION(id)
	_createObject = createObject
	createObject = createObjectDoubleSided
end

function END_DOUBLE_SIDED_TRANSACTION()
	createObject = _createObject
	dim = dim +1
end

function createObjectDoubleSided( ... )
	local temp = _createObject( unpack(arg) )
	setElementDoubleSided(temp, true)
	setElementDimension( temp, dim )
	return temp
end
