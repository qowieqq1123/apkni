







def_class("UIPushGiftBuyThreeWin",UIWindowBase)









function UIPushGiftBuyThreeWin:bindComponents()

self.root=UIObject.get(self,0)
self.tempNode=UIObject.get(self,1)
self.giftNode=UIObject.get(self,2)
self.giftScrollView=UIScrollViewSlow.get(self,3)
self.btnScrollView=UIScrollView.get(self,4)
self.singleNode=UIBaseItem.get(self,5)
self.multiNode=UIObject.get(self,6)
self.otherNode=UIObject.get(self,7)
self.btnContent=UIObject.get(self,8)
self.arrow=UIObject.get(self,9)
self.Content=UIObject.get(self,10)



end


function UIPushGiftBuyThreeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tempNode);self.tempNode=nil;
_UIObject_release(self.giftNode);self.giftNode=nil;
_UIObject_release(self.giftScrollView);self.giftScrollView=nil;
_UIObject_release(self.btnScrollView);self.btnScrollView=nil;
_UIObject_release(self.singleNode);self.singleNode=nil;
_UIObject_release(self.multiNode);self.multiNode=nil;
_UIObject_release(self.otherNode);self.otherNode=nil;
_UIObject_release(self.btnContent);self.btnContent=nil;
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.Content);self.Content=nil;
end


















local _quality=
{
[eQualityColor.eGreen]='image_tuisongpj_1',
[eQualityColor.eBlue]='image_tuisongpj_2',
[eQualityColor.ePurple]='image_tuisongpj_3',
[eQualityColor.eOrange]='image_tuisongpj_4',
[eQualityColor.eRed]='image_tuisongpj_5',
}

function UIPushGiftBuyThreeWin:onLoaded(...)
self:bindComponents()
self.giftScrollView:bindSlowWidget(function(...)
if self and not self.isClose then
self:bindGrid(...)
end
end)
self.btnScrollView:bindScrollWidget(function(...)
if self and not self.isClose then
self:bindBtnGrid(...)
end
end)
self.scrollHeight=self.winlua:GetChildSizeDeltaY(self.giftScrollView:getID())
self.lefttimer={}
self.btntimer={}
self.giftIdxList={}
self.giftIdxLook={}
self.giftItemLook={}
self.optionSelectLookup={}
self.optionDefaultLookup={}
end

function UIPushGiftBuyThreeWin:__delete()
self:unbindComponents()
end

function UIPushGiftBuyThreeWin:onShow(argtable,afterOnloaded)
argtable=argtable or{}
local idlist=pushGiftThreeModel:getGiftIds()
idlist=idlist and table.deepCopy(idlist)or{}
self.idList=self:sortList(idlist)
local lookup={}
for i,v in ipairs(self.idList or{})do
lookup[v]=true
end
local giftId=self.giftId or self.idList[1]

if argtable.giftId then
for i,v in ipairs(argtable.giftId)do
if lookup[v]==true then
giftId=v
break
end
end
end
self:onSelect(giftId)
local itemIdx=self:findGiftIdx(giftId)
self.btnScrollView:jumpToLockX(itemIdx-1)
end

function UIPushGiftBuyThreeWin:onHide()

end



