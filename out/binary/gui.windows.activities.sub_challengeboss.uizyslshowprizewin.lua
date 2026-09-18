







def_class("UIZYSLShowPrizeWin",UIWindowBase)









function UIZYSLShowPrizeWin:bindComponents()

self.BoxCountText=UIText.get(self,0)
self.BoxFreeCountText=UIText.get(self,1)
self.boxGridPanel=UIObject.get(self,2)
self.BoxScrollView=UIObject.get(self,3)
self.DonClose=UIButton.get(self,4)
self.effect=UIObject.get(self,5)
self.goodGridPanel=UIObject.get(self,6)
self.goodScrollView=UIObject.get(self,7)
self.openEffect=UIObject.get(self,8)
self.progressbar=UIProgress.get(self,9)
self.progressText=UIText.get(self,10)
self.progressValue=UIObject.get(self,11)
self.tips=UILinkImageText.get(self,12)
self.tipsText=UIText.get(self,13)
self.Item=UIObject.get(self,14)

self.DonClose:setButtonClick(function()self:onDonClose()end)



end


function UIZYSLShowPrizeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.BoxCountText);self.BoxCountText=nil;
_UIObject_release(self.BoxFreeCountText);self.BoxFreeCountText=nil;
_UIObject_release(self.boxGridPanel);self.boxGridPanel=nil;
_UIObject_release(self.BoxScrollView);self.BoxScrollView=nil;
_UIObject_release(self.DonClose);self.DonClose=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.goodGridPanel);self.goodGridPanel=nil;
_UIObject_release(self.goodScrollView);self.goodScrollView=nil;
_UIObject_release(self.openEffect);self.openEffect=nil;
_UIObject_release(self.progressbar);self.progressbar=nil;
_UIObject_release(self.progressText);self.progressText=nil;
_UIObject_release(self.progressValue);self.progressValue=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.Item);self.Item=nil;
end
















local _this=nil
local cellSizeX_=84
local cellSizeY_=110
local spaceX_=47
local spaceY_=0
local leftPadding_=30
local topPadding_=10
local colNum_=5




function UIZYSLShowPrizeWin:onLoaded(...)
_this=self
self:bindComponents()
self.scrollViewWidth=self.goodScrollView:getChildSizeDeltaX()
self.scrollViewHeight=self.goodScrollView:getChildSizeDeltaY()
self.scrollViewPos=self.goodScrollView:getChildAnchoredPosition()
end


function UIZYSLShowPrizeWin:__delete()
_this=nil



self:unbindComponents()
end




function UIZYSLShowPrizeWin:onShow(argtable,afterOnloaded)
self.curStep=1
self:stopAllTimer()
local tipsStr=argtable.tips or''
local closeTips=argtable.closeTips or'点击空白区域关闭'
local list=argtable.list or{}
self.damage=tonumber(tostring(argtable.damage))
self.boxCnt=argtable.boxCnt or 0
self.bossIdx=argtable.bossIdx
self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.battleID=argtable.battleId
self.activityData=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.bossLv=activitiesHandle_zhenyaoshilian:getMonsterLv(self.subType,self.subId,self.activityData.server_lvl,self.bossIdx)

local tNum=#list
if tNum>0 then
if list[1].sortWeight then
table.sort(list,function(a,b)
return a.sortWeight>b.sortWeight
end)
else
for i,v in pairs(list)do
local itemid=v.param_1
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local rareLv=itemsConfig.getRareLv(itemid)
local sortWeight=rareLv*10000
sortWeight=sortWeight+color*1000
if itemsConfig.isEquip(itemid)then
sortWeight=sortWeight+100
end
v.sortWeight=sortWeight
end
table.sort(list,function(a,b)
return a.sortWeight>b.sortWeight
end)
end
end
self.rewardlist=list

self.tips:setText(tipsStr)
self.tipsText:setText(closeTips)
self.effect:setChildShowEffect(10014,true)

self.isFull=false
self.noteslist={}
self.rewardnum=tNum
self.boxCnt=self.boxCnt or tNum
self.playingAnim=true

if tNum>0 then
self:initRewardView()
self:delayDo(1,function()
self:playShow()
end)
else
self:delayDo(1,function()
self:onFinish()
end)
logErr('没有奖励却打开了奖励展示界面?')
end

self:refreshScore()
end


function UIZYSLShowPrizeWin:onHide()

end




function UIZYSLShowPrizeWin:initBoxView(num)
self.boxGridPanel:setChildLayoutGroupCreateItems(num)
local grids=self.boxGridPanel:getChildLayoutGroupGridList()
for i=1,grids.Count do
local widget=grids[i-1]
self:refreshItemPos(widget,i)
self:refreswhScrollView(self.boxGridPanel,self.BoxScrollView)
local tweener=widget:SetChildDOPunchRotation(0,Vector3(0,0,15),1,20,1,nil)
tweener:SetEase(_Ease.Linear)
end

