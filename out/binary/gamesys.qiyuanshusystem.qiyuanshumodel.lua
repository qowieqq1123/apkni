






local _MODULENAME="qiYuanShuModel"


def_table(_MODULENAME)
qiYuanShuModel.name=_MODULENAME
qiYuanShuModel.data={}

function qiYuanShuModel:onAppStart()

end


function qiYuanShuModel:onEnterState(isReconnect)
qiYuanShuModel:loadQYSPassAniState()
end


function qiYuanShuModel:onProtocolReq()

end


function qiYuanShuModel:onLeaveState(isReconnect)

self.data={}
end



function qiYuanShuModel:initQiYuanShuData(data)
self.data.qiYuanShuData={}
self.data.qiYuanShuData.bdNum=data[1]
self.data.qiYuanShuData.freeNum=data[2]
self.data.qiYuanShuData.gbfreeNum=data[3]
self.data.qiYuanShuData.todayNum=data[4]
self.data.qiYuanShuData.firstFlag=data[5]
self.data.qiYuanShuData.wishGBId=data[6]
self.data.qiYuanShuData.startTime=data[7]
self.data.qiYuanShuData.endTime=data[8]
self.data.qiYuanShuData.bdNum_orange=data[9]
self.data.qiYuanShuData.bdNum_red=data[10]
self.data.qiYuanShuData.lib_id=data[11]or 0
self.data.qiYuanShuData.qyslist={}
end

function qiYuanShuModel:initQiYuanShuTime()
local sTime,eTime=qiYuanShuModel:getQiYuanTime()
local nowTime=timeHelper.getServerShortTime()
if nowTime>=sTime and nowTime>=eTime then

local cfg=cfgHelper.get1(cfg_wishtreeconfig_get,1)
local timeParam=cfg.time_control[2]
local intervalWeek=timeParam[2]
local nextTime_s=sTime+(intervalWeek+1)*86400*7
local nextTime_e=eTime+(intervalWeek+1)*86400*7







self.data.qiYuanShuData.startTime=nextTime_s
self.data.qiYuanShuData.endTime=nextTime_e
end
end

function qiYuanShuModel:setQiYuanShuWishGbId(wishGBId)
if not self.data then
self.data={}
end

if not self.data.qiYuanShuData then
self.data.qiYuanShuData={}
end

self.data.qiYuanShuData.wishGBId=wishGBId
end

function qiYuanShuModel:getQiYuanShuWishGbId()
if not systemModel.isOpen(SYSTEM_DEFINE.eWishTree)then

return nil
end

if not self.data or not self.data.qiYuanShuData then
return nil
end

return self.data.qiYuanShuData.wishGBId
end

function qiYuanShuModel:get_qiyuanshu_data()
if self.data then
return self.data.qiYuanShuData
end
end

function qiYuanShuModel:get_qiyuanshu_free_num()
local num=0
local data=qiYuanShuModel:get_qiyuanshu_data()
if data then
local max_free=cfgHelper.get2(cfg_wishtreeconfig_get,1,'freeNum')
local lerp=max_free-data.freeNum
if lerp>0 then
num=num+lerp
end









end
return num
end

function qiYuanShuModel:initQiYuanTime()
if not systemModel.isOpen(SYSTEM_DEFINE.eWishTree)then

return
end












































end


function qiYuanShuModel:getQiYuanTime()
local data=qiYuanShuModel:get_qiyuanshu_data()
if data then
return data.startTime,data.endTime
end
end


function qiYuanShuModel:checkIsInQiYuanNow()
local sTime,eTime=qiYuanShuModel:getQiYuanTime()
local nowTime=timeHelper.getServerShortTime()
local isInQiYuanNow=sTime and eTime and sTime~=0 and eTime~=0 and nowTime>=sTime and nowTime<eTime or false
return isInQiYuanNow
end

function qiYuanShuModel:getShowBehaviorName()
local color=0
local one=#self.data.rewardsTemp==1
local behaviorNameList={
[1]={
[1]='qiyuanshu_1',
[2]='qiyuanshu_2',
[3]='qiyuanshu_7',
[4]='qiyuanshu_3',
},
[2]={
[1]='qiyuanshu_4',
[2]='qiyuanshu_5',
[3]='qiyuanshu_8',
[4]='qiyuanshu_6',
},
}
local numIndex=one and 1 or 2
for k,v in pairs(self.data.rewardsTemp)do
local itemid=v.param_1
if self:isBigReward(itemid)then

