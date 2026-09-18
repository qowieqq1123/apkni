







def_class("UISubAct_CangBaoTuWin",UIWindowBase)









function UISubAct_CangBaoTuWin:bindComponents()

self.costIcon=UIImage.get(self,0)
self.costTx=UIText.get(self,1)
self.root=UIObject.get(self,2)
self.effect=UIObject.get(self,3)
self.timeTx=UIText.get(self,4)
self.taskBtn=UIButton.get(self,5)
self.tips=UIText.get(self,6)
self.prizeBtn=UIButton.get(self,7)
self.ruleBtn=UIButton.get(self,8)
self.moneyBg=UIButton.get(self,9)
self.scrollView=UIObject.get(self,10)
self.rewardBg=UIObject.get(self,11)
self.cardBtn=UIButton.get(self,12)
self.rightBtn=UIButton.get(self,13)
self.leftBtn=UIButton.get(self,14)
self.taskReddot=UIObject.get(self,15)
self.costRoot=UIObject.get(self,16)
self.freeTx=UIText.get(self,17)
self.prizeReddot=UIObject.get(self,18)
self.cardReddot=UIObject.get(self,19)
self.moneyIcon=UIImage.get(self,20)
self.moneyNum=UIText.get(self,21)
self.scrollContent=UIObject.get(self,22)

self.taskBtn:setButtonClick(function()self:onTaskBtn()end)

self.prizeBtn:setButtonClick(function()self:onPrizeBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.moneyBg:setButtonClick(function()self:onMoneyBg()end)

self.cardBtn:setButtonClick(function()self:onCardBtn()end)

self.rightBtn:setButtonClick(function()self:onRightBtn()end)

self.leftBtn:setButtonClick(function()self:onLeftBtn()end)



end


function UISubAct_CangBaoTuWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costTx);self.costTx=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.timeTx);self.timeTx=nil;
_UIObject_release(self.taskBtn);self.taskBtn=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.prizeBtn);self.prizeBtn=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.moneyBg);self.moneyBg=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.rewardBg);self.rewardBg=nil;
_UIObject_release(self.cardBtn);self.cardBtn=nil;
_UIObject_release(self.rightBtn);self.rightBtn=nil;
_UIObject_release(self.leftBtn);self.leftBtn=nil;
_UIObject_release(self.taskReddot);self.taskReddot=nil;
_UIObject_release(self.costRoot);self.costRoot=nil;
_UIObject_release(self.freeTx);self.freeTx=nil;
_UIObject_release(self.prizeReddot);self.prizeReddot=nil;
_UIObject_release(self.cardReddot);self.cardReddot=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyNum);self.moneyNum=nil;
_UIObject_release(self.scrollContent);self.scrollContent=nil;
end















local _this=nil
local _itemCmp={
root=-1,
name=0,
effect=1,
fragments={2,3,4,5,6,7,8,9,10},
fragmentRoot=11,
picture=12,
}
local _subItemCmp={
root=-1,
name=0,
effect=1,
opened=2,
boom=3,
}
local _pieceab="ui/windows/activities/sub_cangbaotu/cangbaotu_piece_atlas_pak.ab"
local _componentab="ui/windows/activities/sub_cangbaotu/cangbaotu_component_atlas_pak.ab"
local _itemWidth=1128
local _itemInterval=274
local _scrollLimit=300



function UISubAct_CangBaoTuWin:onLoaded(...)
self:bindComponents()
_this=self

local _onDragBegin=function(index,pos)
self:onDragBegin(pos)
end
local _onDragUpdate=function(index,pos)
self:onDragUpdate(pos)
end
local _onDragEnd=function(index,pos)
self:onDragEnd(pos)
end
self.winlua:SetChildUIDragEvent(self.scrollView:getID(),0,_onDragBegin,_onDragEnd,_onDragUpdate)

self._on_money_changed=function(...)
self:on_money_changed(...)
end
self._on_item_changed=function(...)
self:on_item_changed(...)
end
notifySystem:listenNotify(notifyConfig.on_money_changed,self._on_money_changed)
notifySystem:listenNotify(notifyConfig.on_item_changed,self._on_item_changed)
end


function UISubAct_CangBaoTuWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.on_money_changed,self._on_money_changed)
notifySystem:removelistener(notifyConfig.on_item_changed,self._on_item_changed)

