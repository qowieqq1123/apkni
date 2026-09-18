







def_class("UIChuanGongGeWin_JingNeng",UIWindowBase)









function UIChuanGongGeWin_JingNeng:bindComponents()

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
self.freeBtn=UIButton.get(self,11)
self.freeList=UIObject.get(self,12)
self.freePanel=UIButton.get(self,13)
self.freeTx=UIText.get(self,14)
self.helpBtn=UIButton.get(self,15)
self.infoPanelA=UIObject.get(self,16)
self.infoPanelB=UIObject.get(self,17)
self.jianyingA=UIObject.get(self,18)
self.jianyingB=UIObject.get(self,19)
self.replaceA=UIButton.get(self,20)
self.replaceB=UIButton.get(self,21)
self.root=UIObject.get(self,22)
self.selectBtnA=UIButton.get(self,23)
self.selectBtnB=UIButton.get(self,24)

self.applyBtn:setButtonClick(function()self:onApplyBtn()end)

self.freeBtn:setButtonClick(function()self:onFreeBtn()end)

self.freePanel:setButtonClick(function()self:onFreePanel()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.replaceA:setButtonClick(function()self:onReplaceA()end)

self.replaceB:setButtonClick(function()self:onReplaceB()end)

self.selectBtnA:setButtonClick(function()self:onSelectBtnA()end)

self.selectBtnB:setButtonClick(function()self:onSelectBtnB()end)



end


function UIChuanGongGeWin_JingNeng:unbindComponents()
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
jinengRoot=1,
info=2,
tips=3,
}

local animId=6159

local anim={3201,3202,3203,3204,3205,3206,3207,3208}
local _this


function UIChuanGongGeWin_JingNeng:onLoaded(...)
_this=self
self:bindComponents()

