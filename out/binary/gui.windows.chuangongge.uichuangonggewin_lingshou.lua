







def_class("UIChuanGongGeWin_LingShou",UIWindowBase)









function UIChuanGongGeWin_LingShou:bindComponents()

self.applyBtn=UIButton.get(self,0)
self.arrow=UIObject.get(self,1)
self.bgA=UIObject.get(self,2)
self.bgB=UIObject.get(self,3)
self.btnpanel=UIObject.get(self,4)
self.chuangongSpine=UIObject.get(self,5)
self.click=UIObject.get(self,6)
self.costIcon=UIObject.get(self,7)
self.costValue=UIText.get(self,8)
self.dzRootA=UIObject.get(self,9)
self.dzRootB=UIObject.get(self,10)
self.effect=UIObject.get(self,11)
self.forget=UIToggleButton.get(self,12)
self.freeBtn=UIButton.get(self,13)
self.freeList=UIObject.get(self,14)
self.freePanel=UIButton.get(self,15)
self.freeTx=UIText.get(self,16)
self.helpBtn=UIButton.get(self,17)
self.infoPanelA=UIObject.get(self,18)
self.infoPanelB=UIObject.get(self,19)
self.lsWBA=UIObject.get(self,20)
self.lsWBB=UIObject.get(self,21)
self.replaceA=UIButton.get(self,22)
self.replaceB=UIButton.get(self,23)
self.root=UIObject.get(self,24)
self.selectBtnA=UIButton.get(self,25)
self.selectBtnB=UIButton.get(self,26)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)

self.freeBtn:setButtonClick(function()self:onFreeBtn()end)

self.freePanel:setButtonClick(function()self:onFreePanel()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.replaceA:setButtonClick(function()self:onReplaceA()end)

self.replaceB:setButtonClick(function()self:onReplaceB()end)

self.selectBtnA:setButtonClick(function()self:onSelectBtnA()end)

self.selectBtnB:setButtonClick(function()self:onSelectBtnB()end)



end


function UIChuanGongGeWin_LingShou:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.applyBtn);self.applyBtn=nil;
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.bgA);self.bgA=nil;
_UIObject_release(self.bgB);self.bgB=nil;
_UIObject_release(self.btnpanel);self.btnpanel=nil;
_UIObject_release(self.chuangongSpine);self.chuangongSpine=nil;
_UIObject_release(self.click);self.click=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costValue);self.costValue=nil;
_UIObject_release(self.dzRootA);self.dzRootA=nil;
_UIObject_release(self.dzRootB);self.dzRootB=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.forget);self.forget=nil;
_UIObject_release(self.freeBtn);self.freeBtn=nil;
_UIObject_release(self.freeList);self.freeList=nil;
_UIObject_release(self.freePanel);self.freePanel=nil;
_UIObject_release(self.freeTx);self.freeTx=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.infoPanelA);self.infoPanelA=nil;
_UIObject_release(self.infoPanelB);self.infoPanelB=nil;
_UIObject_release(self.lsWBA);self.lsWBA=nil;
_UIObject_release(self.lsWBB);self.lsWBB=nil;
_UIObject_release(self.replaceA);self.replaceA=nil;
_UIObject_release(self.replaceB);self.replaceB=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectBtnA);self.selectBtnA=nil;
_UIObject_release(self.selectBtnB);self.selectBtnB=nil;
end
















local _infoPanelCmpIndex={
name=0,
sjj=1,
djj=2,
info=3,
c1=4,
}

local _this





function UIChuanGongGeWin_LingShou:onLoaded(...)
self:bindComponents()

_this=self



self.freeData={}

self.click:setActive(false)

self.infoPanelA:setActive(false)
self.infoPanelB:setActive(false)

self.checkForget=userActorSetting.get('CHUANGONGGE_FORGET_FLAG',false)
self.forget:setToggle(self.checkForget)
self.forget:setToggleChange(function(name,isOn)
self.checkForget=isOn
userActorSetting.set('CHUANGONGGE_FORGET_FLAG',isOn)
userActorSetting.flush()
end)


