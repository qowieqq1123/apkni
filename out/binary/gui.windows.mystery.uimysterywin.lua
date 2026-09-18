







def_class("UIMysteryWin",UIWindowBase)









function UIMysteryWin:bindComponents()

self.backEffect=UIObject.get(self,0)
self.ButtonCloseBg=UIButton.get(self,1)
self.faZeList=UIObject.get(self,2)
self.Effect=UIObject.get(self,3)
self.resetCamRoot=UIObject.get(self,4)
self.Mask=UIObject.get(self,5)
self.ButtonClose=UIObject.get(self,6)
self.topRoot2=UIObject.get(self,7)
self.denglong=UIObject.get(self,8)
self.newBieCom=UIButton.get(self,9)
self.triggerItemGrid=UIObject.get(self,10)
self.skillRoot=UIObject.get(self,11)
self.triggerItemButton=UIButton.get(self,12)
self.topRoot=UIObject.get(self,13)
self.skillBtnRoot=UIObject.get(self,14)
self.ButtonTeamHide=UIButton.get(self,15)
self.ButtonTeamShow=UIButton.get(self,16)
self.teamChangeButton=UIButton.get(self,17)
self.teamRoot=UIObject.get(self,18)
self.autoImg=UIObject.get(self,19)
self.resetCamButton=UIButton.get(self,20)
self.fazeMask=UIButton.get(self,21)
self.faZeOne=UIObject.get(self,22)
self.wingDir=UIText.get(self,23)
self.icon=UIObject.get(self,24)
self.powerTxt=UIText.get(self,25)
self.butonEvt=UIButton.get(self,26)
self.evtReddot=UIObject.get(self,27)
self.moneyTxt=UIText.get(self,28)
self.ButtonSkillCancel=UIButton.get(self,29)
self.SkillListPanel=UIObject.get(self,30)
self.RoleListPanel=UIObject.get(self,31)
self.ButtonSkillHide=UIButton.get(self,32)
self.ButtonSkillShow=UIButton.get(self,33)
self.SkillAnim=UIObject.get(self,34)
self.skillTips=UIText.get(self,35)
self.skillTips2=UIObject.get(self,36)
self.skillCost=UIText.get(self,37)
self.moneyIcon=UIImage.get(self,38)
self.evtImage=UIImage.get(self,39)
self.powerLeftTxt=UIText.get(self,40)
self.powerTipsTxt=UIText.get(self,41)
self.powerRightTxt=UIText.get(self,42)
self.skillTips2txt=UIText.get(self,43)
self.skillCostIcon=UIImage.get(self,44)
self.cornerText=UIText.get(self,45)
self.RecordListPanel=UIObject.get(self,46)
self.corner=UIObject.get(self,47)
self.bagButton=UIButton.get(self,48)
self.logButton=UIButton.get(self,49)
self.autoPanel=UIObject.get(self,50)
self.RecordPanel=UIObject.get(self,51)
self.startAutoButton=UIButton.get(self,52)
self.cancelAutoButton=UIButton.get(self,53)

self.ButtonCloseBg:setButtonClick(function()self:onButtonCloseBg()end)

self.newBieCom:setButtonClick(function()self:onNewBieCom()end)

self.triggerItemButton:setButtonClick(function()self:onTriggerItemButton()end)

self.ButtonTeamHide:setButtonClick(function()self:onButtonTeamHide()end)

self.ButtonTeamShow:setButtonClick(function()self:onButtonTeamShow()end)

self.teamChangeButton:setButtonClick(function()self:onTeamChangeButton()end)

self.resetCamButton:setButtonClick(function()self:onResetCamButton()end)

self.fazeMask:setButtonClick(function()self:onFazeMask()end)

self.butonEvt:setButtonClick(function()self:onButonEvt()end)

self.ButtonSkillCancel:setButtonClick(function()self:onButtonSkillCancel()end)

self.ButtonSkillHide:setButtonClick(function()self:onButtonSkillHide()end)

self.ButtonSkillShow:setButtonClick(function()self:onButtonSkillShow()end)

self.bagButton:setButtonClick(function()self:onBagButton()end)

self.logButton:setButtonClick(function()self:onLogButton()end)

self.startAutoButton:setButtonClick(function()self:onStartAutoButton()end)

self.cancelAutoButton:setButtonClick(function()self:onCancelAutoButton()end)


self.sprite_button_jljilu_1=0
self.sprite_button_jljilu_2=1
self.spriteAnim_mysterySkill=0
self.spriteAnim_mysterySkill2=1

end


function UIMysteryWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.backEffect);self.backEffect=nil;
_UIObject_release(self.ButtonCloseBg);self.ButtonCloseBg=nil;
_UIObject_release(self.faZeList);self.faZeList=nil;
_UIObject_release(self.Effect);self.Effect=nil;
_UIObject_release(self.resetCamRoot);self.resetCamRoot=nil;
_UIObject_release(self.Mask);self.Mask=nil;
_UIObject_release(self.ButtonClose);self.ButtonClose=nil;
_UIObject_release(self.topRoot2);self.topRoot2=nil;
_UIObject_release(self.denglong);self.denglong=nil;
_UIObject_release(self.newBieCom);self.newBieCom=nil;
_UIObject_release(self.triggerItemGrid);self.triggerItemGrid=nil;
_UIObject_release(self.skillRoot);self.skillRoot=nil;
_UIObject_release(self.triggerItemButton);self.triggerItemButton=nil;
_UIObject_release(self.topRoot);self.topRoot=nil;
_UIObject_release(self.skillBtnRoot);self.skillBtnRoot=nil;
_UIObject_release(self.ButtonTeamHide);self.ButtonTeamHide=nil;
_UIObject_release(self.ButtonTeamShow);self.ButtonTeamShow=nil;
_UIObject_release(self.teamChangeButton);self.teamChangeButton=nil;
_UIObject_release(self.teamRoot);self.teamRoot=nil;
_UIObject_release(self.autoImg);self.autoImg=nil;
_UIObject_release(self.resetCamButton);self.resetCamButton=nil;
_UIObject_release(self.fazeMask);self.fazeMask=nil;
_UIObject_release(self.faZeOne);self.faZeOne=nil;
_UIObject_release(self.wingDir);self.wingDir=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.powerTxt);self.powerTxt=nil;
_UIObject_release(self.butonEvt);self.butonEvt=nil;
_UIObject_release(self.evtReddot);self.evtReddot=nil;
_UIObject_release(self.moneyTxt);self.moneyTxt=nil;
_UIObject_release(self.ButtonSkillCancel);self.ButtonSkillCancel=nil;
_UIObject_release(self.SkillListPanel);self.SkillListPanel=nil;
_UIObject_release(self.RoleListPanel);self.RoleListPanel=nil;
_UIObject_release(self.ButtonSkillHide);self.ButtonSkillHide=nil;
_UIObject_release(self.ButtonSkillShow);self.ButtonSkillShow=nil;
_UIObject_release(self.SkillAnim);self.SkillAnim=nil;
_UIObject_release(self.skillTips);self.skillTips=nil;
_UIObject_release(self.skillTips2);self.skillTips2=nil;
_UIObject_release(self.skillCost);self.skillCost=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.evtImage);self.evtImage=nil;
_UIObject_release(self.powerLeftTxt);self.powerLeftTxt=nil;
_UIObject_release(self.powerTipsTxt);self.powerTipsTxt=nil;
_UIObject_release(self.powerRightTxt);self.powerRightTxt=nil;
_UIObject_release(self.skillTips2txt);self.skillTips2txt=nil;
_UIObject_release(self.skillCostIcon);self.skillCostIcon=nil;
_UIObject_release(self.cornerText);self.cornerText=nil;
_UIObject_release(self.RecordListPanel);self.RecordListPanel=nil;
_UIObject_release(self.corner);self.corner=nil;
_UIObject_release(self.bagButton);self.bagButton=nil;
_UIObject_release(self.logButton);self.logButton=nil;
_UIObject_release(self.autoPanel);self.autoPanel=nil;
_UIObject_release(self.RecordPanel);self.RecordPanel=nil;
_UIObject_release(self.startAutoButton);self.startAutoButton=nil;
_UIObject_release(self.cancelAutoButton);self.cancelAutoButton=nil;
end

















local _HexMapManager=CS.HexagonMapManagerInterface
local round=0
local _this
local createTimer
local globalab='ui/sharedtextures/uiglobalspriteatlas_1.ab'

local skillItemIndex=
{
root=4,
unlock=7,
lock=6,
select=8,
}

local skillItemRotateAngle=
{
5,0,-5
}


local nanduColorName=
{
"平和","险恶","死地"
}


local _Screen=UnityEngine.Screen

local charMap={['0']='A',['1']='B',['2']='C',['3']='D',['4']='E',['5']='F',['6']='G',['7']='H',['8']='I',['9']='J',['%']='K'}
function UIMysteryWin.converNum(num)
local str=''
local isAdd=false
if num>0 then
isAdd=true
str='+'
end
local numStr=tostring(num)
local len=string.len(numStr)
for i=1,len do
local n=string.sub(numStr,i,i)
if isAdd then
local c=charMap[n]
if c~=nil then
str=str..c
else
str=str..n
end
else
str=str..n
end
end
return str

end


function UIMysteryWin:onLoaded(...)
self:bindComponents()
_this=self
local money=mysteryPlayerModel.get_base_config().mapMoneyIcon
self.on_money_change=function(moneyType,lastVal,val)
if money==moneyType then
self:refreshmoney()
end
end
notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_change)
self.SkillListPanel:setChildScrollViewInit(0.5,true,function(...)self:onSkillItemClick(...)end,function(...)self:onSkillItemLongClick(...)end)
self.RoleListPanel:setChildScrollViewInit(0.5,true,function(...)self:onTeamItemClick(...)end,nil)


self.changeBloodtimer={}


self.SkillAnim:setChildUIModelShowTarget(4100,1,{},eAnimationID.idle3_loop,false,nil,0)
end


function UIMysteryWin:__delete()
if self.skillTween then
self.skillTween:Kill()
end
if self.scaleTween then
self.scaleTween:Kill()
end
notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_change)

if self.updateTimer then
self:stopTimerByID(self.updateTimer)
end

self:unbindComponents()

_this=nil
end




function UIMysteryWin:onShow(argtable,afterOnloaded)

self:initData()
self.TeamHide=true
self:onButtonTeamShow()
self.SkillHide=true
self:changeSkillVisible()

self.player=mysteryPlayerModel:get_player()
if self.player then
self.updateTimer=self:setTimer(0.05,0,function()self:onUpdate()end)
end

self:refreshLayer()


end

function UIMysteryWin:onUpdate()
if self and self.player then
local hudPos=mysteryPlayerModel:get_hud_position(self.player.guid,false)
local sp=_HexMapManager.WorldToScreenPoint(hudPos)
local orip=Vector3.New(sp.x,sp.y,sp.z)
local showFlag=false

if sp.x>_Screen.width*0.99 or sp.x<_Screen.width*0.01 or sp.y>_Screen.height*0.99 or sp.y<_Screen.height*0.01-150 then
showFlag=true
end

local l=_Screen.width*0.22
local r=_Screen.width*0.87
local b=_Screen.height*0.25
local t=_Screen.height*0.8

if sp.x>r then
sp.x=r
end
if sp.x<l then
sp.x=l
end
if sp.y>t then
sp.y=t
end
if sp.y<b then
sp.y=b
end
if showFlag then
self.resetCamRoot:setChildUIScreenPos(sp)
self.resetCamRoot:setScale(Vector3.New(1,1,1))
local oriPC=Vector3.New(orip.x,orip.y,0)
local scrPC=Vector3.New(_Screen.width*0.5,_Screen.height*0.5,0)
local angle=Quaternion.FromToRotation(Vector3.New(0,0,1),oriPC-scrPC).eulerAngles

