







itemsLookup={}

local table_insert=table.insert
local table_sort=table.sort



local function_items_lookup=nil

item_funtion_type=
{
jj_xiuweidan=1,
jj_tupodan=2,
lt_jingyandan=3,
eFulu=4,
eBaoXiang=5,
disciple=6,
pro_skill_exp=7,
shouyuan=8,
liaoshang=9,
eMiJingItem=10,
eChatEmotPackage=11,
lingshou=12,
selectbox=13,
baseAttr6=14,
tezhiAdd=15,
tezhiSub=16,
attr6Add=17,
selectDisciple=18,
voucher=19,
huDaoFu=20,
huiChunFu=21,
yinYaoFu=22,
wuFangSpeedUpFu=23,
changShengFu=24,
duihuan=27,
playerimage=28,
eItemEmotPackage=29,
eShangGuXianDi=31,
eShowDZ=33,
eActiveMonthCard=35,
eItemExchange=36,
eCatRecruit=39,
eXianMoDaoHengExp=40,
eMoWuDrop=42,
eXMZengLi=44,
eGiftPack=45,
eGuBaoBaoXiang=46,
eLingShouBaseAttr2=47,
eLingShouDai=49,
eLingShouItem=50,
}


item_funcparam_numIsUseCount_type=
{
[item_funtion_type.disciple]=true,
}



























function itemsLookup:get_function_items(func_type)
if function_items_lookup==nil then
function_items_lookup={}
end
local res=function_items_lookup[func_type]
if res==nil then
res={}
function_items_lookup[func_type]=res
local itemlist=cfgHelper.get1(cfg_items_functype_lookup_get,func_type)
if itemlist then
for i,itemID in ipairs(itemlist)do
local cfg=itemsConfig.getConfig(itemID)
if cfg then
table_insert(res,cfg)
else
logErr(FMT.fmt('找不到物品{0}配置',itemID))
end
end
end
end
return res
end

function itemsLookup:getSuYuanQiItems()
local itemList={}

end

function itemsLookup:getItemsByBag(func_type)
local temp={}
local list=itemsLookup:get_function_items(func_type)or{}
for k,v in pairs(list)do
local num=bagModel.getItemCountById(v.id)
if num>0 then
table.insert(temp,v)
end
end
return temp
end

function itemsLookup:checkItemFuncType(itemID,func_type)
local list=itemsLookup:get_function_items(func_type)or{}
for k,v in pairs(list)do
if itemID==v.id then
return true
end
end
return false
end

