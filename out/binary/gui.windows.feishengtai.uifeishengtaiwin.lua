







def_class("UIFeiShengTaiWin",UIWindowBase)









function UIFeiShengTaiWin:bindComponents()

self.btnAddDis=UIButton.get(self,0)
self.btnChangeDz=UIButton.get(self,1)
self.btnDuJie=UIButton.get(self,2)
self.btnFinishLv=UIButton.get(self,3)
self.btnSpeedup=UIButton.get(self,4)
self.btnUpgrade=UIButton.get(self,5)
self.btnUpgradeText=UIText.get(self,6)
self.buliding=UIObject.get(self,7)
self.DescListPanel=UIObject.get(self,8)
self.firstPanel=UIObject.get(self,9)
self.icon=UIObject.get(self,10)
self.introduceBtn=UIButton.get(self,11)
self.itemroot=UIObject.get(self,12)
self.itemspeed1=UIBaseItem.get(self,13)
self.itemspeed2=UIBaseItem.get(self,14)
self.itemspeed3=UIBaseItem.get(self,15)
self.levelUpTime=UIText.get(self,16)
self.model=UIObject.get(self,17)
self.notOpenRoot=UIObject.get(self,18)
self.rewardBtn=UIButton.get(self,19)
self.rewardreddot=UIObject.get(self,20)
self.speakObj=UIObject.get(self,21)
self.speakText=UIText.get(self,22)
self.sureroot=UIObject.get(self,23)
self.timeroot=UIObject.get(self,24)
self.title=UIText.get(self,25)
self.txtAddDis=UIText.get(self,26)
self.txtCurLevel=UIText.get(self,27)
self.txtIntroduction=UIText.get(self,28)
self.txtJingjie=UIText.get(self,29)
self.txtName=UIText.get(self,30)
self.txtSpeciality=UIText.get(self,31)
self.txtSuccess=UIText.get(self,32)
self.txtSucess=UIText.get(self,33)
self.txtTeZhi=UIText.get(self,34)

self.btnAddDis:setButtonClick(function()self:onBtnAddDis()end)

self.btnChangeDz:setButtonClick(function()self:onBtnChangeDz()end)

self.btnDuJie:setButtonClick(function()self:onBtnDuJie()end)

self.btnFinishLv:setButtonClick(function()self:onBtnFinishLv()end)

self.btnSpeedup:setButtonClick(function()self:onBtnSpeedup()end)

self.btnUpgrade:setButtonClick(function()self:onBtnUpgrade()end)

self.introduceBtn:setButtonClick(function()self:onIntroduceBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)



end


function UIFeiShengTaiWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.btnAddDis);self.btnAddDis=nil;
_UIObject_release(self.btnChangeDz);self.btnChangeDz=nil;
_UIObject_release(self.btnDuJie);self.btnDuJie=nil;
_UIObject_release(self.btnFinishLv);self.btnFinishLv=nil;
_UIObject_release(self.btnSpeedup);self.btnSpeedup=nil;
_UIObject_release(self.btnUpgrade);self.btnUpgrade=nil;
_UIObject_release(self.btnUpgradeText);self.btnUpgradeText=nil;
_UIObject_release(self.buliding);self.buliding=nil;
_UIObject_release(self.DescListPanel);self.DescListPanel=nil;
_UIObject_release(self.firstPanel);self.firstPanel=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.introduceBtn);self.introduceBtn=nil;
_UIObject_release(self.itemroot);self.itemroot=nil;
_UIObject_release(self.itemspeed1);self.itemspeed1=nil;
_UIObject_release(self.itemspeed2);self.itemspeed2=nil;
_UIObject_release(self.itemspeed3);self.itemspeed3=nil;
_UIObject_release(self.levelUpTime);self.levelUpTime=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.notOpenRoot);self.notOpenRoot=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardreddot);self.rewardreddot=nil;
_UIObject_release(self.speakObj);self.speakObj=nil;
_UIObject_release(self.speakText);self.speakText=nil;
_UIObject_release(self.sureroot);self.sureroot=nil;
_UIObject_release(self.timeroot);self.timeroot=nil;
_UIObject_release(self.title);self.title=nil;
_UIObject_release(self.txtAddDis);self.txtAddDis=nil;
_UIObject_release(self.txtCurLevel);self.txtCurLevel=nil;
_UIObject_release(self.txtIntroduction);self.txtIntroduction=nil;
_UIObject_release(self.txtJingjie);self.txtJingjie=nil;
_UIObject_release(self.txtName);self.txtName=nil;
_UIObject_release(self.txtSpeciality);self.txtSpeciality=nil;
_UIObject_release(self.txtSuccess);self.txtSuccess=nil;
_UIObject_release(self.txtSucess);self.txtSucess=nil;
_UIObject_release(self.txtTeZhi);self.txtTeZhi=nil;
end




















