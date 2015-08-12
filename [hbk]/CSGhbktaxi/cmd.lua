function TaxiCommand ( player, command )
  local x,y,z = getElementPosition(player)
  local callername = getPlayerName(player)
  outputChatBox("Your request for a taxi has been sent!",player, 255, 255, 0)
       local x,y,z = getElementPosition(player)
       local zonename = getZoneName(x,y,z)
     for i,p in pairs( getElementsByType( "player" ) ) do
          if ( getElementModel( p) == 20 ) then
              if p ~= player then

             outputChatBox (""..callername.." Called a Taxi at "..zonename.."!", p, 0, 255, 0, false )
            end
end
end
end
addCommandHandler ( "taxi", TaxiCommand )




function TaxiCancelCommand ( player, command )
 local x,y,z = getElementPosition(player)
  local callername = getPlayerName(player)
  outputChatBox("You Canceled taxi",player, 255, 0, 0)
  local x,y,z = getElementPosition(player)
       local zonename = getZoneName(x,y,z)
  for i,p in pairs( getElementsByType( "player" ) ) do
          if ( getElementModel( p) == 20 ) then
              if p ~= player then
    outputChatBox (""..callername.." Canceled Taxi at "..zonename.."!", p, 255, 0, 0, false )

end
end

end

end
addCommandHandler ( "ctaxi", TaxiCancelCommand )
