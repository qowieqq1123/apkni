







def_class("UIChuanGongGeWin",UIWindowBase)









function UIChuanGongGeWin:bindComponents()

self.applyBtn=UIButton.get(self,0)
self.arrow=UIObject.get(self,1)
self.bgA=UIObject.get(self,2)
self.bgB=UIObject.get(self,3)
self.btnpanel=UIObject.get(self,4)
self.click=UIObject.get(self,5)
self.costIcon=UIObject.get(self,6)
self.costValue=UIText.get(self,7)
self.dzRootA=UIObject.get(self,8)
self.dzRootB=UIObject.get(self,9)
self.effect=UIObject.get(self,10)
self.forget=UIToggleButton.get(self,11)
self.freeBtn=UIButton.get(self,12)
self.freeList=UIObject.get(self,13)
self.freePanel=UIButton.get(self,14)
self.freeTx=UIText.get(self,15)
self.helpBtn=UIButton.get(self,16)
self.infoPanelA=UIObject.get(self,17)
self.infoPanelB=UIObject.get(self,18)
self.jianyingA=UIObject.get(self,19)
self.jianyingB=UIObject.get(self,20)
self.replaceA=UIButton.get(self,21)
self.replaceB=UIButton.get(self,22)
self.root=UIObject.get(self,23)
self.selectBtnA=UIButton.get(self,24)
self.selectBtnB=UIButton.get(self,25)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)

self.freeBtn:setButtonClick(function()self:onFreeBtn()end)

self.freePanel:setButtonClick(function()self:onFreePanel()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.replaceA:setButtonClick(function()self:onReplaceA()end)

self.replaceB:setButtonClick(function()self:onReplaceB()end)

self.selectBtnA:setButtonClick(function()self:onSelectBtnA()end)

self.selectBtnB:setButtonClick(function()self:onSelectBtnB()end)



end


function UIChuanGongGeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.applyBtn);self.applyBtn=nil;
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.bgA);self.bgA=nil;
_UIObject_release(self.bgB);self.bgB=nil;
_UIObject_release(self.btnpanel);self.btnpanel=nil;
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
_UIObject_release(self.jianyingA);self.jianyingA=nil;
_UIObject_release(self.jianyingB);self.jianyingB=nil;
_UIObject_release(self.replaceA);self.replaceA=nil;
_UIObject_release(self.replaceB);self.replaceB=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.selectBtnA);self.selectBtnA=nil;
_UIObject_release(self.selectBtnB);self.selectBtnB=nil;
end
















local _item_index={
name=0,
jingjie1=1,
jingjie2=2,
lianti1=3,
lianti2=4,
spitem=5,
info=6,
tips=7,
spRoot=8,
change1=9,
change2=10,
}
local _tempFreeLookup={}
local _content="<color=#76d81e>{0}</color>传功无消耗\n剩余时间：<color=#76d81e>{1}</color>"
local sx_jxjyid=1



function UIChuanGongGeWin:onLoaded(...)
self:bindComponents()

self:playAnimation(-1)

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

end


function UIChuanGongGeWin:__delete()
if self.cloud_guid~=nil then
self:setChildRemoveExpandUI(-1,self.cloud_guid)
self.cloud_guid=nil
end

self:unbindComponents()

uiAIManager:clearUIWinData('UIChuanGongGeWin')
end




function UIChuanGongGeWin:onShow(argtable,afterOnloaded)

self.bdData=argtable.data
self.sfId=zongmenModel:getMountainId()
self.currInfo={}
self:refreshInfo()
self:refreshFreeBtn()
end

function UIChuanGongGeWin:onShowArgRecv()
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.5)
end


function UIChuanGongGeWin:onHide()

end

