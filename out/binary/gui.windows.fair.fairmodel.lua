







fairModel={}


eFairType=
{
eBooth=0,
eBlackMarket=1,
eBlackSpeGoods=2,
eMysteryMarket=3,
}


eFairRefreshType=
{
eFree=0,
eAd=1,
ePay=2,
}

local _itemguidLook
local reqbuyflag=false
local xiaozhushouFlag=false
local notmoneyFlag=nil
local xiaozhushouNum=0
local allxiaozhushouNum=0
local lyrefreshNum=0
local notlyrefreshNum=0



function fairModel.get_booth_config(cfg_key_1,cfg_key_2)
local config=cfg_fangshishopconfig_get(cfg_key_1)[cfg_key_2]
return config
end


function fairModel.get_black_market_config(cfg_key_1,cfg_key_2)
local config=cfg_fangshiguishiconfig_get(cfg_key_1)[cfg_key_2]
return config
end


function fairModel.get_fair_build_id()
return cfgHelper.getdef1(cfg_fangshishopconfig,"buildId")
end


function fairModel.get_booth_goods_num()
local goodNum=cfgHelper.getdef1(cfg_fangshishopconfig,"goodsNum")
return goodNum
end


function fairModel.get_booth_free_flush_times_limit()
local flushGoods=cfgHelper.getdef1(cfg_fangshishopconfig,"flushGoods")
return flushGoods[1]
end


function fairModel.get_booth_free_flush_cd()
local flushGoods=cfgHelper.getdef1(cfg_fangshishopconfig,"flushGoods")
return flushGoods[2]
end


function fairModel.get_booth_ad_flush_times_limit()
local flushGoods=cfgHelper.getdef1(cfg_fangshishopconfig,"flushGoods")
return flushGoods[3]
end


function fairModel.getAdid()
local flushGoods=cfgHelper.getdef1(cfg_fangshishopconfig,"flushGoods")
return flushGoods[5]
end


function fairModel.get_booth_pay_flush_times_limit()
local flushGoods=cfgHelper.getdef1(cfg_fangshishopconfig,"flushGoods")
return flushGoods[4]
end


function fairModel.get_booth_flush_price_list()
return cfgHelper.getdef1(cfg_fangshishopconfig,"flushGoodPrice")
end


function fairModel.get_black_market_level()
return cfgHelper.getdef1(cfg_fangshiguishiconfig,"guildLvl")
end


function fairModel.get_black_market_goods_num()
return cfgHelper.getdef1(cfg_fangshiguishiconfig,"goodsNum")
end


function fairModel.get_black_market_flush_time_list()
return cfgHelper.getdef1(cfg_fangshiguishiconfig,"flushGoodTime")
end




function fairModel:init_data()
self.data={}
self.data.marketData={}
_itemguidLook={}
reqbuyflag=false
xiaozhushouFlag=false
notmoneyFlag=nil
xiaozhushouNum=0
lyrefreshNum=0
allxiaozhushouNum=0
fairModel:sortFlushTimeList()
end


function fairModel:set_data(data)
self.data.init=true
self.data.sys=
{
mountain_id=data[1],
build_id=data[2],
sys_open_time=data[3],
}
self.data.booth=
{
ad_flush_times=data[4],
pay_flush_times=data[5],
free_flush_begintime=data[6],
free_flush_totaltime=data[7],
cfg_key_1=data[8],
cfg_key_2=data[9],
goodsList=data[11],
itemList=data[19],
}
self.data.blackMarket=
{
cfg_key_1=data[12],
cfg_key_2=data[13],
goodsList=data[15],
speGoodList=data[17],
itemList=data[21],
}
self:setItem(data)
end

function fairModel:set_type_data(fairType,goodsList)
self.data.marketData[fairType]={}
self.data.marketData[fairType].goodsList=goodsList
end

function fairModel:update_type_goods_data(fairType,itemId,buyFlag)
for i,v in ipairs(self.data.marketData[fairType].goodsList)do
if v[1]==itemId then
v.buyFlag=buyFlag
end
end
end

