







UISectPalaceModel={}
UISectPalaceModel.data={}


STAND_POINT_TYPE={
evil=2,
neutrality=3,
decent=1,
}


STAND_POINT_NAME={
[STAND_POINT_TYPE.evil]='邪派',
[STAND_POINT_TYPE.neutrality]='中立',
[STAND_POINT_TYPE.decent]='正派',
}

function UISectPalaceModel:initData(list)

end

function UISectPalaceModel:clearData()
self.data={}
end

function UISectPalaceModel:checkAllPostWages()
local all=0
local lookup=UIDiscipleModel:getAllDiscipleDataX()
if lookup then
for k,v in pairs(lookup)do
local netData=v.netData.net
local wages=UIDiscipleModel:getDisciplePostWagesEx(netData)
all=all+wages
end
end
return all
end

function UISectPalaceModel:getPostEffectDesc(cfg)
local desc_str=''
local effects=cfg.effects_myself
local c=0
if effects~=nil then
for i,v in ipairs(effects)do
if c>0 then
desc_str=desc_str..'\n'
end
if v.type==1 then
for k1,v1 in pairs(v.param)do
desc_str=desc_str..FMT.fmt('{0}属性增加{1}点',UIDiscipleModel:getDiscipleBaseAttrName(k1),v1)
c=c+1
break
end
elseif v.type==2 then
desc_str=desc_str..FMT.fmt('修为获取效率提升{0}%',v.param)
end
end
else
desc_str='无'
end
return desc_str
end

function UISectPalaceModel:getPostEffect6Attr(postType,sixAttrType)
local effects_myself=cfgHelper.get2(cfg_guildposconfig_get,postType,'effects_myself')
if effects_myself~=nil then
for i,v in ipairs(effects_myself)do
if v.type==1 then
if sixAttrType==nil then
return v.param
else
return v.param[sixAttrType]
end
end
end
end
return nil
end

function UISectPalaceModel:getPostEffectXiuWeiRete_self(postType)
if self.effects_myself_postType_lookup==nil then
local effects_myself_postType_lookup={}
local cfgs=cfg_guildposconfig()
for _,vv in pairs(cfgs)do
local effects_myself=vv.effects_myself
if effects_myself~=nil then
for _,v in ipairs(effects_myself)do
if v.type==2 then
effects_myself_postType_lookup[vv.id]=v.param
break
end
end
end
end
self.effects_myself_postType_lookup=effects_myself_postType_lookup
end
return self.effects_myself_postType_lookup[postType]or 0
end

function UISectPalaceModel:getDiscipleXiuWeiReteByData(netData)
local postType=UIDiscipleModel:getDisciplePostEX(netData)
local rate_self=UISectPalaceModel:getPostEffectXiuWeiRete_self(postType)
local rate_zm=UISectPalaceModel:getPostEffectXiuWeiRete_zhangmen()
return rate_self+rate_zm
end

function UISectPalaceModel:getDiscipleXiuWeiRete(guid)
local postType=UIDiscipleModel:getDisciplePost(guid)
local rate_self=UISectPalaceModel:getPostEffectXiuWeiRete_self(postType)
local rate_zm=UISectPalaceModel:getPostEffectXiuWeiRete_zhangmen()
return rate_self+rate_zm
end

function UISectPalaceModel:getPostEffectXiuWeiRete_zhangmen()
local dis_list=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eZhangMen)
local netData=nil
if dis_list and#dis_list>0 then
netData=dis_list[1]
end
if netData~=nil then

local effect_xiuwei=cfg_guildposconfig_get(eZongMenPostType.eZhangMen).effect_xiuwei
if effect_xiuwei~=nil then
local jjlv=UIDiscipleModel:getDiscipleJJLevelEx(netData)
return effect_xiuwei[jjlv]or 0
end
end
return 0
end

function UISectPalaceModel:getPostIcon(postType)
return'image_changlaozc_'..cfgHelper.get2(cfg_guildposconfig_get,postType,'icon')
end

function UISectPalaceModel:getPostBigIcon(postType)
local icons=cfgHelper.get2(cfg_guildposconfig_get,postType,'big_icon')
return'frame_zhiweibg_'..icons[1],'icon_zhiweitp_'..icons[2]
end


function UISectPalaceModel:setShanEValue(shan_e_val)
self.data.shaneValue=shan_e_val
end

function UISectPalaceModel:getShanEValue()
return self.data.shaneValue
end


function UISectPalaceModel:getZongMenLiChang()
local shaneValue=self:getShanEValue()
local shaneConfig=cfgHelper.get2(cfg_guilddadianconfig_get,1,'shane_conf')
local standPoint
for i,v in ipairs(shaneConfig)do
if shaneValue>=v[1]and shaneValue<=v[2]then
if i==1 then
standPoint=STAND_POINT_TYPE.evil
elseif i==2 then
standPoint=STAND_POINT_TYPE.neutrality
else
standPoint=STAND_POINT_TYPE.decent
end
end
end
return standPoint
end


function UISectPalaceModel:getZongMenLiChangName()
local lichang=self:getZongMenLiChang()
return STAND_POINT_NAME[lichang]
end


function UISectPalaceModel:checkReddot()
local checklist={eZongMenPostType.eZhangMen,eZongMenPostType.eJielu,eZongMenPostType.eChuanGong,
eZongMenPostType.eJieYin,eZongMenPostType.eZhenYu}
for i,postType in ipairs(checklist)do
local dis_list=UIDiscipleModel:getDiscipleByZongMenPost(postType)
if dis_list==nil or#dis_list<=0 then
local isOpen,lockData=UIDiscipleModel.checkDisciplePostOpen(postType)
if isOpen then
return true,1
end
end
end
if guildOrderModel:checkReddot()then
return true,2
end


if UISectPalaceModel:checkSectPalaceCanLevelUp()then
return true,3
end


local bdData=UISectPalaceController:getBuildData()
if buildSkinModel:checkBuildSkinUnLockReddotByBuildId(bdData.build_id)then
return true,4
end

return false
end


function UISectPalaceModel:checkSectPalaceCanLevelUp()
local bdData=UISectPalaceController:getBuildData()
if bdData.flag==buildingStateType.eUpgrading or bdData.flag==buildingStateType.eBuilding then

return false
end

local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,bdData.build_id,bdData.level+1)
if not nextLvCfg then

return false
end


local flag=zongmenControl:checkLevelUp(nextLvCfg)

return flag
end


function UISectPalaceController:checkSectPalaceInfoReddot()

local bdData=UISectPalaceController:getBuildData()
if bdData then
if buildSkinModel:checkBuildSkinUnLockReddotByBuildId(bdData.build_id)then
return true
end

end
return false
end