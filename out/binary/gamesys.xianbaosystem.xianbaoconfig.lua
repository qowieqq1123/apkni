xianbaoConfig={}
local xianbaoactivelookup=nil
local xianbaoactiveItemlookup=nil
local activeItemlookup=nil
function xianbaoConfig.initlookup()
xianbaoactivelookup={}
activeItemlookup={}
xianbaoactiveItemlookup={}
local allXbCfg=xianbaoConfig.getAllXBCfg()
for k,v in pairs(allXbCfg)do
if v.active then
for k2,v2 in pairs(v.active)do
local itemId=k2
local itemCfg=itemsConfig.getConfig(itemId)
if not activeItemlookup[itemId]then
activeItemlookup[itemId]={}
end
table.insert(activeItemlookup[itemId],v.id)
if itemCfg.type1==itemtype1Type.eXianBao then
if xianbaoactivelookup[itemId]then
logErr(FMT.fmt("仙宝id--》》{0} 的激活道具和 仙宝id--》》{1} 的一样",xianbaoactivelookup[itemId],v.id))
else
xianbaoactivelookup[itemId]=v.id
xianbaoactiveItemlookup[v.id]=itemId
end
end
end
end
end
end

function xianbaoConfig.isXianbaoActiveItem(itemId)
local xbid=xianbaoConfig.getXBId(itemId)
return xbid~=nil,xbid
end

function xianbaoConfig.isXianbaoActiveItemEx(itemId)
if not activeItemlookup then
xianbaoConfig.initlookup()
end
local xbidList=activeItemlookup[itemId]
return xbidList~=nil,xbidList
end


function xianbaoConfig.getXBId(itemId)
if not xianbaoactivelookup then
xianbaoConfig.initlookup()
end
return xianbaoactivelookup[itemId]
end


function xianbaoConfig.getXBActiveItemId(xbid)
local dfxb=xianbaoModel:CheckDianfengXianbao(xbid)
if dfxb then
return 3
end
if not xianbaoactiveItemlookup then
xianbaoConfig.initlookup()
end
return xianbaoactiveItemlookup[xbid]
end


function xianbaoConfig.checkPrint(value,warnTips,warnArg)
if not value then
local warnTips=warnTips or""
for i,v in ipairs(warnArg)do
warnTips=string.format("%s-->>%s",warnTips)
string.format(warnTips,v)
end
logErr(warnTips)
end
end

function xianbaoConfig.getBaseXBCfg()
return cfg_xianbaobaseconfig_get(1)
end

function xianbaoConfig.getAllXBCfg()
return cfg_xianbaoconfig()
end

function xianbaoConfig.getXBCfg(xbId)
return cfg_xianbaoconfig_get(xbId)
end

function xianbaoConfig.getAllXBStarCfg()
return cfg_xianbaostarconfig()
end


function xianbaoConfig.getTypeName(type)
if type==0 then
return"可激活"
end
local cfg=xianbaoConfig.getBaseXBCfg()
local typeList=cfg.typeList
return typeList[type]and typeList[type][1]or""
end

function xianbaoConfig.getXBAllStarCfg(xbId)
local cfg=xianbaoConfig.getAllXBStarCfg()
local xbStartCfg=cfg[xbId]
xianbaoConfig.checkPrint(xbStartCfg,"没有对应的仙宝Id星级配置",{xbId})
return xbStartCfg
end

function xianbaoConfig.getXBStarCfg(xbId,star)
local xbStartCfg=xianbaoConfig.getXBAllStarCfg(xbId)
local stratCfg=xbStartCfg[star]
xianbaoConfig.checkPrint(xbStartCfg,"没有对应的星级配置",{xbId,star})
return stratCfg
end

function xianbaoConfig.getXBMaxStar(xbId)
local xbStartCfg=xianbaoConfig.getXBAllStarCfg(xbId)
return#xbStartCfg
end

function xianbaoConfig.getXianBaoIconName(xbId)
local xbCfg=xianbaoConfig.getXBCfg(xbId)
return xbCfg.icon
end







XianBaoTypeEnum={
eXianBao=ITEM_CONFIG_TYPE.eXianBao,
eGuBao=ITEM_CONFIG_TYPE.eGuBao,
}