function fairModel:can_buy(fairType,index)
if not self.data.marketData[fairType].goodsList[index]then
return false,0
end
local libItem=self.data.marketData[fairType].goodsList[index]
if libItem.buyFlag==1 then
return false,1
end
local zhekouprice=math.floor((libItem[4]*((libItem[5]or 100)/100))+0.5)
local moneyType=libItem[3]
local money=moneyModel.checkEnoughMoney(moneyType,zhekouprice)
if not money then
return false,2,moneyType
end
return true
end



function fairModel:get_data()
return self.data
end

function fairModel:isInit()
return self.data and self.data.init==true
end


function fairModel:get_sys_data()
return self.data.sys
end


function fairModel:set_goods_data(fairType,gridId,isBuy)
if fairType==eFairType.eBooth then
self.data.booth.goodsList[gridId].param_2=isBuy and 1 or 0
elseif fairType==eFairType.eBlackMarket then
self.data.blackMarket.goodsList[gridId].param_2=isBuy and 1 or 0
elseif fairType==eFairType.eBlackSpeGoods then
self.data.blackMarket.speGoodList[gridId].param_2=isBuy and 1 or 0
end
end


function fairModel:is_goods_buyed(fairType,gridId)

end


function fairModel:get_fair_data(fairType)
if fairType==eFairType.eBooth then
return self.data.booth
elseif fairType==eFairType.eBlackMarket then
return self.data.blackMarket
elseif fairType==eFairType.eBlackSpeGoods then
return self.data.blackMarket
else
return self.data.marketData[fairType]
end
end


function fairModel:set_refresh_data(refreshType,beginTime,totalTime)
if refreshType==eFairRefreshType.eFree then
self.data.booth.free_flush_begintime=beginTime
self.data.booth.free_flush_totaltime=totalTime
end
end


function fairModel:get_free_flush_count()
local cd=fairModel.get_booth_free_flush_cd()
local maxCount=fairModel.get_booth_free_flush_times_limit()
local nowTime=timeHelper.getServerShortTime()
local beginTime=self.data.booth and self.data.booth.free_flush_begintime or 0
local totalTime=self.data.booth and self.data.booth.free_flush_totaltime or 0
local nowCount=math.floor((nowTime-beginTime+totalTime)/cd)
local freeCount=math.min(maxCount,nowCount)
return freeCount
end


function fairModel:get_all_Disciple_shagndaoList()
local shangdaoList={}
local discipleNetData=UIDiscipleModel:getAllDiscipleDataX()
for k,v in pairs(discipleNetData)do
local discipleguidStr=v.netData.net.discipleguidStr
local netData=UIDiscipleModel:getDiscipleData(discipleguidStr)
local skill=netData.proskillList[DISCIPLE_PROSKILL_TYPE.eShangDao]
table.insert(shangdaoList,skill.level)
end
table.sort(shangdaoList,function(a,b)
if a>b then
return true
end
end)
return shangdaoList
end


function fairModel:set_CheooseBoxValue(boxCheck)
self.data.boxCheck=boxCheck
end


function fairModel:get_CheooseBoxValue()
return self.data.boxCheck
end


function fairModel:has_free_flush_count()
local freeCount=fairModel:get_free_flush_count()
return freeCount>0
end


function fairModel:Get_Ad_flush_count()
if not adController:supportPlayAD()then return 0 end
return self.data.booth.ad_flush_times
end


function fairModel:has_Ad_flush_count()
if not adController:supportPlayAD()then return false end
local maxCount=fairModel.get_booth_ad_flush_times_limit()
return self.data.booth.ad_flush_times<maxCount
end


function fairModel:get_free_flush_cd()
if self:is_enough_free_flush_count()then
return
end
local cd=fairModel.get_booth_free_flush_cd()
local nowTime=gameUtilityModel.getServerShortTime()
local beginTime=self.data.booth and self.data.booth.free_flush_begintime or 0
local totalTime=self.data.booth and self.data.booth.free_flush_totaltime or 0
return cd-(nowTime-beginTime+totalTime)%cd
end


