

UIAquariumControl=gameState.addListener(fullScreenUI.create())

function UIAquariumControl:onAppStart()
socketManager:register_receiver(6,78,self.recv_6_78)
socketManager:register_receiver(6,79,self.recv_6_79)
socketManager:register_receiver(6,80,self.recv_6_80)
socketManager:register_receiver(6,81,self.recv_6_81)
socketManager:register_receiver(6,82,self.recv_6_82)
socketManager:register_receiver(6,83,self.recv_6_83)
socketManager:register_receiver(6,84,self.recv_6_84)
socketManager:register_receiver(6,85,self.recv_6_85)
socketManager:register_receiver(6,86,self.recv_6_86)
socketManager:register_receiver(6,87,self.recv_6_87)

socketManager:register_receiver(254,67,self.recv_254_67)

self.yuTypes={[0]='所有鱼种','小型鱼种','中型鱼种','大型鱼种','异兽','灵物','摆件'}

local args=
{
fullType=FULL_TYPE.eAquarium,
skinType=fullScreenSkinType.eSkin15,
}
self:initUI(args)
end

function UIAquariumControl:onEnterState(isReconnect)
if isReconnect then
return
end

self.data={}
self.data.fishCountDirty=true
self.sellCheckData={{},{},{true,true,true},{true,true,true,true,true}}

notifySystem:listenNotify(notifyConfig.home_event,self.on_home_event)

notifySystem:listenNotify(notifyConfig.onRankListRefresh,self.onRankListRefresh)
notifySystem:listenNotify(notifyConfig.onNewGameYear,self.onNewGameYear)
end

function UIAquariumControl:onLeaveState(isReconnect)
if isReconnect then
return
end

self.data=nil
self.isInit=nil

self.aquariumBDData=nil

notifySystem:removelistener(notifyConfig.home_event,self.on_home_event)

notifySystem:removelistener(notifyConfig.onRankListRefresh,self.onRankListRefresh)
notifySystem:removelistener(notifyConfig.onNewGameYear,self.onNewGameYear)
end

function UIAquariumControl:onReConnection(isReconnect)
if not isReconnect then
return
end
end

function UIAquariumControl.on_home_event(etype)
if etype==homeEvent.eEnterHome then
UIAquariumControl:onEnterHome()
elseif etype==homeEvent.eLeaveHome then
UIAquariumControl:onLeaveHome()
end
end

function UIAquariumControl:onEnterHome()

end

function UIAquariumControl:onLeaveHome()
self.bdData=nil
end

function UIAquariumControl:showAquariumWin(argstable)
local tabType=FULL_TAB_TYPE.eAquarium

local args=
{
tabType=tabType,
showBg=true,
showTopMask=true,
viewNames={'UIAquariumWin'},
viewArgs={['UIAquariumWin']=argstable},
}
self:showUI(args)
end









function UIAquariumControl.onRankListRefresh(rankType)
if rankType==eRankListType.eYueLongChiRank or rankType==eRankListType.eYueLongChiRankCS then
UIManager:showWindow('UIAquariumLYRankWin')
end
end

function UIAquariumControl:isUseCrossServerData()
local day=timeHelper.getServerOpenDay()
local nday=cfgHelper.getdef1(cfg_yuelongchiconfig,'openserverday')
return day>=nday
end

function UIAquariumControl:getCurrRankType(useCS)
if useCS==nil then
useCS=self:isUseCrossServerData()
end
return useCS and eRankListType.eYueLongChiRankCS or eRankListType.eYueLongChiRank
end

function UIAquariumControl:reqRankData()
local useCS=self:isUseCrossServerData()
if useCS then
rankListController:send_24_2(self:getCurrRankType(useCS))
else
rankListController:send_24_1(self:getCurrRankType(useCS))
end
end

function UIAquariumControl:getRankList()
return rankListModel:getRankList(self:getCurrRankType())
end

function UIAquariumControl:checkRankTime()
return rankListModel:checkRankTime(self:getCurrRankType())
end

function UIAquariumControl:getMyRank()
return rankListModel:getRankNo(self:getCurrRankType())
end

function UIAquariumControl:reqActorInfo(serverId,actorId)
if self:isUseCrossServerData()then
socketManager:send_254_70(serverId,actorId)
else
socketManager:send_254_67(actorId)
end
end

function UIAquariumControl.recv_254_67(actorId,error,actorName,level,ylcInfo)
UIAquariumControl:handleVisitData(actorId,error,actorName,level,ylcInfo)
end

function UIAquariumControl.recv_254_67(actorId,error,actorName,level,ylcInfo)
UIAquariumControl:handleVisitData(actorId,error,actorName,level,ylcInfo)
end

function UIAquariumControl:handleVisitData(actorId,error,actorName,level,ylcInfo)
if error==0 then
UIAquariumControl:setVisitData(actorId,actorName,level,ylcInfo)
UIManager:callWindowFunc('UIAquariumWin','enterVisitModelEx')
else
UIManager.error('仙友未在线')
end
end

function UIAquariumControl:getAquariumBDData()
if not self.aquariumBDData then
self.aquariumBDData=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eYueLongChi)
end
return self.aquariumBDData
end

function UIAquariumControl:refreshHUD()
local bdData=self:getAquariumBDData()
if bdData then
hudControl:refreshBuildingStatusHUD(bdData.un_build_id)
end
end

