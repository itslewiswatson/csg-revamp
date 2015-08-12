--[[
Any unauthorized reprint or use of this material is prohibited.
No part of this script may be reproduced or transmitted in any form or by
Any means, electronic or mechanical, including photocopying, recording,
Or by any information storage and retrieval system without express written
Permission from the author / publisher. 

(C) Jesseunit AkA. Achille, 
ALL RIGHTS RESERVED
]]--






dff = engineLoadDFF ( "files/smoke_flare.dff", 0 )
engineReplaceModel ( dff, 1337 )

dff2 = engineLoadDFF ( "files/shootlight.dff", 0 )
engineReplaceModel ( dff2, 1338 )
    
dff3 = engineLoadDFF ( "files/smoke30m.dff", 0 )
engineReplaceModel ( dff3, 2057 )

addEvent("playBoom", true)



addEventHandler("playBoom", root, function(x, y, z)
        boom = playSound3D("files/fwSound.mp3", x, y, z, false)
        setSoundVolume(boom, 1)
        setSoundMaxDistance(boom, 200)
    end)