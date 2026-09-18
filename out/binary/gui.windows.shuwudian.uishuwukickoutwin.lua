







def_class("UIShuWuKickoutWin",UIWindowBase)









function UIShuWuKickoutWin:bindComponents()

self.entityPanel=UIObject.get(self,0)
self.dznumTxt=UIText.get(self,1)
self.noDZSign=UIObject.get(self,2)
self.roleListPanel=UIObject.get(self,3)
self.btnAdd=UIButton.get(self,4)
self.btnOneKey=UIButton.get(self,5)
self.cloud=UIObject.get(self,6)
self.zhekouInfoBtn=UIButton.get(self,7)

self.btnAdd:setButtonClick(function()self:onBtnAdd()end)

self.btnOneKey:setButtonClick(function()self:onBtnOneKey()end)

self.zhekouInfoBtn:setButtonClick(function()self:onZhekouInfoBtn()end)



end


function UIShuWuKickoutWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.entityPanel);self.entityPanel=nil;
_UIObject_release(self.dznumTxt);self.dznumTxt=nil;
_UIObject_release(self.noDZSign);self.noDZSign=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.btnAdd);self.btnAdd=nil;
_UIObject_release(self.btnOneKey);self.btnOneKey=nil;
_UIObject_release(self.cloud);self.cloud=nil;
_UIObject_release(self.zhekouInfoBtn);self.zhekouInfoBtn=nil;
end
















local _this




function UIShuWuKickoutWin:onLoaded(...)
_this=self
self:bindComponents()

local maxKickoutOneTime=cfgHelper.get2(cfg_disciplekickoutconfig_get,1,'maxKickoutOneTime')
local maxShowKickout=cfgHelper.get2(cfg_disciplekickoutconfig_get,1,'maxShowKickout')
self.standPosScaleRate=cfgHelper.get2(cfg_disciplekickoutconfig_get,1,'standPosScaleRate')or 20
self.maxLimit=math.min(maxKickoutOneTime,maxShowKickout)

local pos=self:getChildCanvas(-1)
local defaultSortLayer=pos[1]
local defaultSortOrder=pos[2]


self.enterPosList={}
self.enityWidgetList={}
local posMinY=9999.0
local entityPanelWidget=self.entityPanel:getWidgetBase()
for i=1,self.maxLimit do
local entityWidget=entityPanelWidget:GetChildWidgetBase(i-1)
self.enityWidgetList[i]=entityWidget
local pos=entityWidget:GetChildAnchoredPosition(-1)
self.enterPosList[i]=pos
if pos.y<posMinY then
posMinY=pos.y
end
entityWidget:SetChildCanvas(1,defaultSortLayer,defaultSortOrder+1)
end
self.posDataLookup={}
self.posMinY=posMinY
self.jumpYRange={posMinY-5,posMinY+5}


local func=function(id)
local widget=self:getChildExpandUI(-1,id)
if widget then
local pos=self:getChildCanvas(-1)
local sortLayer=pos[1]
local sortOrder=pos[2]
widget:SetChildCanvas(-1,sortLayer,sortOrder+3)
end
end
self.cloud_guid=self:setChildGreateExpandUI(-1,self.cloud:getID(),INSTANCE_TYPE.eCommonCloudUIExpand,func)

self:showTopMoney()
end

function UIShuWuKickoutWin:showTopMoney()
UIManager:showWindow('UITopMoneyWin',{{eMoneyType.mtChenYuan},{eMoneyType.mtXianYuan}})
end


function UIShuWuKickoutWin:__delete()
UIManager:closeWindow('UITopMoneyWin')
if self.cloud_guid~=nil then
self:setChildRemoveExpandUI(-1,self.cloud_guid)
self.cloud_guid=nil
end
_this=nil
self:unbindComponents()
self:clearAllEntity()
end


function UIShuWuKickoutWin:onHide()

end




function UIShuWuKickoutWin:onShow(argtable,afterOnloaded)
self.dzSelectList={}
self.dzSelectLookup={}

self:refreshView()
self:initAllEntity()
end



function UIShuWuKickoutWin:initAllEntity()
for idx,entityWidget in ipairs(self.enityWidgetList)do
local dzData=self.dzSelectList[idx]
local guid
if dzData then
guid=dzData[1]
end
if guid then
self:initEnity(guid,idx)
else
self:removeEntity(idx)
end
end
end