function UIAquariumControl:setSellCheckData(data)
userActorArraySetting.set(ACTOR_SETTING_TYPE.eUIAquariumSellFilterWin,"eUIAquariumSellFilterWin",data)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eUIAquariumSellFilterWin)
end

function UIAquariumControl:getSellCheckData()
local sellCheckData=userActorArraySetting.get(ACTOR_SETTING_TYPE.eUIAquariumSellFilterWin,"eUIAquariumSellFilterWin",nil)
if not sellCheckData then
sellCheckData=self.sellCheckData
end
return sellCheckData
end



function UIAquariumControl:setVisitData(actorId,actorName,level,ylcInfo)
self.data.visitActorId=actorId
self.data.visitActorName=actorName
self.data.visitLevel=level
local visitFishItems={}
local visitFishItemPosData={}
local visitFishSizeData={}
if ylcInfo.len>0 then
for i,v in ipairs(ylcInfo.list)do
visitFishItems[tostring(v.itemguid)]=v
end
end
self.data.visitFishItems=visitFishItems

if ylcInfo.poslistlen>0 then
for i,v in ipairs(ylcInfo.posList)do
visitFishItemPosData[tostring(v.catchguid)]=v
end
end
self.data.visitFishItemPosData=visitFishItemPosData

if ylcInfo.sizelistlen>0 then
for i,v in ipairs(ylcInfo.sizeList)do
visitFishSizeData[tostring(v.catchguid)]=v.size
end
end
self.data.visitFishSizeData=visitFishSizeData
end

function UIAquariumControl:getVisitActorName()
return self.data.visitActorName
end

function UIAquariumControl:getVisitLevel()
return self.data.visitLevel
end

function UIAquariumControl:getVisitFishItems()
return self.data.visitFishItems
end

function UIAquariumControl:getVisitDecorationData(guid)
return self.data.visitFishItemPosData[tostring(guid)]
end

function UIAquariumControl:getFishItemsInBag(stypes)
local filter={
[ITEM_FILTER_TYPE.eItemType]={ITEM_FILTER_COMPARE.eEquals,{ITEM_MAIN_TYPE.eYuHuo}},
[ITEM_FILTER_TYPE.eItemType1]={ITEM_FILTER_COMPARE.eEquals,stypes},
}
local items=bagControl.getBagItemsByFilter(BAG_TYPE.eYuHuo,filter)
return items
end

function UIAquariumControl:getInfoCfgByHBId(hbId)
local info=cfgHelper.get2(cfg_yuelongchibookconfig_get,hbId,'info')
local cfg=cfgHelper.get1(cfg_ylcinfoconfig_get,info)
return cfg
end

function UIAquariumControl:getInfoCfgByItemId(itemId)
local itemCfg=itemsConfig.getConfig(itemId)
local cfg=cfgHelper.get1(cfg_ylcinfoconfig_get,itemCfg.info)
return cfg
end

function UIAquariumControl:showSpecialityTips(spId,widget)
local cfg=cfgHelper.get1(cfg_fishfeatureconfig_get,spId)
local info=FMT.fmt('自身灵韵值增加{0}%',cfg.percent)
if cfg.bonus then
for i,v in ipairs(cfg.bonus)do
if v[1]==1 then
local attrs=v[2]
for ii,vv in ipairs(attrs)do
local attrCfg=cfgHelper.get1(cfg_attributesconfig_get,vv[1])
info=FMT.fmt('{0}\n{1} +{2}',info,attrCfg.attrname,vv[2])
end
end
end
end

local args={
target=widget,
stype=4,
name=cfg.name,
desc=cfg.desc,
type='【特性】',
info=info,
color=2,
}
UIManager:showWindow('UIFishSpecialityWin',args)
end

function UIAquariumControl:getAttrAddPercent()
local lingyun=UIAquariumControl:countTotalLingyun()
local cfgs=cfg_yuelongchiprogressconfig()
local percent
for i,v in ipairs(cfgs)do
if lingyun>=v.lingyun then
percent=v.percent
else
break
end
end
return percent or{}
end

function UIAquariumControl:getYueLongChiAttrAddition_Lookup()
if not self:isInitData()then
return{}
end
local list=self:getTotalAttrData(true)
return list
end

function UIAquariumControl:showRuleTips()

local args={
info=ruleTipsImageGroup.eDiaoYu
}
UIManager:showWindow("UIRuleTipsImageWin",args)
end



function UIAquariumControl:checkYueLongChiReddot()
return self:checkFishManagerReddot()or self:checkHandleBookReddot()or self:checkSaiQianBoxReddot()
end

function UIAquariumControl:checkFishManagerReddot()
local level=self:getLevel()
local cfg=cfgHelper.get1(cfg_yuelongchiconfig_get,level)
for i=1,6 do
if self:checkFishManagerTypeReddot(i,cfg)then
return true
end
end
return false
end

function UIAquariumControl:checkFishManagerTypeReddot(ftype,cfg)
if not cfg then
local level=self:getLevel()
cfg=cfgHelper.get1(cfg_yuelongchiconfig_get,level)
end
local exNum=self:getExtendNumByType(ftype)
local num=cfg.max[ftype]+exNum
local curr=self:getFishTypeCount(ftype)
if curr<num then
if yuhuoBagModel:chackHaveOrnamentalTypeItem(ftype)then
return true
end
end
return false
end

