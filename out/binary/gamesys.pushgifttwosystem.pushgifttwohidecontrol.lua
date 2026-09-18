pushGiftTwoHideControl=gameState.addListener({})

local _lookupCfg

local _hideType=
{
eLevel=1,
eXJTeamjihuo=2,
}

local _hideFunc=
{
[_hideType.eLevel]=function(param,id)
local maxlv=param[2]
local zongmenLvl=zongmenModel:getLevel()
if zongmenLvl<maxlv then
loggerUtil.log(FMT.fmt("pushGiftTwoHide,nohide {0}-{1}-{2}",id,zongmenLvl,maxlv))
end
return zongmenLvl>=maxlv
end,
[_hideType.eXJTeamjihuo]=function(param)
local teamindx=param[2]
local ishide=false
if teamindx==3 then
ishide=xianjieModel:getCloudIsRecvQueue()
elseif teamindx==4 then
local handle=seasonModel:getHandle(0)
if handle and handle:checkComplete()then

ishide=true
end
end
return ishide
end,
}



function pushGiftTwoHideControl:onAppStart()
socketManager:addNotify(3,2,function(level)
pushGiftTwoHideControl:onChange(_hideType.eLevel)
end)
notifySystem:listenNotify(notifyConfig.home_event,function(etype)
if etype==homeEvent.eEnterHome then
pushGiftTwoHideControl:onChange(_hideType.eXJTeamjihuo)
end
end)
socketManager:addNotify(39,1,function()
pushGiftTwoHideControl:onChange(_hideType.eXJTeamjihuo)
end)
self:initCfg()
end

function pushGiftTwoHideControl:onProtocolReq()

end


function pushGiftTwoHideControl:initCfg()
_lookupCfg={}

local add=function(cfg)
local param=cfg.openconf[5]
if param then
local typo=param[1]
if _lookupCfg[typo]==nil then _lookupCfg[typo]={}end
local lookupCfg=_lookupCfg[typo]
lookupCfg[#lookupCfg+1]=cfg.id
end
end

local cfgs=pushGiftTwoConfig.getAllConfig()
for _,v in pairs(cfgs)do
add(v)
end

local cfgs=pushGiftTwoConfig.getAllTimeConfig()
for _,v in pairs(cfgs)do
add(v)
end
end


function pushGiftTwoHideControl:isHide(id)

if verifyManager:isHideBusinessActivity()then
return true
end
if not systemModel.isOpen(SYSTEM_DEFINE.eLimitedTimeGift2)then return false end
if not initProControl.isDone()then return false end
local param=pushGiftTwoConfig.getHideConfig(id)
if param==nil or param[1]==nil then return false end
local funcType=param[1]
if _hideFunc[funcType]then
return _hideFunc[funcType](param,id)
end
return false
end

function pushGiftTwoHideControl:onChange(changType)
if not systemModel.isOpen(SYSTEM_DEFINE.eLimitedTimeGift2)then return end
if not initProControl.isDone()then return end
local list=_lookupCfg[changType]
if list==nil then return end
for _,id in ipairs(list)do
if pushGiftTwoModel:checkhideGift(id)then
pushGiftTwoController:removeAdvertParams(id)
end
end
end