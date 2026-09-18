







def_class("UIBingGongFangShowPrizeWin",UIWindowBase)









function UIBingGongFangShowPrizeWin:bindComponents()

self.tipsText=UIText.get(self,0)
self.goodScrollView=UIObject.get(self,1)
self.tips=UILinkImageText.get(self,2)
self.effect=UIObject.get(self,3)
self.noteScrollView=UIObject.get(self,4)
self.fenjieBtn=UIButton.get(self,5)
self.Dropdown1=UIDropdownEx.get(self,6)
self.goodGridPanel=UIObject.get(self,7)
self.noteGridPanel=UIObject.get(self,8)

self.fenjieBtn:setButtonClick(function()self:onFenjieBtn()end)



end


function UIBingGongFangShowPrizeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.goodScrollView);self.goodScrollView=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.noteScrollView);self.noteScrollView=nil;
_UIObject_release(self.fenjieBtn);self.fenjieBtn=nil;
_UIObject_release(self.Dropdown1);self.Dropdown1=nil;
_UIObject_release(self.goodGridPanel);self.goodGridPanel=nil;
_UIObject_release(self.noteGridPanel);self.noteGridPanel=nil;
end



















local _this=nil
local cellSizeX_=84
local cellSizeY_=110
local spaceX_=47
local spaceY_=5
local leftPadding_=30
local topPadding_=10
local colNum_=5
local _dropItemHeight=40
local _dropViewHeight=220


function UIBingGongFangShowPrizeWin:onLoaded(...)
self:bindComponents()
notifySystem:listenNotify(notifyConfig.onItemUse,self.onItemUse)

UIManager.setMoneyMsgShowState(false,true)
self.scrollViewWidth=self.goodScrollView:getChildSizeDeltaX()
self.scrollViewHeight=self.goodScrollView:getChildSizeDeltaY()
self.scrollViewPos=self.goodScrollView:getChildAnchoredPosition()
self.Dropdown1:setChangeAction(function(...)self:onDropdownChange(...)end)
self.Dropdown1:setDropdownLayoutedAction(function(...)self:onDropdownCreate(...)end)
end


function UIBingGongFangShowPrizeWin:__delete()
self:unbindComponents()
end

function UIBingGongFangShowPrizeWin:setDropdowns()
local option={'绿色品质及以下装备','蓝色品质及以下装备','紫色品质及以下装备','橙色品质及以下装备'}
self.Dropdown1:setOption(option)
self.Dropdown1:setValue(0)
end

function UIBingGongFangShowPrizeWin:onDropdownChange(idx)
self.sortTypeIdx=idx+1
end

function UIBingGongFangShowPrizeWin:onDropdownCreate(scrollTrans,contentTrans)
local idx=self.sortTypeIdx and self.sortTypeIdx-1 or 0
local lastPos=contentTrans.localPosition
local height=contentTrans.sizeDelta.y
local posY=lastPos.y
if height>_dropViewHeight then
posY=idx*_dropItemHeight
else
posY=0
end
if posY<=0 then posY=0 end
contentTrans.localPosition=Vector3(lastPos.x,posY,lastPos.z)
end




function UIBingGongFangShowPrizeWin:onShow(argtable,afterOnloaded)
self.sortTypeIdx=1
self.curStep=1
self:stopAllTimer()
self.callback=argtable.callback
local tipsStr=argtable.tips or''
local closeTips=argtable.closeTips or'点击空白区域关闭'
local list=argtable.list
local tNum=#list
if tNum>0 then
if list[1].sortWeight then
table.sort(list,function(a,b)
return a.sortWeight>b.sortWeight
end)
else
for i,v in pairs(list)do
local itemid=v.itemid
local itemguid=v.itemguid
if itemid==nil and itemguid then
itemid=itemsModel.getItem(itemguid).itemid
v.itemid=itemid
end
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

AudioManager.playAudio(407)

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
logErr('没有奖励却打开了UIBingGongFangShowPrizeWin?')
end

self:setDropdowns()
end