function UIPushGiftBuyThreeWin:sortList(list)
if#list<=1 then return list end
local nlist={}
local tlist={}
for i,v in ipairs(list)do
if not pushGiftThreeConfig.isForver(v)then
tlist[#tlist+1]=v
else
nlist[#nlist+1]=v
end
end

if#tlist>0 then
local sortTag={}
local func=function(id)
return pushGiftThreeModel:getLeftBuyTime(id)or 0
end
local idxLookup,tlen=sortHelper.getSortLookup(tlist,func)
for i,v in ipairs(tlist)do
local idx=idxLookup[func(v)]
sortTag[v]=idx*100000+v
end
table.sort(tlist,function(a,b)
return sortTag[a]<sortTag[b]
end)
end
table.sort(nlist,function(a,b)
return a<b
end)
return table.concatTableX(tlist,nlist)
end

function UIPushGiftBuyThreeWin:onSelect(giftId)
if#self.idList==0 then
self.tempNode:setActive(true)
self.giftNode:setActive(false)
return
end
self.giftNode:setActive(true)
self.tempNode:setActive(false)
if self.giftId==giftId then return end
pushGiftThreeModel:removeNewGift(giftId)
self.giftId=giftId
self.isSetZero=nil
self:stopAllTimer()
self:freshGiftPanel()
self:freshBtnsPanel()
end

function UIPushGiftBuyThreeWin:onTimeCount(giftId)
local doingData=pushGiftThreeModel:getDoingData(self.giftId)
if doingData==nil or giftId==self.giftId then
self.giftId=nil
self:stopAllTimer()
self.isSetBtnZero=nil
self.isSetZero=nil
self:onShow()
else
self:freshBtnsPanel()
end
end

function UIPushGiftBuyThreeWin:onShowArgRecv()

end

function UIPushGiftBuyThreeWin:freshGiftPanel()
local cfg=pushGiftThreeConfig.getConfig(self.giftId)
local len=#cfg.times
local isSingle=len<=1
self.singleNode:setActive(isSingle)
self.multiNode:setActive(not isSingle)
self.arrow:setActive(not isSingle)
for i,v in pairs(self.lefttimer)do
self:stopTimerByID(v)
end
self.lefttimer={}
self.isSingle=isSingle
if isSingle then
self:freshSingleNode()
else
self:freshMultiNode()
end
end

function UIPushGiftBuyThreeWin:initIdxData(len)
self.giftIdxList={}
self.giftIdxLook={}
self.giftItemLook={}
for i=1,len do
self.giftIdxList[i]=i
self.giftIdxLook[i]=i
self.giftItemLook[i]=i
end
end

function UIPushGiftBuyThreeWin:freshSingleNode()
local widget=self.singleNode:getChildWidgetBase()
self:initIdxData(1)
self:freshGiftInfo(widget,self.giftId,1)
end

function UIPushGiftBuyThreeWin:freshMultiNode()
local cfg=pushGiftThreeConfig.getConfig(self.giftId)
local len=#cfg.times
self:initIdxData(len)
if len>1 then
local sortTag={}
for i=1,len do
local leftTimes=pushGiftThreeModel:getIdxLeftBuyTimes(self.giftId,i)
local buyTag=leftTimes<=0 and 1 or 0
sortTag[i]=buyTag*100+i
end
table.sort(self.giftIdxList,function(a,b)
return sortTag[a]<sortTag[b]
end)
for i,v in ipairs(self.giftIdxList)do
self.giftIdxLook[i]=v
self.giftItemLook[v]=i
end
end
self.giftScrollView:clearSlowItems()
self.giftScrollView:freshSlowGrids(len,len,1,not self.isSetZero)
self.isSetZero=true
end

function UIPushGiftBuyThreeWin:freshItemList()
if self.isSingle then
local widget=self.singleNode:getChildWidgetBase()
self:freshGiftItems(widget,self.giftId,1)
else
local cfg=pushGiftThreeConfig.getConfig(self.giftId)
local len=#cfg.times
for i=1,len do
local widget=self.giftScrollView:getSlowItemByIndex(i-1)
self:freshGiftItems(widget,self.giftId,i)
end
end
end

function UIPushGiftBuyThreeWin:bindGrid(index,widget)
self:freshGiftInfo(widget,self.giftId,index)
end

function UIPushGiftBuyThreeWin:freshGiftInfo(widget,id,index)
local idx=self.giftIdxLook[index]
local cfg=pushGiftThreeConfig.getConfig(id)

local rewardsCfg=cfg.reward
if cfg.clientreward then
rewardsCfg=cfg.clientreward
end
local optionRewardsCfg=cfg.rewards
local rewards=rewardsCfg and rewardsCfg[idx]or{}
local optionRewards=optionRewardsCfg and optionRewardsCfg[idx]or{}
local len=#cfg.times

local consume=(cfg.consume or{})[idx]
local rechargeid=(cfg.recharge or{})[idx]
local args=(cfg.args or{})[idx]or{}
args=args[2]or{}
local isForver=pushGiftThreeConfig.isForver(id)

local data=pushGiftThreeModel:getAllData(id)
local maxTimes=pushGiftThreeConfig.getBuyTimesByCfg(id,idx)
local leftTimes=pushGiftThreeModel:getIdxLeftBuyTimes(id,idx)

local title=FMT.fmt('活动限购{0}次({1}/{0})',maxTimes,leftTimes)
local buytxt=''
local hasLeftTimes=leftTimes>0
if consume then
local moneyCfg=consume[1]
local moneyType=moneyCfg[1]
local moneyValue=moneyCfg[2]
local moneyName=moneyModel.getMoneyName(moneyType)
buytxt=FMT.fmt('{0}{1}',moneyValue,moneyName)
else
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeid)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
buytxt=str
end
if not hasLeftTimes then
buytxt='已售罄'
end


local nameArgs=args.name

local modelArgs=args.model
local effectArgs=args.effect
local itemArgs=args.item
local bgArgs=args.bg or''
local bottombgArgs=args.bg1 or''
local effectdesc=args.effectdesc

local dlname=args.dlname or{}
local dltips=args.dltips
if dltips then
widget:SetChildActive(17,true)
widget:SetChildText(18,dltips)
else
widget:SetChildActive(17,false)
end

local bgbundle=FMT.fmt('ui/windows/pushgifttwo/sharedtextures/{0}.ab',
string.lower(bgArgs))
local bottombgbundle=FMT.fmt('ui/windows/pushgifttwo/sharedtextures/{0}.ab',
string.lower(bottombgArgs))
widget:SetChildCSImageSprite(0,bgbundle,bgArgs)
widget:SetChildCSImageSprite(4,bottombgbundle,bottombgArgs)

widget:SetChildText(7,title)
widget:SetChildText(6,buytxt)
widget:SetChildImageExGray(5,not hasLeftTimes)
widget:SetChildButtonClick(5,function()
self:onBtnBuy(id,idx)
end,true)


local zktxt=cfg.zktxt
if zktxt and zktxt[idx]then
widget:SetChildActive(19,true)
widget:SetChildText(20,zktxt[idx])
else
widget:SetChildActive(19,false)
end

local itemIdxTable={10,11,12,13,14}

for i=1,5 do
local itemIdx=itemIdxTable[i]
local widget1=widget:GetChildWidgetBase(itemIdx)
local itemInfo=rewards[i]
local isOption=optionRewards[i]~=nil
if isOption then
itemInfo=nil
local len=#pushGiftThreeConfig:getOptionCfg(id,idx,i)
if len>1 then
local selectIdx=pushGiftThreeModel:getSelectGiftItemIdx(id,idx,i)or nil

if selectIdx and pushGiftThreeModel:isOptionItemUnlock(id,idx,i,selectIdx)then
itemInfo=pushGiftThreeConfig:getOptionItemCfg(id,idx,i,selectIdx)[1]
if self.optionSelectLookup[id]==nil then self.optionSelectLookup[id]={}end
if self.optionSelectLookup[id][idx]==nil then self.optionSelectLookup[id][idx]={}end
self.optionSelectLookup[id][idx][i]=selectIdx
end
else
itemInfo=pushGiftThreeConfig:getOptionItemCfg(id,idx,i,1)[1]
isOption=false
if self.optionDefaultLookup[id]==nil then self.optionDefaultLookup[id]={}end
if self.optionDefaultLookup[id][idx]==nil then self.optionDefaultLookup[id][idx]={}end
self.optionDefaultLookup[id][idx][i]=1
end
end
local has=rewards[i]~=nil or optionRewards and optionRewards[i]~=nil or false
widget1:SetChildActive(-1,has)
if has then
if itemInfo then
local hasName=itemArgs and itemArgs.name and itemArgs.name[i]==1
local itemid=itemInfo[1]
local num=itemInfo[2]
local numStr=mathHelper.formatNumber(num)
local iconname=iconHelper.getIconName(itemid)
local itemCfg=itemsConfig.getConfig(itemid)
widget1:SetChildActive(0,true)
widget1:SetChildIcon(1,iconname,false)
widget1:SetChildText(2,FMT.fmt('x{0}',numStr))
widget1:SetChildActive(3,hasName)
widget1:SetChildText(4,hasName and itemsModel.getName(itemid)or'')
if dlname[i]then
widget1:SetChildActive(3,true)
widget1:SetChildText(4,dlname[i])
end
widget1:SetChildCSImageSprite(0,globalABLookup.pushGiftTwo,_quality[itemCfg.color])
widget1:SetChildButtonClick(0,function()
tipsManager.showTips({itemid=itemid})
end,true)
widget1:SetChildActive(5,itemsConfig.isFabao(itemid))
widget1:SetChildActive(6,false)
widget1:SetChildActive(7,isOption)
if isOption then
widget1:SetChildButtonClick(7,function()
self:showOptionSelect(id,idx,i)
end,true)
end
local itemConfig=itemsConfig.getConfig(itemid)
local suitConfig
if itemConfig.bagType==16 then
suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,itemConfig.type2,itemConfig.color)
end
local isZQ=suitConfig~=nil
widget1:SetChildActive(9,isZQ)
widget1:SetChildActive(10,isZQ)
if isZQ then
local suitIconName=string.format("icon_suit_%d",suitConfig.icon)
widget1:SetChildIcon(10,suitIconName,false)
local star=itemConfig.stage
widget1:SetChildGroundStarNum(9,star)
widget1:SetChildStarNumber(9,star)
end
else
widget1:SetChildActive(0,false)
widget1:SetChildIcon(1,'',false)
widget1:SetChildText(2,'')
widget1:SetChildActive(3,false)
widget1:SetChildText(4,'')
widget1:SetChildActive(5,false)
widget1:SetChildActive(6,true)
widget1:SetChildActive(7,false)
widget1:SetChildButtonClick(7,function()
self:showOptionSelect(id,idx,i)
end,true)
widget1:SetChildButtonClick(8,function()
self:showOptionSelect(id,idx,i)
end,true)
widget1:SetChildActive(9,false)
widget1:SetChildActive(10,false)
end
else
widget1:SetChildActive(0,false)
widget1:SetChildIcon(1,'',false)
widget1:SetChildText(2,'')
widget1:SetChildActive(3,false)
widget1:SetChildText(4,'')
widget1:SetChildActive(5,false)
widget1:SetChildActive(6,false)
widget1:SetChildActive(7,false)
widget1:SetChildActive(9,false)
widget1:SetChildActive(10,false)
end
end