function fairModel:is_enough_free_flush_count()
local freeCount=fairModel:get_free_flush_count()
local maxCount=fairModel.get_booth_free_flush_times_limit()
return freeCount>=maxCount
end


function fairModel:enough_pay_flush_count()
return self.data.booth.pay_flush_times
end


function fairModel:is_enough_pay_flush(cb)
local priceList=fairModel.get_booth_flush_price_list()
local nowTimes=fairModel:enough_pay_flush_count()
if nowTimes==0 then
nowTimes=1
end
local price=priceList[nowTimes]
local priceType=price[1]
local priceValue=price[2]
local allmoney=moneyModel.getMoney(priceType)
if self.data.booth.pay_flush_times<fairModel.get_booth_pay_flush_times_limit()then
local flag=moneySystem:useMoney(priceType,priceValue,cb,WARNING_TYPE.eWarning)
return flag,priceType,priceValue
else
UIManager.error('次数不足')
return false
end
end


function fairModel:is_enough_pay_flush_notuseXianYu(cb)
local priceList=fairModel.get_booth_flush_price_list()
local nowTimes=fairModel:enough_pay_flush_count()
if nowTimes==0 then
nowTimes=1
end
local price=priceList[nowTimes]
local priceType=price[1]
local priceValue=price[2]
local allmoney=moneyModel.getMoney(priceType)
if self.data.booth.pay_flush_times<fairModel.get_booth_pay_flush_times_limit()then
return allmoney>=priceValue,priceType,priceValue
else
UIManager.error('次数不足')
return false
end
end


function fairModel:get_black_market_flush_cd()
local cd=0
local passTime=timeHelper.getServerTodayPass()
local flushTimeList=fairModel.get_black_market_flush_time_list()
table.sort(flushTimeList,function(a,b)return a<b end)
local time
for i,v in ipairs(flushTimeList)do
if passTime<=v*3600 then
time=v*3600
break
end
end
if time==nil then
time=(flushTimeList[1]+24)*3600
end
cd=(time-passTime)%86400
return cd
end


function fairModel:is_open_guishi()
local is_guishi_open=zongmenModel:getLevel()<fairModel.get_black_market_level()
return is_guishi_open
end


function fairModel:isMaxShangdaoValue(dizi_level)
local isMax=false
local ShangDaoList=fairModel:get_all_Disciple_shagndaoList()
if dizi_level<ShangDaoList[1]then
isMax=true
end
return isMax
end


function fairModel:checkFangShiReddot()
local booth=fairModel:checkBoothReddot()
local guishi=fairModel:getRecordGuiShi()
return booth or guishi
end

function fairModel:checkBoothReddot()
local hasFreeCount=fairModel:has_free_flush_count()
local ggCount=fairModel:has_Ad_flush_count()
return hasFreeCount or ggCount
end

function fairModel:checkGuiShiReddot()
if fairModel:is_open_guishi()then

return false
end

local reddot=false
local markData=fairModel:getGuiShiCheckTimeMark()
if markData then
local isOpenWin=markData.isOpenWin or false
if not isOpenWin then

local nowTime=timeHelper.getServerLongTime()
if markData.checkTime and nowTime>=markData.checkTime then
reddot=true
end
end
end

return reddot
end

function fairModel:sortFlushTimeList()
local flushTime=fairModel.get_black_market_flush_time_list()
table.sort(flushTime,function(a,b)return a<b end)
self.data.flushTimeList=flushTime
end

function fairModel:getFlushTimeList()
return self.data.flushTimeList
end

function fairModel:setRecordGFair(flag)
self.data.fairTiShi=flag
end

function fairModel:getRecordFair()
return self.data.fairTiShi
end

function fairModel:setRecordGuiShi(flag)
self.data.guishiTiShi=flag
end

function fairModel:getRecordGuiShi()
return self.data.guishiTiShi
end

function fairModel:loadGuiShiCheckTimeMark()
self.data.guiShiCheckTimeMark=userActorSetting.get('guiShiCheckTimeMarkData',nil)

local isNeedUpdate=false
if not self.data.guiShiCheckTimeMark or self.data.guiShiCheckTimeMark.isOpenWin then
isNeedUpdate=true
end