local ab='ui/sharedtextures/uiglobalspriteatlas_1.ab'

local _this=nil
local _format=string.format


function UIFeiShengTaiWin:onLoaded(...)
self:bindComponents()

_this=self
notifySystem:listenNotify(notifyConfig.building_event,self.on_building_event)
end


function UIFeiShengTaiWin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.building_event,self.on_building_event)
_this=nil
UIManager:closeWindow('UITopMoneyWin2')
end




function UIFeiShengTaiWin:onShow(argtable,afterOnloaded)

if argtable then
local guid=argtable.entityId
if guid then
self.sfId=zongmenModel:getMountainId()
self.bdData=zongmenModel:findBuildingByEntityId(guid)
else
self.bdData=argtable.bdDatas
end
end

self:refreshWindow()

UIManager:showWindow('UITopMoneyWin2',{canvasIndex=5,moneys={{eMoneyType.mtLingShi}}})




end

function UIFeiShengTaiWin:refreshWindow()
self.select_dis=0

local pingbi=not FeiShengTaiModel:judeYetFeiSheng()
self.sureroot:setActive(not pingbi)
self.notOpenRoot:setActive(pingbi)
if not pingbi then
self:showLeftPanel()
end
self:showRightPanel()

local reddotflag,rewardflag=FeiShengTaiModel:GetRewardreddot()

self.rewardBtn:setActive(rewardflag)
self.rewardreddot:setActive(reddotflag)
end

function UIFeiShengTaiWin:showLeftPanel()
local guid=self.select_dis or 0


if tostring(guid)~='0'then
local netData=UIDiscipleModel:getDiscipleData(guid)
local jjlv=netData.jingjielv
local jjName,p,pN=UIDiscipleModel:getJJNameX(jjlv)
local jjStr=p and FMT.fmt('{0}\n<size=16>({1})</size>',jjName,pN)or jjName
local successRate=FeiShengTaiModel:getDiscipleBrokeSuccessRate(guid)
self.txtName:setText(UIDiscipleModel:getDiscipleName(guid))
self.txtJingjie:setText(jjStr)
self.txtSuccess:setText(FMT.fmt('成功率：{0}%',successRate))
self.btnChangeDz:setActive(true)
self.btnAddDis:setActive(false)


self.DescListPanel:setActive(false)























else
self.DescListPanel:setActive(false)

self.txtTeZhi:setText('')
self.txtName:setText('')
self.txtJingjie:setText('')
self.txtSpeciality:setText('')
self.txtAddDis:setText('安排弟子')


self.itemspeed3:setActive(false)
self.btnChangeDz:setActive(false)
self.btnAddDis:setActive(true)
self.txtSuccess:setText("")
end
self:SetItemData()
self:showModel()

end

function UIFeiShengTaiWin:getFeiShengEffects(guid)
local configs=UIDiscipleModel:getDiscipleSpecialityConfig(guid)
if#configs>0 then
local feiSheng_effects={}
for i,cfg in ipairs(configs)do
if FeiShengTaiModel:isFeiShengSpeciality(cfg.specialitytype,cfg.id)then
table.insert(feiSheng_effects,cfg)
end
end
if#feiSheng_effects>0 then
return feiSheng_effects
end
end
end

function UIFeiShengTaiWin:showRightPanel()











self:refreshLevelUp()
end

function UIFeiShengTaiWin.on_building_event(etype,sfId,bdId,args)
if etype==buildingEvent.levelUpStart then
_this:showRightPanel()
elseif etype==buildingEvent.levelUpComplete then
_this:showRightPanel()
elseif etype==buildingEvent.speedUpComplete then
_this:showRightPanel()
end
end

function UIFeiShengTaiWin:refreshLevelUp()
local nextLvCfg=cfgHelper.get2(cfg_monijybuilduplvlconfig_get,self.bdData.build_id,self.bdData.level+1)

if self.bdData and self.bdData.level then
self.txtCurLevel:setText(FMT.fmt("{0}级飞升台",self.bdData.level))
end
if nextLvCfg then
self.btnUpgradeText:setText('升级建筑')

self.timeroot:setActive(false)
self.levelUpTime:setActive(false)
self.btnSpeedup:setActive(false)
self.btnFinishLv:setActive(false)
self.btnUpgrade:setActive(true)

































else
self.btnUpgradeText:setText('建筑信息')
self.timeroot:setActive(false)
self.levelUpTime:setActive(false)
self.btnSpeedup:setActive(false)
self.btnFinishLv:setActive(false)
end
end

function UIFeiShengTaiWin:stopLevelUpTimer()
if self.levelUpTimer then
self:stopTimerByID(self.levelUpTimer)
self.levelUpTimer=nil
end
end


