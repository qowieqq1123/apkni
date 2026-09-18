





xingChenBagProtocolControl=gameState.addListener({})



function xingChenBagProtocolControl:onAppStart()
socketManager:register_receiver(37,77,self.recv_37_77)
socketManager:register_receiver(37,78,self.recv_37_78)
socketManager:register_receiver(37,79,self.recv_37_79)

socketManager:register_receiver(37,90,self.recv_37_90)

socketManager:register_receiver(37,91,self.recv_37_91)

socketManager:register_receiver(37,92,self.recv_37_92)

socketManager:register_receiver(37,93,self.recv_37_93)
socketManager:register_receiver(37,94,self.recv_37_94)
end

function xingChenBagProtocolControl:onEnterState()
xingChenBagModel:onEnterState()
end

function xingChenBagProtocolControl:onLeaveState()
xingChenBagModel:onLeaveState()
end


function xingChenBagProtocolControl.req_37_90(pos,guid)
socketManager:send_37_90(pos,guid)
end


function xingChenBagProtocolControl.req_37_91(pos)
socketManager:send_37_91(pos)
end

function xingChenBagProtocolControl.req_37_92(len,guidList)
socketManager:send_37_92(len,guidList)
end


function xingChenBagProtocolControl.req_37_77(main_guid,child_guid,is_use)
socketManager:send_37_77(main_guid,child_guid,is_use)
end


function xingChenBagProtocolControl.req_37_78(main_guid)
socketManager:send_37_78(main_guid)
end


function xingChenBagProtocolControl.req_37_79(child_guid)
socketManager:send_37_79(child_guid)
end


function xingChenBagProtocolControl.req_37_93(pos,len,guidList,len2,itemList)
socketManager:send_37_93(pos,len,guidList,len2,itemList)
end


function xingChenBagProtocolControl.req_37_94(pos)
socketManager:send_37_94(pos)
end


function xingChenBagProtocolControl.recv_37_77(args)
local main_stars_guid,minor_stars_guid,is_use,is_replace,affix_len,affixList,after_star=unpack(args)
is_use=1
xingChenHelper.onXingChenRongHe(main_stars_guid,minor_stars_guid,is_use,is_replace,affix_len,affixList,after_star)


if is_replace==1 then
UIManager:callWindowFunc("UIXJLittleWorldXingChenRongHeWin","recvRongHe",affixList)
else
UIManager:callWindowFunc("UIXJLittleWorldXingChenRongHeWin","recvRongHeNoUse",affixList)
end
xingChenBagProtocolControl.is_use=is_replace


end

function xingChenBagProtocolControl.recv_37_78(main_stars_guid,rare_id)
xingChenHelper.onXingChenRongHeEnd(main_stars_guid,rare_id)

if xingChenBagProtocolControl.is_use==1 then
UIManager:callWindowFunc("UIXJLittleWorldXingChenRongHeWin","recvRongHeEnd")
end

xingChenBagProtocolControl.is_use=nil

xingChenBagModel:setStarEffectDirty()

LittleWorldModel:dirtyAllDiscipleAttribute()

notifySystem:postNotify(notifyConfig.onXCEquipChangebyMix)
end

function xingChenBagProtocolControl.recv_37_79(mainguid)
xingChenHelper.onXingChenFenLiEnd(mainguid)
xingChenBagModel:setStarEffectDirty()
UIManager:callWindowFunc("UIXJLittleWorldXingChenRongHeWin","recvRongHeCancel")

end


function xingChenBagProtocolControl.recv_37_90(pos,stars_guid)
xingChenBagModel:onDressEquip(pos,stars_guid)


UIManager:callWindowFunc("UIXJLittleWorldXingChenWin","refreshLeft")


UIManager:callWindowFunc("UIXJLittleWorldXingChenInfoWin","refresh")
UIManager:callWindowFunc("UIPlanent","refreshStar",pos)

UIManager.info("装配成功")
end

function xingChenBagProtocolControl.recv_37_91(pos)
xingChenBagModel:onTakeOffEquip(pos)

UIManager:callWindowFunc("UIXJLittleWorldXingChenWin","refreshLeft")
UIManager:callWindowFunc("UIXJLittleWorldXingChenBagWin","refreshBagListPanel")
UIManager:callWindowFunc("UIXJLittleWorldXingChenInfoWin","refresh")
UIManager:callWindowFunc("UIPlanent","refreshStar",pos)

UIManager.info("脱下成功")
end

function xingChenBagProtocolControl.recv_37_92(len,guidList)
if len>0 then
local lookup={}
for i,v in ipairs(guidList)do
lookup[tostring(v)]=true
end

xingChenBagModel:deleleItemlist(len,lookup)
end
UIManager:callWindowFunc("UIXJLittleWorldXingChenFenJieWin","recvFenJie")
end

function xingChenBagProtocolControl.recv_37_93(pos,new_lv,new_exp)
xingChenBagModel:setOrbitLevel(pos,new_lv)
xingChenBagModel:setExp(pos,new_exp)
UIManager:callWindowFunc("UIXJLittleWorldXingChenUpWin","recvUpgrade")
notifySystem:postNotify(notifyConfig.onXingGuiLvChange,pos,new_lv)

UIManager:callWindowFunc("UIPlanent","playOrbitLevelEffect",pos)
LittleWorldModel:dirtyAllDiscipleAttribute()
end

function xingChenBagProtocolControl.recv_37_94(pos)
local oriStar=xingChenBagModel:getOrbitLevel(pos)


xingChenBagModel:setOrbitLevel(pos,oriStar+1)
xingChenBagModel:setExp(pos,0)

UIManager:callWindowFunc("UIXJLittleWorldXingChenUpWin","recvBroke",pos)

notifySystem:postNotify(notifyConfig.onXingGuiLvChange,pos)

LittleWorldModel:dirtyAllDiscipleAttribute()
end