self.timer=self:delayDo(1,function()
self.openEffect:setChildShowEffect(10704,true)
self.BoxScrollView:setChildCanvasGroupDOFade(0,1)
self.goodScrollView:setChildCanvasGroupDOFade(1,1,function()
self.boxGridPanel:setChildLayoutGroupClearAllItems()
self.BoxScrollView:setActive(false)
self.timer=nil
end)
end)
end

function UIZYSLShowPrizeWin:initRewardView()
local num=self.rewardnum
self.goodGridPanel:setChildLayoutGroupCreateItems(num)
local grids=self.goodGridPanel:getChildLayoutGroupGridList()
for i=1,num do
local widget=grids[i-1]
local reward=self.rewardlist[i]
self:refreshItemPos(widget,i)
self:refreshItem(reward,widget)
widget:SetChildCanvasGroupAlpha(-1,0)
end
self:refreswhScrollView(self.goodGridPanel,self.goodScrollView)
end

function UIZYSLShowPrizeWin:refreshAllPos()
local num=#self.rewardlist
local grids=self.goodGridPanel:getChildLayoutGroupGridList()
for i=1,num do
local widget=grids[i-1]
self:refreshItemPos(widget,i)
end
self:refreswhScrollView()
end

function UIZYSLShowPrizeWin:refreswhScrollView(gridPanel,scrollView)
local gridPanel=gridPanel
local scrollView=scrollView

local rowNum=math.ceil(self.rewardnum/colNum_)
local h=topPadding_+rowNum*cellSizeY_+(rowNum-1)*spaceY_
gridPanel:setChildSizeDelta(self.scrollViewWidth,h)
local flag=true
if rowNum<=1 then
flag=false
scrollView:setChildAnchoredPos(self.scrollViewPos.x,0)
scrollView:setChildSizeDelta(self.scrollViewWidth,200)
else
scrollView:setChildAnchoredPos(self.scrollViewPos.x,0)
scrollView:setChildSizeDelta(self.scrollViewWidth,200)
end
scrollView:setChildScrollRectEnable(flag)
end

function UIZYSLShowPrizeWin:refreshItemPos(item,idx)
local cNum=idx%colNum_
if cNum==0 then cNum=colNum_ end
local x=leftPadding_+cellSizeX_/2+(cNum-1)*(cellSizeX_+spaceX_)
local rowNum=math.ceil(self.rewardnum/colNum_)
if rowNum<=1 then
local cNum_=self.rewardnum%colNum_
if cNum_>0 then
local w1=cNum_*cellSizeX_+(cNum_-1)*spaceX_
local w2=colNum_*cellSizeX_+(colNum_-1)*spaceX_
local lerp=(w2-w1)/2
x=x+lerp
end
end
local rNum=math.ceil(idx/colNum_)
local y=-(topPadding_+cellSizeY_/2+(rNum-1)*(cellSizeY_+spaceY_))
item:SetChildAnchoredPos(-1,x,y)
end

function UIZYSLShowPrizeWin:refreshItem(item,widget)
local itemid=item.param_1
local num=item.param_2 or 1
local limit=item.conf or{}
local temp_item={itemid=itemid}

limit.itemcount=num<=1 and''or mathHelper.formatNumber(num)
if itemsConfig.isEquip(itemid)then limit.itemcount=nil end
local itemid=temp_item.itemid
if limit.nomalname==nil then
limit.nomalname=true
end
limit.showCountBG=num>1
local porp=itemsComponentHelper.getCommonFillData(temp_item,limit)
local stage=porp[PropIndex(DataPropKey.eWidgetText,6)]
porp[PropIndex(DataPropKey.eWidgetActive,9)]=stage~=nil and stage~=''
porp[PropIndex(DataPropKey.eWidgetIcon,10)]=equipsHelper.getSuitIcon(temp_item)
widget:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
widget:SetChildPropData(0,porp)
end

function UIZYSLShowPrizeWin:refreshScore()
local index
local data
local allCount
local score=0
local free
local chp
local mhp

if self.damage>=0 then
local cfg=cfgHelper.get(cfg_zhenyaoshilianconfig_get,self.subId)
free=cfg.free_rw_cnt
local damage_reward_conf=cfg.damage_reward_conf
local monId=cfg.monster_groub_id[self.bossIdx]
local monCfg=cfgHelper.get(cfg_monstergroup_get,monId)
local monList=monCfg.monList
local monsterId=monList[1]
local monsterCfg=cfgHelper.get(cfg_monsterconfig_get,monsterId)
local lv=self.bossLv
local demageBarData=monsterCfg.demageBar[lv]
for i,v in ipairs(demageBarData)do
if self.damage>=v[1]and self.damage<=v[2]then
index=i
data=v
break
end
end

