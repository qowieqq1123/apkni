







def_class("UILingShouFangShengWin",UIWindowBase)









function UILingShouFangShengWin:bindComponents()

self.btnAdd=UIButton.get(self,0)
self.btnOneKey=UIButton.get(self,1)
self.cloud=UIObject.get(self,2)
self.dznumTxt=UIText.get(self,3)
self.entityPanel=UIObject.get(self,4)
self.noDZSign=UIObject.get(self,5)
self.roleListPanel=UIObject.get(self,6)
self.zhekouInfoBtn=UIButton.get(self,7)

self.btnAdd:setButtonClick(function()self:onBtnAdd()end)

self.btnOneKey:setButtonClick(function()self:onBtnOneKey()end)

self.zhekouInfoBtn:setButtonClick(function()self:onZhekouInfoBtn()end)



end


function UILingShouFangShengWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnAdd);self.btnAdd=nil;
_UIObject_release(self.btnOneKey);self.btnOneKey=nil;
_UIObject_release(self.cloud);self.cloud=nil;
_UIObject_release(self.dznumTxt);self.dznumTxt=nil;
_UIObject_release(self.entityPanel);self.entityPanel=nil;
_UIObject_release(self.noDZSign);self.noDZSign=nil;
_UIObject_release(self.roleListPanel);self.roleListPanel=nil;
_UIObject_release(self.zhekouInfoBtn);self.zhekouInfoBtn=nil;
end
















local _this




function UILingShouFangShengWin:onLoaded(...)
self:bindComponents()

_this=self

local maxKickoutOneTime=cfgHelper.get2(cfg_lingshoufangshengbaseconfig_get,1,'maxKickoutOneTime')
local maxShowKickout=cfgHelper.get2(cfg_lingshoufangshengbaseconfig_get,1,'maxShowKickout')
self.standPosScaleRate=cfgHelper.get2(cfg_lingshoufangshengbaseconfig_get,1,'standPosScaleRate')or 20
self.maxLimit=math.min(maxKickoutOneTime,maxShowKickout)

local pos=self:getChildCanvas(-1)
local defaultSortLayer=pos[1]
local defaultSortOrder=pos[2]


self.enterPosList={}
self.enityWidgetList={}
local posMinY=9999
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

local recv_19_107=function(lsGuidList)
if _this==nil then return end
_this:rec_kickout(lsGuidList)
end
self:addProNotify(19,107,recv_19_107)
end


function UILingShouFangShengWin:__delete()
UIManager:closeWindow('UITopMoneyWin')
if self.cloud_guid~=nil then
self:setChildRemoveExpandUI(-1,self.cloud_guid)
self.cloud_guid=nil
end
_this=nil
self:clearAllEntity()

self:unbindComponents()
end




function UILingShouFangShengWin:onShow(argtable,afterOnloaded)
self.lsSelectList={}
self.lsSelectLookup={}

self:refreshView()
self:initAllEntity()
end


function UILingShouFangShengWin:onHide()

end



function UILingShouFangShengWin:showTopMoney()
UIManager:showWindow('UITopMoneyWin',{{eMoneyType.mtChenYuan},{eMoneyType.mtXianYuan}})
end

function UILingShouFangShengWin:initAllEntity()
for idx,entityWidget in ipairs(self.enityWidgetList)do
local dzData=self.lsSelectList[idx]
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

function UILingShouFangShengWin:initEnity(guid,idx)
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
local lsData=lingshouModel:getLingShouData2(guid)

local posFlipXList=cfgHelper.get2(cfg_lingshoufangshengbaseconfig_get,1,'posFlipXList')
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



local lscfg=lsData.cfg
entityWidget:SetChildUIModelRemoveTarget(0)
local modelParams=lingshouModel.getModelParamsEx(lscfg.model)

local scale=lscfg.modelScale
if not scale then
scale=isometricMapSystem:getModelScale(lscfg.model,true)
end

scale=scale*0.45
if scale<0.5 then
scale=0.5
end
entityWidget:SetChildUIModelShowTarget(0,modelParams.body,scale,modelParams.componets,0,false,true)

entityWidget:SetChildUIModelShowFlipX(0,b_flipx)