self:addNotify(notifyConfig.on_money_changed,function()
self:setCost()
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


function UIChuanGongGeWin_JingNeng:__delete()
_this=nil
self:unbindComponents()
end




function UIChuanGongGeWin_JingNeng:onShow(argtable,afterOnloaded)
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

function UIChuanGongGeWin_JingNeng:onShowArgRecv()
self.root:setChildCanvasGroupAlpha(0)
self.root:setChildCanvasGroupDOFade(1,0.5)
end



function UIChuanGongGeWin_JingNeng:onHide()

end

function UIChuanGongGeWin_JingNeng:getSpeakText(bt,dzId,ttype,stype,tkey)
local cfg=cfgHelper.get1(cfg_chuangonggeconfig_get,1)
if cfg['functionsspeak'..ttype]then
local contents=cfg['functionsspeak'..ttype][stype]
if not self.speakNum then
self.speakNum=self.speakNum or 0
self.speakNum=self.speakNum+1
end

if not self.speakType or self.speakNum%2==1 then
self.speakType=math.random(1,#contents)
end

local txt=contents[self.speakType]

bt:setSharedVar(tkey,txt)
end
end

function UIChuanGongGeWin_JingNeng:selectDZ(dztype,callback)
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
end,
selectPageCB=function(idx)
self.selectPage=idx
end,
selectPage=self.selectPage,
}


local winParams={
canvasIdx=args.canvasIdx,
titleName='',
noBlackBg=args.funcType and _noBlackBgFunc[args.funcType]or nil,
extraWin='UIMDiscipleSelect_chuangongjineng',
extraParams=args,
}

UIManager:showWindow('UICommonDragonBoneWin',winParams)
end

function UIChuanGongGeWin_JingNeng:createDZ(root,dzId,pos,stype,callback)
local initData={
stype=stype,
sepaktime=3,
speakrate=0.5,
speakHUDParent=1,
stateId=1,
}
local tran=root:getCommonComponent('Transform')
local vpos=Vector2.New(pos[1],pos[2])
uiAIManager:createUIDisciple('UIChuanGongGeWin_JingNeng','bt_ui_chuan_gong_ji_neng',dzId,tran,vpos,initData,{checkChuiWei=false},function(bt)
callback(bt)
end)
end

function UIChuanGongGeWin_JingNeng:getSpecialityType(dzDataA,dzDataB)
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

function UIChuanGongGeWin_JingNeng:getNameColor(lv1,lv2)
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

function UIChuanGongGeWin_JingNeng:getJJName(lv1,lv2)
local color=self:getNameColor(lv1,lv2)
local name=FMT.fmt('<color={0}>{1}</color>',color,UIDiscipleModel:getJJNameEx(lv2))
return name
end

function UIChuanGongGeWin_JingNeng:getLTName(lv1,lv2)
local color=self:getNameColor(lv1,lv2)
local name=FMT.fmt('<color={0}>{1}</color>',color,UIDiscipleModel:getLTNameEx(lv2))
return name
end

function UIChuanGongGeWin_JingNeng:refreshInfo()
local widgetA=self.infoPanelA:getChildWidgetBase()
if self.dzA then
widgetA:SetChildActive(_item_index.info,true)
widgetA:SetChildText(_item_index.tips,'')

local name=UIDiscipleModel:getDiscipleName(self.dzA)
widgetA:SetChildText(_item_index.name,name)

local highJob
local info={}
widgetA:SetChildLayoutGroupCreateItems(_item_index.jinengRoot,8)
local descExGrid=widgetA:GetChildLayoutGroupGridList(_item_index.jinengRoot)
info.levelList={}
for i=1,descExGrid.Count do
local grid=descExGrid[i-1]
local lv=UIDiscipleModel:getDiscipleJobLevel(self.dzA,i)
if not highJob or lv>highJob[2]then
highJob={i,lv}
end
grid:SetChildText(1,FMT.fmt("<color=#7d3b17>{0} </color>{1}级",UIDiscipleModel:getDiscipleJobName(i),lv))
local icon=cfgHelper.get2(cfg_discipleproskillconfig_get,i,'icon')
grid:SetChildCSImageSprite(0,globalABLookup.proskill,FMT.fmt('image_gongzhongtp_{0}',icon))
grid:SetChildText(2,lv>0 and"0级"or"")
grid:SetChildActive(3,lv>0)
info.levelList[i]=lv
end

self.highJob=highJob[1]

info.dzId=self.dzA
self.currInfo[1]=info
else
widgetA:SetChildActive(_item_index.info,false)
widgetA:SetChildText(_item_index.tips,'')
end

local widgetB=self.infoPanelB:getChildWidgetBase()
if self.dzB then
widgetB:SetChildActive(_item_index.info,true)
widgetB:SetChildText(_item_index.tips,'')
local name=UIDiscipleModel:getDiscipleName(self.dzB)
widgetB:SetChildText(_item_index.name,name)

local info={}
info.levelList={}
widgetB:SetChildLayoutGroupCreateItems(_item_index.jinengRoot,8)
local descExGrid=widgetB:GetChildLayoutGroupGridList(_item_index.jinengRoot)
for i=1,descExGrid.Count do
local grid=descExGrid[i-1]
local level=UIDiscipleModel:getDiscipleJobLevel(self.dzB,i)
grid:SetChildText(1,FMT.fmt("<color=#7d3b17>{0} </color>{1}级",UIDiscipleModel:getDiscipleJobName(i),level))
local icon=cfgHelper.get2(cfg_discipleproskillconfig_get,i,'icon')
grid:SetChildCSImageSprite(0,globalABLookup.proskill,FMT.fmt('image_gongzhongtp_{0}',icon))
if self.dzA then
local aLevel=UIDiscipleModel:getDiscipleJobLevel(self.dzA,i)
grid:SetChildText(2,aLevel>level and FMT.fmt("{0}级",aLevel)or"")
grid:SetChildActive(3,aLevel>level)
else
grid:SetChildActive(3,true)
grid:SetChildText(2,"???")
end
info.levelList[i]=level
end


info.dzId=self.dzB
self.currInfo[2]=info
else
widgetB:SetChildActive(_item_index.info,false)
widgetB:SetChildText(_item_index.tips,'')
end

self:setCost()
local check=self.dzA~=nil and self.dzB~=nil
self.arrow:setActive(check)
self.btnpanel:setActive(check)
self.replaceA:setActive(self.dzA~=nil)
self.replaceB:setActive(self.dzB~=nil)


end

function UIChuanGongGeWin_JingNeng:countCost()
if self.dzA and self.dzB then
local dzA=self.dzA
local dzB=self.dzB
local cost=0
for _,jobType in pairs(DISCIPLE_PROSKILL_TYPE)do
local aLv=UIDiscipleModel:getDiscipleJobLevel(dzA,jobType)
local bLv=UIDiscipleModel:getDiscipleJobLevel(dzB,jobType)
if aLv>bLv then
local aCost=UIChuanGongGeControl:getJiNengCostConfig(jobType,aLv)or defaultT
local bCost=UIChuanGongGeControl:getJiNengCostConfig(jobType,bLv)or defaultT
cost=cost+((aCost.consume or 0)-(bCost.consume or 0))
end
end
return cost
else
return 0
end
end

function UIChuanGongGeWin_JingNeng:setCost()
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

function UIChuanGongGeWin_JingNeng:playAnimation(id)
self.root:setChildAnimatorParameter('state','int',tostring(id))
self.root:setChildAnimatorParameter('tBreak','trigger','')
end

function UIChuanGongGeWin_JingNeng:checkSelectWithDZID(dztype,selDZ,cmpDZ,wraning)
if dztype==1 then
if cmpDZ then
if selDZ==cmpDZ then
return true
end
local canSelect_job=false
for _,jobType in pairs(DISCIPLE_PROSKILL_TYPE)do
if UIDiscipleModel:getDiscipleJobLevel(selDZ,jobType)>UIDiscipleModel:getDiscipleJobLevel(cmpDZ,jobType)then
canSelect_job=true
break
end
end

if canSelect_job then
return true
else
if wraning then
UIManager.error('因技能等级过低无法成为传功者')
end
return false,1
end
else
return true
end
else
if cmpDZ then
if selDZ==cmpDZ then
return true
end
local canSelect_job=false
for _,jobType in pairs(DISCIPLE_PROSKILL_TYPE)do
if UIDiscipleModel:getDiscipleJobLevel(cmpDZ,jobType)>UIDiscipleModel:getDiscipleJobLevel(selDZ,jobType)then
canSelect_job=true
break
end
end
if canSelect_job then
return true
else
if wraning then
UIManager.error('因技能等级过高无法成为受功者')
end
return false,2
end
else
return true
end
end
return false,0
end




function UIChuanGongGeWin_JingNeng:onSelectBtnA()
self:selectDZ(1,function(dzId)
if dzId and tostring(self.dzB)==tostring(dzId)then
if self:checkSelectWithDZID(1,dzId,self.dzA)then
self:onSelectDZB(self.dzA)
else
self:onSelectDZB()
end
end
self:onSelectDZA(dzId)
end)
end

function UIChuanGongGeWin_JingNeng:onSelectDZA(dzId)
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

function UIChuanGongGeWin_JingNeng:onSelectBtnB()
self:selectDZ(2,function(dzId)
if dzId and tostring(self.dzA)==tostring(dzId)then
if self:checkSelectWithDZID(2,dzId,self.dzB)then
self:onSelectDZA(self.dzB)
else
self:onSelectDZA()
end
end
self:onSelectDZB(dzId)
end)
end

function UIChuanGongGeWin_JingNeng:onSelectDZB(dzId)
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

function UIChuanGongGeWin_JingNeng:onReplaceA()
self:onSelectBtnA()
end

function UIChuanGongGeWin_JingNeng:onReplaceB()
self:onSelectBtnB()
end

function UIChuanGongGeWin_JingNeng:playSuccessAnim()
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
UIManager:showWindow('UIChuanGongResultWin_JingNeng',self.currInfo)
self.currInfo={}
self:onSelectDZA()
self:onSelectDZB()
self:playAnimation(0)
end)
end

