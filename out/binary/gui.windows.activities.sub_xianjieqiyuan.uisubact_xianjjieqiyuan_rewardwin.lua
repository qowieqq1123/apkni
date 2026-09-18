







def_class("UISubAct_xianjjieqiyuan_rewardWin",UIWindowBase)









function UISubAct_xianjjieqiyuan_rewardWin:bindComponents()

self.frameBG=UIButton.get(self,0)
self.model=UIObject.get(self,1)
self.descTxt=UIText.get(self,2)
self.desc2Txt=UIText.get(self,3)
self.goodGridPanel=UIObject.get(self,4)
self.descIcon=UIImage.get(self,5)
self.desc2Icon=UIImage.get(self,6)
self.noteScrollView=UIObject.get(self,7)
self.tenBtn=UIButton.get(self,8)
self.oneBtn=UIButton.get(self,9)
self.root=UIObject.get(self,10)
self.tenCostIcon=UIImage.get(self,11)
self.tenCostDesc=UIText.get(self,12)
self.noteGridPanel=UIObject.get(self,13)
self.oneCostIcon=UIImage.get(self,14)
self.oneCostDesc=UIText.get(self,15)

self.frameBG:setButtonClick(function()self:onFrameBG()end)

self.tenBtn:setButtonClick(function()self:onTenBtn()end)

self.oneBtn:setButtonClick(function()self:onOneBtn()end)



end


function UISubAct_xianjjieqiyuan_rewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.frameBG);self.frameBG=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.desc2Txt);self.desc2Txt=nil;
_UIObject_release(self.goodGridPanel);self.goodGridPanel=nil;
_UIObject_release(self.descIcon);self.descIcon=nil;
_UIObject_release(self.desc2Icon);self.desc2Icon=nil;
_UIObject_release(self.noteScrollView);self.noteScrollView=nil;
_UIObject_release(self.tenBtn);self.tenBtn=nil;
_UIObject_release(self.oneBtn);self.oneBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tenCostIcon);self.tenCostIcon=nil;
_UIObject_release(self.tenCostDesc);self.tenCostDesc=nil;
_UIObject_release(self.noteGridPanel);self.noteGridPanel=nil;
_UIObject_release(self.oneCostIcon);self.oneCostIcon=nil;
_UIObject_release(self.oneCostDesc);self.oneCostDesc=nil;
end
















local _this=nil
local _abName="ui/windows/activities/sub_xianjieqiyuan/xianjieqiyuan_atlas_pak.ab"

function UISubAct_xianjjieqiyuan_rewardWin:onLoaded(...)
_this=self
self:bindComponents()

notifySystem:listenNotify(notifyConfig.onDiscipleCreate,self.onDiscipleCreate)
notifySystem:listenNotify(notifyConfig.onItemUse,self.onItemUse)
notifySystem:listenNotify(notifyConfig.closeUI,self.onCloseUI)
end


function UISubAct_xianjjieqiyuan_rewardWin:__delete()
_this=nil
self:unbindComponents()

notifySystem:removelistener(notifyConfig.onDiscipleCreate,self.onDiscipleCreate)
notifySystem:removelistener(notifyConfig.onItemUse,self.onItemUse)
notifySystem:removelistener(notifyConfig.closeUI,self.onCloseUI)
end


function UISubAct_xianjjieqiyuan_rewardWin:onHide()

end

function UISubAct_xianjjieqiyuan_rewardWin.onDiscipleCreate(dis_guid)
if _this==nil then return end

if UIDiscipleModel:isItemDisciple(dis_guid)then
_this.markDZClose=true
end
end

function UISubAct_xianjjieqiyuan_rewardWin.onItemUse(itemid,num)
if _this==nil then return end

local itemcfg=itemsConfig.getConfig(itemid)
local funcparam=itemcfg.funcparam
if funcparam then
local ftype=funcparam.type
if ftype==item_funtion_type.disciple and funcparam.isSpecial==true then
local dzid=funcparam.discipleid
_this:replay(itemid,num,dzid)
elseif itemsLookup:canAutoExchange(itemid)then
_this:replay(itemid,num,nil)
end
end
end

