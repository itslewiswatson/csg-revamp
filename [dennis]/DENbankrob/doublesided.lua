function START_DOUBLE_SIDED_TRANSACTION(id)
	_createObject = createObject
	createObject = createObjectDoubleSided
end

function END_DOUBLE_SIDED_TRANSACTION()
	createObject = _createObject
end

function createObjectDoubleSided( ... )
	local temp = _createObject( unpack(arg) )
	setElementDoubleSided(temp, true)
	setElementDimension( temp, 1 )
	return temp
end