local entData={}
entData.guid=guid
entData.index=idx
self.posDataLookup[idx]=entData
self:doDZIdle(entData)
end

function UILingShouFangShengWin:removeEntity(idx)
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

function UILingShouFangShengWin:getDZPosIndex(guid)
for idx,entData in pairs(self.posDataLookup)do
if mathHelper.compareInt64(entData.guid,guid)then
return idx
end
end
return nil
end

function UILingShouFangShengWin:clearAllEntity()
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

function UILingShouFangShengWin:doDZIdle(entData)
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
offset={10,90},
}
entData.bt=behaviorManager:addBehaviorTree('bt_ui_lingshou_kickout_idle',nil,true,initData)
end


function UILingShouFangShengWin:idleSpeak(bt,tkey)


local idleTalkList=cfgHelper.get2(cfg_lingshoufangshengbaseconfig_get,1,'idleTalkList')
local str=table.randomIndex(idleTalkList)

bt:setSharedVar(tkey,str)
end


function UILingShouFangShengWin:doAllDZLeave(lsGuidList)
local waitLeaveTime=0
self.lockClick=0
for idx,entData in pairsBySortKey(self.posDataLookup)do
self:doDZLeave(entData,waitLeaveTime)
waitLeaveTime=waitLeaveTime+1
self.lockClick=self.lockClick+1
end
end

function UILingShouFangShengWin:doDZLeave(entData,waitLeaveTime)
if entData.bt then
behaviorManager:removeBehaviorTree(entData.bt)
entData.bt=nil
end
local leaveShow=cfgHelper.get2(cfg_lingshoufangshengbaseconfig_get,1,'leaveShow')
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
offset={10,90},
}
local bt=behaviorManager:addBehaviorTree('bt_ui_lingshou_kickout_leave',nil,true,initData)
bt:setSharedVar('UIstateId',stateId)
entData.bt=bt
end


function UILingShouFangShengWin:levelBack(idx)
local entData=self.posDataLookup[idx]
if entData==nil then return end

if entData.bt then
behaviorManager:removeBehaviorTree(entData.bt)
entData.bt=nil
end
self.posDataLookup[idx]=nil
self.lockClick=self.lockClick-1

end


function UILingShouFangShengWin:levelSpeak(bt,tkey)


local leaveShow=cfgHelper.get2(cfg_lingshoufangshengbaseconfig_get,1,'leaveShow')
local talklist=leaveShow[5]
local str=table.randomIndex(talklist)

bt:setSharedVar(tkey,str)
end

function UILingShouFangShengWin:doTalkAnim(entData,str,time)
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



function UILingShouFangShengWin:refreshView()
local num=#self.lsSelectList
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

function UILingShouFangShengWin:refreshRoleItem(item,idx)
if item==nil then
item=self.roleListPanel:getChildLayoutGroupGridItem(idx-1)
end

local data=self.lsSelectList[idx]
local guid=data[1]
local color=data[2]
local lsData=lingshouModel:getLingShouData2(guid)



comHelper.setChildModelHeadIconBGByColor(item,0,color)


comHelper.setChildModelRawImage_lingshou(item,lsData.id,1,0,eHeadCenterType.eHead,1,nil)

local name=lsData.name or lsData.cfg.name
item:SetChildText(2,name)

local state_str=lingshouModel:getStateName(guid)
item:SetChildText(3,state_str)

local func=function()
self:onItemSubClick(idx)
end
item:SetChildButtonClick(4,func,true)
end

function UILingShouFangShengWin:onItemSubClick(idx)
local data=self.lsSelectList[idx]
local guid=data[1]
local guid_str=tostring(guid)
self.lsSelectLookup[guid_str]=nil
table.remove(self.lsSelectList,idx)
UIManager.info('移除成功')
self:refreshView()

local entIdx=self:getDZPosIndex(guid)
if entIdx then
local f=false
for i,data_ in ipairs(self.lsSelectList)do
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

function UILingShouFangShengWin:onBtnAdd()
if self.lockClick~=nil and self.lockClick>0 then return end
local extraParams={}
extraParams.lsSelectLookup=table.deepCopy(self.lsSelectLookup)
extraParams.onSelectFunc=function(lsSelectLookup_)
if _this==nil then return end
_this:onSelectFunc(lsSelectLookup_)
end