function UIAquariumControl:checkHandleBookReddot()
return self:checkHandleBookPageReddot()or self:checkHBSuitPageReddot()
end

function UIAquariumControl:checkHandleBookPageReddot()
for i=1,4 do
if self:checkHandleBookTypeReddot(i)then
return true
end
end
return false
end

function UIAquariumControl:checkHBSuitPageReddot()
return self:checkCollectNew()or self:checkSuitNew()
end

function UIAquariumControl:checkHandleBookTypeReddot(ftype)
local cfgs=cfg_yuelongchibookconfig()
for i,v in pairs(cfgs)do
if v.type==ftype then
if self:checkHandleBookItemReddot(v.id)then
return true
end
end
end

return false
end

function UIAquariumControl:checkHandleBookItemReddot(bookId)
local data=self:getHandleBookData(bookId)
if data.star==-1 then
if data.times>0 then
return true
end
else
local cfg=cfgHelper.get1(cfg_yuelongchibookconfig_get,bookId)
local sdata=cfg.star[data.star]
local isFull=data.star>=#cfg.star
if not isFull then
if data.times>=sdata[1]then
return true
end
end
if not UIAquariumControl:checkHandleBookFlag(bookId,4)then
return true
end
if UIAquariumControl:checkHandleBookFlag(bookId,0)and not UIAquariumControl:checkHandleBookFlag(bookId,1)then
return true
end
if UIAquariumControl:checkHandleBookFlag(bookId,2)and not UIAquariumControl:checkHandleBookFlag(bookId,3)then
return true
end
end
return false
end

function UIAquariumControl:checkLingYunNew()
local lingyun=self:countTotalLingyun()
local data=self:getLingYunFlagData()
local cfgs=cfg_yuelongchiprogressconfig()
for i,v in ipairs(cfgs)do
if lingyun>=v.lingyun then
if not data[i]then
return true
end
else
break
end
end
return false
end

function UIAquariumControl:checkCollectNew()
local count=self:getHBActiveCount()
local data=self:getCollectFlagData()
local cfgs=cfg_yuelongchicollectconfig()
for i,v in ipairs(cfgs)do
if count>=v.total then
if not data[i]then
return true
end
else
break
end
end
return false
end

function UIAquariumControl:checkSuitNew()
local cfgs=cfg_yuelongchisuitconfig()
local data=self:getSuitFlagData()
for i,v in ipairs(cfgs)do
if not data[tostring(i)]then
local check=true
for ii,vv in ipairs(v.active)do
local hbdata=UIAquariumControl:getHandleBookData(vv[1])
if not hbdata or hbdata.star<vv[2]then
check=false
end
end
if check then
return true
end
end
end
return false
end



function UIAquariumControl:getLingYunFlagData()
local data=userActorArraySetting.get(ACTOR_SETTING_TYPE.eYueLongChi,'LINGYUNFLAGDATA',{})
return data
end

function UIAquariumControl:recordLingYunFlagData()
local lingyun=self:countTotalLingyun()
local cfgs=cfg_yuelongchiprogressconfig()
local list={}
for i,v in ipairs(cfgs)do
if lingyun>=v.lingyun then
list[i]=true
else
break
end
end
userActorArraySetting.set(ACTOR_SETTING_TYPE.eYueLongChi,'LINGYUNFLAGDATA',list)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eYueLongChi)
end

function UIAquariumControl:getCollectFlagData()
local data=userActorArraySetting.get(ACTOR_SETTING_TYPE.eYueLongChi,'COLLECTFLAGDATA',{})
return data
end

function UIAquariumControl:recordCollectFlagData()
local count=self:getHBActiveCount()
local cfgs=cfg_yuelongchicollectconfig()
local list={}
for i,v in ipairs(cfgs)do
if count>=v.total then
list[i]=true
else
break
end
end
userActorArraySetting.set(ACTOR_SETTING_TYPE.eYueLongChi,'COLLECTFLAGDATA',list)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eYueLongChi)
end

function UIAquariumControl:getSuitFlagData()
local data=userActorArraySetting.get(ACTOR_SETTING_TYPE.eYueLongChi,'SUITFLAGDATA',{})
return data
end

function UIAquariumControl:recordSuitFlagData()
local cfgs=cfg_yuelongchisuitconfig()
local list={}
for i,v in ipairs(cfgs)do
local check=true
for ii,vv in ipairs(v.active)do
local hbdata=UIAquariumControl:getHandleBookData(vv[1])
if not hbdata or hbdata.star<vv[2]then
check=false
end
end
if check then
list[tostring(i)]=true
end
end
userActorArraySetting.set(ACTOR_SETTING_TYPE.eYueLongChi,'SUITFLAGDATA',list)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eYueLongChi)
end



function UIAquariumControl:setDatas(datas)
local fishItems={}
local fishItemPosData={}
local fishSizeData={}
local ylcInfo=datas[1]
if ylcInfo.len>0 then
for i,v in ipairs(ylcInfo.list)do
fishItems[tostring(v.itemguid)]=v
end
end
self.data.fishItems=fishItems