if nameArgs then
local lowname=string.lower(nameArgs[1])
local bundle=FMT.fmt('ui/windows/pushgifttwo/sharedtextures/{0}.ab',lowname)
widget:SetChildActive(3,true)
widget:SetChildCSImageSprite(3,bundle,nameArgs[1])
widget:SetChildLocalPos(3,nameArgs[2],nameArgs[3],0)
else
widget:SetChildActive(3,false)
end

widget:SetChildUIModelRemoveTarget(2)
if modelArgs then
local modelId=modelArgs[1]
local scale=modelArgs[2]or 1
local offsetX=modelArgs[3]or 0
local offsetY=modelArgs[4]or 0
local ani=modelArgs[5]or 0
widget:SetChildUIModelShowTarget(2,modelId,scale,{},ani)
if offsetX~=0 or offsetY~=0 then
widget:SetChildUIModelShowTargetOffset(2,offsetX,offsetY)
end
end

if effectArgs then
local effectId=effectArgs[1]
local scale=effectArgs[2]or 1
local xPos=effectArgs[3]or 0
local yPos=effectArgs[4]or 0
widget:SetChildShowEffect(1,effectId,true)
widget:SetChildLocalPos(1,xPos,yPos,0)
widget:SetChildScale(1,Vector3.New(scale,scale,scale))
else
widget:SetChildShowEffect(1,0,false)
end
widget:SetChildActive(15,effectdesc~=nil)
if effectdesc then
local xPos=effectdesc[1]
local yPos=effectdesc[2]
widget:SetChildLocalPos(15,xPos,yPos,0)
widget:SetChildText(16,effectdesc[3])
end