local func=function(id)
local widget=self:getChildExpandUI(-1,id)
if widget then
local pos=self:getChildCanvas(-1)
local sortLayer=pos[1]
local sortOrder=pos[2]
widget:SetChildCanvas(-1,sortLayer,sortOrder+3)
end
end
self.cloud_guid=self:setChildGreateExpandUI(-1,self.root:getID(),INSTANCE_TYPE.eCommonCloudUIExpand,func)

local _recv_19_105=function()
if _this==nil then return end
local exArgs={
lsGuidSrc=_this.lsGuidSrc,
lsGuidDest=_this.lsGuidDest,
oldSrcJJ=_this.oldSrcJJ,
oldSrcXM=_this.oldSrcXM,
oldSrcQL=_this.oldSrcQL,
oldSrcJN=_this.oldSrcJN,
oldDestJJ=_this.oldDestJJ,
}
_this:playChuanGong(exArgs)





end
self:addProNotify(19,105,_recv_19_105)
end


function UIChuanGongGeWin_LingShou:__delete()
_this=nil

if self.cloud_guid~=nil then
self:setChildRemoveExpandUI(-1,self.cloud_guid)
self.cloud_guid=nil
end

if self.btA then
uiAIManager:removeUIInstance(self.btA)
self.btA=nil
end
if self.btB then
uiAIManager:removeUIInstance(self.btB)
self.btB=nil
end

uiAIManager:clearUIWinData('UIChuanGongGeWin_LingShou')

self:unbindComponents()
end




function UIChuanGongGeWin_LingShou:onShow(argtable,afterOnloaded)
if not argtable.isMenu then
self:playAnimation(-1)
self.root:setScale(Vector3(0,0,0))
self.root:setChildDOScale(1,0.35)
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.35)
else
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.35)
end




self.bdData=argtable.data or zongmenModel:getBuildingDataByBdType(mapIdType.zhufeng,SLG_SYSTEM_TYPE.eChuanGongGe)[1]
self.sfId=zongmenModel:getMountainId()
self.currInfo={}
self:refreshInfo()

end

function UIChuanGongGeWin_LingShou:onShowArgRecv()
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.5)
end


function UIChuanGongGeWin_LingShou:onHide()

end





function UIChuanGongGeWin_LingShou:onApplyBtn()
local args={
lsGuidSrc=self.lsA,
lsGuidDest=self.lsB,
costMoney={eMoneyType.mtLingYu,self.cost}
}

local lsDataA=lingshouModel:getLingShouData2(self.lsA)
self.oldSrcJJ=lsDataA.jj_lvl
self.oldSrcXM=lsDataA.xuemai_val
self.oldSrcQL=lingshouModel.getLingShouPropertyVal(lsDataA,lingshouPropertyType.QIANLI)
self.oldSrcJN=lsDataA.skill_level
self.lsGuidSrc=self.lsA
self.lsGuidDest=self.lsB
local lsDataB=lingshouModel:getLingShouData2(self.lsB)
self.oldDestJJ=lsDataB.jj_lvl

self:showWindow('UIChuanGongGeResetWin_LingShou',args)
end



function UIChuanGongGeWin_LingShou:onFreeBtn()
if#self.freeData>0 then
self.freeShow=true
self.freePanel:setScale(Vector3.one)
self.winlua:ForceLayoutRect(self.freeList:getID())
end
end



function UIChuanGongGeWin_LingShou:onFreePanel()
self.freePanel:setScale(Vector3.zero)
self.freeShow=false
end



function UIChuanGongGeWin_LingShou:onHelpBtn()
local args={
ruleGroupID=ruleTipsImageGroup.eChuanGong_lingshou,
}
self:showWindow("UIRuleTipsImage2Win",args)
end



function UIChuanGongGeWin_LingShou:onReplaceA()
self:onSelectBtnA()
end



function UIChuanGongGeWin_LingShou:onReplaceB()
self:onSelectBtnB()
end



function UIChuanGongGeWin_LingShou:onSelectBtnA()
self:selectLS(1,function(dzId)
if dzId and tostring(self.lsB)==tostring(dzId)then
self:onselectLSB(self.lsA)
end
self:onselectLSA(dzId)
end)
end