function UIChuanGongGeWin:getSpeakText(bt,dzId,ttype,stype,tkey)
local cfg=cfgHelper.get1(cfg_chuangonggeconfig_get,1)
local dzData=UIDiscipleModel:getDiscipleData(dzId)
local contents=cfg['speak'..ttype][stype][dzData.stand]
local txt=contents[math.random(1,#contents)]
bt:setSharedVar(tkey,txt)
end

function UIChuanGongGeWin:selectDZ(dztype,callback)
zongmenControl:showSelectManagerWin(self.sfId,self.bdData,dzSelectWinOpenType.eChuanGongGe)







local currDZ
local cmpDZ
if dztype==1 then
currDZ=self.dzA
cmpDZ=self.dzB
else
currDZ=self.dzB
cmpDZ=self.dzA
end

local args={
openType=dzSelectWinOpenType.eChuanGongGe,
effectType=dzSelectEffectType.ePlan,
bdData=self.bdData,
sfId=self.sfId,

dztype=dztype,
currDZ=currDZ,
cmpDZ=cmpDZ,
funcIndex=1,
callback=function(dzId)
callback(dzId)
end
}
discipleSelectController:openDiscipleSelect(args)
end

function UIChuanGongGeWin:createDZ(root,dzId,pos,stype,callback)
local initData={
stype=stype,
sepaktime=3,
speakrate=0.5,
speakHUDParent=1,
stateId=1,
}
local tran=root:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])
uiAIManager:createUIDisciple('UIChuanGongGeWin','bt_ui_chuan_gong',dzId,tran,vpos,initData,nil,function(bt)
callback(bt)
end)
end

function UIChuanGongGeWin:getSpecialityType(dzDataA,dzDataB)
if not dzDataB then
return nil
end
local jjv=dzDataA.jingjielv
local checkJJ=jjv>dzDataB.jingjielv
local ltv=dzDataA.liantilv
local checkLT=ltv>dzDataB.liantilv
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

function UIChuanGongGeWin:getNameColor(lv1,lv2)
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

function UIChuanGongGeWin:getJJName(lv1,lv2)
local color=self:getNameColor(lv1,lv2)
local name=FMT.fmt('<color={0}>{1}</color>',color,UIDiscipleModel:getJJNameEx(lv2))
return name
end

function UIChuanGongGeWin:getLTName(lv1,lv2)
local color=self:getNameColor(lv1,lv2)
local name=FMT.fmt('<color={0}>{1}</color>',color,UIDiscipleModel:getLTNameEx(lv2))
return name
end

function UIChuanGongGeWin:refreshInfo()
local dzDataA=self.dzA and UIDiscipleModel:getDiscipleData(self.dzA)
local dzDataB=self.dzB and UIDiscipleModel:getDiscipleData(self.dzB)
local widgetA=self.infoPanelA:getChildWidgetBase()
if self.dzA then
widgetA:SetChildActive(_item_index.info,true)
widgetA:SetChildText(_item_index.tips,'')
local name=UIDiscipleModel:getDiscipleName(self.dzA)
widgetA:SetChildText(_item_index.name,name)
widgetA:SetChildText(_item_index.jingjie1,UIDiscipleModel:getJJNameEx(dzDataA.jingjielv))
widgetA:SetChildText(_item_index.jingjie2,self:getJJName(dzDataA.jingjielv,0))
widgetA:SetChildText(_item_index.lianti1,UIDiscipleModel:getLTNameEx(dzDataA.liantilv))
widgetA:SetChildText(_item_index.lianti2,self:getLTName(dzDataA.liantilv,0))

widgetA:SetChildActive(_item_index.change1,dzDataA.jingjielv~=0)
widgetA:SetChildActive(_item_index.change2,dzDataA.liantilv~=0)

local info={}
info.dzId=self.dzA
info.jingjie1=dzDataA.jingjielv
info.jingjie2=0
info.lianti1=dzDataA.liantilv
info.lianti2=0
self.currInfo[1]=info

local sptype=self:getSpecialityType(dzDataA,dzDataB)
self.sptype=sptype
info.sptype=sptype
if sptype then
widgetA:SetChildActive(_item_index.spRoot,true)
local spitem=widgetA:GetChildWidgetBase(_item_index.spitem)
local cfg=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eChuangShang,sptype[2])
UIDiscipleModel.refreshSpecialityItemEx(spitem,cfg)
spitem:SetChildButtonClick(0,function()
UIManager:showWindow('UISpecialityWin',{item=spitem,node='bottom',guid=self.dzA,config=cfg})
end)
else
widgetA:SetChildActive(_item_index.spRoot,false)
end
else
widgetA:SetChildActive(_item_index.info,false)
widgetA:SetChildText(_item_index.tips,'请选择传功弟子')
end

