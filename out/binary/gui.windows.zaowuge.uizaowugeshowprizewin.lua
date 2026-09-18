







def_class("UIZaoWuGeShowPrizeWin",UIWindowBase)









function UIZaoWuGeShowPrizeWin:bindComponents()

self.effect=UIObject.get(self,0)
self.goodGridPanel=UIObject.get(self,1)
self.goodScrollView=UIObject.get(self,2)
self.noteGridPanel=UIObject.get(self,3)
self.noteScrollView=UIObject.get(self,4)
self.tips=UILinkImageText.get(self,5)
self.tipsText=UIText.get(self,6)



end


function UIZaoWuGeShowPrizeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.goodGridPanel);self.goodGridPanel=nil;
_UIObject_release(self.goodScrollView);self.goodScrollView=nil;
_UIObject_release(self.noteGridPanel);self.noteGridPanel=nil;
_UIObject_release(self.noteScrollView);self.noteScrollView=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
end
















local _this=nil
local cellSizeX_=84
local cellSizeY_=110
local spaceX_=47
local spaceY_=5
local leftPadding_=30
local topPadding_=10
local colNum_=5

function UIZaoWuGeShowPrizeWin:onLoaded(...)
_this=self
self:bindComponents()
notifySystem:listenNotify(notifyConfig.onItemUse,self.onItemUse)

UIManager.setMoneyMsgShowState(false,true)
self.scrollViewWidth=self.goodScrollView:getChildSizeDeltaX()
self.scrollViewHeight=self.goodScrollView:getChildSizeDeltaY()
self.scrollViewPos=self.goodScrollView:getChildAnchoredPosition()
UIManager:invokeUIMethod("UIShareImageWin","setPhotoRootShowState",false)
end

function UIZaoWuGeShowPrizeWin.onItemUse(itemid,num)
if _this==nil then return end

local itemcfg=itemsConfig.getConfig(itemid)
local funcparam=itemcfg.funcparam
if funcparam then
if itemsLookup:canAutoExchange(itemid)then
_this:replay(itemid,num)
end
end
end

function UIZaoWuGeShowPrizeWin:onHide()

end

function UIZaoWuGeShowPrizeWin:__delete()
_this=nil
self:unbindComponents()
notifySystem:removelistener(notifyConfig.onItemUse,self.onItemUse)
if self.callback then
self.callback()
end
if self.attachCallback then
self.attachCallback()
end

UIManager.setMoneyMsgShowState(true,true)
UIManager:invokeUIMethod("UIShareImageWin","setPhotoRootShowState",true)
end

function UIZaoWuGeShowPrizeWin:onShow(argtable,afterOnloaded)
self.curStep=1
self:stopAllTimer()
self.callback=argtable.callback
local tipsStr=argtable.tips or''
local closeTips=argtable.closeTips or'点击空白区域关闭'
local list=argtable.list
local tNum=#list
if tNum>0 then
for i,v in pairs(list)do
local itemid=v.itemid or v[1]
local itemguid=v.itemguid
if itemid==nil and itemguid then
itemid=itemsModel.getItem(itemguid).itemid
v.itemid=itemid
end
local itemConfig=itemsConfig.getConfig(itemid)
local color=itemConfig.color
local stage=itemConfig.stage or 0

local rareLv=itemsConfig.getRareLv(itemid)
local sortWeight=rareLv*100000
sortWeight=sortWeight+color*10000
sortWeight=sortWeight+stage*1000
if itemsConfig.isEquip(itemid)then
sortWeight=sortWeight+100
end
v.sortWeight=sortWeight
end
table.sort(list,function(a,b)
return a.sortWeight>b.sortWeight
end)
end
self.rewardlist=list

self.tips:setText(tipsStr)
self.tipsText:setText(closeTips)
self.effect:setChildShowEffect(10014,true)

self.noteslist={}
self.rewardnum=tNum
self:refreshNotes()

if tNum>0 then
self:initRewardView()
self.playingAnim=true
self:delayDo(0.3,function()
self:playShow()
end)
else
logErr('没有奖励却打开了UIZaoWuGeShowPrizeWin?')
end

local ycdata=argtable.yc_data
if ycdata then
self:delayDo(1,function()
if _this==nil then return end
self:closeSelf()
end)
end
end



function UIZaoWuGeShowPrizeWin:setAttachCB(callback)
self.attachCallback=callback
end

function UIZaoWuGeShowPrizeWin:initRewardView()
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
self:refreswhScrollView()
end

function UIZaoWuGeShowPrizeWin:refreshAllPos()
local num=#self.rewardlist
local grids=self.goodGridPanel:getChildLayoutGroupGridList()
for i=1,num do
local widget=grids[i-1]
self:refreshItemPos(widget,i)
end
self:refreswhScrollView()
end