if ylcInfo.poslistlen>0 then
for i,v in ipairs(ylcInfo.posList)do
fishItemPosData[tostring(v.catchguid)]=v
end
end
self.data.fishItemPosData=fishItemPosData

if ylcInfo.sizelistlen>0 then
for i,v in ipairs(ylcInfo.sizeList)do
fishSizeData[tostring(v.catchguid)]=v.size
end
end
self.data.fishSizeData=fishSizeData

local extendData={}
if datas[2]>0 then
for i,v in ipairs(datas[3])do
extendData[v.param_1]=v.param_2
end
end
self.data.extendData=extendData

local handbookData={}
if datas[4]>0 then
for i,v in ipairs(datas[5])do
handbookData[v.bookid]=v
end
end
self.data.handbookData=handbookData

local goodsData={}
if datas[6]>0 then
for i,v in ipairs(datas[7])do
goodsData[v.goodsid]=v
end
end
self.data.goodsData=goodsData

local marketData={}
if datas[8]>0 then
for i,v in ipairs(datas[9])do
marketData[v.param_1]=v.param_2
end
end
self.data.marketData=marketData

local reclaimData={}
if datas[10]>0 then
for i,v in ipairs(datas[11])do
reclaimData[v]=true
end
end
self.data.reclaimData=reclaimData

self.data.reclaimValue=datas[12]

local saiqianBoxData={}
if datas[13]>0 then
for i,v in ipairs(datas[14])do
local moneyType=v.param_1
local moneyCount=v.param_2
saiqianBoxData[moneyType]=moneyCount
end
end
UIAquariumControl:setSaiQianBoxMoneyData(saiqianBoxData)

self.isInit=true
end

function UIAquariumControl:isInitData()
return self.isInit
end

function UIAquariumControl:getFishPriceRise(itemId)
local cfg=itemsConfig.getConfig(itemId)
local rise=self:getMarketValue(cfg.type1)or 0
if self.data.reclaimData[cfg.bookid]then
rise=rise+self.data.reclaimValue
end
return 1+rise*0.01
end

function UIAquariumControl:getMaxMarketType()
local ftype=1
local val=0
for k,v in pairs(self.data.marketData)do
if v>val then
ftype=k
val=v
end
end
return ftype
end

function UIAquariumControl:getMarketValue(ftype)
return self.data.marketData[ftype]
end

function UIAquariumControl:getReclaimData()
return self.data.reclaimData
end

function UIAquariumControl:getReclaimValue()
return self.data.reclaimValue
end

function UIAquariumControl:getFishSize(fid)
return self.data.fishSizeData[tostring(fid)]or 1
end

function UIAquariumControl:setFishSize(fid,size)
self.data.fishSizeData[tostring(fid)]=size
end

function UIAquariumControl:getGoodsDatas()
return self.data.goodsData
end

function UIAquariumControl:getGoodsDataById(id)
return self.data.goodsData[id]
end

function UIAquariumControl:setDecorationData(data)
self.data.fishItemPosData[tostring(data.catchguid)]=data
end

function UIAquariumControl:getDecorationData(guid)
return self.data.fishItemPosData[tostring(guid)]
end

function UIAquariumControl:changeDecorationData(oldId,newId)
local idstr=tostring(oldId)
local data=self.data.fishItemPosData[idstr]
self.data.fishItemPosData[idstr]=nil
data.catchguid=newId
self:setDecorationData(data)
end

function UIAquariumControl:getHandleBookData(fid)
local data=self.data.handbookData[fid]
if not data then
data={
catchid=fid,
times=0,
flag=0,
star=-1,
}
self.data.handbookData[fid]=data
end
return data
end








function UIAquariumControl:checkHandleBookFlag(fid,pos)
local data=self:getHandleBookData(fid)
return bitHelper.check_pos(data.flag,pos)
end

function UIAquariumControl:setHandleBookFlag(fid,pos)
local data=self:getHandleBookData(fid)
data.flag=bitHelper.set_1(data.flag,pos)
end

function UIAquariumControl:setHandleBookFlagByWeight(itemId,weight)
local itemCfg=itemsConfig.getConfig(itemId)
local bookId=itemCfg.bookid
local cfg=cfgHelper.get1(cfg_yuelongchibookconfig_get,bookId)
if weight<=cfg.min then
UIAquariumControl:setHandleBookFlag(bookId,0)
elseif weight>=cfg.max then
UIAquariumControl:setHandleBookFlag(bookId,2)
end
self:addFishCountToHandleBook(itemId)
end

function UIAquariumControl:addFishCountToHandleBook(itemId)
local itemCfg=itemsConfig.getConfig(itemId)
if itemCfg.type1<=4 then
local data=self:getHandleBookData(itemCfg.bookid)
data.times=data.times+1
end
end

function UIAquariumControl:checkBookCanActiveOrReceive()
local data=self.data.handbookData
if not data then return false end
local list={}
for bookId,v in pairs(data)do
local isUpStar=false
local isActiveReward=false
local isMinWeight=false
local isMaxWeight=false
if v.star==-1 and v.times>0 then
isUpStar=true