if isNeedUpdate then
fairModel:updateGuiShiCheckTimeMark()
end
end

function fairModel:updateGuiShiCheckTimeMark()
if not fairModel:is_open_guishi()then

local pass=timeHelper.getServerTodayPass()
local flushTime=fairModel:getFlushTimeList()
local checkTime_hour
for i,v in ipairs(flushTime)do
if pass<v*3600 then
checkTime_hour=v
break
end
end

local addDay=0
if not checkTime_hour then
addDay=1
checkTime_hour=flushTime[1]
end
local y,m,d=timeHelper.getServerData()
local checkTime=timeHelper.timeServer(y,m,d+addDay,checkTime_hour,0,0)

self.data.guiShiCheckTimeMark={
checkTime=checkTime,
isOpenWin=false,
}
end
end

function fairModel:saveGuiShiCheckTimeMark()
if self.data.guiShiCheckTimeMark~=nil then
userActorSetting.flushVal('guiShiCheckTimeMarkData',self.data.guiShiCheckTimeMark)
end
end

function fairModel:setGuiShiCheckTimeMark(data)
self.data.guiShiCheckTimeMark=data
end

function fairModel:getGuiShiCheckTimeMark()
if self.data.guiShiCheckTimeMark==nil then
fairModel:loadGuiShiCheckTimeMark()
end

return self.data.guiShiCheckTimeMark
end

function fairModel:get_tips_config(fairType)
local fairData=fairModel:get_fair_data(fairType)
local fairCfg=fairModel.get_black_market_config(fairData.cfg_key_1,fairData.cfg_key_2)
local speaks=fairCfg.talktips
local index=math.random(1,#speaks)
return speaks[index]
end


function fairModel:test_clearGuiShiCheckTimeMark(isUpdateData)
self.data.guiShiCheckTimeMark=nil
userActorSetting.flushVal('guiShiCheckTimeMarkData',nil)
if isUpdateData then
fairModel:getGuiShiCheckTimeMark()
end
end


function fairModel:setItem(data)
local fairItems=data[19]
local guishiItems=data[21]
if fairItems then
for i,v in ipairs(fairItems)do
_itemguidLook[tostring(v.itemguid)]=v
end
end
if guishiItems then
for i,v in ipairs(guishiItems)do
_itemguidLook[tostring(v.itemguid)]=v
end
end
end

function fairModel.getItem(itemguid)
return _itemguidLook[tostring(itemguid)]
end


function fairModel:checkEquipFightUp(item)
local itemid=item.itemid
local itemguid=item.itemguid
local showUp=false
if itemsConfig.isEquip(itemid)then
local itemConfig=itemsConfig.getConfig(itemid)
local itemFight=equipsHelper.getEquipFightX(itemid,itemguid)
local discipleList=discipleLookup:getSortDiscipleList(eDiscipleSortType.eFightSort,{},eSortOrder.eDown)
local max=#discipleList<10 and#discipleList or 10
for i=1,max do
local netdata=discipleList[i].netData
local diziguid=netdata.net.discipleguid
local isCanDress=equipsHelper.isCanDress(diziguid,itemid)
if isCanDress then
local equipType=equipsConfig.getEquipType(itemid)
local equip=equipsHelper.getEquipByDizi(diziguid,equipType)
if equip then
local dressFight=equipsHelper.getEquipFightX(equip.itemid,equip.itemguid)
if itemFight>dressFight then
showUp=true
break
end
else
showUp=true
break
end
end
end
end
return showUp
end

function fairModel:SetReqBuyFlag(flag)
reqbuyflag=flag

end
function fairModel:GetReqBuyFlag()
return reqbuyflag
end


function fairModel:SetBeginXiaoZhuShouFlag(flag)
xiaozhushouFlag=flag

if flag then
fairModel:GetDiziZheKou()
notmoneyFlag=nil
end
end

function fairModel:GetBeginXiaoZhuShouFlag()
return xiaozhushouFlag
end

function fairModel:GetBeginNotmoneyFlag()
return notmoneyFlag
end

function fairModel:ChangeBeginXiaoZhuShouNum(type)
if type==0 or type==1 then
if not notlyrefreshNum then
notlyrefreshNum=0
end
notlyrefreshNum=notlyrefreshNum+1
elseif type==2 then
if not lyrefreshNum then
lyrefreshNum=0
end
lyrefreshNum=lyrefreshNum+1
end


end


function fairModel:SetBeginXiaoZhuShouNum(num)
xiaozhushouNum=num
lyrefreshNum=0
notlyrefreshNum=0
end


function fairModel:SetAllxiaozhushouNum(num)
allxiaozhushouNum=num
end


function fairModel:GetBeginXiaoZhuShouNum()
return xiaozhushouNum
end


function fairModel:GetItemCfgByShopID(shopItemId)
local libItem=cfgHelper.get(cfg_fangshishopitemconfig_get,shopItemId,"Item_conf")
return libItem
end


function fairModel:GetDiziZheKou()
local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eFangShi)
local bdData=bdDatas[1]
local config=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local dzId=bdData.dizi_id
local haveDz=tostring(dzId)~='0'
local dizi_zhekou=nil
if haveDz then
local bd_tybe_cfg=cfg_monijybuildconfig_get(config.id)
local skill_id=bd_tybe_cfg.pro_skill_id
if skill_id then
local pro_skill_cfg=cfg_discipleproskillconfig_get(skill_id)
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
local effectStr=discipleSelectController.getEffectDesc_fs(pro_skill_cfg,level)
local addEffect
if pro_skill_cfg.fangshi_discount then
addEffect=pro_skill_cfg.fangshi_discount[level]
end
if addEffect and addEffect>0 then
dizi_zhekou=addEffect
end
end
end
dizi_zhekou=dizi_zhekou or 0
self.data.dizi_zhekou=dizi_zhekou
end