if oriPC.x-scrPC.x>0 then
self.resetCamButton:setRotation(0,0,180-angle.x-90)
else
self.resetCamButton:setRotation(0,0,angle.x-90)
end
else
self.resetCamRoot:setScale(Vector3.New(0,0,0))
end

end
end

function UIMysteryWin:onResetCamButton()

if self.player then
local pasue=mysteryAIManager:is_pause()
if pasue then
return
end
MysteryController.set_camera_fcous_pos(self.player.roomId,self.player.pos,30,nil,true,_Ease.InOutSine)
end
end

function UIMysteryWin:initData()
local fbid=MysteryModel:get_cur_fbid()
if not fbid then
return
end
self.fbId=fbid

self:refreshPower()
self:refreshWingDir()
self:initTeamList()
self:refreshmoney()
self:initSkillList()
self:refreshSkillTips()
self:showTriggerItemPanel()
self:showRecordCorner()

local isOpenAuto,reason=MysteryGuildOrder.isOrderSetupOpen(fbid)
self.autoReason=reason
if isOpenAuto then
self.autoPanel:setActive(true)
self.autoPanel:setGray(false)

self:setAutoMode(true)
else
if reason then
self.autoPanel:setActive(true)
self.autoPanel:setGray(true)
else
self.autoPanel:setActive(false)
end
end



local cfg=cfg_secretscenefubenconfig_get(fbid)
self.denglong:setActive(false)

local uiOpen=cfg.uiOpen
if uiOpen then
local uiOpenCfg=cfg_secretsceneuishowconfig_get(uiOpen)
if uiOpenCfg then
self.hasQuitTips=uiOpenCfg.quitTips
self.ButtonCloseBg:setActive(uiOpenCfg.quit or false)
self.bagButton:setActive(uiOpenCfg.bagPanel or false)
self.skillRoot:setActive(uiOpenCfg.skillPanel or false)
self.teamChangeButton:setActive(uiOpenCfg.changeTeam or false)
if not uiOpenCfg.targetPanel then
UIManager:closeWindow("UIMysteryTargetWin")
end
end
end

local fbEffect=cfg.backEffect
if fbEffect then
self:showBackEffect(fbEffect,true)
end
end

function UIMysteryWin:refreshSkillTips()
self.skillTips:setActive(false)
end

function UIMysteryWin:refreshmoney()
local moneyType=mysteryPlayerModel.get_base_config().mapMoneyIcon

local moneyValue=moneyModel.getMoney(moneyType)
self.skillCost:setText(mathHelper.formatNumber(moneyValue,true))
self.skillCostIcon:setImageIcon(iconHelper.getIconName(moneyType),false)
end

function UIMysteryWin:refreshPower()
local power=MysteryModel:get_fb_power()
local fbid=MysteryModel:get_cur_fbid()
if fbid then
if MysteryModel:is_use_power(fbid)then
self.topRoot:setActive(true)
self.powerTxt:setText(FMT.fmt("{0}",power))
self.powerTipsTxt:setActive(false)
else
self.topRoot:setActive(false)
self.powerLeftTxt:setActive(false)
self.powerRightTxt:setActive(false)
end
end
end

function UIMysteryWin:refreshLayer()
local fbid=MysteryModel:get_cur_fbid()
local roomId=mysteryRoomModel:get_cur_roomID()



if MysteryModel:get_mystery_sence_type(fbid)==MysterySenceType.ShangGuXianDi then
local cfgfb=cfg_secretscenefubenconfig_get(fbid)
local evtList=mysteryEnvironmentEffectModel:get_environment()
local k=next(evtList)
self.butonEvt:setActive(k~=nil)
if k then
local cfg=cfgHelper.getSSlawRule(k)
if cfg then
self.evtImage:setImageIcon(cfg.image,false)
end
self.butonEvtClick=function()
UIManager:showWindow("UIMysteryEnvironmentWin",{item=self.evtImage:getWidgetBase(),node='bottom',config=cfg})
end
end
if roomId==0 then
self.topRoot:setActive(true)
self.powerLeftTxt:setText("")
self.powerRightTxt:setText("")
self.powerTipsTxt:setText(FMT.fmt("{0}1层",cfgfb.name))
else
local portal=roomId
if portal then
local config=mysteryPortalModel:get_config(portal)
if config and config.layer then
self.topRoot:setActive(true)
self.powerLeftTxt:setText("")
self.powerRightTxt:setText("")
self.powerTipsTxt:setText(FMT.fmt("{0}{1}层（{2}）",cfgfb.name,config.layer,nanduColorName[config.color]))
end
else
self.topRoot:setActive(false)
end
end
else

local reddot=userActorArraySetting.get(ACTOR_SETTING_TYPE.eResMystery,FMT.fmt("evtReddot_{0}",fbid),nil)
self.evtReddot:setActive(not reddot)
local evtList=mysteryEnvironmentEffectModel:get_environment()
local list=mysteryEnvironmentEffectModel:get_environmentList()
local k=next(evtList)
self.butonEvt:setActive(k~=nil)
if k then
if#list>1 then
self.evtImage:setCSImageSprite("ui/windows/mystery/sharedtextures/inmysterysprite.ab","icon_tili_2")
self.butonEvtClick=function()
self.evtReddot:setActive(false)
self:showEntGroupList(fbid,nil,list)
end
self.powerLeftTxt:setText("")
self.powerRightTxt:setText("")
self.powerTipsTxt:setText("环境效果")
else
if k>10000 then
self.evtImage:setCSImageSprite("ui/windows/mystery/sharedtextures/inmysterysprite.ab","icon_tili_2")
self.butonEvtClick=function()
self.evtReddot:setActive(false)
self:showEntGroupList(fbid,k)
end
self.powerLeftTxt:setText("")
self.powerRightTxt:setText("")
self.powerTipsTxt:setText("环境效果")
else
local cfg=cfgHelper.getSSlawRule(k)
if cfg then
self.evtImage:setImageIcon(cfg.image,false)
self.powerLeftTxt:setText("")
self.powerRightTxt:setText("")
self.powerTipsTxt:setText(FMT.fmt("环境效果：{0}",cfg.name))
end
self.butonEvtClick=function()
UIManager:showWindow("UIMysteryEnvironmentWin",{item=self.evtImage:getWidgetBase(),node='bottom',config=cfg})
end
end
end