function UIChuanGongGeWin_JingNeng:setChuanGongState()
self.btA:setSharedVar('stateId',3)
self.btA:broke()
self.btA:reset()
self.btA:tick(0)

self.btB:setSharedVar('stateId',3)
self.btB:broke()
self.btB:reset()
self.btB:tick(0)
end

function UIChuanGongGeWin_JingNeng:getJYModelId(sex)
return sex==1 and 3042 or 3043
end

function UIChuanGongGeWin_JingNeng:playChuanGong(exArgs)
local cdd=moneyModel.getMoney(eMoneyType.mtChuanDao)
local dv=cdd-self.recordCDD
if dv>0 then
exArgs.cddVal=dv
end
self.currInfo.exArgs=exArgs
self.click:setActive(true)







if api_Available_SetChildUIModelEnableInitUISpineParaEx()then
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.effect:getID(),true,true,true)
end

self:playAnimation(1)
self:setChuanGongState()
self:delayDo(2,function()
self.infoPanelA:setActive(false)
self.infoPanelB:setActive(false)
self.arrow:setActive(false)
self.effect:setActive(true)
self.effect:setChildUIModelShowTarget(animId,1,{},anim[self.highJob])

self:delayDo(6.3,function()
self.effect:setActive(false)
self:playAnimation(2)
self:delayDo(2,function()
self:playSuccessAnim()
end)
end)
end)
end