local widgetB=self.infoPanelB:getChildWidgetBase()
if self.dzB then
widgetB:SetChildActive(_item_index.info,true)
widgetB:SetChildText(_item_index.tips,'')
local name=UIDiscipleModel:getDiscipleName(self.dzB)
widgetB:SetChildText(_item_index.name,name)
widgetB:SetChildText(_item_index.jingjie1,UIDiscipleModel:getJJNameEx(dzDataB.jingjielv))
local jjlv=dzDataA and math.max(dzDataA.jingjielv,dzDataB.jingjielv)or-1
widgetB:SetChildText(_item_index.jingjie2,dzDataA and self:getJJName(dzDataB.jingjielv,jjlv)or'???')
widgetB:SetChildText(_item_index.lianti1,UIDiscipleModel:getLTNameEx(dzDataB.liantilv))
local ltlv=dzDataA and math.max(dzDataA.liantilv,dzDataB.liantilv)or-1
widgetB:SetChildText(_item_index.lianti2,dzDataA and self:getLTName(dzDataB.liantilv,ltlv)or'???')

widgetB:SetChildActive(_item_index.change1,dzDataB.jingjielv~=jjlv)
widgetB:SetChildActive(_item_index.change2,dzDataB.liantilv~=ltlv)

local info={}
info.dzId=self.dzB
info.jingjie1=dzDataB.jingjielv
info.jingjie2=jjlv
info.lianti1=dzDataB.liantilv
info.lianti2=ltlv
self.currInfo[2]=info

local specialityType=DISCIPLE_SPECIALITY_TYPE.eXX
local lglist=UIDiscipleModel:getDiscipleSpeciality(self.dzB,specialityType)
local isSX=false
if lglist and next(lglist)then
for k,v in pairs(lglist)do
if v.param_1 and v.param_1==sx_jxjyid then
isSX=true
break
end
end
end
self.isSX=isSX
if isSX then
widgetB:SetChildActive(_item_index.spRoot,true)
local spitem=widgetB:GetChildWidgetBase(_item_index.spitem)
local cfg=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eXX,sx_jxjyid)
UIDiscipleModel.refreshSpecialityItemEx(spitem,cfg)
spitem:SetChildButtonClick(0,function()
UIManager:showWindow('UISpecialityWin',{item=spitem,node='bottom',guid=self.dzB,config=cfg})
end)
else
widgetB:SetChildActive(_item_index.spRoot,false)
end
else
widgetB:SetChildActive(_item_index.info,false)
widgetB:SetChildText(_item_index.tips,'请选择受功弟子')
end

self:setCost()
local check=self.dzA~=nil and self.dzB~=nil
self.arrow:setActive(check)
self.btnpanel:setActive(check)
self.replaceA:setActive(self.dzA~=nil)
self.replaceB:setActive(self.dzB~=nil)

self.forget:setActive(check)
end

function UIChuanGongGeWin:countCost()
if self.dzA and self.dzB then
local jobA=UIDiscipleModel:getDiscipleJob(self.dzA)
local freeCfg=cfgHelper.get2(cfg_chuangonggeconfig_get,1,'free')
local free=freeCfg[0]
if free then
local startStamp=timeHelper.getDateStamp(free[1])
local endStamp=timeHelper.getDateStamp(free[2])
local nowStamp=timeHelper.getServerLongTime()
if nowStamp<=endStamp and nowStamp>=startStamp then
return 0
end
end
free=freeCfg[jobA]
if free then
local startStamp=timeHelper.getDateStamp(free[1])
local endStamp=timeHelper.getDateStamp(free[2])
local nowStamp=timeHelper.getServerLongTime()
if nowStamp<=endStamp and nowStamp>=startStamp then
return 0
end
end

local dzDataA=UIDiscipleModel:getDiscipleData(self.dzA)
local dzDataB=UIDiscipleModel:getDiscipleData(self.dzB)
local consume=cfgHelper.get2(cfg_chuangonggeconfig_get,1,'consume')
local jvC=0
if dzDataA.jingjielv>dzDataB.jingjielv then
local jvA=consume[1][dzDataA.jingjielv]
local jvB=consume[1][dzDataB.jingjielv]
jvC=jvA-jvB
end
local lvC=0
if dzDataA.liantilv>dzDataB.liantilv then
local lvA=consume[2][dzDataA.liantilv]
local lvB=consume[2][dzDataB.liantilv]
lvC=lvA-lvB
end
return jvC+lvC
else
return 0
end
end

