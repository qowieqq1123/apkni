







def_class("UIXianZhangBaoXiaFPWin",UIWindowBase)









function UIXianZhangBaoXiaFPWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.desc=UIText.get(self,1)
self.timeTxt=UIText.get(self,2)
self.skilDesc=UIObject.get(self,3)
self.root=UIObject.get(self,4)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXianZhangBaoXiaFPWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.timeTxt);self.timeTxt=nil;
_UIObject_release(self.skilDesc);self.skilDesc=nil;
_UIObject_release(self.root);self.root=nil;
end
















local _this
local abname="ui/windows/xianzhangbaoxia/xianzhangbaoxia_atlas_pak.ab"
local bigitemidx=
{
itemself=0,
toppanel=1,
bottompanel=2,
icon=3,
name=4,
num=5,
bigrewards=6,
fenpaibtn=7,
rewardView=8,
}
local bottomitemidx=
{
itemself=0,
txt=1,
btn=2,
panelone=3,
paneltwo=4,
rewardone=5,
rewardtwo=6
}
local stateFlag=
{
none=-1,
close=0,
open=1
}



function UIXianZhangBaoXiaFPWin:onLoaded(...)
self:bindComponents()
_this=self
self.list={}
self.stetalist={}
self.memberListLook={}
self.isBXEnd=false
end


function UIXianZhangBaoXiaFPWin:__delete()
self:unbindComponents()
self:stopSelfTimer()
_this=nil
end


function UIXianZhangBaoXiaFPWin:onHeadItemClick(actorKey)
local memberData=self.memberListLook[actorKey]
if memberData then
local actorData=memberData.netData
local myActorid=playerModel:getActorID()
if not mathHelper.compareInt64(myActorid,actorData.actorid)then
otherPlayerController:openOtherPlayerInfoWin(actorData.actorid,nil,actorInterFromType.eXianMeng)
end
end
end

function UIXianZhangBaoXiaFPWin:onShowClick(index)
local bigitem=self.skilDesc:getChildLayoutGroupGridItem(index-1)
local bottomitem=bigitem:GetChildWidgetBase(bigitemidx.bottompanel)
local flag=self.stetalist[index]
if flag==stateFlag.none then
bottomitem:SetChildRotation(bottomitemidx.btn,0,0,180)
bottomitem:SetChildActive(bottomitemidx.panelone,false)
bottomitem:SetChildActive(bottomitemidx.paneltwo,true)

local itemList=self.itemList[index]
local assignList=itemList.assignList
if assignList then
local assignlen=#assignList
bottomitem:SetChildLayoutGroupCreateItems(bottomitemidx.rewardtwo,assignlen,function(index2)
local headitem2=bottomitem:GetChildLayoutGroupGridItem(bottomitemidx.rewardtwo,index2-1)
local assignData=assignList[index2]
local dstActorId=assignData.dstActorId
local actorKey=tostring(dstActorId)
local memberData=self.memberListLook[actorKey]
if memberData then
local actorData=memberData.netData
headitem2:SetChildText(4,actorData.actorname)
local postType=actorData.pos
local postName=xianmengModel.getXMPostName(postType,true)
headitem2:SetChildText(5,postName)

playerController:setHeadIcon(headitem2,2,{iconInfo=actorData.iconInfo,scale=0.68})
headitem2:SetChildButtonClick(1,function()
if _this==nil then return end
self:onHeadItemClick(actorKey)
end)
end
end)
end
self.stetalist[index]=stateFlag.open

elseif flag==stateFlag.open then
bottomitem:SetChildRotation(bottomitemidx.btn,0,0,0)
bottomitem:SetChildActive(bottomitemidx.panelone,true)
bottomitem:SetChildActive(bottomitemidx.paneltwo,false)
self.stetalist[index]=stateFlag.close

elseif flag==stateFlag.close then
bottomitem:SetChildRotation(bottomitemidx.btn,0,0,180)
bottomitem:SetChildActive(bottomitemidx.panelone,false)
bottomitem:SetChildActive(bottomitemidx.paneltwo,true)

self.stetalist[index]=stateFlag.open
end
end

function UIXianZhangBaoXiaFPWin:onFenPeiClick(index)

self:showWindow('UIXianZhangBaoXiaChooseWin',{guid=self.bx_guid,index=index})
end





function UIXianZhangBaoXiaFPWin:onShow(argtable,afterOnloaded)
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.4,nil)
local bxguid=argtable.guid
if bxguid then
self.bx_guid=bxguid
self.bx_list=XianMengBaoXiaModel:getXZBXDataByGuid(bxguid)
self.itemList=self.bx_list.itemList
self:setMemberCheckList()
self.isXZ=XianMengBaoXiaController:isMengZhu()

local timeend=self.bx_list.expireTime
local stamp=timeHelper.getServerShortTime()
self.isBXEnd=stamp>timeend

self:freshlist()
self:startTimer()
end
end


function UIXianZhangBaoXiaFPWin:onHide()

end
function UIXianZhangBaoXiaFPWin:onCloseBtn()
self:closeSelf()
end

function UIXianZhangBaoXiaFPWin:startTimer()
self:stopSelfTimer()
local str=''
local endsec=self.bx_list.expireTime
local func=function()
local stamp=timeHelper.getServerShortTime()
if endsec>stamp then
str=FMT.fmt('距离过期：{0}',timeHelper.format_time_stamp(endsec-stamp))
self.timeTxt:setText(str)
else
self:stopSelfTimer()
UIManager.info('宝匣已过期')



