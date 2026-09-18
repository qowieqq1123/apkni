







local hudLookup={}
local hudLookup_update={}

local hudList_wait={}
local hudList_waitEx={}
local hudParent
local hudParent2












xianjieController.hud1Cfg={0,nil,0.04,1,0,1}
xianjieController.hud2Cfg={0,nil,0.03,1,0.7,1}
xianjieController.hudExCfg={0,nil,0.03,1,0.7,1}
xianjieController.entityHudPerCreateNum=2
function xianjieController:initHudParams()
local lodRange=xianjieController:getCameraLodRange()
local hudcfg,lodLevel

lodLevel=0
hudcfg=xianjieController.hud1Cfg
hudcfg[2]=lodRange[lodLevel+1]

lodLevel=1
hudcfg=xianjieController.hud2Cfg
hudcfg[2]=lodRange[lodLevel+1]

lodLevel=0
hudcfg=xianjieController.hudExCfg
hudcfg[2]=lodRange[lodLevel+1]
end

function xianjieController:getHudParams(hudType)
if hudType==1 then
return xianjieController.hud1Cfg
elseif hudType==2 then
return xianjieController.hud2Cfg
elseif hudType==3 then
return xianjieController.hudExCfg
end
end


function xianjieController:setHUDParent(parent)
hudParent=parent
if parent==nil then
xianjieController.hudWinActive=nil
end
end

function xianjieController:getHUDParent(entityType)
if hudParent==nil then
return
end
local cfg=cfg_xianjieentityconfig_get(entityType)
local HUDsortOrder=cfg.HUDsortOrder
return hudParent[HUDsortOrder]or hudParent[1]
end


function xianjieController:activeHudWin(flag)
if xianjieController.hudWinActive~=flag then
xianjieController.hudWinActive=flag
UIManager:invokeUIMethod('UIXianJieHudWin','activeWin',flag)
end
end

function xianjieController:checkHudWinActive()
local flag=xianjieController.hudWinActive
return flag==nil or flag==true
end

function xianjieController:aWakeWaitHud()
if hudParent~=nil then
local nun=300
local useNun=xianjieController.perWidgetCreateNum

for key,hudType in pairs(hudList_wait)do
hudList_wait[key]=nil
local ent=xianjieController:getEntity(key)
if ent then
useNun=useNun-1
ent:checkHudMark(hudType)
end
nun=nun-1
if nun<0 or useNun<0 then
break
end
end
if useNun>0 then
for key,hudType in pairs(hudList_waitEx)do
local ent=xianjieController:getEntity(key)
hudList_waitEx[key]=nil
nun=nun-1
if ent then
useNun=useNun-1
ent:checkHudExMark(hudType)
end

if nun<0 or useNun<0 then
break
end
end
end
end
end

function xianjieController:getEntityHud(mID)
if mID==nil then return end
return hudLookup[mID]
end

function xianjieController:addEntityHudImp(hudType,entityType,key,data)
local hud=new_xjEntityHud(hudType,entityType,key,data)
local mID=hud.m_ID
assert(hudLookup[mID]==nil)
hudLookup[mID]=hud
if hud.onUpdate then
hudLookup_update[mID]=hud
end
return mID
end

function xianjieController:addEntityHudExImp(hudType,entityType,key,data)
local hud=new_xjEntityHud(hudType,entityType,key,data)
local mID=hud.m_ID
assert(hudLookup[mID]==nil)
hudLookup[mID]=hud
if hud.onUpdate then
hudLookup_update[mID]=hud
end
return mID
end


function xianjieController:addEntityHud(hudType,entityType,key,data)










if hudList_wait~=nil then
hudList_wait[key]=hudType
end

end

function xianjieController:addEntityHudEx(hudType,entityType,key,data)










if hudList_waitEx~=nil then
hudList_waitEx[key]=hudType
end

end

function xianjieController:removeEntityHud(mID,key)
if mID~=nil then
local hud=xianjieController:getEntityHud(mID)
if hud then
release_xjEntityHud(hud)
hudLookup[mID]=nil
hudLookup_update[mID]=nil
end
end
if key~=nil then
if hudList_wait[key]~=nil then
hudList_wait[key]=nil
end
end
end

function xianjieController:removeEntityHudEx(mID,key)
if mID~=nil then
local hud=xianjieController:getEntityHud(mID)
if hud then
release_xjEntityHud(hud)
hudLookup[mID]=nil
hudLookup_update[mID]=nil
end
end
if key~=nil then
if hudList_waitEx[key]~=nil then
hudList_waitEx[key]=nil
end
end
end

function xianjieController:clearAllEntityHud()
if hudLookup~=nil and next(hudLookup)~=nil then
hudLookup={}
hudLookup_update={}



clear_xjEntityHudLookup()
end
hudList_wait={}
end

function xianjieController:updataAllEntitiyHud()
if hudLookup_update~=nil then
for mID,hud in pairs(hudLookup_update)do
if not hud.updataError then
if hud.pcallUpdateFunc1==nil then
hud.pcallUpdateFunc1=function()
hud:onUpdate()
end
hud.pcallUpdateFunc2=function(err)
hud.updataError=true
loggerUtil.logErrFMT('xjHUD onUpdate err!{0}',err)
end
end
xpcall(hud.pcallUpdateFunc1,hud.pcallUpdateFunc2)
end

end
end
end

function xianjieController:invokeEntityHudFunc(mID,funcName,...)
if mID==nil then return end
local hud=xianjieController:getEntityHud(mID)
if hud then
local f=hud[funcName]
if f~=nil then
return f(hud,...)
end
end
end