function UIChuanGongGeWin_LingShou:onSelectBtnB()
self:selectLS(2,function(lsGuid)
if lsGuid and tostring(self.lsA)==tostring(lsGuid)then
self:onselectLSA(self.lsB)
end
self:onselectLSB(lsGuid)
end)
end

function UIChuanGongGeWin_LingShou:onCloseClick()
UIChuanGongGeControl:closeUI()
end


function UIChuanGongGeWin_LingShou:getSpeakText(bt,dzId,ttype,stype,tkey)
local cfg=cfgHelper.get1(cfg_lingshouchuangongbaseconfig_get,1)
local contents=cfg['speak'..ttype][stype]
local txt=contents[math.random(1,#contents)]
bt:setSharedVar(tkey,txt)
end

function UIChuanGongGeWin_LingShou:selectLS(dztype,callback)

local otherSelectGuid
local selfSelectGuid
if dztype==1 then
otherSelectGuid=self.lsB
selfSelectGuid=self.lsA
else
otherSelectGuid=self.lsA
selfSelectGuid=self.lsB
end


local args={
callback=callback,
selectType=dztype,
otherSelectGuid=otherSelectGuid,
selfSelectGuid=selfSelectGuid,
}



local winParams={
titleName='灵兽安排',
extraWin='UIChuangongSelectWin_LingShou',
extraParams=args,
}
self:showWindow('UICommonDragonBoneWin',winParams)

end

function UIChuanGongGeWin_LingShou:createLS(root,lsGuid,pos,stype,callback)
local initData={
stype=stype,
sepaktime=3,
speakrate=0.5,
speakHUDParent=1,
stateId=1,
}
local tran=root:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])
self:createLingShou(stype,'bt_ui_chuangong_lingshou',lsGuid,tran,vpos,initData,nil,function(bt)
callback(bt)
end)
end

function UIChuanGongGeWin_LingShou:createLingShou(stype,fileName,lsGuid,parent,pos,initData,otherData,callback)
otherData=otherData or{}

local dzWidget=stype==1 and self.lsWBA:getChildWidgetBase()or self.lsWBB:getChildWidgetBase()
dzWidget:SetChildActive(-1,true)
dzWidget:SetChildAnchoredPosition(0,pos)
local lsData=lingshouModel:getLingShouData2(lsGuid)
local modelParams=lingshouModel:getLingShouInsideModelInfo(lsGuid)
local scale=lsData.cfg.modelScale*0.5
dzWidget:SetChildUIModelShowTarget(0,modelParams.body,scale,modelParams.componets,0,false,true)

local baseData={
dzId=lsGuid,
dzWidget=dzWidget,
dzIndex=0,
stWidget=dzWidget,
stIndex=-1,
}
if initData then
for k,v in pairs(initData)do
baseData[k]=v
end
end
local bt=behaviorManager:addBehaviorTree(fileName,nil,true,baseData)
if otherData.order then
dzWidget:SetChildCanvasEx(baseData.dzIndex,'',otherData.order)
end
callback(bt)
end

function UIChuanGongGeWin_LingShou:getSpecialityType(lsDataA,lsDataB)
if not lsDataB then
return nil
end
local jjv=lsDataA.jj_lvl
local checkJJ=jjv>lsDataB.jj_lvl
local ltv=lsDataA.liantilv
local checkLT=ltv>lsDataB.liantilv
local speciality=cfgHelper.get2(cfg_chuangonggeconfig_get,1,'speciality')
for i,v in ipairs(speciality)do
if checkJJ then
if jjv>=v[1]and jjv<=v[2]then
return v[5]
end
end
if checkLT then
if ltv>=v[3]and ltv<=v[4]then
return v[5]
end
end
end
return nil
end

function UIChuanGongGeWin_LingShou:getNameColor(lv1,lv2)
local color
if lv1>lv2 then
color='#c82c2c'
elseif lv1<lv2 then
color='#549327'
else
color='#000000'
end
return color
end

function UIChuanGongGeWin_LingShou:getJJName(lv1,lv2)
local color=self:getNameColor(lv1,lv2)
local name=FMT.fmt('<color={0}>{1}</color>',color,UIDiscipleModel:getJJNameEx(lv2))
return name
end