end
if v.star>=0 and not UIAquariumControl:checkHandleBookFlag(bookId,4)then
isActiveReward=true
end
if UIAquariumControl:checkHandleBookFlag(bookId,0)and not UIAquariumControl:checkHandleBookFlag(bookId,1)then
isMinWeight=true
end
if UIAquariumControl:checkHandleBookFlag(bookId,2)and not UIAquariumControl:checkHandleBookFlag(bookId,3)then
isMaxWeight=true
end
if isUpStar or isActiveReward or isMinWeight or isMaxWeight then
local temp={
bookId=bookId,
isUpStar=isUpStar,
isActiveReward=isActiveReward,
isMinWeight=isMinWeight,
isMaxWeight=isMaxWeight,
}
table.insert(list,temp)
end
end
return#list>0,list
end

function UIAquariumControl:getHBActiveCount()
local count=0
for k,v in pairs(self.data.handbookData)do
if v.star~=-1 then
count=count+1
end
end
return count
end

function UIAquariumControl:setExtendValue(ftype,val)
self.data.extendData[ftype]=val
end

function UIAquariumControl:addFinish(item)
self.data.fishItems[tostring(item.itemguid)]=item
self.data.fishCountDirty=true
end

function UIAquariumControl:removeFish(guid)
self.data.fishItems[tostring(guid)]=nil
self.data.fishCountDirty=true
end

function UIAquariumControl:getFishTypeCountData()
if self.data.fishCountDirty then
local list={}
for k,v in pairs(self.data.fishItems)do
local cfg=itemsConfig.getConfig(v.itemid)
local tc=list[cfg.type1]or 0
tc=tc+1
list[cfg.type1]=tc
end
self.data.fishCountData=list
self.data.fishCountDirty=false
end
return self.data.fishCountData
end

function UIAquariumControl:getFishTypeCount(ftype)
local datas=self:getFishTypeCountData()
return datas[ftype]or 0
end

function UIAquariumControl:getYuTypeName(ytype)
return self.yuTypes[ytype]or''
end

function UIAquariumControl:getFishItems()
return self.data.fishItems
end

function UIAquariumControl:getFishItemByGuid(guid)
return self.data.fishItems[tostring(guid)]
end

function UIAquariumControl:getFishTypeByGuid(guid)
local item=self:getFishItemByGuid(guid)
local cfg=itemsConfig.getConfig(item.itemid)
return cfg.type1
end

function UIAquariumControl:getFishItemsByType(ftype)
local items=self:getFishItems()
local list={}
for k,v in pairs(items)do
local cfg=itemsConfig.getConfig(v.itemid)
if cfg.type1==ftype then
table.insert(list,v)
end
end
return list
end

function UIAquariumControl:getBuildingData()
if not self.bdData then
self.bdData=zongmenModel:findBuildingDataByID(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eYueLongChi)
end
return self.bdData
end

function UIAquariumControl:getLevel()
local data=self:getBuildingData()
if data then
return data.level
end
end

function UIAquariumControl:getExtendNumByType(ftype)
return self.data.extendData[ftype]or 0
end

function UIAquariumControl:printLYCount()
local items=self:getFishItems()
local pdata=self:getFishCollectionPercent()
for k,v in pairs(items)do
local cfg=itemsConfig.getConfig(v.itemid)
local ly=self:countFishLingYun(v,cfg,pdata)
logErr(cfg.name,ly)
end
logErr('套装加成',self:countSuitLingYun())
logErr('总值',self:countTotalLingyun())
end

function UIAquariumControl:getFishCollectionPercent()
local cfgs=cfg_yuelongchicollectconfig()
local unlockNum=UIAquariumControl:getHBActiveCount()
local cfg
for i,v in ipairs(cfgs)do
if unlockNum>=v.total then
cfg=v
else
break
end
end
if cfg then
return cfg.percent
else
return{}
end
end

function UIAquariumControl:countFishLingYun(data,cfg,pdata)
if not data then
if cfg then
return cfg.lingyun
else
return 0
end
end
if not cfg then
cfg=itemsConfig.getConfig(data.itemid)
end

local count=cfg.lingyun
local percent=100
local txList=data.itemData.featureList
if txList then
for i,v in ipairs(txList)do
local txcfg=cfgHelper.get1(cfg_fishfeatureconfig_get,v)
percent=percent+(txcfg.percent or 0)
end
end
if not pdata then
pdata=self:getFishCollectionPercent()
end
if pdata[0]then
percent=percent+pdata[0]
end
if pdata[cfg.type1]then
percent=percent+pdata[cfg.type1]
end
if percent>100 then
count=math.floor(count*percent*0.01)
end
return count
end

function UIAquariumControl:countSuitLingYun()
local count=0
local cfgs=cfg_yuelongchisuitconfig()
for i,v in ipairs(cfgs)do
local check=true
for ii,vv in ipairs(v.active)do
local hbdata=self:getHandleBookData(vv[1])
if not hbdata or hbdata.star<vv[2]then
check=false
break
end
end
if check then
count=count+v.lingyun
end
end
return count
end

function UIAquariumControl:countTotalLingyun()
if self.data==nil then return 0 end
if not self.data.lingYunValue then
local items=self:getFishItems()
local pdata=self:getFishCollectionPercent()
local count=0
for k,v in pairs(items)do
count=count+self:countFishLingYun(v,nil,pdata)
end

count=count+self:countSuitLingYun()
self.data.lingYunValue=count
end

return self.data.lingYunValue
end

