







def_class("UIXianYuanXunFangRewardWin",UIWindowBase)









function UIXianYuanXunFangRewardWin:bindComponents()

self.againBtn=UIButton.get(self,0)
self.descIcon=UIImage.get(self,1)
self.descTxt=UIText.get(self,2)
self.frameBG=UIButton.get(self,3)
self.goodGridPanel=UIObject.get(self,4)
self.model=UIObject.get(self,5)
self.noteGridPanel=UIObject.get(self,6)
self.noteScrollView=UIObject.get(self,7)
self.root=UIObject.get(self,8)
self.tenCostDesc=UIText.get(self,9)
self.tenCostIcon=UIImage.get(self,10)
self.Text=UIText.get(self,11)

self.againBtn:setButtonClick(function()self:onAgainBtn()end)

self.frameBG:setButtonClick(function()self:onFrameBG()end)



end


function UIXianYuanXunFangRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.againBtn);self.againBtn=nil;
_UIObject_release(self.descIcon);self.descIcon=nil;
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.frameBG);self.frameBG=nil;
_UIObject_release(self.goodGridPanel);self.goodGridPanel=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.noteGridPanel);self.noteGridPanel=nil;
_UIObject_release(self.noteScrollView);self.noteScrollView=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.tenCostDesc);self.tenCostDesc=nil;
_UIObject_release(self.tenCostIcon);self.tenCostIcon=nil;
_UIObject_release(self.Text);self.Text=nil;
end
















local _this=nil
local _abName='ui/windows/xianyuanxunfang/xianyuanxunfang_atlas_pak.ab'


function UIXianYuanXunFangRewardWin:onLoaded(...)
_this=self
self:bindComponents()

self:addNotify(notifyConfig.onDiscipleCreate,self.onDiscipleCreate)
self:addNotify(notifyConfig.onItemUse,self.onItemUse)
self:addNotify(notifyConfig.closeUI,self.onCloseUI)
end


function UIXianYuanXunFangRewardWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXianYuanXunFangRewardWin:onHide()

end

function UIXianYuanXunFangRewardWin.onDiscipleCreate(dis_guid)
if _this==nil then return end
local srctype=UIDiscipleModel:getDiscipleSrcType(dis_guid)
if UIDiscipleModel:isItemDisciple(dis_guid)and not UIRecruitControl:checkAnimArgs(srctype)then
_this.markDZClose=true
end
end

function UIXianYuanXunFangRewardWin.onItemUse(itemid,num)
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

function UIXianYuanXunFangRewardWin.onCloseUI(name)
if _this==nil then return end

if name=='UIItemRecruitDiscipleWin'and _this.markDZClose==true then
_this:playEffectEnd()
end
end




function UIXianYuanXunFangRewardWin:onShow(argtable,afterOnloaded)
self.myData=xianyuanxunfangModel:getData()
self.mycfg=xianyuanxunfangModel:getCfg2()

self.curStep=1

self.rewardlist=argtable.rewardlist
self.noteslist={}
self.rewardnum=#self.rewardlist
self.showType=argtable.showType
if afterOnloaded then
if self.showType==1 then
self.lockTime=0.5
self.goodGridPanel:setChildAnchoredPos(380,50)
else
self.lockTime=2
self.goodGridPanel:setChildAnchoredPos(0,170)
end
end
self.parentWin=argtable.parentWin
local openBack=argtable.openBack
if openBack then
openBack()
end

self:refreshDesc()
self:refreshBtnCost()
self:initRewardView()
self:refreshNotes()

self.playingAnim=true
if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.frameBG:setActive(false)
self.model:setChildUIModelShowTarget(4026,1,{},0,false,false,0,function()
if _this==nil then return end
_this.frameBG:setActive(true)
_this.root:setChildCanvasGroupAlpha(1)
_this:delayDo(0.2,function()
UIManager:invokeUIMethod(self.parentWin,'resetResultAnim')
end)
_this:playShow()
end)
else
self:playShow()
end
end

function UIXianYuanXunFangRewardWin:refreshDesc()

local icon
if self.myData.round==self.mycfg.upround then
icon='image_yishuzi2'
else
icon='image_yishuzi'
end
self.descIcon:setSprite(_abName,icon)

local maxRoundNum=self.mycfg.round
local lerp=maxRoundNum-self.myData.times
self.descTxt:setText(lerp)
end

function UIXianYuanXunFangRewardWin:refreshBtnCost()
local mycfg=self.mycfg

local itemid=mycfg.itemid
local iconName=iconHelper.getIconName(itemid)
local haveNun=bagControl.invokeFuncByItemId(itemid,'getItemCountByItemID',itemid)
if self.showType==1 then
local str=FMT.fmt('{0}/{1}',haveNun,1)
if haveNun<1 then
str=toColorString(FONT_COLOR.eRedColor,str)
end
self.tenCostIcon:setImageIcon(iconName)
self.tenCostDesc:setText(str)
self.Text:setText('单次寻访')
else
local str=FMT.fmt('{0}/{1}',haveNun,10)
if haveNun<10 then
str=toColorString(FONT_COLOR.eRedColor,str)
end
self.tenCostIcon:setImageIcon(iconName)
self.tenCostDesc:setText(str)
self.Text:setText('十连寻访')
end
end