return behaviorNameList[numIndex][1]
end
local itemConfig=itemsConfig.getConfig(itemid)
if color<=itemConfig.color then
color=itemConfig.color
end
end
if color>=5 then

return behaviorNameList[numIndex][2]
elseif color>=3 then

return behaviorNameList[numIndex][3]
end

return behaviorNameList[numIndex][4]
end

function qiYuanShuModel:isBigReward(itemid)
local bigConfig=cfg_wishtreebigrewardconfig()
return bigConfig[itemid]~=nil and bigConfig[itemid].bigReward==1
end

function qiYuanShuModel:saveRewardsTemp(itemList)
self.data.rewardsTemp=itemList
end

function qiYuanShuModel:getRewardsTemp()
return self.data.rewardsTemp
end

function qiYuanShuModel:setShowItemList(list,num)
self.data.showItems=list
self.data.showNum=num
end

function qiYuanShuModel:getShowItemid()
local showItems=self.data.showItems
if showItems then
local rand
if#showItems<=self.data.showNum then
rand=math.random(1,#showItems)
else
rand=math.random(self.data.showNum+1,#showItems)
end
local itemid=showItems[rand]
table.remove(showItems,rand)
table.insert(showItems,1,itemid)
return showItems[1]
end
end

function qiYuanShuModel:setShowPoints(points)
self.data.showPoints=points
end

function qiYuanShuModel:getShowPosition()
local points=self.data.showPoints
local rand=math.random(1,#points)
local pos=points[rand]
table.remove(points,rand)
return pos
end

function qiYuanShuModel:getShowDatas(list)
local lv=zongmenModel:getLevel()
for i,v in ipairs(list)do
if lv>=v[1]and lv<=v[2]then
return v
end
end
return list[#list]
end


function qiYuanShuModel:loadQYSPassAniState()
self.data.passAni=userActorSetting.get('qiYuanShuPassAniState',false)
end

function qiYuanShuModel:saveQYSPassAniState()
userActorSetting.set('qiYuanShuPassAniState',self.data.passAni)
userActorSetting.flush()
end

function qiYuanShuModel:changeQYSPassAniState(val)
self.data.passAni=val
end

function qiYuanShuModel:getQYSPassAniState()
return self.data.passAni
end


function qiYuanShuModel:getWishGuBaoSelectList()
if not self.data.wishGuBaoSelectList then
self.data.wishGuBaoSelectList={}
end
self:initWishGuBaoSelectList()

return self.data.wishGuBaoSelectList
end

function qiYuanShuModel:initWishGuBaoSelectList()
local lib_id=self.data.qiYuanShuData.lib_id
local wishGuBaoCfg=qiYuanShuModel:getQiYuanShu_wishGuBaoList(lib_id)

local sortList={}
for gubaoId,param in pairs(wishGuBaoCfg)do
local percent=param[1]
local itemId=param[2]
sortList[#sortList+1]={
gubaoId=gubaoId,
itemId=itemId,
}
end


table.sort(sortList,function(a,b)
return a.itemId<b.itemId
end)
self.data.wishGuBaoSelectList=sortList
end


function qiYuanShuModel:getQiYuanActId()

return-1
end


function qiYuanShuModel:checkQiYuanShuEnterReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eWishTree)then

return false
end
local isInQiYuanNow=qiYuanShuModel:checkIsInQiYuanNow()
if not isInQiYuanNow then

return false
end


local freenum=qiYuanShuModel:get_qiyuanshu_free_num()
if freenum>0 then

return true
end


return qiYuanShuModel:checkQiYuanShopReddot()or qiYuanShuModel:isNewReddot()

end


function qiYuanShuModel:checkQiYuanShopReddot()
if not systemModel.isOpen(SYSTEM_DEFINE.eWishTree)then

return false
end







local shopId=eFuncShopType.eQiYuan
local shopCfg=funcShopModel.get_shop_item_conf(shopId)
for i,v in pairs(shopCfg)do
local isSpecial=v.specialFlag and v.specialFlag==1 or false
if isSpecial and funcShopModel:check_item_unlock(shopId,v.id,nil,'hide')then
if funcShopModel:check_item_unlock(shopId,v.id)then
local isSellOut=funcShopModel:checkSoldout(shopId,v.id)
local moneyType=v.money[1]
local price=v.money[2]
if not isSellOut and moneyModel.checkEnoughMoney(moneyType,price)then

return true
end
end
end
end
return false
end

function qiYuanShuModel:test_printQiYuanTime()
if not systemModel.isOpen(SYSTEM_DEFINE.eWishTree)then

return UIManager.info("系统未开启")
end

local sTime,eTime=qiYuanShuModel:getQiYuanTime()
UIManager.info(FMT.fmt("开始时间：{0}",timeHelper.getFormatByShortStamp(sTime)))
UIManager.info(FMT.fmt("结束时间：{0}",timeHelper.getFormatByShortStamp(eTime)))
end




function qiYuanShuModel:checkQiYuanShuOpen(lib_id)
if not lib_id then return false end
if lib_id==0 then
return true
else
local cfg=cfg_wishtreelibconfig_get(lib_id)
if cfg then
local day=timeHelper.getServerOpenDay()
local lv=zongmenModel:getLevel()
local version=qiYuanShuModel:checkVerSion(cfg)
if lv>=cfg.level and day>=cfg.server_open_day and version then
return true
end
end
end
return false
end

function qiYuanShuModel:checkVerSion(cfg)
if cfg then
if cfg.game_version then
local versionId=pfwindowslController:getGameVersion()
for id,v in pairs(cfg.game_version)do
if id==versionId then
return true
end
end
else
return true
end
end
return false
end

function qiYuanShuModel:setQiYuanShuOpenlist()
self.data.qiYuanShuData.qyslist={}
local list=cfg_wishtreelibconfig()
for k,v in ipairs(list)do
if qiYuanShuModel:checkQiYuanShuOpen(v.id)then
table.insert(self.data.qiYuanShuData.qyslist,v.id)
end
end
end
function qiYuanShuModel:getQiYuanShuOpenlist()
return self.data.qiYuanShuData.qyslist or{}
end
function qiYuanShuModel:setQiYuanShuId(lib_id)
self.data.qiYuanShuData.lib_id=lib_id
end

function qiYuanShuModel:getQiYuanShuId()
return self.data.qiYuanShuData.lib_id or 0
end

function qiYuanShuModel:resetwishGBId()
self.data.qiYuanShuData.wishGBId=0
end


function qiYuanShuModel:getQiYuanShu_Suit(lib_id)
if lib_id==0 then
local cfg=cfgHelper.get1(cfg_wishtreeconfig_get,1)
return cfg.ShowNme
else
local cfg=cfgHelper.get1(cfg_wishtreelibconfig_get,lib_id)
return cfg.ShowNme
end
end

function qiYuanShuModel:getQiYuanShu_wishGuBaoList(lib_id)
if lib_id==0 then
local cfg=cfgHelper.get1(cfg_wishtreeconfig_get,1)
return cfg.wishGuBaoList
else
local cfg=cfgHelper.get1(cfg_wishtreelibconfig_get,lib_id)
return cfg.wishGuBaoList
end
end

function qiYuanShuModel:getQiYuanShu_bdGuBao(lib_id)
if lib_id==0 then
local cfg=cfgHelper.get1(cfg_wishtreeconfig_get,1)
return cfg.bdGuBao2
else
local cfg=cfgHelper.get1(cfg_wishtreelibconfig_get,lib_id)
return cfg.bdGuBao2
end
end

function qiYuanShuModel:getQiYuanShu_bigRewardShow(lib_id)
if lib_id==0 then
local cfg=cfgHelper.get1(cfg_wishtreeconfig_get,1)
return cfg.bigRewardShow
else
local cfg=cfgHelper.get1(cfg_wishtreelibconfig_get,lib_id)
return cfg.bigRewardShow
end
end

function qiYuanShuModel:getQiYuanShu_rewardShow(lib_id)
if lib_id==0 then
local cfg=cfgHelper.get1(cfg_wishtreeconfig_get,1)
return cfg
else
local cfg=cfgHelper.get1(cfg_wishtreelibconfig_get,lib_id)
return cfg
end
end

function qiYuanShuModel:getQiYuanShu_cost(lib_id)
if lib_id==0 then
local cfg=cfgHelper.get1(cfg_wishtreeconfig_get,1)
return cfg.cost
else
local cfg=cfgHelper.get1(cfg_wishtreelibconfig_get,lib_id)
return cfg.cost
end
end

function qiYuanShuModel:isNewReddot()
local _List=qiYuanShuModel:getQiYuanShuOpenlist()
if _List and next(_List)then
local list=cfg_wishtreelibconfig()or{}
local newlen=#list
local oldlen=userActorSetting.get('UIQiYuanShuWinreddot',0)
return newlen~=oldlen
else
return false
end
end