function fairModel:ClearRecordItem()
self.data.xiaozhushou={}
end


function fairModel:RecordItem(gridlist)
for k,v in ipairs(gridlist)do
local gridId=v
if not self.data.xiaozhushou then
self.data.xiaozhushou={}
end
local shopid=self.data.booth.goodsList[gridId].param_1
local libItem=fairModel:GetItemCfgByShopID(shopid)
local itemid=libItem[1]
local itemCount=libItem[2]
local moneyType=libItem[3]
local moneyValue=libItem[4]
local distance=(100-libItem[5])
local israre=libItem[6]
local candistance=libItem[7]
local needValue

if candistance~=0 and self.data.dizi_zhekou~=0 then

needValue=math.floor((moneyValue*(distance-self.data.dizi_zhekou)/100)+0.5)
else
needValue=math.floor(moneyValue*(distance/100)+0.5)
end

if not self.data.xiaozhushou[moneyType]then
self.data.xiaozhushou[moneyType]=needValue
else
self.data.xiaozhushou[moneyType]=self.data.xiaozhushou[moneyType]+needValue
end

end
end


function fairModel:SetxiaozhushouData()
if not self.data.xiaozhushou or not next(self.data.xiaozhushou)then
return{}
end

local itemdatamoney={}
for k,v in pairs(self.data.xiaozhushou)do
local itemConfig=itemsConfig.getConfig(k)
table.insert(itemdatamoney,{k,v,itemConfig.color})
end
table.sort(itemdatamoney,function(a,b)
return a[3]>b[3]
end)

return itemdatamoney

end



function fairModel:AutoBuyItem()
local setup,cfg=guildOrderModel:getSetupData(GUILD_ORDER_TYPE.eAutoBuy)
local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eFangShi)
local bdData=bdDatas[1]
local config=cfgHelper.get1(cfg_monijybuildconfig_get,bdData.build_id)
local dzId=bdData.dizi_id
local haveDz=tostring(dzId)~='0'
local dizi_zhekou=nil
if haveDz then
local bd_tybe_cfg=cfg_monijybuildconfig_get(config.id)
local skill_id=bd_tybe_cfg.pro_skill_id
if skill_id then
local pro_skill_cfg=cfg_discipleproskillconfig_get(skill_id)
local level=UIDiscipleModel:getDiscipleJobLevel(dzId,skill_id)
local effectStr=discipleSelectController.getEffectDesc_fs(pro_skill_cfg,level)
local addEffect
if pro_skill_cfg.fangshi_discount then
addEffect=pro_skill_cfg.fangshi_discount[level]
end
if addEffect and addEffect>0 then
dizi_zhekou=addEffect
end
end
end
dizi_zhekou=dizi_zhekou or 0