function UIXianYuanXunFangRewardWin:initRewardView()
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

function UIXianYuanXunFangRewardWin:refreshItem(item,itemid,itemnum)
local countStr=''
local showCountBG=false
if itemnum>1 then
showCountBG=true
countStr=tostring(itemnum)
end
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)

local itemConfig=itemsConfig.getConfig(itemid)
item:SetChildText(2,itemConfig.name)
end

function UIXianYuanXunFangRewardWin:refreshItemNew(item,idx)
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
if isNew then
if not self.newDZIDlist then
self.newDZIDlist={}
end
self.newDZIDlist[#self.newDZIDlist+1]=itemid
end
end




function UIXianYuanXunFangRewardWin:playShow()
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
self:delayDo(delay,func2)
end

function UIXianYuanXunFangRewardWin:playEffect()
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
self:playItemEffect(item)
local func=function()
self:playEffectEnd()
end
self:delayDo(0.4,func)
else
self:playEffectEnd()
end
end
end

function UIXianYuanXunFangRewardWin:playItemEffect(item)
item:SetChildShowEffect(3,10164,true)
local func=function()
item:SetChildShowEffect(4,10165,true)
end
self:delayDo(0.5,func)
end

function UIXianYuanXunFangRewardWin:checkItem()
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

function UIXianYuanXunFangRewardWin:replay(itemid_,num,dzid)
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
self:playItemEffect(item)
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
local func=function()

AudioManager.playAudio(509)
self:refreshItem(item,itemid__,itemnum__)
end
self:delayDo(0.5,func)
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
self:delayDo(0.8,func)
end
end
end
end

function UIXianYuanXunFangRewardWin:playEffectEnd()
self.markDZClose=nil
self.curStep=self.curStep+1
if self.curStep<=self.rewardnum then
self:playEffect()
else
self:onFinish()
end
end

function UIXianYuanXunFangRewardWin:onFinish()
self.playingAnim=false
self:checkStartStory()
end

function UIXianYuanXunFangRewardWin:checkStartStory()
local targetItemID=nil
local dzid=nil
local min=1000
for i,v in ipairs(self.newDZIDlist or{})do
local itemid=v
local itemcfg=itemsConfig.getConfig(itemid)
local funcparam=itemcfg.funcparam
if funcparam then
local ftype=funcparam.type
if ftype==item_funtion_type.disciple and funcparam.isSpecial==true then
local checkflag,playCdn,storyBehaviorName=UIRecruitControl:checkAnimArgs(itemid)
if checkflag and#playCdn<min then
targetItemID=itemid
min=#playCdn
dzid=funcparam.discipleid
end
end
end
end
self.newDZIDlist=nil
if not targetItemID or not dzid then
return
end

local backArgs={id=xxx,args={}}
if not UIRecruitControl:checkStartStory(targetItemID,backArgs)then
local dzData=UIDiscipleModel:getDiscipleDataByDiziId_onlyFirst(dzid)
if not dzData then
dzData=UIDiscipleModel:getDiscipleDataByDiziId(dzid)
end
if dzData and dzData.discipleguid then
UIRecruitControl:showItemRecruitDiscipleWindow(targetItemID,dzData.discipleguid)
end
end
end





function UIXianYuanXunFangRewardWin:addNote(str)
table.insert(self.noteslist,str)
self:refreshNotes()
end

function UIXianYuanXunFangRewardWin:refreshNotes()
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



function UIXianYuanXunFangRewardWin:onClickItem(itemId,index,guid,attach)
if self.playingAnim==true then return end
if self.clickLock==true then return end
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eRight})
end

function UIXianYuanXunFangRewardWin:onAgainBtn()
if self.playingAnim==true then return end
if self.clickLock==true then return end
if self.clickLockTime then
if gameUtilityModel.getServerShortTime()<self.clickLockTime then
return
end
self.clickLockTime=nil
end

self.clickLock=true
if self.showType==1 then
UIManager:invokeUIMethod(self.parentWin,'useItem',1,1,2)
else
UIManager:invokeUIMethod(self.parentWin,'useItem',10,2,2)
end
end

function UIXianYuanXunFangRewardWin:clearClickLock(isclear)
self.clickLock=nil
if not isclear then
self.clickLockTime=gameUtilityModel.getServerShortTime()+self.lockTime
end
end

function UIXianYuanXunFangRewardWin:onShareBtn()

end

function UIXianYuanXunFangRewardWin:onFrameBG()
self:onClickClose()
end

function UIXianYuanXunFangRewardWin:onClickClose()
if self.playingAnim==true then
return
end

self:closeSelf()
end

function UIXianYuanXunFangRewardWin:rec_chouka()
self:refreshDesc()
end