if self.lefttimer[idx]then
self:stopTimerByID(self.lefttimer[idx])
self.lefttimer[idx]=nil
end
if not isForver and hasLeftTimes then
widget:SetChildActive(8,true)
local starttime=data.starttime
local fixTime=pushGiftThreeConfig.getOpenTime(id)
local curStamp=timeHelper.getServerShortTime()
local endStamp=starttime+fixTime
local tick=function()
local curStamp=timeHelper.getServerShortTime()
local left=endStamp-curStamp
if left>=0 then
widget:SetChildText(9,FMT.fmt('剩余时间:{0}',timeHelper.format_time_stamp3(left)))
else
widget:SetChildActive(8,false)
widget:SetChildText(9,'')
if self.lefttimer[idx]then
self:stopTimerByID(self.lefttimer[idx])
self.lefttimer[idx]=nil
end
end
end

self.lefttimer[idx]=self:setTimer(1,0,tick)
tick()
else
widget:SetChildActive(8,false)
widget:SetChildText(9,'')
end
end


function UIPushGiftBuyThreeWin:freshGiftItems(widget,id,index)
local idx=self.giftIdxLook[index]
local cfg=pushGiftThreeConfig.getConfig(id)
local rewardsCfg=cfg.reward
if cfg.clientreward then
rewardsCfg=cfg.clientreward
end
local optionRewardsCfg=cfg.rewards
local rewards=rewardsCfg and rewardsCfg[idx]or{}
local optionRewards=optionRewardsCfg and optionRewardsCfg[idx]or{}

local args=(cfg.args or{})[idx]or{}
args=args[2]or{}
local itemArgs=args.item

local itemIdxTable={10,11,12,13,14}

for i=1,5 do
local itemIdx=itemIdxTable[i]
local widget1=widget:GetChildWidgetBase(itemIdx)
local itemInfo=rewards[i]
local isOption=optionRewards[i]~=nil
if isOption then
itemInfo=nil
local len=#pushGiftThreeConfig:getOptionCfg(id,idx,i)
if len>1 then
local selectIdx=pushGiftThreeModel:getSelectGiftItemIdx(id,idx,i)or nil