local colorMap={1,2,3,4,5}
local colorNameMap={'绿色品质及以下装备','蓝色品质及以下装备','紫色品质及以下装备','橙色品质及以下装备'}
function UIBingGongFangShowPrizeWin:onFenjieBtn()
local bdData=zongmenModel:haveBuildByBuildType(SLG_SYSTEM_TYPE.eBaGuaLu1)
if not bdData then
UIManager.error("需建造八卦炉")
return
end

if self.rewardlist then
local selectGUIDList={}
for i,v in pairs(self.rewardlist)do
if v.itemguid and itemsConfig.isEquip(v.itemid)then
local color=itemsConfig.getItemColor(v.itemid)
if color<=colorMap[self.sortTypeIdx]then
table.insert(selectGUIDList,v.itemguid)
end
end
end
local len=#selectGUIDList
if len>0 then
local rrlitems=self:calcuItems(selectGUIDList)
UIFullBaGuaLuControl:setRongLianGUID(selectGUIDList,rrlitems)
self:onClickClose()
else
UIManager.error(FMT.fmt("没有{0}",colorNameMap[self.sortTypeIdx]))
end
end
end
function UIBingGongFangShowPrizeWin:calcuItems(selectGUIDList)
local rlitems={}
for _,itemguid in ipairs(selectGUIDList)do
local item=itemsModel.getItem(itemguid)
local items=equipsHelper.returnRonglianItems(item)

rlitems=table.concatTableXX(rlitems,items)
end
local rrlitems={}
for i,v in ipairs(rlitems)do
if not itemsConfig.isMoney(v[1])then
rrlitems[#rrlitems+1]=v
end
end
return rrlitems
end

function UIBingGongFangShowPrizeWin:onHide()

end

function UIBingGongFangShowPrizeWin:setAttachCB(callback)
self.attachCallback=callback
end

function UIBingGongFangShowPrizeWin:initRewardView()
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

function UIBingGongFangShowPrizeWin:refreshAllPos()
local num=#self.rewardlist
local grids=self.goodGridPanel:getChildLayoutGroupGridList()
for i=1,num do
local widget=grids[i-1]
self:refreshItemPos(widget,i)
end
self:refreswhScrollView()
end

function UIBingGongFangShowPrizeWin:refreswhScrollView()
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

function UIBingGongFangShowPrizeWin:refreshItemPos(item,idx)
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

function UIBingGongFangShowPrizeWin:refreshItem(item,widget)
local itemguid=item.itemguid
local itemid=item.itemid
local num=item.num or 1
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
limit.itemcount=num<=1 and''or num
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

self:onClickItem(...)
end)
widget:SetChildPropData(0,porp)
end




function UIBingGongFangShowPrizeWin:playShow()
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

function UIBingGongFangShowPrizeWin:playEffect()
local index=self.curStep
local item=self.goodGridPanel:getChildLayoutGroupGridItem(index-1)
local reward=self.rewardlist[index]
local itemid=reward.itemid
local itemnum=reward.num

local num=itemsLookup:checkAutoExchange(itemid,itemnum)
if num~=nil then
bagProtocolControl.req_use_item(itemid,num)
else
self:playEffectEnd()
end
end

function UIBingGongFangShowPrizeWin:replay(itemid_,num)
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
self:delayDo(0.8,func)
end
end
end

function UIBingGongFangShowPrizeWin:playEffectEnd()
self.curStep=self.curStep+1
if self.curStep<=self.rewardnum then
self:playEffect()
else
self:onFinish()
end
end

function UIBingGongFangShowPrizeWin:onFinish()
self.playingAnim=false
end





function UIBingGongFangShowPrizeWin:addNote(str)
table.insert(self.noteslist,1,str)
self:refreshNotes()
end

function UIBingGongFangShowPrizeWin:refreshNotes()
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



function UIBingGongFangShowPrizeWin:onClickItem(itemId,index,itemguid,attach)
itemsComponentHelper.onItemClick(itemId,index,itemguid,attach)
end

function UIBingGongFangShowPrizeWin:onClickClose()




self:closeSelf()
end