if not index then
index=#demageBarData
data=demageBarData[index]
end

for j,k in ipairs(damage_reward_conf)do
if lv>=k[1]and lv<=k[2]then

local reward_conf=k[3][self.bossIdx]

for i,v in ipairs(reward_conf)do
if self.damage>=v[1]then
score=v[2]+free
if i==#reward_conf then
self.isFull=true
end

end
end
end
end
chp=self.damage-data[1]
mhp=data[2]-data[1]
allCount=data[2]
else
chp=99999
mhp=99999
allCount=99999
self.damage=99999
score=self.boxCnt
end

if score==0 then
score=self.rewardnum
if self.battleID==nil then
self.DonClose:setActive(true)
end
end

local str=string.format("X %s",score)
local progressText=FMT.fmt('{0}/{1}',self.damage,allCount)

if self.isFull then
mhp=100
chp=100
progressText=FMT.fmt('{0}',self.damage)
end

self.BoxCountText:setText(str)
self.progressbar:setProgressValue(chp,mhp)
self.progressText:setText(progressText)

self:initBoxView(score)
end




function UIZYSLShowPrizeWin:playShow()
local delay=0
local d=0.1
local num=self.rewardnum
local grids=self.goodGridPanel:getChildLayoutGroupGridList()
for i=1,num do
local item=grids[i-1]
local func=function()
item:SetChildCanvasGroupDOFade(-1,1,0.2)
end
if delay>0 then
self:delayDo(delay,func)
else
func()
end
delay=delay+d
end
local func2=function()
self:playEffect()
end
self:delayDo(delay,func2)
end

function UIZYSLShowPrizeWin:playEffect()
local index=self.curStep
local item=self.goodGridPanel:getChildLayoutGroupGridItem(index-1)
local reward=self.rewardlist[index]
local itemid=reward.param_1
local itemnum=reward.param_2

local num=itemsLookup:checkAutoExchange(itemid,itemnum)
if num~=nil then
bagProtocolControl.req_use_item(itemid,num)
else
self:playEffectEnd()
end
end

function UIZYSLShowPrizeWin:replay(itemid_,num)
local index=self.curStep
if index<=self.rewardnum then
local reward=self.rewardlist[index]
local itemid=reward.itemid
local itemnum=reward.num
if itemid==itemid_ then

local itemid__,itemnum__
local isAdd=false
local new_itemid,new_itemnum
local new_str
if itemsLookup:canAutoExchange(itemid)then
local itemcfg=itemsConfig.getConfig(itemid)
local funcparam=itemcfg.funcparam
if num>=itemnum then
itemid__=funcparam.money_id
itemnum__=funcparam.money_num*itemnum
new_str=itemsLookup:getAutoExchangeDesc(itemid,itemnum,itemid__,itemnum__)
else
isAdd=true
itemid__=itemid
itemnum__=itemnum-num
new_itemid=funcparam.money_id
new_itemnum=funcparam.money_num*num
new_str=itemsLookup:getAutoExchangeDesc(itemid,num,new_itemid,new_itemnum)
end
end

reward.itemid=itemid__
reward.num=itemnum__
reward.itemguid=nil
local widget=self.goodGridPanel:getChildLayoutGroupGridItem(index-1)

AudioManager.playAudio(509)
widget:SetChildShowEffect(1,10078,true)
local func2=function()
self:refreshItem(reward,widget)
if isAdd then

local new_reward={itemid=new_itemid,num=new_itemnum}
table.insert(self.rewardlist,new_reward)
self.goodGridPanel:setChildLayoutGroupAddItem()
local new_item=self.goodGridPanel:getChildLayoutGroupGridItem(#self.rewardlist-1)
self:refreshItem(new_reward,new_item)
self:refreshAllPos()
end
if new_str~=nil then
self:addNote(new_str)
end
end
self:delayDo(0.5,func2)
local func=function()
self:playEffectEnd()
end
self:delayDo(0.5,func)
end
end
end

function UIZYSLShowPrizeWin:playEffectEnd()
self.curStep=self.curStep+1
if self.curStep<=self.rewardnum then
self:playEffect()
else
self:onFinish()
end
end

function UIZYSLShowPrizeWin:onFinish()
self.playingAnim=false

end

function UIZYSLShowPrizeWin:onClickItem(itemId,index,itemguid,attach)
itemsComponentHelper.onItemClick(itemId,index,itemguid,attach)
end

function UIZYSLShowPrizeWin:onDonClose()

self:closeSelf()
end