function UIFeiShengTaiWin:onHide()
UIManager:closeWindow('UITopMoneyWin2')
end

function UIFeiShengTaiWin:onClickClose()
self:closeSelf()
end

function UIFeiShengTaiWin:onSelectDis(guid)
self.select_dis=guid
self:showLeftPanel()
end





function UIFeiShengTaiWin:onBtnUpgrade()
self.bdData.feishengtai=true
UIManager:showWindow('UIBuildingInfoWin',self.bdData)
end

function UIFeiShengTaiWin:onBtnAddDis()
if self.bdData.flag==2 then
UIManager.info("飞升台升级中，完成升级后才可使用")
return
end

local args={
openType=dzSelectWinOpenType.eFeiSheng,
bdData=self.bdData,

callback=function(guid)
self:onSelectDis(guid)
end,
select_dis=self.select_dis,
}

UIManager:showWindow("UIDiscipleSelectWin_feisheng",args)
end

function UIFeiShengTaiWin:onBtnDuJie()
if FeiShengTaiModel:haveLightningDisciple()then
UIManager.error("飞升台占用中")
return
end

if self.select_dis and self.select_dis~=0 and UIFeiShengTaiWin:checkCostEnough()then
FeiShengTaiModel:saveDzOldData(self.select_dis)
FeiShengTaiController:Send_FeiSheng(self.select_dis)
end

if not self.select_dis or self.select_dis==0 then
UIManager.error("请先选择需要飞升的弟子")
self:onBtnAddDis()
end
end

function UIFeiShengTaiWin:getThunderTalkText(guid)
local talkTextList={}
local list={1,3,5,6,7,8}
local jobid=UIDiscipleModel:getDiscipleJob(guid)
local config=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,jobid,'thunder')