function UIChuanGongGeWin:setCost()
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

function UIChuanGongGeWin:playAnimation(id)
self.root:setChildAnimatorParameter('state','int',tostring(id))
self.root:setChildAnimatorParameter('tBreak','trigger','')
end




function UIChuanGongGeWin:onSelectBtnA()
self:selectDZ(1,function(dzId)
if dzId and tostring(self.dzB)==tostring(dzId)then
self:onSelectDZB(self.dzA)
end
self:onSelectDZA(dzId)
end)
end

function UIChuanGongGeWin:onSelectDZA(dzId)
if self.btA then
uiAIManager:removeUIInstance(self.btA)
self.btA=nil
end
local remove=false
if self.dzA and tostring(self.dzA)==tostring(dzId)then
remove=true
end
if dzId and not remove then
self.selectBtnA:setActive(false)
self.infoPanelA:setActive(true)
self:createDZ(self.dzRootA,dzId,{0,0},1,function(bt)
self.btA=bt
local widget=bt:getSharedVar('dzWidget')
local index=bt:getSharedVar('dzIndex')
widget:SetChildUIModelShowFlipX(index,true)
widget:SetChildButtonClick(2,function()
self:onSelectBtnA()
end)
end)
self.dzA=dzId
else
self.selectBtnA:setActive(true)
self.infoPanelA:setActive(false)
self.dzA=nil
end
self:refreshInfo()
end

function UIChuanGongGeWin:onSelectBtnB()
self:selectDZ(2,function(dzId)
if dzId and tostring(self.dzA)==tostring(dzId)then
self:onSelectDZA(self.dzB)
end
self:onSelectDZB(dzId)
end)
end

function UIChuanGongGeWin:onSelectDZB(dzId)
if self.btB then
uiAIManager:removeUIInstance(self.btB)
self.btB=nil
end
local remove=false
if self.dzB and tostring(self.dzB)==tostring(dzId)then
remove=true
end
if dzId and not remove then
self.selectBtnB:setActive(false)
self.infoPanelB:setActive(true)
self:createDZ(self.dzRootB,dzId,{0,0},2,function(bt)
self.btB=bt
local widget=bt:getSharedVar('dzWidget')
widget:SetChildButtonClick(2,function()
self:onSelectBtnB()
end)
end)
self.dzB=dzId
else
self.selectBtnB:setActive(true)
self.infoPanelB:setActive(false)
self.dzB=nil
end
self:refreshInfo()
end

function UIChuanGongGeWin:onReplaceA()
self:onSelectBtnA()
end

function UIChuanGongGeWin:onReplaceB()
self:onSelectBtnB()
end

function UIChuanGongGeWin:playSuccessAnim()
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
UIManager:showWindow('UIChuanGongResultWin',self.currInfo)
self.currInfo={}
self:onSelectDZA()
self:onSelectDZB()
self:playAnimation(0)
end)
end

function UIChuanGongGeWin:setChuanGongState()
self.btA:setSharedVar('stateId',3)
self.btA:broke()
self.btA:reset()
self.btA:tick(0)

self.btB:setSharedVar('stateId',3)
self.btB:broke()
self.btB:reset()
self.btB:tick(0)
end

function UIChuanGongGeWin:getJYModelId(sex)
return sex==1 and 3042 or 3043
end

function UIChuanGongGeWin:playChuanGong(exArgs)
local cdd=moneyModel.getMoney(eMoneyType.mtChuanDao)
local dv=cdd-self.recordCDD
if dv>0 then
exArgs.cddVal=dv
end
self.currInfo.exArgs=exArgs
self.click:setActive(true)

local sexA=UIDiscipleModel:getDiscipleSex(self.dzA)
local sexB=UIDiscipleModel:getDiscipleSex(self.dzB)
self.jianyingA:setChildUIModelShowTarget(self:getJYModelId(sexA),1,nil,eAnimationID.stand)
self.jianyingB:setChildUIModelShowTarget(self:getJYModelId(sexB),1,nil,eAnimationID.stand)
self.jianyingB:setChildUIModelShowFlipX(true)

