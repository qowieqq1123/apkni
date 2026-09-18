local mojieshopdata=nil
function funcShopModel:clearData_mojiesd()
mojieshopdata=nil
end

local checkMJUnLockFunc=
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













local seasonId=xianjieController:getMoJieSaiJiID()
if not seasonId then
return false
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
[funcShopUnlockType.eMoJieJieDuan]=function(args)
local nowchapteridx,stage=xianjieController:getMoJieSaiJiChapteridx()
if not nowchapteridx then
return false
end
return args[2]<=nowchapteridx
end
}
function funcShopModel:CheckMoJie(id,data)
if checkMJUnLockFunc[id]then
return checkMJUnLockFunc[id](data)
end
return false
end

function funcShopModel:initData_mojiesd()
mojieshopdata={}
end
function funcShopModel:SetMoJieShop(buyListLen,buyList)
mojieshopdata={}
if buyListLen>0 then
for k,v in ipairs(buyList)do
local cfg=cfg_devildomshopconfig_get(v.buyId)
if cfg.group then

if mojieshopdata[cfg.group]then
mojieshopdata[cfg.group]=mojieshopdata[cfg.group]+v.buyNum
else
mojieshopdata[cfg.group]=v.buyNum
end

end
end
end
end

function funcShopModel:ChangeMoJieShop(buyId,buyNum)
local cfg=cfg_devildomshopconfig_get(buyId)
if cfg.group then
if mojieshopdata[cfg.group]then
mojieshopdata[cfg.group]=mojieshopdata[cfg.group]+buyNum
else
mojieshopdata[cfg.group]=buyNum
end
end
end

function funcShopModel:GetMoJieShop()
return mojieshopdata
end


function funcShopModel:findNumMoJie(buyId)
local cfg=cfg_devildomshopconfig_get(buyId)
if cfg.group then
if mojieshopdata[cfg.group]then
return mojieshopdata[cfg.group]
else
return 0
end
end
end