local _checkParamsFunc=
{
[item_funtion_type.disciple]=function(funcparam,itemID,ignoreWarning)
if funcparam.num then
local count=bagModel.getItemCountById(itemID)
if count<funcparam.num then
if not ignoreWarning then
UIManager.error('道具不足')
gainControl:showGainWin(itemID)
end
return false
end
end
if not funcparam.isSpecial then
local cur=UIDiscipleModel:checkDiscipleCount()
local max=UIRecruitModel:getZongMenPeopleMax()
if cur>=max then
if not ignoreWarning then
UIManager.error('宗门弟子人数达到上限')
end
return false
end
end
return true
end,
[item_funtion_type.wuFangSpeedUpFu]=function(funcparam,itemID,ignoreWarning)

local sfId=mapIdType.zhufeng
local buildIdList=funcparam.build
local buildTypeList=funcparam.build_type
local hasCanSpeedUpBd=false

if buildIdList then

for bdId,v in pairs(buildIdList)do
local bdDataList=zongmenModel:getBuildingDataByBdId(sfId,bdId)
local buildCfg=cfgHelper.get1(cfg_monijybuildconfig_get,bdId)
local bdType=buildCfg and buildCfg.build_type or nil
if bdId==SLG_SYSTEM_TYPE.eLianDanFang then

for i,bdData in ipairs(bdDataList)do
local liandanCd=buildingCDControl:getCD(buildingCDType.liandan,bdData.un_build_id)
if liandanCd and liandanCd>0 then
return true
end
end
elseif bdType and bdType==24 then

for i,bdData in ipairs(bdDataList)do
local planCd=buildingCDControl:getCD(buildingCDType.shangpu,bdData.un_build_id)
if planCd and planCd>0 then
return true
end
end
else

for i,bdData in ipairs(bdDataList)do
local planCd=buildingCDControl:getCD(buildingCDType.plan,bdData.un_build_id)
if planCd and planCd>0 then
return true
end
end
end
end
end

if buildTypeList then

for bdType,v in pairs(buildTypeList)do
local bdDataList=zongmenModel:getBuildingDataByBdType(sfId,bdType)
if bdType==6 then

for i,bdData in ipairs(bdDataList)do
local liandanCd=buildingCDControl:getCD(buildingCDType.liandan,bdData.un_build_id)
if liandanCd and liandanCd>0 then
return true
end
end
elseif bdType==24 then

for i,bdData in ipairs(bdDataList)do
local planCd=buildingCDControl:getCD(buildingCDType.shangpu,bdData.un_build_id)
if planCd and planCd>0 then
return true
end
end
else

for i,bdData in ipairs(bdDataList)do
local planCd=buildingCDControl:getCD(buildingCDType.plan,bdData.un_build_id)
if planCd and planCd>0 then
return true
end
end
end
end
end

if not hasCanSpeedUpBd then
if not ignoreWarning then
UIManager.error('无需加速，祖师莫要浪费加速符')
end
return false
end
return true
end,
[item_funtion_type.eMiJingItem]=function(funcparam,itemID,ignoreWarning)
local randomMJ=funcparam.randomMJ
if randomMJ then
local FBCreateTime=MysteryModel:get_mysteryFB_create_CD()
if FBCreateTime==-1 then
if not ignoreWarning then
UIManager.error('随机秘境数量达到上限')
end
return false
end
end
return true
end,
[item_funtion_type.eFulu]=function(funcparam,itemID,ignoreWarning)
local id=funcparam.gsid
local cfg=cfg_guildstateconfig_get(id)
local sametype=cfg.sametype
if sametype~=0 then
local has=homeBuffModel.hasHigherLevelBuff(id)
if has then
if not ignoreWarning then
UIManager.error('已有更高等级的符箓效果')
end
return false
end
end
return true
end,
[item_funtion_type.eBaoXiang]=function(funcparam,itemID,ignoreWarning)



if itemID==10152 then

if not xianmengdigongController:checkOpen()then
if not ignoreWarning then
UIManager.error('仙盟地宫活动尚未开启')
end
return false
end
if not xianmengModel:hasXM()then
if not ignoreWarning then
UIManager.error('需要先加入仙盟')
end
return false
end
end
return true
end,
[item_funtion_type.playerimage]=function(funcparam,itemid,ignoreWarning)
local itemCfg=itemsConfig.getConfig(itemid)
if itemCfg.funcparam and itemCfg.funcparam.duration~=nil then

return true
end
local sex=playerModel:getActorSex()
local list=itemCfg.funcparam.list[sex]
for i,v in ipairs(list)do
if playerImageModel:isUnlockImage(v[1],v[2])then
if not ignoreWarning then
UIManager.error('形象已激活，无需重复使用')
end
return false
end
end
return true
end,
[item_funtion_type.eActiveMonthCard]=function(funcparam,itemid,ignoreWarning)
local cardId=funcparam.ykid
local isCanRenewal=rechargeModel:checkMonthCardCanRenewal(cardId)
if not isCanRenewal then
if not ignoreWarning then
UIManager.error("月卡最大有效天数已达上限")
end
end
return isCanRenewal
end,

[item_funtion_type.eCatRecruit]=function(funcparam,itemID,ignoreWarning)
if funcparam.num then
local count=bagModel.getItemCountById(itemID)
if count<funcparam.num then
if not ignoreWarning then
UIManager.error('道具不足')
gainControl:showGainWin(itemID)
end
return false
end
end
if not wanBaoXunBaoDuiModel:isFullEmployee()then
if not ignoreWarning then
UIManager.info('雇员已满员了喵')
end
return false
end
return true
end,

[item_funtion_type.eXMZengLi]=function(funcparam,itemID,ignoreWarning)
if not xianmengModel:hasXM()then
UIManager.error('仙盟宝箱需要加入仙盟才能使用')
return false
end

if not systemModel.isOpen(SYSTEM_DEFINE.eGuildBox)then
UIManager.error('仙盟赠礼系统暂未开启')
return false
end
return true
end,
[item_funtion_type.eLingShouDai]=function(funcparam,itemID,ignoreWarning)
local cur=lingshouModel:getLSCount()
local max=lingshouModel:getLSMaxCount()
if cur>=max then
if not ignoreWarning then
UIManager.info('宗门灵兽已达上限')
end
return false
end
return true
end,
}