function UIAquariumControl:setYunLingValueDirty()
self.data.lingYunValue=nil
end

function UIAquariumControl:getTotalAttrData(countFeatureAttr)

local percent=self:getAttrAddPercent()
local list={}
local cfgs=cfg_yuelongchibookconfig()
for k,v in pairs(cfgs)do
local data=self:getHandleBookData(k)
if data.star>=0 then
local attrs=v.star[data.star][2]
local add=percent[v.type]or 0
if percent[0]then
add=add+percent[0]
end
for ii,vv in ipairs(attrs)do
local val=list[vv[1]]or 0
list[vv[1]]=val+math.floor(vv[2]*(1+add*0.01))
end
end
end
if countFeatureAttr then

local splist=self:getAllActiveFeature()
for i,v in ipairs(splist)do
local bonus=cfgHelper.get2(cfg_fishfeatureconfig_get,v,'bonus')
if bonus then
for ii,vv in ipairs(bonus)do
if vv[1]==1 then
local attrs=vv[2]
for iii,vvv in ipairs(attrs)do
local val=list[vvv[1]]or 0
list[vvv[1]]=val+vvv[2]
end
end
end
end
end
end
return list
end

function UIAquariumControl:getAllActiveFeature(sort)
local items=self:getFishItems()
local list={}
for k,v in pairs(items)do
local flist=v.itemData.featureList
if flist then
for ii,vv in ipairs(flist)do
table.insert(list,vv)
end
end
end

if sort then
table.sort(list,function(a,b)
return a<b
end)
end
return list
end

function UIAquariumControl:getItemByGuid(guid)
local data=bagModel.getItem(guid)
if not data then
data=self:getFishItemByGuid(guid)
end
return data
end

function UIAquariumControl:isFishType(ftype)
return ftype~=6
end

function UIAquariumControl:showYuHuoTips(itemid,index,itemguid,attach)

tipsManager.showTips({formType=TIPS_FORM_TYPE.eYuHuo,itemid=itemid,itemguid=itemguid,attach=attach})
end

function UIAquariumControl:countScaleBySize(scale,size,itemid)
local cfg=self:getInfoCfgByItemId(itemid)
if size==0 then
return scale*cfg.min_scale
elseif size==2 then
return scale*cfg.max_scale
end
return scale
end

function UIAquariumControl:openHandleBookWin()
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.yuZhongTuJian,{})
end

function UIAquariumControl:isOrnamentalFish(item)
return item and item.itemData.view==1
end



function UIAquariumControl:getSaiQianBoxData()
return self.data.saiQianBoxData
end


function UIAquariumControl:getSaiQianBoxMoneyData()
if not self.data.saiQianBoxData then
return
end
return self.data.saiQianBoxData.moneyList
end


function UIAquariumControl:setSaiQianBoxMoneyData(data)
if not self.data.saiQianBoxData then
self.data.saiQianBoxData={}
end

if not self.data.saiQianBoxData.moneyList then
self.data.saiQianBoxData.moneyList={}
end

self.data.saiQianBoxData.moneyList=data
end

function UIAquariumControl.onNewGameYear(islogin)
if islogin then
return
end

local level=UIAquariumControl:getLevel()
if not level then
return
end
local cfg=cfgHelper.get1(cfg_yuelongchiconfig_get,level)
local storeList=cfg and cfg.store or{}
local moneyData=UIAquariumControl:getSaiQianBoxMoneyData()or{}
local yearAddCfg=cfgHelper.getdef1(cfg_yuelongchiconfig,'year')
local fishTypeCountData=UIAquariumControl:getFishTypeCountData()
local yearAddMoneyList={}
for fishType,fishCount in pairs(fishTypeCountData)do
local addList=yearAddCfg[fishType]
if addList then
for i,v in ipairs(addList)do
local moneyType=v[1]
local addNum=v[2]
local tmpCount=yearAddMoneyList[moneyType]or 0
yearAddMoneyList[moneyType]=tmpCount+addNum*fishCount
end
end
end

local newMoneyData={}
local needSetNewData=false
for moneyType,maxNum in pairs(storeList)do
local nowMoneyCount=moneyData[moneyType]or 0
local addCount=yearAddMoneyList[moneyType]
if nowMoneyCount<maxNum and addCount then
local newMoneyCount=nowMoneyCount+math.ceil(addCount)
if newMoneyCount>maxNum then
newMoneyCount=maxNum
end
needSetNewData=true
newMoneyData[moneyType]=newMoneyCount
end
end
if needSetNewData then
UIAquariumControl:setSaiQianBoxMoneyData(newMoneyData)

UIManager:callWindowFunc('UIAquariumWin','refreshSaiQianBox')

UIAquariumControl:refreshHUD()
end
end

function UIAquariumControl:checkSaiQianBoxReddot()
local moneyData=UIAquariumControl:getSaiQianBoxMoneyData()
if not moneyData or not next(moneyData)then
return false
end


local level=UIAquariumControl:getLevel()
if not level then
return false
end
local cfg=cfgHelper.get1(cfg_yuelongchiconfig_get,level)
local storeList=cfg and cfg.store or{}
local target=cfgHelper.getdef1(cfg_yuelongchiconfig,'overaccumulate')or 1
for moneyType,maxNum in pairs(storeList)do
local nowMoneyCount=moneyData[moneyType]or 0
if moneyType==eMoneyType.mtManYiDu and nowMoneyCount>=maxNum*target then