function UIChuanGongGeWin_LingShou:getLTName(lv1,lv2)
local color=self:getNameColor(lv1,lv2)
local name=FMT.fmt('<color={0}>{1}</color>',color,UIDiscipleModel:getLTNameEx(lv2))
return name
end

function UIChuanGongGeWin_LingShou:refreshInfo()
local lsDataA=self.lsA and lingshouModel:getLingShouData2(self.lsA)
local lsDataB=self.lsB and lingshouModel:getLingShouData2(self.lsB)

self.infoPanelA:setActive(self.lsA~=nil)
self.infoPanelB:setActive(self.lsB~=nil)
if self.lsA then
local widgetA=self.infoPanelA:getChildWidgetBase()

local name=lsDataA.name
widgetA:SetChildText(_infoPanelCmpIndex.name,name)

local sjjName=lingshouModel.getJJNameEx(lsDataA.jj_lvl,3)
widgetA:SetChildText(_infoPanelCmpIndex.sjj,sjjName)
local isShowChange=lsDataA.jj_lvl>0
widgetA:SetChildActive(_infoPanelCmpIndex.c1,isShowChange)
if isShowChange then
local djjName=lingshouModel.getJJNameEx(0,3)
widgetA:SetChildText(_infoPanelCmpIndex.djj,djjName)
end
end

if self.lsB then
local widgetB=self.infoPanelB:getChildWidgetBase()

local name=lsDataB.name
widgetB:SetChildText(_infoPanelCmpIndex.name,name)

local sjjName=lingshouModel.getJJNameEx(lsDataB.jj_lvl,3)
widgetB:SetChildText(_infoPanelCmpIndex.sjj,sjjName)
local isShowChange=lsDataA~=nil
widgetB:SetChildActive(_infoPanelCmpIndex.c1,isShowChange)
if isShowChange then
local djjName=lingshouModel.getJJNameEx(lsDataA.jj_lvl,3)
widgetB:SetChildText(_infoPanelCmpIndex.djj,djjName)
end
end

self:setCost()
local check=self.lsA~=nil and self.lsB~=nil
self.arrow:setActive(check)
self.btnpanel:setActive(check)
self.replaceA:setActive(self.lsA~=nil)
self.replaceB:setActive(self.lsB~=nil)

self.forget:setActive(false)
end

function UIChuanGongGeWin_LingShou:countCost()
local count=0
if self.lsA and self.lsB then
local lsDataA=lingshouModel:getLingShouData2(self.lsA)
local lsDataB=lingshouModel:getLingShouData2(self.lsB)

local cgCfg=cfgHelper.get(cfg_lingshouchuangongbaseconfig_get,1)

local ajjc=lsDataA.jj_lvl>0 and cgCfg.jjlvItems[lsDataA.jj_lvl]or defaultT
local bjjc=lsDataB.jj_lvl>0 and cgCfg.jjlvItems[lsDataB.jj_lvl]or defaultT
if ajjc and bjjc then
local dval=(ajjc[2]or 0)-(bjjc[2]or 0)
count=count+dval

else
logErr("灵兽传功 灵兽境界 消耗 缺少配置",lsDataA.jj_lvl,lsDataB.jj_lvl)
end

if lsDataA.xuemai_val>1 then
local axmc=cgCfg.xmlvItems[lsDataA.xuemai_val]
if axmc then
count=count+axmc[2]

else
logErr("灵兽传功 灵兽血脉 消耗 缺少配置",lsDataA.xuemai_val)
end
end

if lsDataA.skill_level>1 then
local amsc=cgCfg.skillItems[lsDataA.skill_level]
if amsc then
count=count+amsc[2]

else
logErr("灵兽传功 灵兽技能 消耗 缺少配置",lsDataA.skill_level)
end
end

if lsDataA.qianli>0 then
local val=lsDataA.qianli-lsDataA.qianli_init
if val>=0 then
local aqc=cgCfg.qlvItems[val]
if aqc then
count=count+aqc[2]

else
logErr("灵兽传功 灵兽潜力 消耗 缺少配置",val)
end
end
end
end
return count
end