function itemsLookup:checkUseItemCondition(itemID,ignoreWarning)
local cfg=itemsConfig.getConfig(itemID)

local level=cfg.level or 1
local zmLevel=zongmenModel:getLevel()
if zmLevel<level then
if not ignoreWarning then
UIManager.error(FMT.fmt('需要宗门等级达到{0}级才能使用',level))
end
return
end

local scene=cfg.scene
if scene then
local currScene=mainControl:getSceneType()
if not scene[currScene]then
if not ignoreWarning then
for k,v in pairs(scene)do
UIManager.error(FMT.fmt('该道具需要在{0}使用',sceneNames[k]))
end
end
return false
else
local mapIds=scene[currScene]
local typeName=type(mapIds)
if typeName=="table"then
if not mainControl:isInSubScenes(currScene,mapIds)then
local currSubScene=mainControl:getSubSceneID()
local mountainName=mainControl:getSubSceneName(currScene,currSubScene)
if not ignoreWarning then
UIManager.error(FMT.fmt('该道具无法在{0}使用',mountainName))
end
return false
end
elseif typeName=="number"then
if not mainControl:isInSubScene(currScene,mapIds)then
local currSubScene=mainControl:getSubSceneID()
local mountainName=mainControl:getSubSceneName(currScene,currSubScene)
if not ignoreWarning then
UIManager.error(FMT.fmt('该道具无法在{0}使用',mountainName))
end
return false
end
end
end
end


local useLimit=cfg.uselimit
if useLimit then
local maxUseCount=useLimit[2]
local limitType=useLimit[1]
local limitTypeName=''
if limitType==1 then

limitTypeName="今日"
elseif limitType==2 then

limitTypeName="本周"
end


local nowUseCount=bagModel:getItemUseCount(itemID)
if nowUseCount>=maxUseCount then
if not ignoreWarning then
UIManager.error(FMT.fmt('该道具{0}剩余次数不足',limitTypeName))
end
return false
end
end


local funcparam=cfg.funcparam
if funcparam then
local funcType=funcparam.type
local func=_checkParamsFunc[funcType]
if func and not func(funcparam,itemID,ignoreWarning)then
return false
end
end
return true
end