self:stopCorrectTick()
self:cancelCorrect()

if self.effectTween and self.effectTween:IsActive()then
self.effectTween:Kill()
self.effectTween=nil
end
end




function UISubAct_CangBaoTuWin:onShow(argtable,afterOnloaded)
if argtable then
local old=self.activityId==argtable.act_id and self.subType==argtable.sub_act_type and self.subId==argtable.sub_act_id
if not old then
self.activityId=argtable.act_id
self.subType=argtable.sub_act_type
self.subId=argtable.sub_act_id
self.parentWin=argtable.parentWin
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.info=activitiesModel:getSubActInfo(self.activityId,self.subType,self.subId)
self:initView()
end

self:refreshViewImp()

local subWindow=argtable.extraParams and argtable.extraParams.subWindow or nil
if subWindow then
local tab=subWindow==1 and SEC_FULL_TAB_TYPE.cangbaotuMyCard or SEC_FULL_TAB_TYPE.cangbaotuMyRecord
oneTabScreenController:openTabUI(tab,{activityId=self.activityId,subType=self.subType,subId=self.subId})
end
end
end


function UISubAct_CangBaoTuWin:onHide()

end



function UISubAct_CangBaoTuWin:on_money_changed(moneyType,lastVal,val)
if moneyType==self.listen[1]then
self:refreshMoney()
self:refreshPrize()
end

if table.containsValue(self.config.money,moneyType)then
self:refreshList()
end
end

function UISubAct_CangBaoTuWin:on_item_changed(changeType,itemguid,itemid,oldcount,newcount)
if itemid==self.listen[1]then
self:refreshMoney()
self:refreshPrize()
end

if table.containsValue(self.config.money,itemid)then
self:refreshList()
end
end


function UISubAct_CangBaoTuWin:onRuleBtn()
local d={}
d.title='规则'
d.mode=3
d.name='cangbaotu_help_%d'
UIManager:showWindow('UIRuleWin',d)
end


function UISubAct_CangBaoTuWin:onMoneyBg()
local itemId=self.listen[1]
gainControl:showCommonGainWin_item(itemId)
end


function UISubAct_CangBaoTuWin:onCardBtn()
oneTabScreenController:openTabUI(SEC_FULL_TAB_TYPE.cangbaotuMyCard,{activityId=self.activityId,subType=self.subType,subId=self.subId})
end


function UISubAct_CangBaoTuWin:onPrizeBtn()
local data=self.info:getData()
if not data then
return
end

local line=self.config.free
local times=data.task.searchtimes
local itemId=self.listen[1]
local have=itemsModel.getCount(itemId)
if line<=times and have<self.need then
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(itemId)))
gainControl:showGainWin(itemId)
return
end

self.root:setActive(false)

local itemId=self.listen[1]
local args={
activityId=self.activityId,
subType=self.subType,
subId=self.subId,
closeCB=function()
self.root:setActive(true)
end
}
self:showWindow("UISubAct_CangBaoTuCardWin",args)
end


function UISubAct_CangBaoTuWin:onTaskBtn()
self:showWindow("UISubAct_CangBaoTuTaskWin",{activityId=self.activityId,subType=self.subType,subId=self.subId})
end


function UISubAct_CangBaoTuWin:onRightBtn()
if self.correctTween or self.correctTick then return end
self:onSelectMap()



local target=self:convertCurrentIndex()
local x=(target)*-(_itemWidth+_itemInterval)
self.correctTween=self.scrollContent:setChildDOAnchorPosX(x,1,function()
self.correctTween=nil
self:onSelectMap(target)
end)
self.correctTween:OnUpdate(function()
self:onDragUpdate()
end)
end


function UISubAct_CangBaoTuWin:onLeftBtn()
if self.correctTween or self.correctTick then return end
self:onSelectMap()



local target=self:convertCurrentIndex()
local x=(target-2)*-(_itemWidth+_itemInterval)
self.correctTween=self.scrollContent:setChildDOAnchorPosX(x,1,function()
self.correctTween=nil
self:onSelectMap(target)
end)
self.correctTween:OnUpdate(function()
self:onDragUpdate()
end)
end

