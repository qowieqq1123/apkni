







playerModel={}

HeadKuangAnimType={
eSequence=1,
eSpine=2,
}

local netData=nil
local _otherData={}
local _init=false
local _defaultHeadLookup=nil
local _defaultName=nil

function playerModel:InitNetData(args1,args2,args3,args4,args5)





netData={}
netData.actorHandle=args1
netData.actorID=args2
netData.actorName=args3
netData.serverID=args4
netData.sex=args5
_init=true
return netData
end

function playerModel:resetData()
netData=nil
_otherData={}
_init=false
end

function playerModel:checkInit(isWarming)
if _init==false then
if isWarming then

end
return false
end
return true
end

function playerModel:lostConnection()
_init=false
end

function playerModel:onProtocolReq()
_defaultName=cfgHelper.get3(cfg_noviciateconfig_get,"defaultPlayerName","value",1)
end


function playerModel:getActorHandle()
if not playerModel:checkInit(true)then return end
return netData.actorHandle
end

function playerModel:getActorID()
if not playerModel:checkInit(true)then return end
return netData.actorID
end
function playerModel:getActorIDStr()
local actorid=playerModel:getActorID()
if actorid then
return mathHelper.int64_to_string(actorid)
end
end

function playerModel:checkActorNameDefault()
if not playerModel:checkInit(true)then return end
return mathHelper.int64_to_string(netData.actorID)==netData.actorName
end

function playerModel:getActorName()
local check=playerModel:checkActorNameDefault()
if check==nil or check==true then
return _defaultName
end
return netData.actorName
end

function playerModel:getOtherActorName(name)
if not name or name==''then return'神秘祖师'end
return name
end


function playerModel:getOtherZongMenName(name)
if not name or name==''then return'隐秘宗门'end
return name
end



function playerModel:getActorServerID()
if not playerModel:checkInit(true)then return end
return netData.serverID
end

function playerModel:getActorSex()
if not playerModel:checkInit(true)then return end
return netData.sex
end

function playerModel:getActorLevel()
return zongmenModel:getLevel()
end


function playerModel:getActorFightValue()
return _otherData.fight or 0
end

function playerModel:getActorTop15FightValue()
return _otherData.fight_top15 or 0
end

function playerModel:getActorTop15FightHistoryValue()
return _otherData.fight_top15_history or 0
end

function playerModel:getActorIcon()
return UISettingModel:get_curhead_icon()
end


function playerModel:getActorIconInfo()
local iconInfo={}
local headid=UISettingModel:get_cur_head()
local kuangid=UISettingModel:get_cur_head_kuang()
iconInfo.actoricon=mathHelper.concatToInt32(kuangid,headid)
iconInfo.piList=playerImageModel:getPlayerImage()
iconInfo.pllistlen=#(iconInfo.piList or{})
iconInfo.blueinfo=blueDiamondModel:getBuleInfo()
return iconInfo
end


function playerModel:getActorIconInfoByCfg(headid,kuangid)
local iconInfo={}
iconInfo.actoricon=mathHelper.concatToInt32(kuangid,headid)
return iconInfo
end


function playerModel:getActorHeadKuang()
return UISettingModel:get_curkuang_icon()
end


function playerModel:getActorHeadKuangAnim()
return UISettingModel:get_curkuang_anim()
end

function playerModel:getRecharge()
return _otherData.recharge or 0
end

function playerModel:checkActorLevel(level)
return playerModel:getActorLevel()>=level
end

function playerModel:checkActorId(actorId)
return tostring(playerModel:getActorID())==tostring(actorId)
end

function playerModel:checkServerId(serverid)
local localServerId=playerModel:getActorServerID()
return localServerId==serverid
end

function playerModel:setActorName(name)
if not playerModel:checkInit(true)then return end
netData.actorName=name
end

function playerModel:setActorSex(sex)
if not playerModel:checkInit(true)then return end
netData.sex=sex
end


function playerModel:getActorHead(head)
local highId,lowId=mathHelper.splitToInt16(head)
local kuang=playerModel:getActorFrameIconById(highId)
local icon=playerModel:getActorIconById(lowId)
return icon,kuang
end

function playerModel:getActorIconById(id)
local icon=cfgHelper.get2(cfg_headportraitconfig_get,id,'icon')
if icon==nil then

return 0






else
return icon
end
end

function playerModel:getActorFrameIconById(id)
local icon=cfgHelper.get2(cfg_headportraitframeconfig_get,id,'icon')
if icon==nil then

return 0

else
return icon
end
end




function playerModel:getActorFrameAnimById(id)
local cfg=cfgHelper.get1(cfg_headportraitframeconfig_get,id)
local anim=nil
local animType=nil
local enterAnimId=nil
if cfg then
if cfg.effectID or cfg.model then


if cfg.effectID then

animType=HeadKuangAnimType.eSequence
anim=cfg.effectID
elseif cfg.model then

animType=HeadKuangAnimType.eSpine
anim=cfg.model[1]
enterAnimId=cfg.model[2]or eAnimationID.stand
end
return animType,anim,enterAnimId
else

return nil
end
else
logErr(FMT.fmt("找不到头像框id: {0} 对应的配置",id))
return nil
end
end

function playerModel:setFight(fight)
_otherData.fight=fight
end

function playerModel:setTop15Fight(fight1,fight2)
_otherData.fight_top15=fight1
_otherData.fight_top15_history=fight2
end

function playerModel:setRecharge(recharge)
_otherData.recharge=recharge
end

function playerModel.getHeadAndKuang(actoricon)
local headid=bit.band(actoricon,0xFFFF)
local kuangid=bit.band(bit.rshift(actoricon,16),0xFFFF)
local headIcon=playerModel:getActorIconById(headid)
local kuangIcon=playerModel:getActorFrameIconById(kuangid)

return headIcon,kuangIcon
end

function playerModel.isDefaultHead(icon)
if _defaultHeadLookup==nil then
_defaultHeadLookup={}
local cfgs=cfg_headportraitconfig()
for k,v in pairs(cfgs)do
if v.isdef then
_defaultHeadLookup[v.icon]=v.id
end
end
end
return _defaultHeadLookup[icon]~=nil
end

function playerModel.getBlueinfo(blueinfo)
local dd={}
if blueinfo then
dd.level=bit.band(blueinfo,0xFF)
dd.isBule=bit.band(bit.rshift(blueinfo,8),0xFF)~=0
dd.isSBule=bit.band(bit.rshift(blueinfo,16),0xFF)~=0
dd.isYear=bit.band(bit.rshift(blueinfo,24),0xFF)~=0
else
dd.level=0
dd.isBule=false
dd.isSBule=false
dd.isYear=false
end
return dd
end