function UIZaoWuGeShowPrizeWin:refreswhScrollView()
local rowNum=math.ceil(self.rewardnum/colNum_)
local h=topPadding_+rowNum*cellSizeY_+(rowNum-1)*spaceY_
self.goodGridPanel:setChildSizeDelta(self.scrollViewWidth,h)
local flag=true
if rowNum<=1 then
flag=false
self.goodScrollView:setChildAnchoredPos(self.scrollViewPos.x,10)
self.goodScrollView:setChildSizeDelta(self.scrollViewWidth,200)
else
self.goodScrollView:setChildAnchoredPos(self.scrollViewPos.x,self.scrollViewPos.y)
self.goodScrollView:setChildSizeDelta(self.scrollViewWidth,256)
end
self.goodScrollView:setChildScrollRectEnable(flag)
end

function UIZaoWuGeShowPrizeWin:refreshItemPos(item,idx)
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

function UIZaoWuGeShowPrizeWin:refreshItem(item,widget)
local itemguid=item.itemguid
local itemid=item.itemid or item[1]
local num=item.num or item[2]or 1
local limit=item.conf or{}
local temp_item
if itemguid then
temp_item=itemsModel.getItem(itemguid)
if not temp_item then
temp_item={itemid=itemid}
end
else
temp_item={itemid=itemid}
end
limit.itemcount=num<=1 and''or mathHelper.formatNumber(num)
if itemsConfig.isEquip(itemid)then limit.itemcount=nil end
local itemid=temp_item.itemid
if limit.nomalname==nil then
limit.nomalname=true
end
limit.showCountBG=num>1
local porp=itemsComponentHelper.getCommonFillData(temp_item,limit)
local stage=porp[PropIndex(DataPropKey.eWidgetText,6)]

local itemConfig=itemsConfig.getConfig(itemid)
local suitConfig
if itemConfig.bagType==16 then
suitConfig=cfgHelper.get2(cfg_boatequipsuitconfig_get,itemConfig.type2,itemConfig.color)
end
local isZQ=suitConfig~=nil

porp[PropIndex(DataPropKey.eWidgetActive,9)]=stage~=nil and stage~=''and not isZQ
porp[PropIndex(DataPropKey.eWidgetIcon,10)]=equipsHelper.getSuitIcon(temp_item)
porp[PropIndex(DataPropKey.eWidgetActive,6)]=stage~=nil and stage~=''and not isZQ



widget:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
widget:SetChildPropData(0,porp)
widget:SetChildActive(2,isZQ)
widget:SetChildActive(3,isZQ)
if isZQ then
local suitIconName=string.format("icon_suit_%d",suitConfig.icon)
widget:SetChildIcon(3,suitIconName,false)
local star=itemConfig.stage
widget:SetChildGroundStarNum(2,star)
widget:SetChildStarNumber(2,star)
end

end




function UIZaoWuGeShowPrizeWin:playShow()
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

function UIZaoWuGeShowPrizeWin:playEffect()
local index=self.curStep
local item=self.goodGridPanel:getChildLayoutGroupGridItem(index-1)
local reward=self.rewardlist[index]
local itemid=reward.itemid or reward[1]
local itemnum=reward.num or reward[2]

local num=itemsLookup:checkAutoExchange(itemid,itemnum)
if num~=nil then
bagProtocolControl.req_use_item(itemid,num)
else
self:playEffectEnd()
end
end

function UIZaoWuGeShowPrizeWin:replay(itemid_,num)
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

function UIZaoWuGeShowPrizeWin:playEffectEnd()
self.curStep=self.curStep+1
if self.curStep<=self.rewardnum then
self:playEffect()
else
self:onFinish()
end
end

function UIZaoWuGeShowPrizeWin:onFinish()
self.playingAnim=false
end





function UIZaoWuGeShowPrizeWin:addNote(str)
table.insert(self.noteslist,1,str)
self:refreshNotes()
end

function UIZaoWuGeShowPrizeWin:refreshNotes()
local c=#self.noteslist
self.noteScrollView:setActive(c>0)
if c>0 then
self.noteGridPanel:setChildLayoutGroupCreateItems(c)
local grids=self.noteGridPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids[i-1]
local str=self.noteslist[i]
item:SetChildText(0,str)
end
end
end



function UIZaoWuGeShowPrizeWin:onClickItem(itemId,index,itemguid,attach)
itemsComponentHelper.onItemClickEx(itemId,index,itemguid,attach)
end

function UIZaoWuGeShowPrizeWin:onClickClose()



self:closeSelf()

UIPrisonControl:check_item_changed()
end