function UIShuWuKickoutWin:initEnity(guid,idx)
local old_entData=self.posDataLookup[idx]
local isSame=false
if old_entData~=nil and mathHelper.compareInt64(old_entData.guid,guid)then
isSame=true
end

if isSame then
return
end

if old_entData~=nil then
self:removeEntity(idx)
end

local posFlipXList=cfgHelper.get2(cfg_disciplekickoutconfig_get,1,'posFlipXList')
local flipx=posFlipXList[idx]or 0
local b_flipx
if flipx==0 then
b_flipx=false
else
b_flipx=true
end
local entityWidget=self.enityWidgetList[idx]
local pos=self.enterPosList[idx]
entityWidget:SetChildAnchoredPosition(0,pos)
entityWidget:SetChildCanvasGroupAlpha(0,1)
local offsetX=0
local fadeIn=0.6
local scale=1
local lerpY=pos.y-self.posMinY
local posRate=self.standPosScaleRate
if lerpY<0 then lerpY=0 end
local scale_rate=1.0-lerpY/posRate/posRate
if scale_rate<0.1 then
scale_rate=0.1
else
scale_rate=mathHelper.decimal(scale_rate,1)
end
scale=scale*scale_rate
comHelper.setChildHead(entityWidget,guid,0,1,offsetX,nil,false,nil,fadeIn)

entityWidget:SetChildUIModelShowFlipX(0,b_flipx)
entityWidget:SetChildScale(0,Vector3(scale,scale,scale))

local entData={}
entData.guid=guid
entData.index=idx
self.posDataLookup[idx]=entData
self:doDZIdle(entData)
end

function UIShuWuKickoutWin:removeEntity(idx)
local entityWidget=self.enityWidgetList[idx]
local oldData=self.posDataLookup[idx]
if oldData~=nil then
if oldData.bt then
behaviorManager:removeBehaviorTree(oldData.bt)
oldData.bt=nil
end
entityWidget:SetChildUIModelRemoveTarget(0)
self.posDataLookup[idx]=nil
end
end

function UIShuWuKickoutWin:getDZPosIndex(guid)
for idx,entData in pairs(self.posDataLookup)do
if mathHelper.compareInt64(entData.guid,guid)then
return idx
end
end
return nil
end

function UIShuWuKickoutWin:clearAllEntity()
if self.posDataLookup~=nil then
for idx,entData in pairsBySortKey(self.posDataLookup)do
local entityWidget=self.enityWidgetList[idx]
if entData.bt then
behaviorManager:removeBehaviorTree(entData.bt)
entData.bt=nil
end
entityWidget:SetChildUIModelRemoveTarget(0)
end
self.posDataLookup={}
end
end

function UIShuWuKickoutWin:doDZIdle(entData)
if entData.bt then
behaviorManager:removeBehaviorTree(entData.bt)
entData.bt=nil
end
local idx=entData.index
local entityWidget=self.enityWidgetList[idx]
local initData={
dzWidget=entityWidget,
dzIndex=0,
tkIndex=1,
entIndex=idx,
}
entData.bt=behaviorManager:addBehaviorTree('bt_ui_shuwudian_kickout_idle',nil,true,initData)
end


function UIShuWuKickoutWin:idleSpeak(bt,tkey)


local idleTalkList=cfgHelper.get2(cfg_disciplekickoutconfig_get,1,'idleTalkList')
local str=table.randomIndex(idleTalkList)

bt:setSharedVar(tkey,str)
end


function UIShuWuKickoutWin:doAllDZLeave(discipleList)
local waitLeaveTime=0
self.lockClick=0
for idx,entData in pairsBySortKey(self.posDataLookup)do
self:doDZLeave(entData,waitLeaveTime)
waitLeaveTime=waitLeaveTime+1
self.lockClick=self.lockClick+1
end
end