local itemList=self.itemList
for index,v in ipairs(itemList)do
local bigitem=self.skilDesc:getChildLayoutGroupGridItem(index-1)
bigitem:SetChildActive(bigitemidx.fenpaibtn,false)
end
local win=UIManager:findActiveWindow('UIXianZhangBaoXiaChooseWin')
if win then
win:onCloseBtn()
end
end
end
func()
self.timer=self:setTimer(1,0,func)
end
function UIXianZhangBaoXiaFPWin:stopSelfTimer()
if self.timer then
self:stopTimerByID(self.timer)
end
self.timer=nil
end

function UIXianZhangBaoXiaFPWin:setMemberCheckList()
local list=xianmengModel:getXMMemberList()
local temp={}
for i,v in ipairs(list)do






local d={netData=v,actorid=v.actorid}
temp[tostring(v.actorid)]=d
end
self.memberListLook=temp

end


function UIXianZhangBaoXiaFPWin:freshsever(bxguid)

self.bx_list=XianMengBaoXiaModel:getXZBXDataByGuid(self.bx_guid)
self.itemList=self.bx_list.itemList

local timeend=self.bx_list.expireTime
local stamp=timeHelper.getServerShortTime()
self.isBXEnd=stamp>timeend
self:freshlist()

end


function UIXianZhangBaoXiaFPWin:freshlist()
local itemList=self.itemList
local dataNum=#itemList
if dataNum>0 then
self.skilDesc:setChildLayoutGroupCreateItems(dataNum,function(index)
self:refreshSingleBtn(index)
end)
end
end
function UIXianZhangBaoXiaFPWin:refreshSingleBtn(index)
local bigitem=self.skilDesc:getChildLayoutGroupGridItem(index-1)
local itemList=self.itemList[index]
local bxitemid=itemList.itemId
local assignList=itemList.assignList
local itemNum=itemList.itemNum
local itemNum2=itemList.itemNum2
local itemConfig=itemsConfig.getConfig(bxitemid)
self.stetalist[index]=stateFlag.none


bigitem:SetChildText(bigitemidx.name,itemConfig.name)
bigitem:SetChildText(bigitemidx.num,FMT.fmt("数量：<color=#ca631d>{0}/{1}</color>",itemNum2,itemNum))
local iconname=iconHelper.getIconName(bxitemid)
bigitem:SetChildIcon(bigitemidx.icon,iconname,false)


local sm_rewardList={}
local funcparam=itemConfig and itemConfig.funcparam or nil
if funcparam then
local funType=funcparam.type
if funType==item_funtion_type.eBaoXiang or funType==item_funtion_type.eXMZengLi then

local dropId=98473


local dropCfg=cfgHelper.get1(cfg_awardconfig_get,dropId)
local reward=dropCfg.showItems
if reward and next(reward)then
sm_rewardList=reward
end
end
end

local sm_len=#sm_rewardList
if sm_len<5 then
bigitem:SetChildScrollRectEnable(bigitemidx.rewardView,false)
end
if sm_len>0 then
bigitem:SetChildLayoutGroupCreateItems(bigitemidx.bigrewards,sm_len,function(index1)
local sm_item=bigitem:GetChildLayoutGroupGridItem(bigitemidx.bigrewards,index1-1)
local sm_reward=sm_rewardList[index1]
local sm_itemid=sm_reward[1]
local sm_count=sm_reward[2]
local showCountBG=sm_count>1
local countStr=showCountBG and mathHelper.formatNumber(sm_count)or""
local itemConf={itemid=sm_itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local itemProp=itemsComponentHelper.getCommonFillDataSmall(itemConf)
sm_item:SetChildPropData(0,itemProp)
sm_item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClickEx)
end)
end


if self.isXZ and not self.isBXEnd then
bigitem:SetChildActive(bigitemidx.fenpaibtn,true)
bigitem:SetChildButtonClick(bigitemidx.fenpaibtn,function()
if _this==nil then return end
self:onFenPeiClick(index)
end)
else
bigitem:SetChildActive(bigitemidx.fenpaibtn,false)
end


local bottomitem=bigitem:GetChildWidgetBase(bigitemidx.bottompanel)
if assignList then
bigitem:SetChildActive(bigitemidx.bottompanel,true)
local flag=self.stetalist[index]
if flag==stateFlag.none then
bottomitem:SetChildRotation(bottomitemidx.btn,0,0,0)
bottomitem:SetChildActive(bottomitemidx.panelone,true)
bottomitem:SetChildActive(bottomitemidx.paneltwo,false)


local assignlen=#assignList
bottomitem:SetChildLayoutGroupCreateItems(bottomitemidx.rewardone,assignlen,function(index2)
local headitem=bottomitem:GetChildLayoutGroupGridItem(bottomitemidx.rewardone,index2-1)
local assignData=assignList[index2]
local dstActorId=assignData.dstActorId
local actorKey=tostring(dstActorId)
local memberData=self.memberListLook[actorKey]
if memberData then
local actorData=memberData.netData
playerController:setHeadIcon(headitem,0,{iconInfo=actorData.iconInfo,scale=0.68})
end
end)


bottomitem:SetChildButtonClick(bottomitemidx.btn,function()
if _this==nil then return end
self:onShowClick(index)
end)
else
bottomitem:SetChildRotation(bottomitemidx.btn,0,0,180)
bottomitem:SetChildActive(bottomitemidx.panelone,false)
bottomitem:SetChildActive(bottomitemidx.paneltwo,true)
end
else
bigitem:SetChildActive(bigitemidx.bottompanel,false)
end
end