end
self.topRoot:setActive(k~=nil)
end
end

function UIMysteryWin:showEntGroupList(fbid,groupId,list)
self.faZeList:setActive(true)
local l,n
if list then
l=list
n=#list
else
local lib=cfgHelper.get(cfg_sslawruleteamconfig_get,groupId)
l=lib.list
n=#l
end

self.faZeList:setChildScrollViewCreateGrids(n,1)
local grids=self.faZeList:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local grid=grids[i-1]
local id=l[i]
local cfg=cfgHelper.getSSlawRule(id)
grid:SetChildCSImageIcon(1,cfg.image,false)
grid:SetChildText(0,cfg.name)
grid:SetChildText(2,cfg.desc)
end

userActorArraySetting.flushVal(ACTOR_SETTING_TYPE.eResMystery,FMT.fmt("evtReddot_{0}",fbid),true)

end

function UIMysteryWin:refreshWingDir()
local fbid=MysteryModel:get_cur_fbid()
if MysteryModel:have_wing(fbid)then
self.topRoot2:setActive(true)
self.wingDir:setText(MysteryModel:get_wing_direct()==0 and"下轮风向：左风"or"下轮风向：右风")
else
self.topRoot2:setActive(false)
end
end

function UIMysteryWin:showEnterRoomEffect()
self.winid:SetChildShowEffect(self.Effect:getID(),2,true)
round=0
createTimer=timer.new()
createTimer:start(0.1,self.playEffectInRound,5)
end

function UIMysteryWin:showEffect(effectId,show)
self.winid:SetChildShowEffect(self.Effect:getID(),effectId,show)
end

function UIMysteryWin:showBackEffect(effectId,show)
self.winid:SetChildShowEffect(self.backEffect:getID(),effectId,show)
end

function UIMysteryWin:showTeamEffect(index,effectId)
local grid=self.RoleListPanel:getChildScrollViewItemWidget(index-1)
if grid then
grid:SetChildShowEffect(13,effectId,true)
end
end

function UIMysteryWin.playEffectInOneRound()
local playerPos=mysteryPlayerModel:get_player_pos()
if not playerPos then
return 0
end
local posList=mysteryPosHelper.get_round_pos_list(playerPos,round)
local roomID=mysteryRoomModel:get_cur_roomID()
local groudLayer=mysteryRoomModel:get_GroundLayer(roomID)
local gridNum=0
for i,v in ipairs(posList)do
_HexMapManager.RunSurfaceSpriteAnimator(Vector3(v.x,v.y,0),groudLayer,"CreateAnim2",0,nil)
gridNum=gridNum+1
end
return gridNum
end

function UIMysteryWin.playEffectInRound()
local gridNum=_this.playEffectInOneRound()
if gridNum==0 then
return
end
round=round+1
end

function UIMysteryWin:initTeamList()
self.probeTeam=MysteryModel:get_fb_probeTeam()or{}
local teamSize=#self.probeTeam
if teamSize>0 then

self.RoleListPanel:setChildScrollViewCreateGrids(teamSize,6)

local grids=self.RoleListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local guid=self.probeTeam[i].unitId
local unitType=self.probeTeam[i].unitType
local blood=tonumber(tostring(self.probeTeam[i].blood))

local item=grids[i-1]
item:SetChildProgress(2,blood,10000)
if unitType==fightPreSelectModel.teamEntityType.dizi then
item:SetChildText(0,UIDiscipleModel:getDiscipleName(guid))
item:SetChildActive(2,true)

local imageInfo=UIDiscipleModel:getDiscipleInsideModelInfo(guid)
local headCenter=cfgHelper.get2(cfg_dbbodyconfig_get,imageInfo.body,'headCenter')or{}
local head=headCenter[eHeadCenterType.eHead]
imageInfo.headCenter={head[1],head[2]-20,head[3]}
comHelper.setChildModelRawImageEx(3,item,imageInfo,0,nil,blood<=0)

if UIDiscipleModel:checkInjuryType(guid,eInjuryType.eHealth)then
item:SetChildActive(8,false)
else
item:SetChildActive(8,true)
local injury=UIDiscipleModel:getDiscipleInjury(guid)
local injury_icon=eInjuryType:getIcon(injury)
item:SetChildCSImageSprite(5,globalab,injury_icon)
end
item:SetChildActive(12,false)
elseif unitType==fightPreSelectModel.teamEntityType.npc then
guid=tonumber(tostring(guid))
local npcConfig=fightPreSelectModel.getNPCConfig(guid)
if npcConfig then
item:SetChildText(0,npcConfig.name)
local imageInfo=fightPreSelectModel.getNPCInSideModel(guid)
if imageInfo then
local headCenter=cfgHelper.get2(cfg_dbbodyconfig_get,imageInfo.body,'headCenter')or{}
local head=headCenter[eHeadCenterType.eHead]
imageInfo.headCenter={head[1],head[2]-20,head[3]}

comHelper.setChildModelRawImageEx(3,item,imageInfo,0,nil,blood<=0)
end
item:SetChildActive(8,false)
item:SetChildActive(12,true)