function UIChuanGongGeWin_JingNeng:showDialog(content,callback)
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

function UIChuanGongGeWin_JingNeng:setDZAnimationState(bt,animId,isFlip)
local widget=bt:getSharedVar('dzWidget')
local index=bt:getSharedVar('dzIndex')
widget:SetChildModelAnimationState(index,animId)
if isFlip~=nil then
widget:SetChildUIModelShowFlipX(index,isFlip)
end
end


function UIChuanGongGeWin_JingNeng:onAnimationEvent(msg)
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

function UIChuanGongGeWin_JingNeng:onApplyBtn()
moneySystem:useMoney(eMoneyType.mtLingYu,self.cost,function()
self:handleApply()
end,WARNING_TYPE.eWarning,eMoneyType.mtXianYu)
end

function UIChuanGongGeWin_JingNeng:handleApply()
self:showDialog("是否确认进行传功？",function()
local have=moneyModel.getMoney(eMoneyType.mtLingYu)
if have>=self.cost then
local flag=self.checkForget and 1 or 0
self:reqChuanGong(flag)
else
UIManager.error(FMT.fmt('{0}不足',moneyModel.getMoneyName(2)))
end
end)
end

function UIChuanGongGeWin_JingNeng:reqChuanGong(flag,checkFlag)

local isContinue

local isIgnoreCheckA=checkFlag and mathHelper.getBitValue(checkFlag,0)or false
if not isIgnoreCheckA then
isContinue=self:checkBuildManager(self.dzA,checkFlag,1)
if not isContinue then
return
end
end


local isIgnoreCheckB=checkFlag and mathHelper.getBitValue(checkFlag,1)or false
if not isIgnoreCheckB then
isContinue=self:checkBuildManager(self.dzB,checkFlag,2)
if not isContinue then
return
end
end

self.recordCDD=moneyModel.getMoney(eMoneyType.mtChuanDao)
UIChuanGongGeControl:reqChuanGong_jiNeng(self.dzA,self.dzB)
end



function UIChuanGongGeWin_JingNeng:checkBuildManager(dis_guid,checkFlag,bitIdx)
checkFlag=checkFlag or 0
checkFlag=mathHelper.setbit(checkFlag,bitIdx-1)
local sfId
local isBuildManager=false
local bdData=zongmenModel:getDiscipleWorkroom(dis_guid)
if bdData then
sfId=zongmenModel:getBuildingLocationMapId(bdData.un_build_id)
isBuildManager=true
else
sfId=mapIdType.zhufeng
bdData=zongmenModel:findBuildingByManager(sfId,dis_guid)
if bdData then
isBuildManager=true
end
end

if isBuildManager then
local func=function()
if _this==nil or not _this.isVisible then return end
zongmenControl:reqChangeBuildingManager(sfId,bdData.un_build_id,Int64_0)
local flag=_this.checkForget and 1 or 0
_this:reqChuanGong(flag,checkFlag)
end

local isCanFire=zongmenControl:checkBuildingManagerCanFire(sfId,bdData.un_build_id,func)
if isCanFire then
func()
else
return false
end
end

return true
end


function UIChuanGongGeWin_JingNeng:onHelpBtn()
local args={
ruleGroupID=ruleTipsImageGroup.eChuanGong,
page=2,
}
self:showWindow("UIRuleTipsImage2Win",args)
end

function UIChuanGongGeWin_JingNeng:onCloseClick()
UIChuanGongGeControl:closeUI()
end


function UIChuanGongGeWin_JingNeng:onFreeBtn()
if#self.freeData>0 then
self.freeShow=true
self.freePanel:setScale(Vector3.one)
self.winlua:ForceLayoutRect(self.freeList:getID())
end
end

function UIChuanGongGeWin_JingNeng:onFreePanel()
self.freePanel:setScale(Vector3.zero)
self.freeShow=false
end