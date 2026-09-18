local shanhaishopdata=nil
function funcShopModel:clearData_shanhai()
shanhaishopdata=nil
end

local checkZZSHUnLockFunc=
{

[funcShopUnlockType.eZongMenLevel]=function(args)
local zmLevel=zongmenModel:getLevel()
if args[3]then
return args[2]<=zmLevel and args[3]>=zmLevel
else
return args[2]<=zmLevel
end

end,

[funcShopUnlockType.eSystem]=function(args)
return systemModel.isOpen(args[2])
end,

[funcShopUnlockType.eXianMengLevel]=function(args)
return args[2]<=(xianmengModel:getXMLevel()or 0)
end,

[funcShopUnlockType.eXianMengDuanWei]=function(args)

local level=lingxuwenjianModel:getScoreLevel()

return args[2]<=level
end,

[funcShopUnlockType.eXianMengZhanSaiJi]=function(args)


local nowsaiji=zhengzhanshanhaiModel:getRaceIndex()
local shSeasonId=zhengzhanshanhaiModel:getSHSeasonId()
local seasonId
if shSeasonId==-1 then

seasonId=nowsaiji
else

seasonId=shSeasonId+1
end
local minNeedSeasonId=args[2]
local maxNeedSeasonId=args[3]
if maxNeedSeasonId then
return minNeedSeasonId<=seasonId and maxNeedSeasonId>=seasonId
else
return seasonId>=minNeedSeasonId
end
end,
[funcShopUnlockType.eTimeLimit]=function(args)
local nowTime=timeHelper.getServerLongTime()
local startTime=timeHelper.dataToTimeStam(args[2])
if args[3]then
local endTime=timeHelper.dataToTimeStam(args[3])
return nowTime>=startTime and nowTime<=endTime
else
return nowTime>=startTime
end
end,
[funcShopUnlockType.ePlatformLimit]=function(args)
local limitType=args[2]

local pfId=gameUtilityModel.getServerPlatform()
local limitList=args[3]
if limitType==1 then

if limitList[pfId]==1 then
return true
end
return false
elseif limitType==2 then

if limitList[pfId]==1 then
return false
end
return true
end
end,
}
function funcShopModel:CheckShanHai(id,data)
if checkZZSHUnLockFunc[id]then
return checkZZSHUnLockFunc[id](data)
end
return false
end

function funcShopModel:initData_shanhai()
shanhaishopdata={}
end
function funcShopModel:SetShanHaiShop(buyListLen,buyList)
shanhaishopdata={}
if buyListLen>0 then

for k,v in ipairs(buyList)do
local cfg=cfg_shanhaishopconfig_get(v.buyId)
if cfg.group then

if shanhaishopdata[cfg.group]then
shanhaishopdata[cfg.group]=shanhaishopdata[cfg.group]+v.buyNum
else
shanhaishopdata[cfg.group]=v.buyNum
end

end

end
end
end

function funcShopModel:ChangeShanHaiShop(buyId,buyNum)
local cfg=cfg_shanhaishopconfig_get(buyId)
if cfg.group then
if shanhaishopdata[cfg.group]then
shanhaishopdata[cfg.group]=shanhaishopdata[cfg.group]+buyNum
else
shanhaishopdata[cfg.group]=buyNum
end
end
end

function funcShopModel:GetShanHaiShop()
return shanhaishopdata
end


function funcShopModel:findNum(buyId)
local cfg=cfg_shanhaishopconfig_get(buyId)
if cfg.group then
if shanhaishopdata[cfg.group]then
return shanhaishopdata[cfg.group]
else
return 0
end
end
end