function UIShuWuKickoutWin:doDZLeave(entData,waitLeaveTime)
if entData.bt then
behaviorManager:removeBehaviorTree(entData.bt)
entData.bt=nil
end
local leaveShow=cfgHelper.get2(cfg_disciplekickoutconfig_get,1,'leaveShow')
local idx=entData.index
local entityWidget=self.enityWidgetList[idx]
local zeroPosX=leaveShow[1]
local entPos=entityWidget:GetChildLocalPosition(0)
local stateId=1
if entPos.y>=self.jumpYRange[1]and entPos.y<=self.jumpYRange[2]then
stateId=0
end
local isLeft=entPos.x<=zeroPosX
local zeroPosY=entPos.y
local zeroPos={zeroPosX,zeroPosY}
local jumpPosX=zeroPosX
local jumpPosY=leaveShow[2]
local jumpPos={jumpPosX,jumpPosY}
local bottomPosX=zeroPosX
local bottomPosY=leaveShow[3]
local bottomPos={bottomPosX,bottomPosY}
local endPosXList=leaveShow[4]
local endPosX
if isLeft then
endPosX=endPosXList[2]
else
endPosX=endPosXList[1]
end
local endPosY=bottomPosY
local endPos={endPosX,endPosY}
local initData={
dzWidget=entityWidget,
dzIndex=0,
tkIndex=1,
entIndex=idx,
waitLeaveTime=waitLeaveTime,
zeroPos=zeroPos,
jumpPos=jumpPos,
bottomPos=bottomPos,
endPos=endPos,
}
local bt=behaviorManager:addBehaviorTree('bt_ui_shuwudian_kickout_leave',nil,true,initData)
bt:setSharedVar('UIstateId',stateId)
entData.bt=bt
end


function UIShuWuKickoutWin:levelBack(idx)
local entData=self.posDataLookup[idx]
if entData==nil then return end

if entData.bt then
behaviorManager:removeBehaviorTree(entData.bt)
entData.bt=nil
end
self.posDataLookup[idx]=nil
self.lockClick=self.lockClick-1

end


function UIShuWuKickoutWin:levelSpeak(bt,tkey)


local leaveShow=cfgHelper.get2(cfg_disciplekickoutconfig_get,1,'leaveShow')
local talklist=leaveShow[5]
local str=table.randomIndex(talklist)

bt:setSharedVar(tkey,str)
end

function UIShuWuKickoutWin:doTalkAnim(entData,str,time)
if entData.talkTween~=nil then
entData.talkTween:Kill()
entData.talkTween=nil
end
if entData.talkCloseTimer then
self:stopTimerByID(entData.talkCloseTimer)
entData.talkCloseTimer=nil
end
local idx=entData.index
local entityWidget=self.enityWidgetList[idx]
entityWidget:SetChildText(2,str)
entityWidget:SetChildActive(1,true)
entityWidget:SetChildScale(1,Vector3.zero)

entData.talkTween=entityWidget:SetChildDOScale(1,1.2,0.2,function()
if _this==nil then return end
entData.talkTween=nil
entData.talkTween=entityWidget:SetChildDOScale(1,1,0.1,function()
if _this==nil then return end
entData.talkTween=nil
end)
end)

entData.talkCloseTimer=self:delayDo(time,function()
entData.talkCloseTimer=nil
entityWidget:SetChildActive(1,false)
end)
end



function UIShuWuKickoutWin:refreshView()
local num=#self.dzSelectList
local hasman=num>0


self.dznumTxt:setActive(hasman)
if hasman then
self.dznumTxt:setText(tostring(num))
end

self.noDZSign:setActive(not hasman)

self.btnOneKey:setActive(hasman)


self.roleListPanel:setChildLayoutGroupCreateItems(num)
if hasman then
local grids=self.roleListPanel:getChildLayoutGroupGridList()
for i=1,num do
local item=grids[i-1]
self:refreshRoleItem(item,i)
end
end
end

function UIShuWuKickoutWin:refreshRoleItem(item,idx)
if item==nil then
item=self.roleListPanel:getChildLayoutGroupGridItem(idx-1)
end

local data=self.dzSelectList[idx]
local guid=data[1]
local color=data[2]



comHelper.setChildModelHeadIconBGByColor(item,0,color)

comHelper.setChildModelRawImage(item,guid,1,0,eHeadCenterType.eHead)

item:SetChildText(2,UIDiscipleModel:getDiscipleName(guid))

local state_str=UIDiscipleModel:getDiscipleStateDesc(guid,' ')
item:SetChildText(3,state_str)

local func=function()
self:onItemSubClick(idx)
end
item:SetChildButtonClick(4,func,true)
end