return true
end
end

return false
end


function UIAquariumControl:test_printNowSaiQianBoxMoneyData()
local moneyData=UIAquariumControl:getSaiQianBoxMoneyData()
if not moneyData or not next(moneyData)then

return
end

local str="测试塞钱箱 "
for moneyType,moneyCount in pairs(moneyData)do
local name=moneyModel.getMoneyName(moneyType)
local tmpStr=FMT.fmt("[{0}:{1}] ",name,moneyCount)
str=FMT.fmt("{0}{1}",str,tmpStr)
end

end



function UIAquariumControl:GetAllfishfeature()
if not self.data.alltxcfg then
self.data.alltxcfg=cfg_fishfeatureconfig()
end
return self.data.alltxcfg
end



function UIAquariumControl:reqGetSaiQianReward(assistant)
socketManager:send_6_79(assistant or 0)
end

function UIAquariumControl:reqHBReward(id,rtype,is_assistant)
socketManager:send_6_80(id,rtype,is_assistant or 0)
end

function UIAquariumControl:reqHBStarUp(id,is_assistant)
socketManager:send_6_81(id,is_assistant or 0)
end

function UIAquariumControl:reqExpansion(ctype,times)
socketManager:send_6_82(ctype,times)
end

function UIAquariumControl:reqDelivery(oldId,newId)
socketManager:send_6_83(oldId,newId)
end

function UIAquariumControl:reqPlaced(posInfo)
socketManager:send_6_84(posInfo)
end

function UIAquariumControl:reqBuyGoods(id,num)
socketManager:send_6_85(id,num)
end

function UIAquariumControl:reqBuyGoods(id,num)
socketManager:send_6_85(id,num)
end

function UIAquariumControl:reqDeal(len,arr,is_assistant)
socketManager:send_6_86(len,arr,is_assistant or 0)
end

function UIAquariumControl:reqChangeSize(sizeInfo)
socketManager:send_6_87(sizeInfo)
end



function UIAquariumControl.recv_6_78(datas)
UIAquariumControl:setDatas(datas)

UIAquariumControl:setYunLingValueDirty()

UIManager:callWindowFunc('UIAquariumWin','refreshSaiQianBox')
UIManager:callWindowFunc('UIAquariumHandbookWin','refresh')
UIManager:callWindowFunc('UIYYHYWin','refreshtujianreddot')
UIAquariumControl:refreshHUD()
reddotControl.on_change_catch_type(CATCH_TYPE.eYueLongChi)
end


function UIAquariumControl.recv_6_79(assistant)

local saiqianBoxData={}
UIAquariumControl:setSaiQianBoxMoneyData(saiqianBoxData)

UIManager:callWindowFunc('UIAquariumWin','refreshSaiQianBox')


UIAquariumControl:refreshHUD()
end

function UIAquariumControl.recv_6_80(id,rtype,is_assistant)
UIAquariumControl:setHandleBookFlag(id,rtype)

UIManager:callWindowFunc('UIAquariumHandbookWin','refresh')
UIManager:callWindowFunc('UIAquariumWin','setReddot')
UIManager:callWindowFunc('UIYYHYWin','refreshtujianreddot')

UIAquariumControl:refreshHUD()
reddotControl.on_change_catch_type(CATCH_TYPE.eYueLongChi)
end

function UIAquariumControl.recv_6_81(id,star,is_assistant)
local data=UIAquariumControl:getHandleBookData(id)
local cfg=cfgHelper.get1(cfg_yuelongchibookconfig_get,id)
local lstar=data.star
if lstar<0 then
data.times=data.times-1
UIManager:callWindowFunc('UIAquariumHandbookWin','playEffect')

AudioManager.playAudio(585)
else
data.times=data.times-cfg.star[lstar][1]

AudioManager.playAudio(586)
end
data.star=star

UIAquariumControl:setYunLingValueDirty()

UIManager:callWindowFunc('UIAquariumHandbookWin','refresh')
UIManager:callWindowFunc('UIAquariumWin','setReddot')
UIManager:callWindowFunc('UIYYHYWin','refreshtujianreddot')


UIDiscipleModel:setAllDiscipleAttrListDirty()
UIAquariumControl:refreshHUD()
reddotControl.on_change_catch_type(CATCH_TYPE.eYueLongChi)
notifySystem:postNotify(notifyConfig.onYueLongChiLingYunChange)
end

function UIAquariumControl.recv_6_82(ctype,extend)
UIAquariumControl:setExtendValue(ctype,extend)
UIManager:callWindowFunc('UIAquariumManagerWin','refresh')
UIManager:callWindowFunc('UIAquariumWin','setReddot')
UIManager:callWindowFunc('UIYYHYWin','refreshtujianreddot')

UIAquariumControl:refreshHUD()
end