function UISubAct_xianjjieqiyuan_rewardWin.onCloseUI(name)
if _this==nil then return end

if name=='UIItemRecruitDiscipleWin'and _this.markDZClose==true then
_this:playEffectEnd()
end
end




function UISubAct_xianjjieqiyuan_rewardWin:onShow(argtable,afterOnloaded)
self.curStep=1
self.actID=argtable.act_id
self.subType=argtable.sub_act_type
self.subid=argtable.sub_act_id
self.sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)

self.rewardlist=argtable.rewardlist
self.noteslist={}
self.rewardnum=#self.rewardlist
self.showType=argtable.showType
self.actData=argtable.actData
if afterOnloaded then
if self.showType==1 then
self.lockTime=1

else
self.lockTime=10

end
end
self.parentWin=argtable.parentWin
local openBack=argtable.openBack
if openBack then
openBack()
end

self:refreshDesc()
self:initRewardView()
self:refreshNotes()

self.playingAnim=true
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)

self.model:setChildUIModelShowTarget(4026,1,{},0,false,false,0,function()
if _this==nil then return end

_this.root:setChildCanvasGroupAlpha(1)



_this:playShow()
end)
else
self:playShow()
end
end

function UISubAct_xianjjieqiyuan_rewardWin:refreshDesc()
local sub_actInfo=activitiesModel:getSubActInfoData(self.actID,self.subType,self.subid)
local sub_actcfg=activitiesModel:getSubActivityConfig(self.subType,self.subid)
local icon
local maxRoundNum=sub_actcfg.round
local lerp=maxRoundNum-sub_actInfo.times
if sub_actInfo.round==sub_actcfg.upround then
icon='image_xianjieqiyuan_8'
else
icon='image_xianjieqiyuan_10'
end
self.descIcon:setSprite(_abName,icon)
self.descTxt:setText(lerp)


local itemid=self.sub_actcfg.itemid

local haveNun=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)

local hasfree=activitiesHandle_xianjieqiyuan.checkHasFree(self.subType,self.subid,self.actData.free)
local str="首次免费"
if not hasfree then
str=FMT.fmt('{0}/{1}',haveNun,1)
if haveNun<1 then
str=toColorString(FONT_COLOR.eRedColor,str)
end
end
self.oneCostIcon:setActive(not hasfree)
self.oneCostDesc:setText(str)

str=FMT.fmt('{0}/{1}',haveNun,10)
if haveNun<10 then
str=toColorString(FONT_COLOR.eRedColor,str)
end
self.tenCostDesc:setText(str)
end

function UISubAct_xianjjieqiyuan_rewardWin:initRewardView()
local iconName=iconHelper.getIconName(self.sub_actcfg.itemid)
self.oneCostIcon:setImageIcon(iconName)
self.tenCostIcon:setImageIcon(iconName)

local num=self.rewardnum
self.goodGridPanel:setChildLayoutGroupCreateItems(num)
local grids=self.goodGridPanel:getChildLayoutGroupGridList()
local cav=self:getChildCanvas(-1)
for i=1,num do
local item=grids[i-1]
local reward=self.rewardlist[i]

item:SetChildCanvas(5,cav[1],cav[2]+1)

item:SetChildShowEffect(4,0,false)

self:refreshItem(item,reward.itemid,reward.num,true)

item:SetChildActive(-1,false)
end
end

function UISubAct_xianjjieqiyuan_rewardWin:refreshItem(item,itemid,itemnum)
local countStr=''
local showCountBG=false
if itemnum>1 then
showCountBG=true
countStr=tostring(itemnum)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,colorEffect=itemsConfig.getItemColor(itemid)>eQualityColor.eBlue}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)

local itemConfig=itemsConfig.getConfig(itemid)
item:SetChildText(2,itemConfig.name)
end

function UISubAct_xianjjieqiyuan_rewardWin:refreshItemNew(item,idx)
if item==nil then
item=self.goodGridPanel:getChildLayoutGroupGridItem(idx-1)
end

local reward=self.rewardlist[idx]
local itemid=reward.itemid
local isNew=false

