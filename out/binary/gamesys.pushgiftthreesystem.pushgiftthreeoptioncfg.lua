pushGiftThreeOptionCfg={}

local _unlockType=
{
eSystem=1,
}

local _unLockFunc=
{
[_unlockType.eSystem]=function(params)
local sysid=params[2]
return systemModel.isOpen(sysid)
end,
}

function pushGiftThreeOptionCfg.isUnlock(params)
if params==nil then return true end
for i,v in ipairs(params)do
local unlockType=v[1]
if _unLockFunc[unlockType]then
if not _unLockFunc[unlockType](v)then
return false
end
else
loggerUtil.logErrFMT('v3尚未支持可选礼包解锁类型:{0}',unlockType)
return false
end
end
return true
end