self:playAnimation(1)
self:setChuanGongState()
self:delayDo(2,function()
self.effect:setChildShowEffect(10130,true)
self:delayDo(3,function()
self.effect:setChildShowEffect(10130,false)
self:playAnimation(2)
self:delayDo(2,function()
self:playSuccessAnim()
end)
end)
end)
end

function UIChuanGongGeWin:showDialog(content,callback)
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

function UIChuanGongGeWin:setDZAnimationState(bt,animId,isFlip)
local widget=bt:getSharedVar('dzWidget')
local index=bt:getSharedVar('dzIndex')
widget:SetChildModelAnimationState(index,animId)
if isFlip~=nil then
widget:SetChildUIModelShowFlipX(index,isFlip)
end
end


function UIChuanGongGeWin:onAnimationEvent(msg)
if msg=='start_move_1'then
self:setDZAnimationState(self.btA,eAnimationID.run)
self:setDZAnimationState(self.btB,eAnimationID.run)
elseif msg=='start_move_2'then
self:setDZAnimationState(self.btA,eAnimationID.stand)
self:setDZAnimationState(self.btB,eAnimationID.stand)
elseif msg=='end_move_1'then
self:setDZAnimationState(self.btA,eAnimationID.run,false)
self:setDZAnimationState(self.btB,eAnimationID.run,true)
elseif msg=='end_move_2'then
self:setDZAnimationState(self.btA,eAnimationID.stand,true)
self:setDZAnimationState(self.btB,eAnimationID.stand,false)
end
end

function UIChuanGongGeWin:onApplyBtn()
itemsModel:useItem(eMoneyType.mtLingYu,self.cost,function()
self:handleApply()
end,WARNING_TYPE.eWarning,eMoneyType.mtXianYu)
end

local _dialougeResultType={
noReturnReward=1,
resetDaoYan_NoCount=2,
resetDaoYan_HasCount_Use=3,
resetDaoYan_HasCount_NoUse=4,
}

local _hasResultType=function(list,type)
return table.findValue(list,type)~=nil
end

function UIChuanGongGeWin:handleApply(dialougeList)
dialougeList=dialougeList or{}

