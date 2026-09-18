pushGiftHideControl=gameState.addListener({})

local _lookupCfg

local _hideType=
{
eLevel=1,
}


local _hideFunc=
{
[_hideType.eLevel]=function(param)
local maxlv=param[2]
return zongmenModel:getLevel()>=maxlv
end,
}



function pushGiftHideControl:onAppStart()
socketManager:addNotify(3,2,function(level)
pushGiftHideControl:onChange(_hideType.eLevel)
end)
self:initCfg()
end

function pushGiftHideControl:onProtocolReq()
pushGiftModel:initAllhideGift()
end



function pushGiftHideControl:initCfg()
_lookupCfg={}
local cfgs=pushGiftConfig.getAllConfig()
for _,v in pairs(cfgs)do
local cfg=v
local param=cfg.openconf[5]
if param then
local typo=param[1]
if _lookupCfg[typo]==nil then _lookupCfg[typo]={}end
local cfg=_lookupCfg[typo]
cfg[#cfg+1]=v.id
end
end
end


function pushGiftHideControl:isHide(id)

if verifyManager:isHideBusinessActivity()then
return true
end
if not systemModel.isOpen(SYSTEM_DEFINE.eLimitedTimeGift)then return false end
if not initProControl.isDone()then return false end
local param=pushGiftConfig.getHideConfig(id)
if param==nil or param[1]==nil then return false end
local funcType=param[1]
if _hideFunc[funcType]then
return _hideFunc[funcType](param)
end
return false
end

function pushGiftHideControl:onChange(changType)
if not systemModel.isOpen(SYSTEM_DEFINE.eLimitedTimeGift)then return end
if not initProControl.isDone()then return end
local list=_lookupCfg[changType]
if list==nil then return end
for _,id in ipairs(list)do
pushGiftModel:checkhideGift(id)
end
end