local fairData=fairModel:get_fair_data(eFairType.eBooth)
local goodsList=fairData.goodsList
local fairCfg=fairModel.get_booth_config(fairData.cfg_key_1,fairData.cfg_key_2)
local moneyFlag=setup.moneyFlag
local moneyRange=cfg.moneyRange
local moneyLookup={}
local goodlist={}
for idx,good in ipairs(goodsList)do
local check=false

local libIndex=good.param_1
local isBuy=good.param_2==1
local libType=good.param_3
local item_lib=libType==1 and fairCfg.randomItem_lib or fairCfg.story_randomItem_lib
local shopItemId=libIndex
local libItem=cfgHelper.get(cfg_fangshishopitemconfig_get,shopItemId,"Item_conf")
if libItem~=nil then
local itemid=libItem[1]
local itemCount=libItem[2]
local moneyType=libItem[3]
local moneyValue=libItem[4]
local distance=(100-libItem[5])
local israre=libItem[6]
local candistance=libItem[7]
local needValue

if candistance~=0 and dizi_zhekou~=0 then

needValue=math.floor((moneyValue*(distance-dizi_zhekou)/100)+0.5)
else
needValue=math.floor(moneyValue*(distance/100)+0.5)
end


for i,moneyType_ in ipairs(moneyRange)do
if bitHelper.check_pos(moneyFlag,i-1)then
if moneyType_==moneyType then
check=true
break
end
end
end

if check then
local itemConfig=itemsConfig.getConfig(itemid)

if itemsConfig.isEquip(itemid)then

local equipColorIndex=setup.equipColorIndex
local color_=cfg.equipColorRange[equipColorIndex]
if color_<0 then
check=false
else
if itemConfig.color<color_ then
check=false
end
end
elseif itemsConfig.isMaterials(itemid)then

local clColorIndex=setup.clColorIndex
local stage_=cfg.clColorRange[clColorIndex]
if stage_<0 then
check=false
else
if itemConfig.stage<stage_ then
check=false
end
end
elseif itemsConfig.isItem(itemid)then

if itemConfig.type1==7 and itemConfig.type2==1 then

local jjDanYaoIndex=setup.jjDanYaoIndex
local color_=cfg.jjDanYaoRange[jjDanYaoIndex]
if color_<0 then
check=false
else
if itemConfig.color<color_ then
check=false
end
end
elseif itemConfig.type1==7 and itemConfig.type2==3 then

local ltDanYaoIndex=setup.ltDanYaoIndex
local color_=cfg.ltDanYaoRange[ltDanYaoIndex]
if color_<0 then
check=false
else
if itemConfig.color<color_ then
check=false
end
end
else

local elseFlag=setup.elseFlag
local elseRange=cfg.elseRange
local f
for i,v in ipairs(elseRange)do
if itemConfig.type1==v[1]and itemConfig.type2==v[2]then
f=true
if not bitHelper.check_pos(elseFlag,i-1)then
check=false
end
break
end
end
if not f then
check=false
end
end
else
check=false
end
end
if check and not isBuy then
local hasnum=moneyLookup[moneyType]
if hasnum==nil then
hasnum=moneyModel.getMoney(moneyType)
end
if hasnum>=needValue then
moneyLookup[moneyType]=hasnum-needValue
table.insert(goodlist,idx)
else

notmoneyFlag=moneyType
end
end
end
end
if#goodlist>0 then
fairController:req_buylist(eFairType.eBooth,#goodlist,goodlist)
else

if notmoneyFlag then

fairModel:OverXiaoZhuShou(2)
else

fairModel:req_refreshByXiaoZhuShou()
end
end

end

function fairModel:getBuildData()
local bdDatas=zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eFangShi)
local bdData=bdDatas[1]
return bdData
end