local xianbaoFunc={
getConfig=function(id)
return itemsConfig.getConfig(id,ITEM_CONFIG_TYPE.eXianBao)
end,
getXBActiveItemId=function(id)
return xianbaoConfig.getXBActiveItemId(id)
end,
checkReddot=function(id)
return xianbaoModel:checkXBReddot(id)
end,
checkCanUpStar=function(id)
return xianbaoModel:checkCanUpStar(id)
end,
getIcon=function(id)
return xianbaoConfig.getXianBaoIconName(id)
end,
getBaseFight=function(id)
return xianbaoModel:getBaseFightEx(id)
end,
getTipsAttrList=function(args)
local xbid=args[1]
local dfxb=xianbaoModel:CheckDianfengXianbao(xbid)
if dfxb then
local dflevel=DianFengLevelModel:getLevel()
local cfglvl=cfg_dianfenglevelconfig_get(dflevel)
local attrlist=cfglvl.attrs
return attrlist
else
local starlv=args[2]
local starCfg=xianbaoConfig.getXBStarCfg(xbid,starlv)
local attrlist=starCfg.attrs
return attrlist
end
end,
getLevel=function(args)
local id=args[1]
local dfxb=xianbaoModel:CheckDianfengXianbao(id)
if dfxb then
local dflevel=DianFengLevelModel:getLevel()
local lv=xianbaoModel:checkActive(id)and dflevel
return lv
else
local attach=args[2]
local starlv=attach and attach.starlv or 0
local lv=xianbaoModel:checkActive(id)and xianbaoModel:getXbStart(id)or(starlv or 0)
return lv
end
end,
getTipsModelArgs=function(argstable)
local cfgType=argstable.cfgType
local itemid=argstable.itemid
local args=argstable.modelArgs
if argstable.attach==nil then argstable.attach={}end
local attach=argstable.attach

local modelArgs=nil

local cfg,cfg2=itemsConfig.getConfig(itemid,cfgType)
local moveType
local move=argstable.move
if move and move==TIPS_MOVE_POS.eLeft then
moveType=TIPS_MOVE_POS.eRight
else
moveType=TIPS_MOVE_POS.eLeft
end

modelArgs={}
modelArgs.win='UITipsXianBaoModelWin'
modelArgs.args={
moveType=moveType,
args=args,
attach=attach,
itemid=itemid,
itemConfigType=ITEM_CONFIG_TYPE.eXianBao,
formType=argstable.formType
}

return modelArgs
end,
getName=function(id)
local cfg=itemsConfig.getConfig(id,ITEM_CONFIG_TYPE.eXianBao)
return cfg.name
end,
getColor=function(id)
local cfg=itemsConfig.getConfig(id,ITEM_CONFIG_TYPE.eXianBao)
return cfg.color
end,
}

local gubaoFunc={
getConfig=function(id)
return itemsConfig.getConfig(id,ITEM_CONFIG_TYPE.eGuBao)
end,
getXBActiveItemId=function(id)
return id
end,
checkReddot=function(id)

local state,lostInfo=xianzhiModel:checkCanUpXianBaoLevel()
return state
end,
checkCanUpStar=function(id)

return false
end,
getIcon=function(id)
local cfg=itemsConfig.getConfig(id,ITEM_CONFIG_TYPE.eGuBao)

local icon=cfg.icon
local lv=gubaoModel:getSkillLv(id)
if cfg.relevantPram.pram.gbMultipleInfo then
for clv,data in pairs(cfg.relevantPram.pram.gbMultipleInfo)do
if lv>=clv then
icon=data[3]
end
end
end
return gubaoModel:getGuBaoIconName(icon)
end,
getBaseFight=function(id)
return gubaoModel:getBaseFight(id)
end,
getTipsAttrList=function(args)
local id=args[1]
local attrlist
local isActive=gubaoModel:checkActive(id)
if isActive then
attrlist=gubaoModel:getBaseAttrList(id,true)
end
if attrlist==nil then
attrlist=cfgHelper.get2(cfg_gubaoconfig_get,id,'attr')
end
return attrlist
end,
getLevel=function(id)
return gubaoModel:getSkillLv(id)
end,
getTipsModelArgs=function(argstable)
local cfgType=argstable.cfgType
local itemid=argstable.itemid
local args=argstable.modelArgs
if argstable.attach==nil then argstable.attach={}end
local attach=argstable.attach

local modelArgs=nil

local cfg,cfg2=itemsConfig.getConfig(itemid,cfgType)
local relevantPram=cfg.relevantPram
if relevantPram==nil and cfg2~=nil then
relevantPram=cfg2.relevantPram
end
if relevantPram then
local moveType
local move=argstable.move
if move and move==TIPS_MOVE_POS.eLeft then
moveType=TIPS_MOVE_POS.eRight
else
moveType=TIPS_MOVE_POS.eLeft
end
if relevantPram.pram.gbMultipleInfo then
local id=argstable.itemid
local gbMultipleInfo=relevantPram.pram.gbMultipleInfo
local lv=gubaoModel:getSkillLv(id)
relevantPram=table.deepCopy(relevantPram)
if gbMultipleInfo then
for clv,data in pairs(gbMultipleInfo)do
if lv>=clv then
relevantPram.pram.effectid=data[2]
end
end
end
end
local modelType=relevantPram.relevantId
if modelType==1 then
modelArgs={}
modelArgs.win='UITipsModelThreeWin'
modelArgs.args={relevantPram=relevantPram,
moveType=moveType,
args=args,
attach=attach,
itemid=itemid,
itemConfigType=ITEM_CONFIG_TYPE.eGuBao}
else



end
end
return modelArgs
end,
getName=function(id)
local cfg=itemsConfig.getConfig(id,ITEM_CONFIG_TYPE.eGuBao)
local name=cfg.name
local lv=gubaoModel:getSkillLv(id)
if cfg.relevantPram.pram.gbMultipleInfo then
for clv,data in pairs(cfg.relevantPram.pram.gbMultipleInfo)do
if lv>=clv then
name=data[1]
end
end
end

name=FMT.fmt("{0}+{1}",name,lv)
return name
end,
getColor=function(id)
local cfg=itemsConfig.getConfig(id,ITEM_CONFIG_TYPE.eGuBao)
return cfg.color
end,
}

local typeFunc={
[XianBaoTypeEnum.eXianBao]=xianbaoFunc,
[XianBaoTypeEnum.eGuBao]=gubaoFunc,
}

function xianbaoConfig.getTypeFunc(type)
return typeFunc[type]
end

function xianbaoConfig.getTypeFuncResult(type,name,args)
if typeFunc[type]then
if typeFunc[type][name]then
return typeFunc[type][name](args)
else
logErr(FMT.fmt("xianbaoConfig typeFunc func 缺失 {0}-{1}",type,name))
end
else
logErr(FMT.fmt("xianbaoConfig typeFunc 缺失 {0}",type))
end
end