function UIAquariumControl.recv_6_83(oldId,newId)
local oldStr=tostring(oldId)
local newStr=tostring(newId)
local oldFish
if oldStr~='0'then
oldFish=UIAquariumControl:getFishItemByGuid(oldId)
UIAquariumControl:removeFish(oldId)
UIManager:callWindowFunc('UIAquariumWin','removeFish',oldId)
end
if newStr~='0'then
local item=bagModel.getItem(newId)
UIAquariumControl:addFinish(item)
local ncfg=itemsConfig.getConfig(item.itemid)
local needLoad=true
if oldFish then
local ocfg=itemsConfig.getConfig(oldFish.itemid)
if ocfg.type1==6 and ncfg.type1==6 then
UIAquariumControl:changeDecorationData(oldId,newId)
end
else
if ncfg.type1==6 then
needLoad=false
end
end
if needLoad then
UIManager:callWindowFunc('UIAquariumWin','putInFish',item)
end
end

UIAquariumControl:setYunLingValueDirty()

UIManager:callWindowFunc('UIAquariumManagerWin','refreshAndSelect',newId,oldStr=='0')
UIManager:callWindowFunc('UIAquariumManagerWin','delaySetReddot')
UIManager:callWindowFunc('UIAquariumWin','setTopInfo')
UIManager:callWindowFunc('UIAquariumWin','setLingYun')
UIManager:callWindowFunc('UIAquariumWin','delaySetReddot')


UIDiscipleModel:setAllDiscipleAttrListDirty()
UIAquariumControl:refreshHUD()
notifySystem:postNotify(notifyConfig.onYueLongChiLingYunChange)
end

function UIAquariumControl.recv_6_84(posInfo)
UIAquariumControl:setDecorationData(posInfo)
UIManager:callWindowFunc('UIAquariumWin','completeDecoration',posInfo)
end

function UIAquariumControl.recv_6_85(id,num)
local data=UIAquariumControl:getGoodsDataById(id)
data.bought=num
UIManager:callWindowFunc('UIAquariumShopWin','refresh')
UIManager:callWindowFunc('UIAquariumWin','setReddot')

UIAquariumControl:refreshHUD()

AudioManager.playAudio(514)
end

function UIAquariumControl.recv_6_86(len,arr,is_assistant)
UIManager:callWindowFunc('UIAquariumBagWin','completeSell')
UIManager:callWindowFunc('UIAquariumWin','setReddot')

if is_assistant==1 then
timeEventController.delayDo(0.1,function()
local xzsEffectData={
sub_effecttype=XIAOZHUSHU_ENUM.xzs_YueLongChi,
sub_effecttype2=XIAOZHUSHUDETAIL_ENUM.xzs_sub_ylc_sell,
notRealRewards=true,
moneyCount=UIAquariumControl.xzsAutoSellMoneyCount,
}
notifySystem:postNotify(notifyConfig.onShowPrize,ePrizeType.eXZS_Common,UIAquariumControl.xzsAutoSellItemList,xzsEffectData)
UIAquariumControl.xzsAutoSellItemList=nil
UIAquariumControl.xzsAutoSellMoneyCount=nil
end)
end

UIAquariumControl:refreshHUD()
end

function UIAquariumControl.recv_6_87(sizeInfo)
UIAquariumControl:setFishSize(sizeInfo.catchguid,sizeInfo.size)
UIManager:callWindowFunc('UIAquariumWin','completeChangeSize',sizeInfo)
UIManager:callWindowFunc('UIAquariumManagerWin','refreshInfoPanel')
end



function UIAquariumControl:autoSellFish(checkReddot)
local datas=UIAquariumControl:getFishItemsInBag({1,2,3,4})
local list={}
local sellData=UIAquariumControl:getSellCheckData()
local sendCount=0
for i,v in ipairs(datas)do
local itemData=v
local itemCount=v.itemcount
local isSPFish=UIAquariumControl:isOrnamentalFish(itemData)
local cfg=itemsConfig.getConfig(itemData.itemid)
local stype=cfg.type1
local color=cfg.color
local check=true
if isSPFish then
if not sellData[1][stype]then
check=false
end
if not sellData[2][color]then
check=false
end
else
if not sellData[3][stype]then
check=false
end
if not sellData[4][color]then
check=false
end
end
if check then
if checkReddot then
return true
end
local sdata=list[tostring(itemData.itemguid)]
if sdata then
sdata[2]=sdata[2]+itemCount
else
sdata={itemData,itemCount}
list[tostring(itemData.itemguid)]=sdata
sendCount=sendCount+1
if sendCount>=1000 then
break
end
end
end
end

local countSellPrice=function(itemid,itemCount)
local count=0
local cfg=itemsConfig.getConfig(itemid)
local rise=UIAquariumControl:getFishPriceRise(itemid)
count=count+math.floor(cfg.dealPrice[2]*rise*itemCount)
return count
end

local sendDatas={}
self.xzsAutoSellItemList={}
self.xzsAutoSellMoneyCount=0
local lookup={}
for i,v in pairs(list)do
local itemData=v[1]
local itemCount=v[2]
local itemguid=itemData.itemguid
local itemid=itemData.itemid
lookup[itemid]=(lookup[itemid]or 0)+itemCount
table.insert(sendDatas,{itemguid,itemCount})
self.xzsAutoSellMoneyCount=self.xzsAutoSellMoneyCount+countSellPrice(itemid,itemCount)
end
for itemid,itemCount in pairs(lookup)do
table.insert(self.xzsAutoSellItemList,{itemid=itemid,num=itemCount})
end
if#sendDatas>0 then
UIAquariumControl:reqDeal(#sendDatas,sendDatas,1)
end
end