function UIShuWuKickoutWin:onItemSubClick(idx)
local data=self.dzSelectList[idx]
local guid=data[1]
local guid_str=tostring(guid)
self.dzSelectLookup[guid_str]=nil
table.remove(self.dzSelectList,idx)
UIManager.info('移除成功')
self:refreshView()

local entIdx=self:getDZPosIndex(guid)
if entIdx then
local f=false
for i,data_ in ipairs(self.dzSelectList)do
local guid_=data_[1]
local entIdx_=self:getDZPosIndex(guid_)
if entIdx_==nil then
f=true
self:initEnity(guid_,entIdx)
break
end
end
if not f then
self:removeEntity(entIdx)
end
end

end

function UIShuWuKickoutWin:onBtnAdd()
if self.lockClick~=nil and self.lockClick>0 then return end
local extraParams={}
extraParams.dzSelectLookup=table.deepCopy(self.dzSelectLookup)
extraParams.onSelectFunc=function(dzSelectLookup_)
if _this==nil then return end
_this:onSelectFunc(dzSelectLookup_)
end

local winParams={
titleName='选择弟子',
extraWin='UIKickoutDZSelectWin',
extraParams=extraParams,
}
UIManager:showWindow('UICommonDragonBoneWin',winParams)
end

function UIShuWuKickoutWin:onSelectFunc(dzSelectLookup_)
local change=false
for guid_str,guid in pairs(dzSelectLookup_)do
local isSelect1=guid~=nil
local isSelect2=self.dzSelectLookup[guid_str]~=nil
if isSelect1~=isSelect2 then
change=true
end
end
for guid_str,guid in pairs(self.dzSelectLookup)do
local isSelect1=guid~=nil
local isSelect2=dzSelectLookup_[guid_str]~=nil
if isSelect1~=isSelect2 then
change=true
end
end
if change then
UIManager.info('选择成功')

self.dzSelectLookup=dzSelectLookup_
self.dzSelectList={}
for guid_str,guid in pairs(dzSelectLookup_)do
if guid then
local color=UIDiscipleModel:getDiscipleColor(guid)
table.insert(self.dzSelectList,{guid,color})
end
end
if#self.dzSelectList>1 then
table.sort(self.dzSelectList,function(a,b)
return a[2]>b[2]
end)
end
self:initAllEntity()
end

self:refreshView()
end

function UIShuWuKickoutWin:onBtnOneKey()
if self.lockClick~=nil and self.lockClick>0 then return end
local num=#self.dzSelectList
if num<=0 then return end

local dis_list={}
for i,data in ipairs(self.dzSelectList)do
table.insert(dis_list,data[1])
end
local rewards=UIDiscipleModel:getKickoutRewards(dis_list)
local desc='确定要将弟子逐出宗门吗？'
if#rewards<=0 then
rewards=nil
end
local isShowDownText=false
for i,v in ipairs(rewards)do
local itemCfg=itemsConfig.getConfig(v[1])
if itemCfg.type1==itemtype1Type.eZYBJ then
isShowDownText=true
break
end
end
local args={
title='逐出宗门',
downText=isShowDownText and'专业技能经验返还最低比例：<color=#d4852e>4%</color>'or nil,
desc1=desc,
desc2=nil,
rewards=rewards,
rewardTitle='宗门将获得以下补偿',
showCancel=false,
cancelName=nil,
commitName='逐出',
cancelCB=nil,
commitCB=function()
UIDiscipleController:reqKickoutEx(dis_list,true)
end,
}
UIManager:showWindow('UIDialougeRewardWin',args)
end

function UIShuWuKickoutWin:rec_kickout(discipleList)
self.dzSelectList={}
self.dzSelectLookup={}

self:refreshView()

self:doAllDZLeave(discipleList)
end

function UIShuWuKickoutWin:rec_kickoutFail()
self.dzSelectList={}
self.dzSelectLookup={}

self:refreshView()

self:clearAllEntity()
end

function UIShuWuKickoutWin:refreshZheKouInfoImg()

end

function UIShuWuKickoutWin:onZhekouInfoBtn()






local d={}
d.title='规则说明'
d.mode=3
d.name='UIShuWuKickoutWin_rule_%d'
d.showBlack=true




UIManager:showWindow('UIRuleWin',d)
end