function UIChuanGongGeWin_LingShou:setCost()
self.costIcon:setChildIcon(iconHelper.getIconName(2),true)
self.cost=self:countCost()
local have=moneyModel.getMoney(2)
if have>=self.cost then
self.costValue:setText(self.cost)
else
local col=FONT_COLOR_VAL[FONT_COLOR.eRedColor]
self.costValue:setText(FMT.fmt('<color={0}>{1}</color>',col,self.cost))
end
end

function UIChuanGongGeWin_LingShou:playAnimation(id)
self.root:setChildAnimatorParameter('state','int',tostring(id))
self.root:setChildAnimatorParameter('tBreak','trigger','')
end




function UIChuanGongGeWin_LingShou:onselectLSA(lsGuid)
if self.btA then
uiAIManager:removeUIInstance(self.btA)
self.btA=nil
end
local remove=false
if self.lsA and tostring(self.lsA)==tostring(lsGuid)then
remove=true
end
if lsGuid and not remove then
self.selectBtnA:setActive(false)
self.infoPanelA:setActive(true)
self.dzRootA:setActive(true)
self:createLS(self.dzRootA,lsGuid,{0,0},1,function(bt)
self.btA=bt
local widget=bt:getSharedVar('dzWidget')
local index=bt:getSharedVar('dzIndex')
widget:SetChildUIModelShowFlipX(index,true)
widget:SetChildButtonClick(2,function()
self:onSelectBtnA()
end)
end)
self.lsA=lsGuid
else
self.selectBtnA:setActive(true)
self.infoPanelA:setActive(false)
self.dzRootA:setActive(false)
self.lsA=nil
self.lsWBA:setActive(false)
end
self:refreshInfo()
end

function UIChuanGongGeWin_LingShou:onselectLSB(lsGuid)
if self.btB then
uiAIManager:removeUIInstance(self.btB)
self.btB=nil
end
local remove=false
if self.lsB and tostring(self.lsB)==tostring(lsGuid)then
remove=true
end
if lsGuid and not remove then
self.selectBtnB:setActive(false)
self.infoPanelB:setActive(true)
self.dzRootB:setActive(true)
self:createLS(self.dzRootB,lsGuid,{0,0},2,function(bt)
self.btB=bt
local widget=bt:getSharedVar('dzWidget')
widget:SetChildButtonClick(2,function()
self:onSelectBtnB()
end)
end)
self.lsB=lsGuid
else
self.selectBtnB:setActive(true)
self.infoPanelB:setActive(false)
self.dzRootB:setActive(false)
self.lsB=nil
self.lsWBB:setActive(false)
end
self:refreshInfo()
end

function UIChuanGongGeWin_LingShou:playSuccessAnim()
self.btA:setSharedVar('stateId',2)
self.btA:setSharedVar('animKey','dead')
self.btA:broke()
self.btA:reset()
self.btA:tick(0)

self.btB:setSharedVar('stateId',2)
self.btB:setSharedVar('animKey','ui_jump1')
self.btB:broke()
self.btB:reset()
self.btB:tick(0)

self:delayDo(2,function()
self.click:setActive(false)
UIManager:showWindow('UIChuanGongResultWin_LingShou',self.currInfo)
self.currInfo={}
self:onselectLSA()
self:onselectLSB()
self:playAnimation(0)
self:refreshInfo()
end)
end

function UIChuanGongGeWin_LingShou:setChuanGongState()
self.btA:setSharedVar('stateId',3)
self.btA:broke()
self.btA:reset()
self.btA:tick(0)

self.btB:setSharedVar('stateId',3)
self.btB:broke()
self.btB:reset()
self.btB:tick(0)
end

function UIChuanGongGeWin_LingShou:getJYModelId(sex)
return sex==1 and 3042 or 3043
end

function UIChuanGongGeWin_LingShou:playChuanGong(exArgs)
self.currInfo.exArgs=exArgs
self.click:setActive(true)



self:playAnimation(1)
self:setChuanGongState()
self:delayDo(2,function()

self.chuangongSpine:setActive(true)
self:delayDo(7.6,function()

self.chuangongSpine:setActive(false)
self:playAnimation(2)
self:delayDo(2,function()
self:playSuccessAnim()
end)
end)
end)
end