if selectIdx and pushGiftThreeModel:isOptionItemUnlock(id,idx,i,selectIdx)then
itemInfo=pushGiftThreeConfig:getOptionItemCfg(id,idx,i,selectIdx)[1]
if self.optionSelectLookup[id]==nil then self.optionSelectLookup[id]={}end
if self.optionSelectLookup[id][idx]==nil then self.optionSelectLookup[id][idx]={}end
self.optionSelectLookup[id][idx][i]=selectIdx
end
else
itemInfo=pushGiftThreeConfig:getOptionItemCfg(id,idx,i,1)[1]
isOption=false
if self.optionDefaultLookup[id]==nil then self.optionDefaultLookup[id]={}end
if self.optionDefaultLookup[id][idx]==nil then self.optionDefaultLookup[id][idx]={}end
self.optionDefaultLookup[id][idx][i]=1
end
end
local has=rewards[i]~=nil or optionRewards and optionRewards[i]~=nil or false
widget1:SetChildActive(-1,has)
if has then
if itemInfo then
local hasName=itemArgs and itemArgs.name and itemArgs.name[i]==1
local itemid=itemInfo[1]
local num=itemInfo[2]
local numStr=mathHelper.formatNumber(num)
local iconname=iconHelper.getIconName(itemid)
local itemCfg=itemsConfig.getConfig(itemid)
widget1:SetChildActive(0,true)
widget1:SetChildIcon(1,iconname,false)
widget1:SetChildText(2,FMT.fmt('x{0}',numStr))
widget1:SetChildActive(3,hasName)
widget1:SetChildText(4,hasName and itemsModel.getName(itemid)or'')
widget1:SetChildCSImageSprite(0,globalABLookup.pushGiftTwo,_quality[itemCfg.color])
widget1:SetChildButtonClick(0,function()
tipsManager.showTips({itemid=itemid})
end,true)
widget1:SetChildActive(5,itemsConfig.isFabao(itemid))
widget1:SetChildActive(6,false)
widget1:SetChildActive(7,isOption)
if isOption then
widget1:SetChildButtonClick(7,function()
self:showOptionSelect(id,idx,i)
end,true)
end
local itemConfig=itemsConfig.getConfig(itemid)
local suitConfig
if itemConfig.bagType==16 then
suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,itemConfig.type2,itemConfig.color)
end
local isZQ=suitConfig~=nil
widget1:SetChildActive(9,isZQ)
widget1:SetChildActive(10,isZQ)
if isZQ then
local suitIconName=string.format("icon_suit_%d",suitConfig.icon)
widget1:SetChildIcon(10,suitIconName,false)
local star=itemConfig.stage
widget1:SetChildGroundStarNum(9,star)
widget1:SetChildStarNumber(9,star)
end
else
widget1:SetChildActive(0,false)
widget1:SetChildIcon(1,'',false)
widget1:SetChildText(2,'')
widget1:SetChildActive(3,false)
widget1:SetChildText(4,'')
widget1:SetChildActive(5,false)
widget1:SetChildActive(6,true)
widget1:SetChildActive(7,false)
widget1:SetChildButtonClick(7,function()
self:showOptionSelect(id,idx,i)
end,true)
widget1:SetChildButtonClick(8,function()
self:showOptionSelect(id,idx,i)
end,true)
widget1:SetChildActive(9,false)
widget1:SetChildActive(10,false)
end
else
widget1:SetChildActive(0,false)
widget1:SetChildIcon(1,'',false)
widget1:SetChildText(2,'')
widget1:SetChildActive(3,false)
widget1:SetChildText(4,'')
widget1:SetChildActive(5,false)
widget1:SetChildActive(6,false)
widget1:SetChildActive(7,false)
widget1:SetChildActive(9,false)
widget1:SetChildActive(10,false)
end
end
end

function UIPushGiftBuyThreeWin:freshGiftBuyInfo(id,idx)
local itemIdx=self.giftItemLook[idx]
local widget=self.giftScrollView:getSlowItemByIndex(itemIdx-1)
if widget==nil then return end
local cfg=pushGiftThreeConfig.getConfig(id)
local consume=(cfg.consume or{})[idx]
local rechargeid=(cfg.recharge or{})[idx]
local len=#cfg.times
local args=(cfg.args or{})[idx]or{}
args=args[2]or{}
local maxTimes=pushGiftThreeConfig.getBuyTimesByCfg(id,idx)
local leftTimes=pushGiftThreeModel:getIdxLeftBuyTimes(id,idx)

local title=FMT.fmt('活动限购{0}次({1}/{0})',maxTimes,leftTimes)