if self.sptype and not _hasResultType(dialougeList,_dialougeResultType.noReturnReward)then
local _func=function()
dialougeList[#dialougeList+1]=_dialougeResultType.noReturnReward
self:handleApply(dialougeList)
end
local sisx=self.isSX
local cfg=UIDiscipleModel:getSpecialityConfig(DISCIPLE_SPECIALITY_TYPE.eChuangShang,self.sptype[2])
local name=UIDiscipleModel:getDiscipleName(self.dzA)
local content=FMT.fmt(cfgHelper.getlang('chuangongge_tips_1'),name,cfg.name)
self:showDialog(content,function()
if sisx then

local showdata=
{
type='UIDialouge',
title='提示',
content="受功弟子持有<color=#c82c2c><将信将疑></color>，逐出该弟\n子是不会获得境界、炼体材料返还\n是否确认?",
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=_func,
showclosebtn=true,
}
local comfirmDialog2=UIDialogManager.newDialog(showdata)
comfirmDialog2:show()
else
_func()
end
end)
return
end

if UIDiscipleModel:isDaoYanDZ(self.dzA)and UIDiscipleModel:getDaoYanLevel(self.dzA)>0 then
local max=UIDiscipleController:getMonthMaxResetDaoYanMaxCount()
local useTimes=UIDiscipleController:getDiscipleDaoYanResetCount()
local isHasResetCount=max>useTimes
local dzName=UIDiscipleModel:getDiscipleName(self.dzA)
local noDialougeHas=(not _hasResultType(dialougeList,_dialougeResultType.resetDaoYan_HasCount_Use)and not _hasResultType(dialougeList,_dialougeResultType.resetDaoYan_HasCount_NoUse))
local noDialougeNoHas=not _hasResultType(dialougeList,_dialougeResultType.resetDaoYan_NoCount)
if isHasResetCount and noDialougeHas then
local args={}
local lang=cfgHelper.get1(cfg_lang_get,"chuanGongGe_Reset_Desc")or"{0}-{1}"
local max=UIDiscipleController:getMonthMaxResetDaoYanMaxCount()
local useTimes=UIDiscipleController:getDiscipleDaoYanResetCount()
local consumeTimes=max-useTimes
local countStr=FMT.fmt("{0}/{1}",consumeTimes,max)
countStr=consumeTimes>0 and toColorStringX('#549327',countStr)or toColorString(FONT_COLOR.eRedColor,countStr)
local content=FMT.fmt(lang,dzName,countStr)
args.content=content
args.resetCost=cfgHelper.getdef(cfg_discipledaoyanconfig,'reset_cost')
local costDesc="消耗："
for index,cost in ipairs(args.resetCost)do
local itemid=cost[1]
local itemcount=cost[2]
local itemIconName=itemsModel.getItemIconName(itemid)
local chatEmot=chatEmotHelper.getIconEmotMesg(itemIconName,30)
local isEnough=itemsModel:canUseItem(itemid,itemcount)
local countStr=isEnough and toColorString(FONT_COLOR.eNomalColor,itemcount)or toColorString(FONT_COLOR.eRedColor,itemcount)
costDesc=FMT.fmt("{0}{1}{2}",costDesc,chatEmot,countStr)
end
args.tips=costDesc
args.resetRewardList=UIDiscipleController:calculateResetRewardList(self.dzA)
args.resetCallBack=function()
if not UIDiscipleController:checkCanResetDiscipleDaoYan()then return end
dialougeList[#dialougeList+1]=_dialougeResultType.resetDaoYan_HasCount_Use
self:handleApply(dialougeList)
end
args.cancelCallBack=function()
dialougeList[#dialougeList+1]=_dialougeResultType.resetDaoYan_HasCount_NoUse
self:handleApply(dialougeList)
end
args.cancelBtnTxt="只传功"
args.resetBtnTxt="重置并传功"
self:showWindow("UIDiscipleDaoYanResetWin",args)
return
elseif noDialougeNoHas and(not isHasResetCount)then
local lang=cfgHelper.get1(cfg_lang_get,'chuanGongGe_NoCount_Desc')or"{0}"
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt(lang,dzName),
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function()
dialougeList[#dialougeList+1]=_dialougeResultType.resetDaoYan_NoCount
self:handleApply(dialougeList)
end,
}
local comfirmDialogEnter=UIDialogManager.newDialog(showdata)
comfirmDialogEnter:show()
return
end
end

if _hasResultType(dialougeList,_dialougeResultType.resetDaoYan_HasCount_Use)then
UIDiscipleController:reqDaoYanReset(self.dzA)
end

local flag=self.checkForget and 1 or 0
self:reqChuanGong(flag)
end

function UIChuanGongGeWin:reqChuanGong(flag)
self.recordCDD=moneyModel.getMoney(eMoneyType.mtChuanDao)
UIChuanGongGeControl:reqChuanGong(self.dzA,self.dzB,flag)
end

function UIChuanGongGeWin:onHelpBtn()

local args={
ruleGroupID=ruleTipsImageGroup.eChuanGong,
}
self:showWindow("UIRuleTipsImage2Win",args)
end

function UIChuanGongGeWin:onCloseClick()

UIChuanGongGeControl:closeUI()
end

function UIChuanGongGeWin:refreshFreeBtn()
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

function UIChuanGongGeWin:startFreeTick()
if not self.freeTick then
self.freeTick=self:setTimer(1,0,function()
self:updateFreeTick()
end)
end
end

function UIChuanGongGeWin:stopFreeTick()
if self.freeTick then
self:stopTimerByID(self.freeTick)
self.freeTick=nil
end
end

function UIChuanGongGeWin:updateFreeTick()
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

function UIChuanGongGeWin:onFreeBtn()
if#self.freeData>0 then
self.freeShow=true
self.freePanel:setScale(Vector3.one)
self.winlua:ForceLayoutRect(self.freeList:getID())
end
end

function UIChuanGongGeWin:onFreePanel()
self.freePanel:setScale(Vector3.zero)
self.freeShow=false
end