




homeBuffControl=gameState.addListener({})


function homeBuffControl:onAppStart()
socketManager:register_receiver(3,15,self.initHomeStateList)
socketManager:register_receiver(3,16,self.onHomeStateAdd)
socketManager:register_receiver(3,17,self.onHomeStableDelete)
end

function homeBuffControl:onEnterState()
homeBuffModel.init()
homeBuffModel.startTimer()

end

function homeBuffControl:onLeaveState()
homeBuffModel.stopTimer()
homeBuffModel.init()
end

function homeBuffControl:onPlayerCreate()
homeBuffControl.freshWindow()
end



function homeBuffControl.initHomeStateList(len,list)
homeBuffModel.initStateList(list)
homeBuffControl.freshWindow()
end

function homeBuffControl.onHomeStateAdd(id,endtime,guid,src)
homeBuffModel.addState(guid,id,endtime,true,src)
homeBuffControl.freshWindow(id)
end

function homeBuffControl.onHomeStableDelete(id,guid)
homeBuffModel.removeStateById(id,guid)
homeBuffControl.freshWindow()
end

function homeBuffControl.reqHomeStateList()
socketManager:send_3_15()
end


function homeBuffControl.freshWindow(id)
local list=homeBuffModel.getAllList()
if UIManager:isActive('UIHomeBuffWin')then
homeBuffModel.readAllBuff()
UIManager:callWindowFunc('UIHomeBuffWin','onShow',{list=list,isInit=true})
end

notifySystem:postNotify(notifyConfig.onZongMenBuffFresh,id)
end

function homeBuffControl.showWindow(isInit)
local list=homeBuffModel.getAllList()
UIManager:showWindow('UIHomeBuffWin',{list=list,isInit=isInit})
end

function homeBuffControl.onBuffClick()
if UIManager:isActive('UIHomeBuffWin')then

local callback=function()
UIManager:closeWindow('UIHomeBuffWin')
end
UIManager:invokeUIMethod('UIHomeBuffWin','hideHomeBuffPanel',callback)
else
homeBuffControl.showWindow()
homeBuffModel.readAllBuff()

end
end

function homeBuffControl.sort(list)
if list and#list>1 then
table.sort(list,function(a,b)
local aId=a[1]
local bId=b[1]
local aCfg=cfg_guildstateconfig_get(aId)
local bCfg=cfg_guildstateconfig_get(bId)
local aTag=(aCfg.sort or 0)*1000-aId
local bTag=(bCfg.sort or 0)*1000-bId
return aTag>bTag
end)
end
end

function homeBuffControl.checkInfuenceAutoInvreaseByBuff(type)
local list=homeBuffModel.getEffectList()
local isInf=false
local infVal=100
for k,buffData in pairs(list)do
local buffId=buffData[1]
local effects=cfgHelper.get2(cfg_guildstateconfig_get,buffId,'effects')
for k,effectId in ipairs(effects)do
local buffCfg=cfgHelper.get2(cfg_guildstateeffectconfig_get,effectId)
if buffCfg.effect_type==18 then
local includeList=buffCfg.param[1]
if table.findValue(includeList,type)then
isInf=true
infVal=infVal+buffCfg.param[2]
end
end
end

end
return isInf,infVal
end