local buytxt=''
local hasLeftTimes=leftTimes>0
if consume then
local moneyCfg=consume[1]
local moneyType=moneyCfg[1]
local moneyValue=moneyCfg[2]
local moneyName=moneyModel.getMoneyName(moneyType)
buytxt=FMT.fmt('{0}{1}',moneyValue,moneyName)
else
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeid)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
buytxt=str
end
if not hasLeftTimes then
buytxt='已售罄'
widget:SetChildText(6,buytxt)
if self.lefttimer[idx]then
self:stopTimerByID(self.lefttimer[idx])
end
self.lefttimer[idx]=nil
widget:SetChildText(9,'')

end

widget:SetChildText(7,title)
widget:SetChildImageExGray(5,not hasLeftTimes)
end

function UIPushGiftBuyThreeWin:bindBtnGrid(index,widget)
local id=self.idList[index]
local cfg=pushGiftThreeConfig.getConfig(id)
local isSelect=id==self.giftId
local isNew=pushGiftThreeModel:isNewGift(id)
local isForver=pushGiftThreeConfig.isForver(id)
widget:SetChildButtonClick(0,function()
self:onSelect(id)
end)
widget:SetChildActive(1,not isSelect)
widget:SetChildActive(2,isSelect)
widget:SetChildText(3,cfg.name)
widget:SetChildLocalPosY(3,isForver and 0 or 13)
widget:SetChildActive(4,isNew)
widget:SetChildActive(5,not isForver and not isSelect)
widget:SetChildActive(6,not isForver and isSelect)

if self.btntimer[id]then
self:stopTimerByID(self.btntimer[id])
self.btntimer[id]=nil
end
local data=pushGiftThreeModel:getAllData(id)
if not isForver then
local starttime=data.starttime
local fixTime=pushGiftThreeConfig.getOpenTime(id)
local curStamp=timeHelper.getServerShortTime()
local endStamp=starttime+fixTime
local left=endStamp-curStamp

if left>0 then
local tick=function()
local curStamp=timeHelper.getServerShortTime()
local left1=endStamp-curStamp
if left1>=0 then
widget:SetChildText(7,timeHelper.format_time_stamp3(left1))
else
widget:SetChildText(7,'')
end
end
self.btntimer[id]=self:setTimer(1,0,tick)
tick()
else
widget:SetChildText(7,'')
end
else
widget:SetChildText(7,'')
end
end

function UIPushGiftBuyThreeWin:freshBtnsPanel()
for i,v in pairs(self.btntimer)do
self:stopTimerByID(v)
end
self.btntimer={}
if not self.isSetBtnZero then
self.isSetBtnZero=true
local len=#self.idList
self.btnScrollView:clearItems()
self.btnScrollView:freshGridsNum(len,len,1,not self.isSetBtnZero)
else
self:onfreshBtnsPanel()
end
end

function UIPushGiftBuyThreeWin:onfreshBtnsPanel()
local len=#self.idList
for i=1,len do
self:onfreshBtnInfo(i)
end
end


function UIPushGiftBuyThreeWin:onfreshBtnInfo(idx)
local widget=self.btnScrollView:getGridObjectByindex(idx-1)
if widget==nil then return end
self:bindBtnGrid(idx,widget)
end

function UIPushGiftBuyThreeWin:onBuySuccess(id,idx)
if id~=self.giftId then return end
if self.isSingle then
self:freshSingleNode()
else
local leftTimes=pushGiftThreeModel:getIdxLeftBuyTimes(id,idx)
if leftTimes==0 then
self:freshGiftPanel()
else
self:freshGiftBuyInfo(id,idx)
end
end
end

function UIPushGiftBuyThreeWin:showNextGift()
local idList=self.idList
local len=#idList
if len<=0 then
return false
end
local idx=nil
local nextid=nil
for i,id in ipairs(idList)do
if pushGiftModel:getLeftBuyTimes(id)then
nextid=id
idx=pushGiftModel:getNextHasLeftBuyTimesGift(id)
break
end
end
if nextid==nil then return false end
self:onSelect(nextid)
return true
end

function UIPushGiftBuyThreeWin:onBtnBuy(id,idx)
local leftTimes=pushGiftThreeModel:getIdxLeftBuyTimes(id,idx)
if leftTimes<=0 then
UIManager.error('购买次数不足')
return
end
local lookup=self.optionSelectLookup[id]and self.optionSelectLookup[id][idx]or nil
local defaultlookup=self.optionDefaultLookup[id]and self.optionDefaultLookup[id][idx]or nil
if not pushGiftThreeModel:isFillAllOption(id,idx,lookup,defaultlookup)then
UIManager.error('请选择自选道具！')
return
end
local cfg=pushGiftThreeConfig.getConfig(id)
if cfg.consume and cfg.consume[idx]then
local consume=cfg.consume[idx]
local moneyType=consume[1][1]
local moneyCount=consume[1][2]
local func=function()
if not moneyModel.checkEnoughMoney(moneyType,moneyCount)then
local moneyName=moneyModel.getMoneyName(moneyType)
UIManager.error(FMT.fmt('{0}不足',moneyName))
gainControl:showGainWin(moneyType)
return
end
pushGiftThreeController.buyGift(id,idx,lookup,defaultlookup)