local itemcfg=itemsConfig.getConfig(itemid)
local checkuse=false
local funcparam=itemcfg.funcparam
if funcparam then
local ftype=funcparam.type
if ftype==item_funtion_type.disciple and funcparam.isSpecial==true then
local srctype=itemid
isNew=UIDiscipleModel:findSrcTypeDisciple(srctype)==nil
end
end
item:SetChildActive(1,isNew)
end




function UISubAct_xianjjieqiyuan_rewardWin:playShow()
if self.delayEffect_PlayShow then
self:stopTimerByID(self.delayEffect_PlayShow)
self.delayEffect_PlayShow=nil
end

local delay=0
local d=0.2
local num=self.rewardnum
local grids=self.goodGridPanel:getChildLayoutGroupGridList()

if num<=1 then

AudioManager.playAudio(545)
else

AudioManager.playAudio(507)
end

for i=1,num do
local item=grids[i-1]
local func=function()
item:SetChildActive(-1,true)
item:SetChildScale(-1,Vector3(2,2,2))
item:SetChildDOScale(-1,1,d,nil)
end
if delay>0 then
self:delayDo(delay,func)
else
func()
end
delay=delay+d
if d>0.13 then
d=d-0.01
end
end
local func2=function()
self:playEffect()
end
self.delayEffect_PlayShow=self:delayDo(delay,func2)
end

function UISubAct_xianjjieqiyuan_rewardWin:playEffect()
if self.delayEffect_PlayEffect then
self:stopTimerByID(self.delayEffect_PlayEffect)
self.delayEffect_PlayEffect=nil
end

local index=self.curStep
local item=self.goodGridPanel:getChildLayoutGroupGridItem(index-1)
local reward=self.rewardlist[index]
local itemConfig=itemsConfig.getConfig(reward.itemid)

self:refreshItemNew(item,index)

local checkuse=self:checkItem()
if checkuse then
bagProtocolControl.req_use_item(reward.itemid,reward.num)
else
if itemConfig.color>=eQualityColor.eRed then
self:playItemEffect(item,index)
local func=function()
self:playEffectEnd()
end
self.delayEffect_PlayEffect=self:delayDo(0.4,func)
else
self:playEffectEnd()
end
end
end

function UISubAct_xianjjieqiyuan_rewardWin:playItemEffect(item,index)
if self.delayItemEffect==nil then
self.delayItemEffect={}
end
if self.delayItemEffect[index]then
self:stopTimerByID(self.delayItemEffect[index])
self.delayItemEffect[index]=nil
end

item:SetChildShowEffect(3,10164,true)
local func=function()
item:SetChildShowEffect(4,10165,true)
end

self.delayItemEffect[index]=self:delayDo(0.5,func)
end

function UISubAct_xianjjieqiyuan_rewardWin:checkItem()
local index=self.curStep
local reward=self.rewardlist[index]
local itemid=reward.itemid
local itemnum=reward.num
local itemcfg=itemsConfig.getConfig(itemid)
local checkuse=false
local funcparam=itemcfg.funcparam
if funcparam then
local ftype=funcparam.type
if ftype==item_funtion_type.disciple and funcparam.isSpecial==true then

local itemCount=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
if itemCount>=itemnum then
checkuse=true
end
end
end
return checkuse
end

function UISubAct_xianjjieqiyuan_rewardWin:replay(itemid_,num,dzid)
local index=self.curStep
if index<=self.rewardnum then
local reward=self.rewardlist[index]
local itemid=reward.itemid
local itemnum=reward.num
if itemid==itemid_ then
if self.markDZClose~=true then

local itemid__,itemnum__
local itemcfg=itemsConfig.getConfig(itemid)
local funcparam=itemcfg.funcparam
local ftype=funcparam.type
local isAdd=false
local new_itemid,new_itemnum
local checkAutoUse=false
local new_str
if ftype==item_funtion_type.disciple then
local yuanpo=cfgHelper.get2(cfg_discipleconfig_get,dzid,'yuanpo')
itemid__=yuanpo[1]
itemnum__=yuanpo[2]*num
checkAutoUse=itemsLookup:canAutoExchange(itemid__)