end
end
if blood<=0 then
local emotList=cfgHelper.get2(cfg_secretscenebaseconfig_get,1,"deadFace")
local emot=emotList[math.random(1,#emotList)]
item:SetChildActive(6,true)
item:SetChildUIModelShowTarget(6,emot,1,{},eAnimationID.stand)

else
item:SetChildActive(6,false)
end
end
end
end

function UIMysteryWin:onTeamItemClick(id,index)
local roleData=self.probeTeam[index+1]
local discipleList={}

if(not worldController:checkNoticiateBlockOpen())then
return
end
local pause,pType=mysteryAIManager:is_pause()
if pType==eMysteryPauseType.eTeamDead then
pause=false
end
if mysteryTriggerManager.isInTrigger or pause or mysteryAIManager.is_on_round()then
return
end

if roleData then
local blood=tonumber(tostring(roleData.blood))
if blood<=0 then
if MysteryModel:get_mystery_sence_type(MysteryModel:get_cur_fbid())==MysterySenceType.ShangGuXianDi then
UIFullMysteryMainControl:showMysteryChangeTeamWin({fbId=MysteryModel:get_cur_fbid()})
else
UIManager:showWindow("UMysteryDeadTipsWin")
end
else
for i,v in ipairs(self.probeTeam)do
if v.unitType==eTeamEntityType.dizi then
table.insert(discipleList,UIDiscipleModel:getDiscipleDataX(v.unitId))
end
end

if roleData.unitType==eTeamEntityType.dizi then
UIManager:closeWindow("UIWorldBossWin")
UIFullDiscipleMainControl:showWindowInfo({dis_guid=roleData.unitId,disciplelist=discipleList})
else
UIManager.error("不是门中弟子，无法查看信息")
end
end
end

end

function UIMysteryWin:talk(talkId,name,talkStr,useIndex)
local emot=nil
local desc=nil
if talkId then
local dialoguecfg=cfgHelper.get1(cfg_storydialogueconfig_get,talkId)
if dialoguecfg then
emot=dialoguecfg.emot
desc=dialoguecfg.dialogue
end
else
desc=talkStr
end

if not desc then
return
end

if self.talktimer then
return
end

if self.TeamHide then
return
end
local index=nil
if useIndex then
index=useIndex
else
index=name==nil and math.random(1,#self.probeTeam)
end

local teamdiziName=''
for i,v in ipairs(self.probeTeam)do
local unitType=v.unitType
local guid=v.unitId
if unitType==fightPreSelectModel.teamEntityType.dizi then
teamdiziName=UIDiscipleModel:getDiscipleName(guid)
elseif unitType==fightPreSelectModel.teamEntityType.npc then
local id=tonumber(tostring(guid))
if id then
local npcConfig=fightPreSelectModel.getNPCConfig(id)
teamdiziName=npcConfig.name
end
end

if teamdiziName==name then
index=i
break
end
end


desc=gameplotModel:replaceName(desc,teamdiziName)

if index then
local grid=self.RoleListPanel:getChildScrollViewItemWidget(index-1)
if grid then
if emot then
grid:SetChildActive(11,true)

grid:SetChildText(11,chatEmotHelper.decodeEmot(emot))
else
grid:SetChildActive(11,false)
end

grid:SetChildActive(9,true)
grid:SetChildCanvasGroupAlpha(9,0)

grid:SetChildText(10,desc)

grid:SetChildCanvasGroupDOFade(9,1,0.1,nil)

local func=function()
if self and not self.isClose then
if self.taklTween~=nil then
self.taklTween:Complete()
self.taklTween=nil
end
self.taklTween=grid:SetChildCanvasGroupDOFade(9,0,0.2,nil)
end
self.talktimer=nil
end
if self and not self.isClose then
self.talktimer=timer.new()
self.talktimer:start(3,function()
if self and not self.isClose then
func()
end
end,1)
end
end
end

end

function UIMysteryWin:bloodChange(index,value,isRelive)
if self.changeBloodtimer[index]then
self.waitToPlayBlood=self.waitToPlayBlood or{}
self.waitToPlayBlood[index]=self.waitToPlayBlood[index]or{}
if not isRelive then
table.insert(self.waitToPlayBlood[index],{value,isRelive})
end
return
end

if index then
local grid=self.RoleListPanel:getChildScrollViewItemWidget(index-1)
if grid then



if value>0 then
self.changeBloodTween=grid:SetChildDOLocalMoveY(7,85,1,nil)
self:showTeamEffect(index,10099)
else
self.changeBloodTween=grid:SetChildDOLocalMoveY(7,65,1,nil)
end

if not isRelive then
local str=FMT.fmt("{0}{1}",self.converNum(mathHelper.floor(value/100)),value>0 and'K'or'%')

grid:SetChildText(7,str)
grid:SetChildLocalPosY(7,72)
grid:SetChildCanvasGroupDOFade(7,1,0.1,nil)

local func=function()
if self and not self.isClose then
if self.changeBloodTween~=nil then
self.changeBloodTween:Complete()
self.changeBloodTween=nil
end
self.changeBloodTween=grid:SetChildCanvasGroupDOFade(7,0,0.2,nil)
end
self.changeBloodtimer[index]=nil
if self.waitToPlayBlood and self.waitToPlayBlood[index]then
local args=table.remove(self.waitToPlayBlood[index],1)
if args then
self:bloodChange(index,args[1],args[2])
end
end
end
if self and not self.isClose then
self.changeBloodtimer[index]=timer.new()
self.changeBloodtimer[index]:start(1,function()
if self and not self.isClose then
func()
end
end,1)
end
end
end
end
end


function UIMysteryWin:initSkillList()
local isBanSkill=mysteryPortalModel:isRoomBanSkill()

local fbId=self.fbId or MysteryModel:get_cur_fbid()
self.probeSkill=mysterySkillModel:get_fb_active_skill(fbId)
local cfgfb=cfg_secretscenefubenconfig_get(fbId)
local mustUseSkill=cfgfb.mustUseSkill
local mustUse={}
if mustUseSkill then
for i,v in pairs(mustUseSkill)do
mustUse[v[1]]=v[2]
end
end
self.mustUseSkill=mustUse
if#self.probeSkill>0 then
self.skillBtnRoot:setActive(true)
self.SkillListPanel:setChildScrollViewCreateGrids(3,6)
local grids=self.SkillListPanel:getChildScrollViewItemWidgets()
local length=grids.Count
for i=1,length do
local item=grids[i-1]
if self.probeSkill[i]then
local skillId=self.probeSkill[i].skill_id
local count=self.probeSkill[i].skill_num
local skillCfg=mysterySkillModel.get_skill_config(skillId)
if item and skillCfg then
local needUnlock=skillCfg.unlock and skillCfg.unlock==1
local isLock=isBanSkill or(needUnlock and not QianJiGeModel:is_skill_unlock(skillId))and(not mustUse[skillId])



item:SetChildCSImageIcon(0,skillCfg.icon,false)
if count and mustUse[skillId]and mustUse[skillId]>=999 then
count=nil
end

if not skillCfg.times then
count=nil
end
if isLock then
count=nil
end

if count then
item:SetChildActive(5,true)
item:SetChildText(1,count)
else
item:SetChildActive(5,false)
end





item:SetChildText(2,skillCfg.name)

item:SetChildImageExGray(0,isLock or false)
item:SetChildActive(skillItemIndex.lock,false)
item:SetChildActive(skillItemIndex.unlock,true)

item:SetChildDoBrightness(skillItemIndex.root,((count==nil)or(count~=nil and count>0))and 1 or 0.6,0.2,nil)
end
else
item:SetChildActive(skillItemIndex.lock,true)
item:SetChildActive(skillItemIndex.unlock,false)
end
item:SetChildRotation(skillItemIndex.root,0,0,skillItemRotateAngle[i])
item:SetChildLocalPosY(skillItemIndex.root,i==math.ceil(length/2)and 10 or 0)

end
self:resetSkillItemBright()
self.ButtonSkillCancel:setActive(mysterySkillModel:is_ready())

self:showSkillTips(false)
else
self.skillBtnRoot:setActive(false)
end
end

function UIMysteryWin:setSkillItemBright(index,alpha)
local grid=self.SkillListPanel:getChildScrollViewItemWidget(index-1)
if grid then
grid:SetChildDoBrightness(skillItemIndex.root,alpha,0.2,nil)
end
end

function UIMysteryWin:resetSkillItemBright()
if self.readySkill then
local grid=self.SkillListPanel:getChildScrollViewItemWidget(self.readySkill)
if grid then



grid:SetChildActive(skillItemIndex.select,false)
end
end

self.readySkill=nil
end

function UIMysteryWin:skillCancel()


if mysterySkillModel:is_in_skill_effect(eMysterySkillType.eHold)then

mysterySkillModel:set_in_skill_effect(eMysterySkillType.eHold,nil)

mysterySkillModel:remove_all_hold()
return true
end

if mysterySkillModel:is_in_skill_effect(eMysterySkillType.eFlash)then

mysterySkillModel:set_in_skill_effect(eMysterySkillType.eFlash,nil)

mysterySkillModel:remove_all_flash()
return true
end

if mysterySkillModel:is_in_skill_effect(eMysterySkillType.eYuFengHanYing)then
mysterySkillModel:set_in_skill_effect(eMysterySkillType.eYuFengHanYing,nil)

mysterySkillModel:remove_all_yfhy()
return true
end

if mysterySkillModel:is_in_skill_effect(eMysterySkillType.eTanYunShou)then
mysterySkillModel:set_in_skill_effect(eMysterySkillType.eTanYunShou,nil)

mysterySkillModel:remove_all_tys()
return true
end
end

local skillTipsPos={-160,-33,95}
function UIMysteryWin:showSkillTips(show,skillCfg,index)
if show and skillCfg.useSkillTips then
self.skillTips2:setActive(true)
self.skillTips2txt:setText(skillCfg.useSkillTips)
self.skillTips2:setChildAnchoredPos(skillTipsPos[index+1],166.25)
else
self.skillTips2:setActive(false)
end
end

function UIMysteryWin:onSkillItemClick(id,index)

local pause,pType=mysteryAIManager:is_pause()
if mysteryTriggerManager.isInTrigger or pause then
return
end


local skillData=self.probeSkill[index+1]
if not skillData then
return
end
local skillId=skillData.skill_id
local count=skillData.skill_num
local skillCfg=mysterySkillModel.get_skill_config(skillId)
local useTimes=skillCfg.times


if self:skillCancel()then

mysterySkillModel:clear_ready_skill()
self:resetSkillItemBright()
self.ButtonSkillCancel:setActive(mysterySkillModel:is_ready())
self:showSkillTips(false)
return
end
local needUnlock=skillCfg.unlock and skillCfg.unlock==1

local isLock=needUnlock and not QianJiGeModel:is_skill_unlock(skillId)and(self.mustUseSkill~=nil and not self.mustUseSkill[skillId])
if isLock then
UIManager.error('需前往千机阁解锁')
return
end

if mysteryPortalModel:isRoomBanSkill()then
UIManager.error("本层无法使用探索技能")
return
end

if skillCfg.useres then
local cost=skillCfg.useres[1]
if itemsConfig.isMoney(cost[1])then
if not moneyModel.checkEnoughMoney(cost[1],cost[2])then
local name=moneyModel.getMoneyName(cost[1])
UIManager.error(string.format('%s不足',name))
gainControl:showGainWin(cost[1])
return
end
else
local itemCount=bagControl.invokeFuncByItemId(cost[1],'getItemCountByItemID',cost[1])
if itemCount<cost[2]then
local name=itemsConfig.getItemName(cost[1])
UIManager.error(string.format('%s不足',name))
gainControl:showGainWin(cost[1])
return
end
end
end
if useTimes and count<=0 then
UIManager.error('使用次数不足')
return
end

if mysteryAIManager.is_on_round()then
return
end

if mysteryAIManager:check_pause_type(eMysteryPauseType.eWaitToMoveRecv)then
UIManager.error('移动中无法使用技能')
return
end

if mysterySkillModel:is_fb_probeSkill_silent(true)then
return
end


mysterySkillEffectManager:use_skill(skillId)



if mysterySkillModel:is_ready()then
local grids=self.SkillListPanel:getChildScrollViewItemWidgets()
for i=0,grids.Count-1 do
if i==index then




grids[i]:SetChildActive(skillItemIndex.select,true)
end
end
self.readySkill=index

self:showSkillTips(true,skillCfg,index)
end
end

function UIMysteryWin:onButtonSkillCancel()
self:skillCancel()

mysterySkillModel:clear_ready_skill()

self:resetSkillItemBright()

self.ButtonSkillCancel:setActive(mysterySkillModel:is_ready())


end

function UIMysteryWin:onSkillItemLongClick(id,index)
local skillData=self.probeSkill[index+1]
local skillId=skillData.skill_id
UIManager:showWindow("UIQJGSkillTipsWin",{skillId=skillId})
end


function UIMysteryWin:OnEnable()

end


function UIMysteryWin:OnDisable()

end


function UIMysteryWin:showRecordPanel(itemList)
self.RecordListPanel:setChildScrollViewCreateGrids(#itemList,1)
local grids=self.RecordListPanel:getChildScrollViewItemWidgets()
for i=1,grids.Count do
if itemList[i]then
local itemId=itemList[i][1]
local count=itemList[i][2]
local itemguid=itemList[i][3]
local item_config=itemsConfig.getConfig(itemId)

local item=grids[i-1]
if item and item_config then

local color=nil
if item_config.color==FONT_COLOR.ePurpleColor then
color="#bb8cf1"
else
color=FONT_COLOR_VAL[item_config.color]
end
item:SetChildText(0,FMT.fmt("获得【<color={0}>{1}</color> x{2}】",color,item_config.name,count))
item:SetChildButtonClick(0,function()
tipsManager.showTips({formType=TIPS_FORM_TYPE.eNone,itemid=itemId,itemguid=itemguid})
end)
end
end
end
end


function UIMysteryWin:showRecordCorner()
local count=mysteryTreasureModel:getCornerCount()
if count>0 then
self.corner:setActive(true)
self.cornerText:setText(count)
else
self.corner:setActive(false)
end
end

function UIMysteryWin:getRecordCornerPos()
return self.logButton:getChildPosition()
end

function UIMysteryWin:playLogButtonAni()
if self.scaleTween then
self.scaleTween:Kill()
end
self.scaleTween=self.logButton:setChildDOScale(1.2,0.3)
self.scaleTween:SetEase(_Ease.Linear)
self.scaleTween:SetLoops(2,_LoopType.Yoyo)
end


function UIMysteryWin:showTriggerItemPanel()
local fbid=MysteryModel:get_cur_fbid()
if not fbid then
return
end
local cfg=cfg_secretscenefubenconfig_get(fbid)
local triggerItem=cfg.triggerItem
if triggerItem then
local tpList=triggerItem[1]
local hide=triggerItem[3]
if hide==1 then
return
end
self.triggerItemGrid:setActive(true)
self.triggerItemButton:setActive(true)
self.triggerItemGrid:setChildLayoutGroupCreateItems(#tpList)
local grids=self.triggerItemGrid:getChildLayoutGroupGridList()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local tpId=tpList[i]
local tpConfig=cfgHelper.get(cfg_mijingfakeitemconfig_get,tpId)
if tpConfig then
local icon=tpConfig.icon
if icon then
item:SetChildIcon(0,icon,false)
end
local num=MysteryModel:get_fake_item_count(tpId)
item:SetChildText(1,FMT.fmt("x{0}",num))
end
end
end
end

function UIMysteryWin:onTriggerItemButton()
local fbid=MysteryModel:get_cur_fbid()
if not fbid then
return
end
local cfg=cfg_secretscenefubenconfig_get(fbid)
local triggerItem=cfg.triggerItem
if triggerItem then
local helpId=triggerItem[2]
local descStr=cfgHelper.get1(cfg_lang_get,helpId)or'语言表未配置'
local pos=Vector2.New(-18,-25)
UIManager:showWindow('UIConditionTipsOne',{str=descStr,showType=4,posItem=self.triggerItemButton,pos=pos})
end
end



function UIMysteryWin:onButtonCloseBg()
local pause,pType=mysteryAIManager:is_pause()
if pType==eMysteryPauseType.eTeamDead then
pause=false
end
if mysteryTriggerManager.isInTrigger or pause then
return
end

local fbId=self.fbId or MysteryModel:get_cur_fbid()

if mysteryAIManager.is_on_round()then
mysteryAIManager:stop_ai()
end


if MysteryModel:is_practice_mystery(fbId)then
MysteryModel:set_fb_finish(eMysteryQuitType.eBreak)
MysteryController.send_4_27()
MysteryController.send_4_4(fbId)
return
end

if self.hasQuitTips then
if MysteryModel:get_fb_progress()>=100 then
MysteryModel:set_fb_finish(eMysteryQuitType.eFinish)
notifySystem:postNotify(notifyConfig.on_mystery_finish,fbId)
MysteryController.send_4_27()
else
local showdata=
{
type='UIDialougeHighest',
title='提示',
content='即将离开秘境，请问师尊是打算？',
canceltext='返 回',
oktext='队伍撤离',
allowclickBG='false',
cancelcallback=function(...)
local pause,pType=mysteryAIManager:is_pause()
if pType==eMysteryPauseType.eTeamDead then
pause=false
end
if mysteryTriggerManager.isInTrigger or pause then
return
end
MysteryModel:set_fb_finish(eMysteryQuitType.eBreak)
MysteryController.send_4_27()
end,
okcallback=function(...)
local pause,pType=mysteryAIManager:is_pause()
if pType==eMysteryPauseType.eTeamDead then
pause=false
end
if mysteryTriggerManager.isInTrigger or pause then
return
end
MysteryModel:set_fb_finish(eMysteryQuitType.eBreak)
MysteryController.send_4_27()
MysteryController.send_4_4(fbId)
end,
showclosebtn=true,
}
if self.comfirmDialog then
self.comfirmDialog.deleteSelf=function(...)

if self and not self.isClose then
self.comfirmDialog=nil
end
end
else
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog.deleteSelf=function(...)

if self and not self.isClose then
self.comfirmDialog=nil
end
end
self.comfirmDialog:show()
end
end
else
MysteryModel:set_fb_finish(eMysteryQuitType.eBreak)
MysteryController.send_4_27()
end
end


function UIMysteryWin:onButtonTeamHide()
if not self.TeamHide then
self:onButtonTeam()
end
end


function UIMysteryWin:onButtonTeamShow()
if self.TeamHide then
self:onButtonTeam()
end
end

function UIMysteryWin:onButtonTeam()
if self.teamRoot:getTransform()then
self.TeamHide=self.TeamHide or false



self.teamRoot:setChildDOAnchorPosX(self.TeamHide and 0 or-770,0.1,function()
if self and not self.isClose then
self.TeamHide=not self.TeamHide
self.ButtonTeamHide:setActive(not self.TeamHide)
self.ButtonTeamShow:setActive(self.TeamHide)

end
end)
end
end


function UIMysteryWin:onButtonSkillHide()
self.SkillAnim:setChildModelAnimationState(eAnimationID.idle1,1,function()
self.SkillAnim:setChildModelAnimationState(eAnimationID.stand,1)
end)
self.ButtonSkillHide:setActive(false)

local skillGo=self.skillRoot:getGameObject()
if skillGo~=nil and skillGo.activeSelf then
self.skillRoot:setChildDOAnchorPosX(self.SkillHide and 400 or-129.5,0.35,
function()
self.ButtonSkillShow:setActive(true)
end)
self.skillRoot:setChildCanvasGroupDOFade(0,0.25)
end
self.SkillHide=not self.SkillHide
end

function UIMysteryWin:onButtonSkillShow()
self.SkillAnim:setChildModelAnimationState(eAnimationID.idle2,1,function()
self.SkillAnim:setChildModelAnimationState(eAnimationID.idle3_loop,1)
end)
self.ButtonSkillShow:setActive(false)

local skillGo=self.skillRoot:getGameObject()
if skillGo~=nil and skillGo.activeSelf then
self.skillRoot:setChildDOAnchorPosX(self.SkillHide and 400 or-129.5,0.35,function()
self.ButtonSkillHide:setActive(true)
end)
self.skillRoot:setChildCanvasGroupDOFade(1,0.25)
end
self.SkillHide=not self.SkillHide
end

function UIMysteryWin:changeSkillVisible()
local skillGo=self.skillRoot:getGameObject()

if skillGo~=nil and skillGo.activeSelf then
local eSkillRootPos={-142,-142,-142}
local skillRootPos=400
if#self.probeSkill>0 then
skillRootPos=eSkillRootPos[#self.probeSkill]
end

self.skillRoot:setChildAnchoredPosition(Vector3(self.SkillHide and skillRootPos or 400,-12,0))
self.ButtonSkillShow:setActive(not self.SkillHide)
self.ButtonSkillHide:setActive(self.SkillHide)
end
end

function UIMysteryWin:onSkillBookFinish()
self:changeSkillVisible()
end

function UIMysteryWin:onBagButton()
local pause,pType=mysteryAIManager:is_pause()
if pType==eMysteryPauseType.eTeamDead then
pause=false
end

if mysteryTriggerManager.isInTrigger or pause or mysteryAIManager.is_on_round()then
return
end

UIFullMysteryMainControl:showWindow("UIMysteryRuleBagWin")
end

function UIMysteryWin:onLogButton()
if not self.recordPanelShow then
local itemList=mysteryTreasureModel:getRecordItemList()
if next(itemList)then




self:showWindow("UIMysteryItemDropWin",{itemsList=itemList})
else
UIManager.error("暂无奖励记录")
end
mysteryTreasureModel:initCornerCount()
self:showRecordCorner()
else



end
end

function UIMysteryWin:onNewBieCom()

end

function UIMysteryWin:onTeamChangeButton()
local pause,pType=mysteryAIManager:is_pause()
if pType==eMysteryPauseType.eTeamDead then
pause=false
end
if mysteryTriggerManager.isInTrigger or pause or mysteryAIManager.is_on_round()then
return
end
UIManager:closeWindow("UIWorldBossWin")
UIFullMysteryMainControl:showMysteryChangeTeamWin({fbId=MysteryModel:get_cur_fbid()})
end

function UIMysteryWin:onButonEvt()
if self.butonEvtClick then
self.butonEvtClick()
end
end

function UIMysteryWin:onFazeMask()
self.faZeList:setActive(false)
end

function UIMysteryWin:setAutoMode(flag)
MysteryGuildOrder:setAutoMode(flag)
self.autoImg:setActive(MysteryGuildOrder:isInAuto())
self.startAutoButton:setActive(not flag)
self.cancelAutoButton:setActive(flag)

end

function UIMysteryWin:onStartAutoButton()
if self.autoReason==eMysteryOrderReason.ePassMystery then
UIManager.error("通关过该秘境方可使用")
return
elseif self.autoReason==eMysteryOrderReason.eOrderActive then
UIManager.error("在宗门大殿研究\"自动探索\"法令方可使用")
return
elseif self.autoReason==eMysteryOrderReason.eOrderSetupOpen then
UIManager.error("宗门法令\"自动探索\"未启用")
return
end
self:setAutoMode(true)


UIManager.info("开始自动探索秘境")
end

function UIMysteryWin:onCancelAutoButton()
self:setAutoMode(false)


UIManager.info("取消自动探索秘境")
end

function UIMysteryWin:setOrder(flag)
local setup=guildOrderModel:getSetupData(GUILD_ORDER_TYPE.eMysteryAuto)
setup.isOpen=flag
guildOrderModel:flushSetupData(GUILD_ORDER_TYPE.eMysteryAuto)
guildOrderModel:changeSetupOpen(GUILD_ORDER_TYPE.eMysteryAuto,setup.isOpen)
end