end

local isEnough=moneyModel.checkEnoughMoney(moneyType,moneyCount)
if not isEnough and moneyType==eMoneyType.mtLingYu then

local hasLingYuCount=moneyModel.getMoney(moneyType)
local needXianYuCount=moneyCount-hasLingYuCount
isEnough=moneyModel.checkEnoughMoney(eMoneyType.mtXianYu,needXianYuCount)
end
if not isEnough then
local MoneyName=moneyModel.getMoneyName(moneyType)
UIManager.error(FMT.fmt("{0}不足",MoneyName))
gainControl:showGainWin(moneyType)
return
end


local content="是否花费 {0}<color=#549327>{1}</color> 购买？"
local itemIconName=iconHelper.getIconName(moneyType)
local iconStr=chatEmotHelper.getIconEmotMesg(itemIconName,36)
content=FMT.fmt(content,iconStr,moneyCount)
local showdata=
{
type='UIDialougeWithIcon',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
okcallback=function(...)
moneySystem:useMoney(moneyType,moneyCount,func,WARNING_TYPE.eWarning)
end,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()

else
local optionStr=''
if lookup or defaultlookup then
local t={}
if lookup then
for hoidIdx,_idx in pairs(lookup)do
t[#t+1]={hoidIdx,_idx}
end
end

if defaultlookup then
for hoidIdx,_idx in pairs(defaultlookup)do
t[#t+1]={hoidIdx,_idx}
end
end

table.sort(t,function(a,b)
return a[1]<b[1]
end)

for i,v in ipairs(t)do
optionStr=FMT.fmt('{0}-{1}',optionStr,v[2])
end
end
local rechargeid=cfg.recharge[idx]
local rechargecfg=cfgHelper.get1(cfg_rechargeconfig_get,rechargeid)
local str=pfwindowslController:showDesc_ByMoneyType(rechargecfg)
local numStr=str:match("^%d+")

local rechargeAmount=payControl:getRechargeAmount(rechargeid)
local twoTimeCostNum=rechargeAmount*2
local titemid,voucherCount=payControl.getVoucherId(twoTimeCostNum)
local buyFunc=function(count,isItem)
if isItem then
local param=FMT.fmt('{0}-{1}{2}',id,idx,optionStr)
local pram=jsonHelper.encode({rechargeid,param})
bagProtocolControl.req_1_21(titemid,count*rechargeAmount,pram)
else
payControl.reqPay(rechargeid,count)
end
end
local buyFuncNoVoucher=function()
local param=FMT.fmt('{0}-{1}',id,idx)
payControl.reqPayNoVoucher(rechargeid,1,param)
end
local leftTimes=pushGiftThreeModel:getIdxLeftBuyTimes(id,idx)
local buyTimes=pushGiftThreeModel:getAlreadyBuyTimes(id,idx)
local totalTimes=pushGiftThreeConfig.getBuyTimesByCfg(id,idx)
if leftTimes>1 and voucherCount>=twoTimeCostNum then
local totalRewards={}
local cfg=pushGiftThreeConfig.getConfig(id)
local rewardsCfg=cfg.reward
if cfg.clientreward then
rewardsCfg=cfg.clientreward
end
local optionRewardsCfg=cfg.rewards
local rewards=rewardsCfg and rewardsCfg[idx]or{}
local optionRewards=optionRewardsCfg and optionRewardsCfg[idx]or{}
for i=1,#rewards do
local itemInfo=rewards[i]
local isOption=optionRewards[i]~=nil
if isOption then
itemInfo=nil
local len=#pushGiftThreeConfig:getOptionCfg(id,idx,i)
if len>1 then
local selectIdx=pushGiftThreeModel:getSelectGiftItemIdx(id,idx,i)or nil

if selectIdx and pushGiftThreeModel:isOptionItemUnlock(id,idx,i,selectIdx)then
itemInfo=pushGiftThreeConfig:getOptionItemCfg(id,idx,i,selectIdx)[1]
if self.optionSelectLookup[id]==nil then self.optionSelectLookup[id]={}end
if self.optionSelectLookup[id][idx]==nil then self.optionSelectLookup[id][idx]={}end
self.optionSelectLookup[id][idx][i]=selectIdx
end
else
itemInfo=pushGiftThreeConfig:getOptionItemCfg(id,idx,i,1)[1]
isOption=false
if self.optionDefaultLookup[id]==nil then self.optionDefaultLookup[id]={}end
if self.optionDefaultLookup[id][idx]==nil then self.optionDefaultLookup[id][idx]={}end
self.optionDefaultLookup[id][idx][i]=1
end
end
table.insert(totalRewards,{itemInfo[1],itemInfo[2]})
end
local args={
rewards=totalRewards,
name=cfg.name,
price={titemid,rechargeAmount},
leftNum=buyTimes,
maxcount=totalTimes,
isCheckMaxSelectCount=true,
callback=function(num)
buyFunc(num,true)
end,
ReqPaycallback=buyFuncNoVoucher
}
UIManager:showWindow("UICommonBuyDialogWin",args)
else
local rechargeId=cfg.recharge[idx]
local param=FMT.fmt('{0}-{1}{2}',id,idx,optionStr)
payControl.reqPay(rechargeId,1,param)
end
end
end

function UIPushGiftBuyThreeWin.onItemClick(itemid,index,itemguid,attach)
if itemid==nil or itemid==-1 then return end
tipsManager.showTips({itemid=itemid,itemguid=itemguid,attach=attach,showModel=true})
end

function UIPushGiftBuyThreeWin:findGiftIdx()
local giftId=self.giftId
local giftList=self.idList
if giftId==nil then return end
for i,v in ipairs(giftList)do
if giftId==v then return i end
end
end

function UIPushGiftBuyThreeWin:onScrollChange()
local height=self.winlua:GetChildSizeDeltaY(self.Content:getID())
local div=height-self.scrollHeight
if div>0 then
local localPosY=self.winlua:GetChildLocalPosition(self.Content:getID()).y
local left=div-localPosY
local show=left>0 and(div-localPosY)>10 or false
self.arrow:setActive(show)
else
self.arrow:setActive(false)
end
end

function UIPushGiftBuyThreeWin:onSelectOption(selectLookup,args)
local giftId=args.giftId
local lvIdx=args.lvIdx
if self.giftId~=giftId then return end
local oldLookup=self.optionSelectLookup[giftId]and self.optionSelectLookup[giftId][lvIdx]or{}
local changed=false
for hoidIdx,idx in pairs(selectLookup)do
if oldLookup[hoidIdx]~=idx then
changed=true
break
end
end
if changed then
if self.optionSelectLookup[giftId]==nil then self.optionSelectLookup[giftId]={}end
self.optionSelectLookup[giftId][lvIdx]=selectLookup
for hoidIdx,index in pairs(selectLookup)do
pushGiftThreeModel:setSelectGiftItemIdx(giftId,lvIdx,hoidIdx,index,false)
end
pushGiftThreeModel:flushSelectGiftItem()
self:freshItemList()
end
end

function UIPushGiftBuyThreeWin:showOptionSelect(giftId,lvIdx,shoidIdx)
local rewards=pushGiftThreeConfig:getOptionRewards(giftId,lvIdx)
if rewards==nil then return end
local itemList={}
local selectLookup={}
local holeList={}
for hoidIdx,v in pairs(rewards)do
local selectIdx=pushGiftThreeModel:getSelectGiftItemIdx(giftId,lvIdx,hoidIdx)
local len=#pushGiftThreeConfig:getOptionCfg(giftId,lvIdx,hoidIdx)
if len>1 then
holeList[#holeList+1]=hoidIdx
if itemList[hoidIdx]==nil then itemList[hoidIdx]={}end
local itemholeList=itemList[hoidIdx]
for i,vv in ipairs(v)do
if pushGiftThreeModel:isOptionItemUnlock(giftId,lvIdx,hoidIdx,i)then
itemholeList[#itemholeList+1]={i,vv[1]}
if selectIdx==i then
selectLookup[hoidIdx]=selectIdx
end
end
end
end
end
if self.optionSelectLookup[giftId]==nil then self.optionSelectLookup[giftId]={}end
self.optionSelectLookup[giftId][lvIdx]=selectLookup
table.sort(holeList,function(a,b)
return a<b
end)
local args={
selectLookup=table.deepCopy(selectLookup),
itemList=itemList,
holeList=holeList,
selectHoleIdx=shoidIdx,
selectCallback=function(...)
if self and not self.isClose then
self:onSelectOption(...)
end
end,
attach={giftId=giftId,lvIdx=lvIdx},
}
self:showWindow('UIPushGiftSelectWin',args)
end