function UISubAct_CangBaoTuWin:onClickSubItem(mainIdx,subIdx)
local data=self.info:getData()
local mapid=data.current.mapid
if mapid==mainIdx then
local config=self.config.money
local pieceflag=data.current.pieceflag
local cnt=#config
if cnt==mathHelper.cntbit(pieceflag,0,cnt)then
call_activitiesHandle_func('activitiesHandle_cangbaotu','reqActiveFragment',self.activityId,self.subId,0)
end
local flag=mathHelper.getBitValue(pieceflag,subIdx-1)
if not flag then
local money=self.config.money[subIdx]
local enough=itemsModel.getCount(money)>0
if enough then
call_activitiesHandle_func('activitiesHandle_cangbaotu','reqActiveFragment',self.activityId,self.subId,subIdx)
else
local args={
activityId=self.activityId,
subType=self.subType,
subId=self.subId,
map=mapid,
piece=subIdx,
}
self:showWindow("UISubAct_CangBaoTuUnlockTips",args)
end
end
end
end

function UISubAct_CangBaoTuWin:initView()

self:startCDTick()

self:initMoneyItem()

self:initList()
end

function UISubAct_CangBaoTuWin:initMoneyItem()
self.listen={}
for i,v in ipairs(self.config.consume)do
table.insert(self.listen,v[1])
if i==1 then
self.need=v[2]
end
end
local itemId=self.listen[1]
local iconname=iconHelper.getIconName(itemId)
self.moneyIcon:setIcon(iconname)
self.costIcon:setIcon(iconname)
self:refreshMoney()
end

function UISubAct_CangBaoTuWin:initList()
local cnt=#self.config.mapName
self.scrollContent:setChildLayoutGroupCreateItems(cnt,function(index)
local item=self.scrollContent:getChildLayoutGroupGridItem(index-1)
local cfg=self.config.mapName[index]
item:SetChildCSImageSprite(_itemCmp.name,_componentab,cfg[2])
item:SetChildCSImageSprite(_itemCmp.picture,_pieceab,cfg[5])
if cfg[6]then
item:SetChildAnchoredPos(_itemCmp.effect,cfg[6][1]or 0,cfg[6][2]or 0)
end
item.gameObject.name=tostring(index)
for i,v in ipairs(_itemCmp.fragments)do
local subItem=item:GetChildWidgetBase(v)
subItem:SetChildCSImageSprite(_subItemCmp.opened,_pieceab,cfg[1][i])
subItem:SetChildButtonClick(_subItemCmp.root,function()
self:onClickSubItem(index,i)
end)
end
end)
local data=self.info:getData()
local map=data.current.mapid
local target=math.min(map,cnt)

local x=(target-1)*-(_itemWidth+_itemInterval)
self.scrollContent:setChildAnchoredPos(x,0)
self.leftBtn:setActive(target>1)
self.rightBtn:setActive(false)
self.selected=target
end

function UISubAct_CangBaoTuWin:startCDTick()
self:updateCDTick()
if not self.cdTick then
self.cdTick=self:setTimer(1,0,function()
self:updateCDTick()
end)
end
end

function UISubAct_CangBaoTuWin:stopCDTick()
if self.cdTick then
self:stopTimerByID(self.cdTick)
self.cdTick=nil
end
end

function UISubAct_CangBaoTuWin:updateCDTick()
local time=activitiesModel:getSubActEndLeftTime(self.activityId,self.subType,self.subId)
self.timeTx:setText(FMT.fmt("活动剩余时间：{0}",timeHelper.format_time_stamp3(time)))
end

