pushGiftThreeHideControl=gameState.addListener({})

local _lookupCfg

local _hideType=
{
eLevel=1,
eXJTeamjihuo=2,
}


local _hideFunc=
{
[_hideType.eLevel]=function(param)
local maxlv=param[2]
return zongmenModel:getLevel()>=maxlv
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



function pushGiftThreeHideControl:onAppStart()
socketManager:addNotify(3,2,function(level)
pushGiftThreeHideControl:onChange(_hideType.eLevel)
end)
notifySystem:listenNotify(notifyConfig.home_event,function(etype)
if etype==homeEvent.eEnterHome then
pushGiftThreeHideControl:onChange(_hideType.eXJTeamjihuo)
end
end)
socketManager:addNotify(39,1,function()
pushGiftThreeHideControl:onChange(_hideType.eXJTeamjihuo)
end)
self:initCfg()
end

function pushGiftThreeHideControl:onProtocolReq()

end



function pushGiftThreeHideControl:initCfg()
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

local cfgs=pushGiftThreeConfig.getAllConfig()
for _,v in pairs(cfgs)do
if v.id then
add(v)
end
end

local cfgs=pushGiftThreeConfig.getAllTimeConfig()
for _,v in pairs(cfgs)do
if v.id then
add(v)
end
end
end


function pushGiftThreeHideControl:isHide(id)

if verifyManager:isHideBusinessActivity()then
return true
end
if not systemModel.isOpen(SYSTEM_DEFINE.eLimitedTimeGift3)then return false end
if not initProControl.isDone()then return false end
local param=pushGiftThreeConfig.getHideConfig(id)
if param==nil or param[1]==nil then return false end
local funcType=param[1]
if _hideFunc[funcType]then
return _hideFunc[funcType](param)
end
return false
end

function pushGiftThreeHideControl:onChange(changType)
if not systemModel.isOpen(SYSTEM_DEFINE.eLimitedTimeGift3)then return end
if not initProControl.isDone()then return end
local list=_lookupCfg[changType]
if list==nil then return end
for _,id in ipairs(list)do
if pushGiftThreeModel:checkhideGift(id)then
pushGiftThreeController:removeAdvertParams(id)
end
end
end