function UIChuanGongGeWin_LingShou:showDialog(content,callback)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=callback,
showclosebtn=true,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()
end

function UIChuanGongGeWin_LingShou:setDZAnimationState(bt,animId,isFlip)
local widget=bt:getSharedVar('dzWidget')
local index=bt:getSharedVar('dzIndex')
widget:SetChildModelAnimationState(index,animId)
if isFlip~=nil then

end
end


function UIChuanGongGeWin_LingShou:onAnimationEvent(msg)
if msg=='start_move_1'then


elseif msg=='start_move_2'then
self:setDZAnimationState(self.btA,eAnimationID.stand)
self:setDZAnimationState(self.btB,eAnimationID.stand)
elseif msg=='end_move_1'then


elseif msg=='end_move_2'then
self:setDZAnimationState(self.btA,eAnimationID.stand,true)
self:setDZAnimationState(self.btB,eAnimationID.stand,false)
end
end

function UIChuanGongGeWin_LingShou:refreshFreeBtn()
local cfg=cfgHelper.get2(cfg_chuangonggeconfig_get,1,"free")
local nowStamp=timeHelper.getServerLongTime()
table.clear(self.freeData)
table.clear(_tempFreeLookup)
for job,freeTime in pairs(cfg)do
local startStamp=timeHelper.getDateStamp(freeTime[1])
local endStamp=timeHelper.getDateStamp(freeTime[2])
if nowStamp<=endStamp then
local key=FMT.fmt("{0}_{1}",freeTime[1],freeTime[2])
local index=_tempFreeLookup[key]
local temp=nil
if index==nil then
temp={
startStamp=startStamp,
endStamp=endStamp,
inCycle=false,
jobs={},
}
table.insert(self.freeData,temp)
_tempFreeLookup[key]=#self.freeData
else
temp=self.freeData[index]
end
table.insert(temp.jobs,job)
end
end
local freeCnt=#self.freeData
if freeCnt>1 then
table.sort(self.freeData,function(a,b)
if a.inCycle==b.inCycle then
return a.endStamp>b.endStamp
else
return a.inCycle
end
end)
end
for i,v in ipairs(self.freeData)do
if#v.jobs>1 then
table.sort(v.jobs)
end
end

if freeCnt>0 then
local first=self.freeData[1]
self.freeBtn:setActive(first.inCycle)
self.freeList:setChildLayoutGroupCreateItems(freeCnt)
self:updateFreeTick()
self:startFreeTick()
else
self.freeBtn:setActive(false)
self:stopFreeTick()
self:onFreePanel()
end
end

function UIChuanGongGeWin_LingShou:startFreeTick()
if not self.freeTick then
self.freeTick=self:setTimer(1,0,function()
self:updateFreeTick()
end)
end
end

function UIChuanGongGeWin_LingShou:stopFreeTick()
if self.freeTick then
self:stopTimerByID(self.freeTick)
self.freeTick=nil
end
end

function UIChuanGongGeWin_LingShou:updateFreeTick()
local first=self.freeData[1]
local nowStamp=timeHelper.getServerLongTime()
if nowStamp>first.endStamp then
self:refreshFreeBtn()
elseif nowStamp>=first.startStamp then
if not first.inCycle then
first.inCycle=true
self.freeBtn:setActive(true)
end
local delta=first.endStamp-nowStamp
self.freeTx:setText(timeHelper.format_time_stamp3(delta,true))
end


local items=self.freeList:getChildLayoutGroupGridList()
for index=1,items.Count do
local item=items[index-1]
local data=self.freeData[index]
local delta=data.endStamp-nowStamp
local str=nil
if table.containsValue(data.jobs,0)then
str="<color=#76d81e>全职业</color>"
else
for i,v in ipairs(data.jobs)do
local jobName=cfgHelper.get2(cfg_disciplevocationconfig_get,v,"name")
str=str==nil and jobName or FMT.fmt("{0}、{1}",str,jobName)
end
end
str=FMT.fmt(_content,str,timeHelper.format_time_stamp3(delta,true))
item:SetChildText(-1,str)
end
self.winlua:ForceLayoutRect(self.freeList:getID())

end