function fairModel:req_refreshByXiaoZhuShou()

if not xiaoZhuShouController:checkXiaoZhuShouOpen()then
fairModel:OverXiaoZhuShou()
return
end
if xiaozhushouNum==0 then
fairModel:OverXiaoZhuShou()
return
end



if fairModel:has_free_flush_count()then
fairController:req_refresh(eFairRefreshType.eFree)
xiaozhushouNum=xiaozhushouNum-1
return
end

if fairModel:has_Ad_flush_count()then
local id=fairModel.getAdid()
local buildData=fairModel:getBuildData()
local sfId=zongmenModel:getMountainId()
local un_buildid=buildData.un_build_id
local ext=adController:getParam(sfId,un_buildid)
local itemid=cfg_advertconfig().const_def.itemid
local cb=function(flag,id,ext)
if flag then
xiaozhushouNum=xiaozhushouNum-1
else

fairModel:OverXiaoZhuShou(3)
end
end
adController:playAD(id,ext,cb,1)

return
end

local cb=function()
fairController:req_refresh(eFairRefreshType.ePay)
xiaozhushouNum=xiaozhushouNum-1
end
local payflag,priceType,priceValue=fairModel:is_enough_pay_flush_notuseXianYu(cb)
if not payflag then

fairModel:OverXiaoZhuShou(1)
else
cb()
if not self.data.xiaozhushou then
self.data.xiaozhushou={}
end
if not self.data.xiaozhushou[priceType]then
self.data.xiaozhushou[priceType]=priceValue
else
self.data.xiaozhushou[priceType]=self.data.xiaozhushou[priceType]+priceValue
end
end

end


function fairModel:OverXiaoZhuShou(flag)
fairModel:SetBeginXiaoZhuShouFlag(false)
local itemdatamoney=fairModel:SetxiaozhushouData()
local showtext=""
if not flag then
if lyrefreshNum==0 then
showtext=FMT.fmt("已刷新{0}次，购买了以下商品",notlyrefreshNum)
else
showtext=FMT.fmt("已刷新{0}次，灵玉额外刷新{1}次，购买了以下商品",notlyrefreshNum,lyrefreshNum)
end
elseif flag==1 then
if lyrefreshNum==0 then
showtext=FMT.fmt("已刷新{0}次，灵玉不足，无法继续刷新",notlyrefreshNum)
else
showtext=FMT.fmt("已刷新{0}次，灵玉额外刷新{1}次，灵玉不足，无法继续刷新",notlyrefreshNum,lyrefreshNum)
end
xiaoZhuShouModel:addReportData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_fs,showtext)
elseif flag==2 then
local moneyname="灵玉/灵石"
if notmoneyFlag then
moneyname=moneyModel.getMoneyName(notmoneyFlag)
end
if lyrefreshNum>0 then
showtext=FMT.fmt("已刷新{0}次，灵玉额外刷新{1}次，{2}不足，无法完成购买，已停止刷新",notlyrefreshNum,lyrefreshNum,moneyname)
elseif notlyrefreshNum>0 and lyrefreshNum==0 then
showtext=FMT.fmt("已刷新{0}次，{1}不足，无法完成购买，已停止刷新",notlyrefreshNum,moneyname)
elseif notlyrefreshNum==0 and lyrefreshNum==0 then
showtext=FMT.fmt("{0}不足，无法完成购买，已停止刷新",moneyname)
end
xiaoZhuShouModel:addReportData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_fs,showtext)
elseif flag==3 then
showtext=FMT.fmt("已刷新{0}次，观影券不足，无法继续刷新",notlyrefreshNum)
xiaoZhuShouModel:addReportData(XIAOZHUSHUDETAIL_ENUM.xzs_sub_fs,showtext)
end

local args={UseMoneydata=itemdatamoney,num=xiaozhushouNum,showtext=showtext}
xiaoZhuShouDetailFunc.autoReceiveFangShiShowPrize(args)

fairModel:SetBeginXiaoZhuShouNum(0)
fairModel:SetAllxiaozhushouNum(0)
end