local winParams={
titleName='灵兽放生',
extraWin='UIKickoutLSSelectWin',
extraParams=extraParams,
}
UIManager:showWindow('UICommonDragonBoneWin',winParams)
end

function UILingShouFangShengWin:onSelectFunc(lsSelectLookup_)
local change=false
for guid_str,guid in pairs(lsSelectLookup_)do
local isSelect1=guid~=nil
local isSelect2=self.lsSelectLookup[guid_str]~=nil
if isSelect1~=isSelect2 then
change=true
end
end
for guid_str,guid in pairs(self.lsSelectLookup)do
local isSelect1=guid~=nil
local isSelect2=lsSelectLookup_[guid_str]~=nil
if isSelect1~=isSelect2 then
change=true
end
end
if change then
UIManager.info('选择成功')

self.lsSelectLookup=lsSelectLookup_
self.lsSelectList={}
for guid_str,guid in pairs(lsSelectLookup_)do
if guid then
local color=lingshouModel:getColor(guid)
table.insert(self.lsSelectList,{guid,color})
end
end
if#self.lsSelectList>1 then
table.sort(self.lsSelectList,function(a,b)
return a[2]>b[2]
end)
end
self:initAllEntity()
end

self:refreshView()
end

function UILingShouFangShengWin:onBtnOneKey()
if self.lockClick~=nil and self.lockClick>0 then return end
local num=#self.lsSelectList
if num<=0 then return end

local lsGuidList={}
for i,data in ipairs(self.lsSelectList)do
table.insert(lsGuidList,data[1])
end


local desc='确定要将灵兽进行放生吗？'


local isShowDownText=false
local rewards=lingshouModel:getKickoutRewards(lsGuidList)
if#rewards<=0 then
rewards=nil
end
local dofunc=function()
local args={
title='灵兽放生',
downText=isShowDownText and'专业技能经验返还最低比例：<color=#d4852e>4%</color>'or nil,
desc1=desc,
desc2=nil,
rewards=rewards,
rewardTitle='宗门将获得以下补偿',
showCancel=false,
cancelName=nil,
commitName='确认',
cancelCB=nil,
guid=nil,
commitCB=function()
lingshouController:reqKickOutLingShou(lsGuidList)
end,
}
UIManager:showWindow('UIDialougeRewardWin',args)
end



local hasRedTip=false
for _,a in ipairs(lsGuidList)do
local pinzhi=lingshouModel:getColor(a)
if pinzhi>=5 then
hasRedTip=true
break
end
end

if hasRedTip then

local content="放生的灵兽中有<color=#c82c2c>红色灵兽</color>极为珍贵，且可用于繁衍，确定要放生吗？"
UIDialogManager.getConfirmDialog3(nil,content,dofunc,REPEAT_TYPE.eLingShouFangShengPinzhiTiXing)
else
dofunc()
end

end


function UILingShouFangShengWin:listToLookup(list)
local lookup={}
if not list then return lookup end
for _,r in ipairs(list)do
local id,val
if type(r)=="table"then
if r.param_1 and r.param_2 then
id,val=r.param_1,r.param_2
elseif r[1]and r[2]then
id,val=r[1],r[2]
elseif r.id and r.val then
id,val=r.id,r.val
end
end
if id and val then
lookup[id]=(lookup[id]or 0)+val
end
end
return lookup
end

function UILingShouFangShengWin:rec_kickout(lsGuidList)
self.lsSelectList={}
self.lsSelectLookup={}

self:refreshView()

self:doAllDZLeave(lsGuidList)
end

function UILingShouFangShengWin:rec_kickoutFail()
self.lsSelectList={}
self.lsSelectLookup={}

self:refreshView()

self:clearAllEntity()
end

function UILingShouFangShengWin:refreshZheKouInfoImg()

end

function UILingShouFangShengWin:onZhekouInfoBtn()






local d={}
d.title='规则说明'
d.mode=3
d.name='UILingShouFangShengWin_rule_%d'
d.showBlack=true




UIManager:showWindow('UIRuleWin',d)
end
