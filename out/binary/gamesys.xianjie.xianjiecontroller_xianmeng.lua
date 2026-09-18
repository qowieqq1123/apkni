function xianjieController:onAppStart_xianmeng()
socketManager:register_receiver(35,43,self.recv_35_43)
socketManager:register_receiver(35,156,self.recv_35_156)
socketManager:register_receiver(35,157,self.recv_35_157)
socketManager:register_receiver(35,184,self.recv_35_184)
end


function xianjieController:send_35_43(guid)
socketManager:send_35_43(guid)
end

function xianjieController:send_35_156(guildid)
socketManager:send_35_156(guildid)
end

function xianjieController:send_35_184(sceneidx,x,y)
socketManager:send_35_184(sceneidx,x,y)
end


function xianjieController.recv_35_43(guildid,assistLen,assistList)
if assistLen>0 then
for _,v in ipairs(assistList)do
if v.disciplelistlen>0 then
for _,vv in ipairs(v.guidlist)do
otherPlayerModel.detailDisciple_dzAttrList_int_to_int64(vv.dzAttrList)
end
end
end
end
xianjieModel:setXianMengGarrison(guildid,assistList or defaultT,timeHelper.getServerShortTime())
end

function xianjieController.recv_35_156(guildid,assistLen,assistList,dataSec)
if assistLen>0 then
for _,v in ipairs(assistList)do
if v.disciplelistlen>0 then
for _,vv in ipairs(v.guidlist)do
otherPlayerModel.detailDisciple_dzAttrList_int_to_int64(vv.dzAttrList)
end
end
end
end
xianjieModel:setXianMengGarrison(guildid,assistList or defaultT,dataSec)
end

function xianjieController.recv_35_157(dataSec)
local guildid=xianmengModel:myXMGuildID()
if guildid then
xianjieModel:refreshXianMengGarrisonTime(guildid,dataSec)
end
end

function xianjieController.recv_35_184(sceneidx,x,y,actorid)
if playerModel:checkActorId(actorid)then
UIManager.info("移动成功")
end
xianjieModel:addXianMengMoveTimes()
end