local exnum=dzLingCuiShopController:checkFullTianMingItem(itemid)
if exnum and exnum>0 then
else
new_str=itemsLookup:getAutoExchangeDesc_GLdizi(funcparam.discipleid)
end
elseif itemsLookup:canAutoExchange(itemid)then
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
local item=self.goodGridPanel:getChildLayoutGroupGridItem(index-1)
self:playItemEffect(item,index)
if isAdd then

local new_reward={itemid=new_itemid,num=new_itemnum}
table.insert(self.rewardlist,new_reward)
self.goodGridPanel:setChildLayoutGroupAddItem()
local new_item=self.goodGridPanel:getChildLayoutGroupGridItem(#self.rewardlist-1)
self:refreshItem(new_item,new_itemid,new_itemnum)
end
if new_str~=nil then
self:addNote(new_str)
end

if self.delayTick_replay1 then
self:stopTimerByID(self.delayTick_replay1)
self.delayTick_replay1=nil
end

local func=function()

AudioManager.playAudio(509)
self:refreshItem(item,itemid__,itemnum__)
end
self.delayTick_replay1=self:delayDo(0.5,func)

if self.delayTick_replay2 then
self:stopTimerByID(self.delayTick_replay2)
self.delayTick_replay2=nil
end
local func=function()

local isEnd=true
if checkAutoUse then
local num=itemsLookup:checkAutoExchange(itemid__,itemnum__)
if num~=nil then
bagProtocolControl.req_use_item(itemid__,num)
isEnd=false
end
end
if isEnd then
self:playEffectEnd()
end
end
self.delayTick_replay2=self:delayDo(0.8,func)
end
end
end
end

function UISubAct_xianjjieqiyuan_rewardWin:playEffectEnd()
self.markDZClose=nil
self.curStep=self.curStep+1
if self.curStep<=self.rewardnum then
self:playEffect()
else
self:onFinish()
end
end

function UISubAct_xianjjieqiyuan_rewardWin:onFinish()
self.playingAnim=false
self.clickLockTime=nil
end





function UISubAct_xianjjieqiyuan_rewardWin:addNote(str)
table.insert(self.noteslist,1,str)
self:refreshNotes()
end

function UISubAct_xianjjieqiyuan_rewardWin:refreshNotes()
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



function UISubAct_xianjjieqiyuan_rewardWin:onClickItem(itemId,index,guid,attach)
if self.playingAnim==true then return end
if self.clickLock==true then return end
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eRight})
end



















function UISubAct_xianjjieqiyuan_rewardWin:clearClickLock(isclear)
self.clickLock=nil
if not isclear then
self.clickLockTime=gameUtilityModel.getServerShortTime()+self.lockTime
end
end

function UISubAct_xianjjieqiyuan_rewardWin:onShareBtn()

end

function UISubAct_xianjjieqiyuan_rewardWin:onFrameBG()
self:onClickClose()
end

function UISubAct_xianjjieqiyuan_rewardWin:onClickClose()
if self.playingAnim==true then
return
end
UIManager:invokeUIMethod(self.parentWin,'resetResultAnim')
self:closeSelf()
end

function UISubAct_xianjjieqiyuan_rewardWin:onTenBtn()
if self.playingAnim==true then return end
if self.clickLock==true then return end

if self.clickLockTime then
if gameUtilityModel.getServerShortTime()<self.clickLockTime then
return
end
self.clickLockTime=nil
end

self.clickLock=true
self.lockTime=10
UIManager:invokeUIMethod(self.parentWin,'useItem',10,2,1)
end

function UISubAct_xianjjieqiyuan_rewardWin:onOneBtn()
if self.playingAnim==true then return end
if self.clickLock==true then return end
if self.clickLockTime then
if gameUtilityModel.getServerShortTime()<self.clickLockTime then
return
end
self.clickLockTime=nil
end

self.clickLock=true
self.lockTime=1
UIManager:invokeUIMethod(self.parentWin,'useItem',1,1,1)
end