function itemsLookup:checkDicipleUseItemCondition(dis_guid,itemID)
local item=itemsConfig.getConfig(itemID)
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
local isfix=true
local nonfix={}
local funcparam=item.funcparam
if funcparam~=nil then
local condition=funcparam.condition
if condition~=nil then
local jingjie=itemsConfig.getFuncParamCndByType(ITEM_FUNC_CND_TYPE.eJingjieLv,condition)
if jingjie then
local jjlv=netData.jingjielv
if jjlv<jingjie[1]or jjlv>jingjie[2]then
isfix=false
nonfix[ITEM_FUNC_CND_TYPE.eJingjieLv]=jingjie
end
end
local lianti=itemsConfig.getFuncParamCndByType(ITEM_FUNC_CND_TYPE.eLiantiLv,condition)
if lianti~=nil then
local ltlv=netData.liantilv
if ltlv<lianti[1]or ltlv>lianti[2]then
isfix=false
nonfix[ITEM_FUNC_CND_TYPE.eLiantiLv]=lianti
end
end
local attr6=itemsConfig.getFuncParamCndByType(ITEM_FUNC_CND_TYPE.eAttr6,condition)
if attr6~=nil then
local attrlist={}
for i,v in ipairs(attr6)do
local v1=UIDiscipleModel:getDiscipleBaseAttr(dis_guid,v[1])
if v1<v[2][1]or v1>v[2][2]then
attrlist[#attrlist+1]=v
end
end
if#attrlist>0 then
isfix=false
nonfix[ITEM_FUNC_CND_TYPE.eAttr6]=attrlist
end
end
local linggen=itemsConfig.getFuncParamCndByType(ITEM_FUNC_CND_TYPE.eLingGen,condition)
if linggen~=nil then

end
local tezhi=itemsConfig.getFuncParamCndByType(ITEM_FUNC_CND_TYPE.eTeZhi,condition)
if tezhi~=nil then
local templist={}
local netData=UIDiscipleModel:getDiscipleDataByStr(tostring(dis_guid))
for i,v in ipairs(tezhi)do
local specialityType=v[1]
local specialityHoldMax=v[2]
local len=UIDiscipleModel:getDiscipleSpecialityLen(netData,specialityType)
if len>specialityHoldMax then
templist[#templist+1]=v
end
end
if#templist>0 then
isfix=false
nonfix[ITEM_FUNC_CND_TYPE.eTeZhi]=templist
end
end
end
end
return isfix,nonfix
end

function itemsLookup:checkDicipleUseItemCondition_pass(dis_guid,itemID)
local item=itemsConfig.getConfig(itemID)
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
local isfix=true
local funcparam=item.funcparam
if funcparam~=nil then
local condition=funcparam.condition
if condition~=nil then
local isfix_=true
local linggen=itemsConfig.getFuncParamCndByType(ITEM_FUNC_CND_TYPE.eLingGen,condition)
if linggen~=nil and#linggen>0 then
isfix_=false
for i,lgid in ipairs(linggen)do
if UIDiscipleModel:getDiscipleSpecialityByID(dis_guid,DISCIPLE_SPECIALITY_TYPE.eSpiritRoot,lgid,true)~=nil then
isfix_=true
break
end
end
end
isfix=isfix and isfix_
end
end
return isfix
end

function itemsLookup:checkLingShouUseItemCondition(ls_guid,itemID)
local item=itemsConfig.getConfig(itemID)
local lsData=lingshouModel:getLingShouData(ls_guid)
local isfix=true
local nonfix={}
local funcparam=item.funcparam
if funcparam~=nil then
local condition=funcparam.condition
if condition~=nil then

local jingjie=itemsConfig.getFuncParamCndByType(ITEM_FUNC_CND_TYPE.eLingshouLv,condition)
if jingjie then
local jjlv=lsData.jj_lvl
if jjlv<jingjie[1]or jjlv>jingjie[2]then
isfix=false
nonfix[ITEM_FUNC_CND_TYPE.eLingshouLv]=jingjie
end
end


local attr6=itemsConfig.getFuncParamCndByType(ITEM_FUNC_CND_TYPE.eLingShouAttr2,condition)
if attr6~=nil then
local attrlist={}
for i,v in ipairs(attr6)do
local v1=lingshouModel:getAllAttrLookupX(ls_guid,v[1])
if v1<v[2][1]or v1>v[2][2]then
attrlist[#attrlist+1]=v
end
end
if#attrlist>0 then
isfix=false
nonfix[ITEM_FUNC_CND_TYPE.eLingShouAttr2]=attrlist
end
end




















end
end
return isfix,nonfix
end
function itemsLookup:checkSatiety(dis_guid,itemID,isWarning)
local itemcfg=itemsConfig.getConfig(itemID)
local funcparam=itemcfg.funcparam
if funcparam~=nil then
local satiety=funcparam.satiety
if satiety~=nil and satiety>0 then
local netData=UIDiscipleModel:getDiscipleData(dis_guid)
if UIDiscipleModel:checkDiscipleSatietyFull(netData)then
if isWarning then
UIManager.error('修为丹饱食度已满')
end
return false
end
end
end
return true
end

function itemsLookup.checkParamType(itemid,type)
local funcparam=itemsConfig.getConfig(itemid).funcparam
if funcparam then
return funcparam.type==type
end
return false
end

function itemsLookup.getParamTypeById(itemid)
local cfg=itemsConfig.getConfig(itemid)
return itemsLookup.getParamType(cfg)
end

function itemsLookup.getParamType(cfg)
local funcparam=cfg.funcparam
if funcparam then
return funcparam.type
end
end




function itemsLookup:canAutoExchange(itemid)
local itemcfg=itemsConfig.getConfig(itemid)
local ftype
local funcparam=itemcfg.funcparam
if funcparam then
ftype=funcparam.type
end
return ftype==item_funtion_type.duihuan
end


function itemsLookup:checkAutoExchange(itemid,itemnum)
local itemcfg=itemsConfig.getConfig(itemid)
local funcparam=itemcfg.funcparam
if funcparam then
local ftype=funcparam.type

if ftype==item_funtion_type.duihuan then
if itemcfg.type1==22 then

local num=dzLingCuiShopController:checkFullTianMingItem(itemid)
if num then
return math.min(itemnum,num)
end
end
end
end
return nil
end


function itemsLookup:getAutoExchangeDesc(old_itemid,old_num,new_itemid,new_num)
local str=new_itemid
local old_itemcfg=itemsConfig.getConfig(old_itemid)
local new_itemcfg=itemsConfig.getConfig(new_itemid)
if old_itemcfg.type1==22 then

local dzids=dzLingCuiShopController:getYuanPo2dzid(old_itemid)
local dzid=dzids[1]
local glid=liandonModel:CheckDiZi_Guanlian(dzid)
local glflag=nil
if glid then
glflag=liandonModel:CheckDiZiActive_Guanlian(dzid)

end
if glflag then
local s_fmt='弟子“{0}”的天命已满，超出的{1}个\"{2}\"已自动转化为{3}{4}！'
local name=cfgHelper.get2(cfg_discipleconfig_get,glid,"name")
str=FMT.fmt(s_fmt,name,old_num,old_itemcfg.name,new_num,new_itemcfg.name)
else
local s_fmt='弟子“{0}”的天命已满，超出的{1}个\"{2}\"已自动转化为{3}{4}！'
local name=cfgHelper.get2(cfg_discipleconfig_get,dzid,"name")
str=FMT.fmt(s_fmt,name,old_num,old_itemcfg.name,new_num,new_itemcfg.name)
end
end
return str
end


function itemsLookup:getAutoExchangeDesc_GLdizi(diziid)
local str=nil

if diziid then


local glid=liandonModel:CheckDiZi_Guanlian(diziid)
local glflag=nil
if not glid then
return
end

glflag=liandonModel:CheckDiZiActive_Guanlian(diziid)
if glflag then
local s_fmt='已经获得弟子“{0}”，“{1}”自动转化成{2}个"{3}"'
local glname=cfgHelper.get2(cfg_discipleconfig_get,glid,"name")
local name=cfgHelper.get2(cfg_discipleconfig_get,diziid,"name")
local yuanpo=cfgHelper.get2(cfg_discipleconfig_get,diziid,"yuanpo")
local itemcfg=itemsConfig.getConfig(yuanpo[1])
str=FMT.fmt(s_fmt,glname,name,yuanpo[2],itemcfg.name)
end
end
return str
end