function UISubAct_CangBaoTuWin:refreshView(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshViewImp()
end
end

function UISubAct_CangBaoTuWin:refreshViewImp()

self:refreshTaskReddot()

self:refreshPrize()

self:refreshCardReddot()

self:refreshList()
end

function UISubAct_CangBaoTuWin:afterPrize(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshPrize()
self:refreshTaskReddot()
end
end

function UISubAct_CangBaoTuWin:afterActive(activityId,subType,subId,pieceid,rewards_)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
local data=self.info:getData()
local map=data.current.mapid
if pieceid==0 then
local cnt=#self.config.mapName
if map<=cnt then
showPrizeControl.showWindow(rewards_,function()
self:stopCorrectTick()
self:cancelCorrect()

self.effectTween=Lua.SequenceProxy.New()
self.effectTween:AppendCallback(function()
self.effect:setActive(true)

AudioManager.playAudio(596)
end)
self.effectTween:AppendInterval(0.2)
local showTween=self.effect:setChildCanvasGroupDOFade(1,0.5)
self.effectTween:Append(showTween)
self.effectTween:AppendInterval(1)
local hideTween=self.effect:setChildCanvasGroupDOFade(0,0.5)
self.effectTween:Append(hideTween)
self.effectTween:AppendCallback(function()
self.effect:setActive(false)
self:onRightBtn()





end)




end)
else
showPrizeControl.showWindow(rewards_)
end
else
local items=self.scrollContent:getChildLayoutGroupGridList()
if map<=items.Count then
local item=items[map-1]
local fragment=item:GetChildWidgetBase(_itemCmp.fragments[pieceid])
fragment:SetChildShowEffect(_subItemCmp.boom,10294,true)

AudioManager.playAudio(595)





end
end
self:refreshTaskReddot()
self:refreshList()
end
end

function UISubAct_CangBaoTuWin:afterTask(activityId,subType,subId)
if self.activityId==activityId and self.subType==subType and self.subId==subId then
self:refreshTaskReddot()
end
end

function UISubAct_CangBaoTuWin:onNewDay()
self:refreshTaskReddot()
self:refreshPrize()
end

function UISubAct_CangBaoTuWin:refreshMoney()
local itemId=self.listen[1]
local count=itemsModel.getCount(itemId)
self.moneyNum:setText(count)
end

function UISubAct_CangBaoTuWin:refreshTaskReddot(check)
if check then
if check[1]~=self.activityId or check[2]~=self.subType or check[3]~=self.subId then
return
end
end

local reddot=self.info:getTaskReddot()
self.taskReddot:setActive(reddot)
end

function UISubAct_CangBaoTuWin:refreshPrize()
local reddot=self.info:getFreeReddot()
self.prizeReddot:setActive(reddot)

local line=self.config.free
local data=self.info:getData()
local times=data.task.searchtimes
if line<=times then
self.freeTx:setText('')
self.costRoot:setActive(true)
local num=itemsModel.getCount(self.listen[1])
local tempStr=num>=self.need and self.need or FMT.cfmt(FONT_COLOR.eRedColor,"{0}",self.need)
self.costTx:setText(FMT.fmt("消耗:{0}",tempStr))
else
self.freeTx:setText(FMT.fmt("免费次数：{0}",line-times))
self.costRoot:setActive(false)
end
end

function UISubAct_CangBaoTuWin:refreshCardReddot(check)
if check then
if check[1]~=self.activityId or check[2]~=self.subType or check[3]~=self.subId then
return
end
end

local reddot=self.info:getRecordReddot()
self.cardReddot:setActive(reddot)
end

function UISubAct_CangBaoTuWin:refreshList()
local items=self.scrollContent:getChildLayoutGroupGridList()
local data=self.info:getData()
for i=1,items.Count do
local item=items[i-1]
item:SetChildActive(-1,i<=data.current.mapid)
self:refreshListItem(i,item)
end
self:onSelectMap(self.selected)
end

function UISubAct_CangBaoTuWin:refreshListItem(itemIdx,item)
item=item or self.scrollContent:getChildLayoutGroupGridItem(itemIdx-1)
local data=self.info:getData()
local mapid=data.current.mapid
if mapid<itemIdx then
item:SetChildActive(_itemCmp.fragmentRoot,true)
for i,v in ipairs(_itemCmp.fragments)do
local subItem=item:GetChildWidgetBase(v)
subItem:SetChildActive(_subItemCmp.opened,false)

subItem:SetChildActive(_subItemCmp.effect,false)
end
item:SetChildActive(_itemCmp.effect,false)
item:SetChildActive(_itemCmp.picture,false)
elseif mapid>itemIdx then






item:SetChildActive(_itemCmp.effect,false)
item:SetChildActive(_itemCmp.picture,true)
item:SetChildActive(_itemCmp.fragmentRoot,false)
else
local mainFlag=true
local pieceflag=data.current.pieceflag
item:SetChildActive(_itemCmp.fragmentRoot,true)
for i,v in ipairs(_itemCmp.fragments)do
local subFlag=mathHelper.getBitValue(pieceflag,i-1)
local enough=itemsModel.getCount(self.config.money[i])>0
local subItem=item:GetChildWidgetBase(v)
subItem:SetChildActive(_subItemCmp.opened,subFlag)

subItem:SetChildActive(_subItemCmp.effect,not subFlag and enough)
mainFlag=mainFlag and subFlag
end
item:SetChildActive(_itemCmp.effect,mainFlag)
item:SetChildActive(_itemCmp.picture,false)
end
end

function UISubAct_CangBaoTuWin:onDragBegin(pos)
self.dragPos=pos
self:onSelectMap()
self:stopCorrectTick()
self:cancelCorrect()
end

function UISubAct_CangBaoTuWin:onDragEnd(pos)
local dir=pos.x-self.dragPos.x

self.dragPos=nil
self:startCorrectTick(dir)
end

function UISubAct_CangBaoTuWin:onDragUpdate()

local data=self.info:getData()


local index=self:convertCurrentIndex()
self.leftBtn:setActive(index>1)
self.rightBtn:setActive(index<math.min(data.current.mapid,#self.config.mapName))










end

function UISubAct_CangBaoTuWin:startCorrectTick(dir)
if not self.correctTick then
self.contentPos=self.scrollContent:getChildAnchoredPosition()
self.correctTick=self:setTimer(0.2,0,function()
self:onDragUpdate()
local pos=self.scrollContent:getChildAnchoredPosition()

if self.contentPos==pos then
self:stopCorrectTick()
self:doCorrect(dir)
else
self.contentPos=pos
end
end)
end
end

function UISubAct_CangBaoTuWin:stopCorrectTick()
if self.correctTick then
self:stopTimerByID(self.correctTick)
self.correctTick=nil
end
end

function UISubAct_CangBaoTuWin:doCorrect(dir)
self:cancelCorrect()

local index=self:convertCorrentIndex(dir)
local x=(index-1)*-(_itemWidth+_itemInterval)
self.correctTween=self.scrollContent:setChildDOAnchorPosX(x,0.5,function()
self.correctTween=nil
self:onSelectMap(index)
end)
self.correctTween:OnUpdate(function()
self:onDragUpdate()
end)
end

function UISubAct_CangBaoTuWin:cancelCorrect()
if self.correctTween then
self.correctTween:Kill()
self.correctTween=nil
end
end

function UISubAct_CangBaoTuWin:onSelectMap(index)

if index then
self.selected=index
local rewards=self.config.mapName[index][4]or{}
self.rewardBg:setActive(true)

self.rewardBg:setChildLayoutGroupCreateItems(#rewards,function(index)
local rewardItem=self.rewardBg:getChildLayoutGroupGridItem(index-1)
local data=rewards[index]
local conf={itemid=data[1],itemcount=data[2]>1 and data[2]or"",showCountBG=data[2]>1,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
rewardItem:SetChildPropData(-1,prop)
rewardItem:SetBaseItemClickEvent(-1,function(...)
itemsComponentHelper.onItemClickEx(...)
end)
end)

else
self.selected=nil

self.rewardBg:setActive(false)
end
end

function UISubAct_CangBaoTuWin:convertCorrentIndex(dir)
local pos=self.scrollContent:getChildAnchoredPosition()
if math.abs(dir)<_scrollLimit then
local temp=math.floor(pos.x/-(_itemWidth+_itemInterval)+0.5)+1
return temp
end
local left=dir>0
if left then
local index=math.floor(math.abs(pos.x)/(_itemWidth+_itemInterval))
return math.max(index,0)+1
else
local index=math.ceil(math.abs(pos.x)/(_itemWidth+_itemInterval))+1
local data=self.info:getData()
return math.min(index,data.current.mapid,#self.config.mapName)
end














end

function UISubAct_CangBaoTuWin:convertCurrentIndex()
local pos=self.scrollContent:getChildAnchoredPosition()
local data=self.info:getData()
return Mathf.Clamp(math.floor(pos.x/-(_itemWidth+_itemInterval))+1,1,math.min(data.current.mapid,#self.config.mapName))
end