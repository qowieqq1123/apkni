




mysteryTrap={}

local _updateposList={}
local _updatecolorList={}
local _updatlayerList={}










function mysteryTrap.req_4_84(trapId)
socketManager:send_4_84(trapId)
mysteryTrap:setTrapPause(true)
end

function mysteryTrap.req_4_85(trapIdList)
socketManager:send_4_85(#trapIdList,trapIdList)
mysteryTrap:setTrapPause(true)

local trap=next(trapIdList)and trapIdList[1]
local trapConfig=cfgHelper.get(cfg_secretscenetrapconfig_get,trap)
if trapConfig and trapConfig.resultdelay then
mysteryTrap:setTrapEffectDelay(trapConfig.resultdelay)
end
end


function mysteryTrap.recv_4_83(fbid,len,trapList)
mysteryTrapModel:initTrapData(trapList)


local checkTrap2=mysteryTrap:checkTrapExe(mysteryRoomModel:get_cur_roomID(),mysteryPlayerModel:get_player_pos())
if checkTrap2 and next(checkTrap2)then
local list={}
for i,v in pairs(checkTrap2)do
table.insert(list,i)
end
mysteryTrap.req_4_85(list)
end
end

function mysteryTrap.recv_4_84(trap)
mysteryTrap:setTrapPause(false)
mysteryTrapModel:setTrapData(trap.trapId,trap)

mysteryTrapModel:init_grid_color(trap.trapId)
end

function mysteryTrap.recv_4_85(len,trapList)
mysteryTrap:setTrapPause(false)
local haveBegavior=false
if len>0 then
local behaviorList={}

for i,v in ipairs(trapList)do
if v.param_2>0 then
mysteryTrapModel:setTrapRstIndex(v.param_1,v.param_2)

local trapConfig=cfgHelper.get(cfg_secretscenetrapconfig_get,v.param_1)
if trapConfig then

if trapConfig.behavior then
haveBegavior=true
local trapMapData=mysteryTrapModel:getTrapMapData(v.param_1)
behaviorList[v.param_1]=true
mysteryPosBehevior:runBehaviorByPos(trapMapData.poslist,trapConfig.behavior,function()
behaviorList[v.param_1]=nil
if not next(behaviorList)then
mysteryTrap:setTrapPause(false)
mysteryEntityController.handle_meet()
end
end)
end













end
end
end
end

if haveBegavior then
mysteryTrap:setTrapPause(true)
else
mysteryEntityController.handle_meet()
end

mysteryTrap:setTrapEffectDelay(nil)
end

function mysteryTrap:initTrap()
local fbid=MysteryModel:get_cur_fbid()
if not fbid then return end
local cfg=cfgHelper.get(cfg_secretscenefubenconfig_get,fbid)
local trap=cfg.trap
if not trap then return end

for i,v in ipairs(trap)do
mysteryTrapModel:initTrapMapData(v)
end

mysteryTrap:start_color_change()


local checkTrap2=mysteryTrap:checkTrapExe(mysteryRoomModel:get_cur_roomID(),mysteryPlayerModel:get_player_pos())
if checkTrap2 and next(checkTrap2)then
local list={}
for i,v in pairs(checkTrap2)do
table.insert(list,i)
end
mysteryTrap.req_4_85(list)
end


end



function mysteryTrap:checkTrapStop(room,pos,offset)
local offsetStep=offset or 2
offsetStep=offsetStep-1

local trapId=mysteryTrapModel:getMapTrapByPos(room,pos)
if trapId then
local trapMapData=mysteryTrapModel:getTrapMapData(trapId)
if trapMapData then
local trapData=mysteryTrapModel:getTrapData(trapId)
if not trapData then
trapData={trapId=trapId,fdStep=0,cdStep=trapMapData.coldtime,times=0,rstIndex=0}

if trapData.cdStep+offsetStep>trapMapData.coldtime then
return trapId
end
else
if trapData.times<trapMapData.times then
if trapData.fdStep>=0 and trapData.fdStep+offsetStep>=trapMapData.waittime and trapData.rstIndex==0 then
return trapId
end
if trapData.cdStep+offsetStep>trapMapData.coldtime then
return trapId
end
end
end


end
end


local allTrap=mysteryTrapModel:getAllTrapMapData()
if allTrap then
local roomId=mysteryRoomModel:get_cur_roomID()
for trapId,trapMapData in pairs(allTrap)do
if roomId==trapMapData.room then
local trapData=mysteryTrapModel:getTrapData(trapId)
if not trapData then
trapData={trapId=trapId,fdStep=0,cdStep=trapMapData.coldtime,times=0,rstIndex=0}
end
if trapData.times<trapMapData.times then
if trapData.fdStep>0 and trapData.fdStep+offsetStep>=trapMapData.waittime then
return trapId
end
end
end
end
end
end


function mysteryTrap:checkTrap(room,pos)

local trapId=mysteryTrapModel:getMapTrapByPos(room,pos)
if trapId then
local trapMapData=mysteryTrapModel:getTrapMapData(trapId)
if trapMapData then
local trapData=mysteryTrapModel:getTrapData(trapId)
if not trapData then
trapData={trapId=trapId,fdStep=0,cdStep=trapMapData.coldtime,times=0,rstIndex=0}
end

if trapData.times>=trapMapData.times then
return
end

if trapMapData.waittime==0 then
return
end

if trapData.rstIndex==1 and trapData.cdStep<=trapMapData.coldtime then
return
end

if trapData.fdStep>0 and trapData.fdStep<trapMapData.waittime then
return
end

return trapId
end
end
end


function mysteryTrap:checkTrapExe(room,pos)
local exeTrap={}
local trapId=mysteryTrapModel:getMapTrapByPos(room,pos)
if trapId then
local trapMapData=mysteryTrapModel:getTrapMapData(trapId)
if trapMapData then
local trapData=mysteryTrapModel:getTrapData(trapId)
if not trapData then
trapData={trapId=trapId,fdStep=0,cdStep=trapMapData.coldtime,times=0,rstIndex=0}
end
if trapData.times<=trapMapData.times then
if trapMapData.waittime==0 and trapData.rstIndex==1 and trapData.cdStep>trapMapData.coldtime then
exeTrap[trapId]=1
else
if trapData.rstIndex==0 and trapData.fdStep>=trapMapData.waittime then
exeTrap[trapId]=1
end
end
end
end
end


local allTrap=mysteryTrapModel:getAllTrapMapData()
if allTrap then
local roomId=mysteryRoomModel:get_cur_roomID()
for trapId,trapMapData in pairs(allTrap)do
if roomId==trapMapData.room then
local trapData=mysteryTrapModel:getTrapData(trapId)
if not trapData then
trapData={trapId=trapId,fdStep=0,cdStep=trapMapData.coldtime,times=0,rstIndex=0}
end
if not(trapData.rstIndex==1 and trapData.cdStep<=trapMapData.coldtime)then

if trapData.rstIndex==0 and trapData.times<=trapMapData.times then
if trapData.fdStep>0 and trapData.fdStep>=trapMapData.waittime then
exeTrap[trapId]=1
end
end

end
end
end
end

return exeTrap
end

function mysteryTrap:updateTrapStep(moveStep)
local allTrap=mysteryTrapModel:getAllTrapMapData()
if allTrap then
for trapId,trapMapData in pairs(allTrap)do
local trapData=mysteryTrapModel:getTrapData(trapId)
if trapData then

if trapData.times<=trapMapData.times then
if trapData.rstIndex==0 then
trapData.fdStep=trapData.fdStep+moveStep
if trapData.fdStep>=trapMapData.waittime then
trapData.fdStep=trapMapData.waittime
end
end
if(trapData.rstIndex==1)and trapMapData.coldtime>0 then
trapData.cdStep=trapData.cdStep+moveStep



end


local hudList=trapMapData.hudList

if hudList and trapData.rstIndex==0 then
for guid,v in pairs(hudList)do
MysteryController.refreshUIHUD(guid,"refreshStep",trapMapData.waittime-trapData.fdStep)
end
end
end
end
end

end
end

function mysteryTrap:setTrapPause(pause)
if pause then
MysteryModel.currentFBData.trapPause=timeHelper.getServerShortTime()
else
MysteryModel.currentFBData.trapPause=nil
end
end

function mysteryTrap:isTrapPause()
local now=timeHelper.getServerShortTime()
local pause=MysteryModel.currentFBData.trapPause
if pause and now-pause<10 then
return true
end
end

function mysteryTrap:setTrapEffectDelay(delay)
MysteryModel.currentFBData.trapDelay=delay
end

function mysteryTrap:getTrapEffectDelay()
return MysteryModel.currentFBData.trapDelay
end




function mysteryTrap:start_color_change()
if self.updateTimer then
return
end
local colorGrids=mysteryTrapModel:get_grid_color_list()
if colorGrids and next(colorGrids)then
self.updateTimer=timer.new()

self.startColor=mysteryTrapModel:get_start_color()
if not self.updateCB then
self.updateCB=function()
self:update_color_change()
end
end

self:update_color_change()
if self.updateTimer then
self.updateTimer:start(0,self.updateCB)
end
end
end

function mysteryTrap:update_color_change()
local colorGrids=mysteryTrapModel:get_grid_color_list()
if colorGrids==nil or next(colorGrids)==nil and self.updateTimer then
self.updateTimer:cancel()
self.updateTimer=nil
end
local delta=0.02
local color=nil
local newVal=nil
local lerpVal=nil
local trapData=nil

table.clear(_updateposList)
table.clear(_updatecolorList)
table.clear(_updatlayerList)
for guid,v in pairs(colorGrids)do
trapData=mysteryTrapModel:getTrapMapData(guid)
if trapData then
local colorPosList=trapData.poslist
if colorPosList then
local colorRange=2
if v>0 then
newVal=v+delta*colorRange
if newVal>1 then
newVal=-0.01
end
else
newVal=v-delta*colorRange
if newVal<-1 then
newVal=0.01
end
end

local endColor=mysteryTrapModel:get_end_color()
lerpVal=newVal<0 and(1+newVal)or newVal
color=Color.Lerp(self.startColor,endColor,lerpVal)
local groundLayer=mysteryRoomModel:get_GroundLayer(trapData.room)
for _,pos in pairs(colorPosList)do
local posGuid=MysteryModel:get_grid_have_entity(trapData.room,pos)
if posGuid==-guid or posGuid==nil then
table.insert(_updateposList,pos)
table.insert(_updatecolorList,color)
table.insert(_updatlayerList,groundLayer)

mysteryTrapModel:set_color_grid_entity(guid,newVal)
MysteryModel:add_grid_color_entity(trapData.room,pos,-guid)
end
end
end
end
end

if next(_updateposList)then
_HexMapManager.SetTileAddColorList(_updateposList,_updatecolorList,_updatlayerList)
end
end