








function UIDiscipleModel:checkday_increase()
local all=UIDiscipleModel:getAllDiscipleDataX()
if all then
for k,v in pairs(all)do
local netData=v.netData.net
UIDiscipleModel:jingjiesatiety_increase(netData)
end
end
end


function UIDiscipleModel:jingjiesatiety_increase(netdata)
local jingjiesatiety=netdata.jingjiesatiety
jingjiesatiety=int64.zero
netdata.jingjiesatiety=jingjiesatiety
end



function UIDiscipleModel:checkyear_increase()
local all=UIDiscipleModel:getAllDiscipleDataX()
if all then
for k,v in pairs(all)do
local netData=v.netData.net
if worldController:checkNoticiateBlockOpen()then
UIDiscipleModel:shouyuan_increase(netData)
end
UIDiscipleModel:injury_increase(netData)
UIDiscipleModel:loyalty_increase(netData)
end
end
end


function UIDiscipleModel:shouyuan_increase(netdata)
local shouyuan=netdata:getShouYuan()
if shouyuan~=-1 then
local autogrow=cfgHelper.getglobal1('shouyuandecr')or 1
local rate=1
rate=rate+dzSpecialityGrowEffectController:getShouYuanLostSpeedRate(netdata)/100
shouyuan=shouyuan-autogrow*rate
if shouyuan<0 then
shouyuan=0
end
netdata.shouyuan=shouyuan
end
end


function UIDiscipleModel:injury_increase(netdata)
local guid=netdata.discipleguid
if UIDiscipleModel:checkInjuryChuiWeiType(guid)then

return
end
local injury=netdata.injury
local old=injury
local autogrow=cfgHelper.get2(cfg_discipleinjuryconfig_get,1,'autogrow')

local rate=1+zongmenModel:getDzRoomEffect_injuryRate_ex(guid)

rate=rate+UIFuLuFangModel:getFuBaoEffect(guid,FUBAO_EFFECT_TYPE.eInjuryRecoverSpeed)/100
injury=math.floor(injury-autogrow*rate)
if injury<0 then
injury=0
end
netdata.injury=injury

local old_injuryType=eInjuryType.getType(old)
local new_injuryType=eInjuryType.getType(injury)
if old_injuryType~=new_injuryType then
UIDiscipleModel:setDiscipleAttrListDirty(netdata,DISCIPLE_ATTRIBUTE_TYPE.eInjury)
end
end


function UIDiscipleModel:loyalty_increase(netdata)
local loyalty=netdata.loyalty
local autogrow=cfgHelper.get2(cfg_discipleloyaltyconfig_get,1,'autogrow')
local rate=1+zongmenModel:getDzRoomEffect_loyaltyRate_ex(netdata)
local rate2=1+dzSpecialityGrowEffectController:getLoyaltyRateLookup(netdata,1)/100
loyalty=math.floor(loyalty+autogrow*rate*rate2)
local max=cfgHelper.get2(cfg_discipleloyaltyconfig_get,1,'max')
if loyalty>max then
loyalty=max
end
netdata.loyalty=loyalty
end