for i=1,3 do
local rdmIndex=math.random(1,#list)
local index=list[rdmIndex]
local temp={}

for j,v in ipairs(list)do
if v~=index then
table.insert(temp,v)
end
end
list=temp

local talkList=config[index]
rdmIndex=math.random(1,#talkList)
local talk_str=talkList[rdmIndex]

table.insert(talkTextList,talk_str)
end

return talkTextList[1],talkTextList[2],talkTextList[3]
end

function UIFeiShengTaiWin:checkCostEnough()
local feisheng_cost=cfgHelper.get2(cfg_feishengjctjbasicconfig_get,1,'feisheng_cost')
local cost=feisheng_cost[90]

for k,v in ipairs(cost)do
local itemId=v[1]
local useCount=v[2]
local haveCount=itemsModel.getCount(itemId)

if haveCount<useCount then
UIManager.error('材料不足')
gainControl:showGainWin(itemId)
return false
end
end
return true
end

function UIFeiShengTaiWin:moveEntity()
local speed=5
local targetPos=Vector3Int(-17.5,-8,0)
local tran=_MapManager.GetTilemapObjectTransform(_this.stId)
local wpos=_MapManager.GetCellCenterWorld(zongmenModel:getMountainId(),targetPos,mapLayer.Data)
wpos.y=wpos.y+5

local mpos=tran.position
local dis=Vector3.Distance(wpos,mpos)
local duration=dis/speed

self.tweener=_DOTweenProxy.DOMove(tran,wpos,duration)
self.tweener:SetEase(_Ease.Linear)

self.tweener:OnComplete(function(...)
FeiShengTaiController:closeDuJieFeiSheng()
end)
end

function UIFeiShengTaiWin:duJieAnim(guid)

local scale=0.9
local text1,text2,text3=_this:getThunderTalkText(guid)

local rolespeaktxt=roleAudioController:getplayRoleSpeakTxt(guid,roleAudioNodeType.JingJieTiSheng_succes)

local mapId=zongmenModel:getMountainId()
local pos=_MapManager.ToVector3Int(-52,-17,0)
local info=UIDiscipleModel:getDiscipleImageInfo(guid)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(info)
local bodyid=modelParams.body
local componets=modelParams.componets
_this.stId=isometricMapSystem:createRoleEntity(objectType.eRole,mapId,0,bodyid,componets,SortingLayers.ITBuilding,scale,pos)

local args={
dzTalk1=text1,
dzTalk2=text2,
dzTalk3=text3,
stId=_this.stId,
rolespeaktxt=rolespeaktxt,
targetPos=Vector3Int(-17.5,-8,0),
isMapPos=true,
isChangeContainer=true,
}
local bt=behaviorManager:addBehaviorTree("ai_dz_feishengtdujie",args,true,args,true)
FeiShengTaiModel:setId(bt,_this.stId)


isometricMapSystem:enterStoryMode()

AudioManager.setPauseBGMusic(true)
end

function UIFeiShengTaiWin:onBtnSpeedup()
self.bdData.feishengtai=true
UIManager:showWindow('UIBuildingInfoWin',self.bdData)
end

function UIFeiShengTaiWin:onBtnFinishLv()
zongmenControl:reqBuildingLevelUpComplete(self.sfId,self.bdData.un_build_id)
end



function UIFeiShengTaiWin:SetItemData()
local feisheng_cost=cfgHelper.get2(cfg_feishengjctjbasicconfig_get,1,'feisheng_cost')

local cost=feisheng_cost[90]
if not cost then
return
end
for i=1,3 do
local widget=nil
if i==1 then
self.itemspeed1:setActive(true)
widget=self.winlua:GetChildWidgetBase(self.itemspeed1:getID())
elseif i==2 then
self.itemspeed2:setActive(true)
widget=self.winlua:GetChildWidgetBase(self.itemspeed2:getID())
elseif i==3 then
self.itemspeed3:setActive(true)
widget=self.winlua:GetChildWidgetBase(self.itemspeed3:getID())
end
if cost[i]then
local itemConfig=itemsConfig.getConfig(cost[i][1])
local color=itemConfig.color
widget:SetChildIcon(1,iconHelper.getIconName(cost[i][1]),false)
local costnum=cost[i][2]
local havenum=itemsModel.getCount(cost[i][1])
local moneystr=mathHelper.formatNumber4(tonumber(costnum),1)
if costnum>havenum then
moneystr=FMT.fmt("<color={0}>{1}</color>",FONT_COLOR_VAL[FONT_COLOR.eRedColor],moneystr)
end
widget:SetChildText(2,moneystr)
widget:SetChildActive(9,true)
widget:SetChildQulaity(0,color)
widget:SetChildButtonClick(1,function(...)
itemsComponentHelper.onItemClickEx(cost[i][1])
end)
end

end
end


function UIFeiShengTaiWin:showModel()
local dzguid=self.select_dis or 0
if dzguid==0 then
self.speakObj:setChildCanvasGroupAlpha(0)
self:clearSpeakTimer()
self.model:setChildUIModelRemoveTarget()
return
end
self.model:setChildUIModelRemoveTarget()
local args={
tmLv=UIDiscipleModel:getTianMingLevel(dzguid),
}
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(dzguid,true,1,args)

modelParams.anim=mountHelper.getMountAni(dzguid,modelParams.anim)
self.model:setChildUIModelShowTarget(modelParams.body,modelParams.scale,modelParams.componets,modelParams.anim,false,false)
self.npcTalkTime=5
self.npcTalkShowTime=5
self:delayDo(0.3,function()
self:doSpeaking()
end)
end

function UIFeiShengTaiWin:doSpeaking()
self:clearSpeakTimer()
local speaktable=cfgHelper.get2(cfg_feishengjctjbasicconfig_get,1,'fstdizi_txt')

local rand=math.random(1,#speaktable)
local speakStr=speaktable[rand]
self.speakObj:setChildCanvasGroupAlpha(1)
self.speakText:setChildTrendsTextPlay(speakStr,30,nil)
self:doTalkAnim()

end

function UIFeiShengTaiWin:doTalkAnim()
if self.talkTween~=nil then
self.talkTween:Kill()
self.talkTween=nil
end
self.speakObj:setScale(Vector3.zero)
self:delayDo(0.5,function()
self.speakObj:setChildCanvasGroupAlpha(1)
self.talkTween=self.speakObj:setChildDOScale(1.2,0.2,function()
if _this==nil then return end
_this.talkTween=nil
_this.talkTween=_this.speakObj:setChildDOScale(1,0.1,function()
if _this==nil then return end
_this.talkTween=nil
return _this:talkEnd()
end)
end)
end)
end


function UIFeiShengTaiWin:talkEnd()
self:clearSpeakTimer()
self.speakShowTimer=self:delayDo(self.npcTalkShowTime,function()

self.speakObj:setScale(Vector3.zero)

self.speakTimer=self:delayDo(self.npcTalkTime,function()
return self:doSpeaking()
end)
end)
end


function UIFeiShengTaiWin:clearSpeakTimer()
if self.speakTimer then
self:stopTimerByID(self.speakTimer)
self.speakTimer=nil
end

if self.speakShowTimer then
self:stopTimerByID(self.speakShowTimer)
self.speakShowTimer=nil
end
end

function UIFeiShengTaiWin:onBtnChangeDz()
self:onBtnAddDis()
end


function UIFeiShengTaiWin:onIntroduceBtn()
tipsManager.closeTips()
local d={}
d.title='规则说明'
d.mode=3
d.name='feishengtai_repair_rule_%d'
d.closeCB=function()
end
UIManager:showWindow('UIRuleWin',d)
end


function UIFeiShengTaiWin:onRewardBtn()
UIManager:showWindow("UIFST_repairRewardWin",{FSTstage=self.FSTstage})

end