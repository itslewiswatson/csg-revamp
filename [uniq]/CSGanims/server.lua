addEvent( "startAnim", true )
function startAnim ( block, anim)
	setPedAnimation(source,block,anim,-1, true, false, true, true)
end
addEventHandler ("startAnim", root, startAnim)

addEvent ( "stopAnim", true )
function stopAnim ()
	setPedAnimation(source) 
end
addEventHandler ( "stopAnim", root, stopAnim )
