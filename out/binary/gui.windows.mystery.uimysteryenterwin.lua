







def_class("UIMysteryEnterWin",UIWindowBase)









function UIMysteryEnterWin:bindComponents()

self.aim2Panel=UIObject.get(self,0)
self.aimPanel=UIObject.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.closeTxt=UIText.get(self,3)
self.colorTitle=UIImage.get(self,4)
self.costImage=UIImage.get(self,5)
self.costPanel=UIObject.get(self,6)
self.costTxt=UIText.get(self,7)
self.detailBtn=UIButton.get(self,8)
self.effect=UIObject.get(self,9)
self.enterButton=UIButton.get(self,10)
self.enterTxt=UIText.get(self,11)
self.environmentPanel=UIObject.get(self,12)
self.environmentTxt=UIText.get(self,13)
self.fbTitleTxt=UIText.get(self,14)
self.leftJianTou=UIObject.get(self,15)
self.model=UIObject.get(self,16)
self.moneybar=UIObject.get(self,17)
self.moneyBars_1=UIButton.get(self,18)
self.moneyBars_2=UIButton.get(self,19)
self.moneyBars_3=UIButton.get(self,20)
self.progressTxt=UIText.get(self,21)
self.quitButton=UIButton.get(self,22)
self.rewards=UIObject.get(self,23)
self.rightJianTou=UIObject.get(self,24)
self.root=UIObject.get(self,25)
self.strengthTxt=UIText.get(self,26)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.detailBtn:setButtonClick(function()self:onDetailBtn()end)

self.enterButton:setButtonClick(function()self:onEnterButton()end)

self.moneyBars_1:setButtonClick(function()self:onMoneyBars_1()end)

self.moneyBars_2:setButtonClick(function()self:onMoneyBars_2()end)

self.moneyBars_3:setButtonClick(function()self:onMoneyBars_3()end)

self.quitButton:setButtonClick(function()self:onQuitButton()end)
self.moneyBars={
self.moneyBars_1,
self.moneyBars_2,
self.moneyBars_3,
}



end


function UIMysteryEnterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.aim2Panel);self.aim2Panel=nil;
_UIObject_release(self.aimPanel);self.aimPanel=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.closeTxt);self.closeTxt=nil;
_UIObject_release(self.colorTitle);self.colorTitle=nil;
_UIObject_release(self.costImage);self.costImage=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.costTxt);self.costTxt=nil;
_UIObject_release(self.detailBtn);self.detailBtn=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.enterButton);self.enterButton=nil;
_UIObject_release(self.enterTxt);self.enterTxt=nil;
_UIObject_release(self.environmentPanel);self.environmentPanel=nil;
_UIObject_release(self.environmentTxt);self.environmentTxt=nil;
_UIObject_release(self.fbTitleTxt);self.fbTitleTxt=nil;
_UIObject_release(self.leftJianTou);self.leftJianTou=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.moneybar);self.moneybar=nil;
_UIObject_release(self.moneyBars_1);self.moneyBars_1=nil;
_UIObject_release(self.moneyBars_2);self.moneyBars_2=nil;
_UIObject_release(self.moneyBars_3);self.moneyBars_3=nil;
_UIObject_release(self.progressTxt);self.progressTxt=nil;
_UIObject_release(self.quitButton);self.quitButton=nil;
_UIObject_release(self.rewards);self.rewards=nil;
_UIObject_release(self.rightJianTou);self.rightJianTou=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.strengthTxt);self.strengthTxt=nil;
self.moneyBars=nil;
end


















local skillSlot={}

local colorBg={
[1]="frame_mijingrwcknd_1",
[2]="frame_mijingrwcknd_2",
[3]="frame_mijingrwcknd_3",
[4]="frame_mijingrwcknd_4",
[5]="frame_mijingrwcknd_5",
}

local colorEffect={
[1]=10119,
[2]=10120,
[3]=10121,
[4]=10122,
[5]=10123,
}

local abName="ui/windows/mystery/sharedtextures/outmysterysprite.ab"

local _this=nil


function UIMysteryEnterWin:onLoaded(...)
self:bindComponents()
_this=self

self:setModel()

self:addNotify(notifyConfig.onXianJieCameraMove,self.onXianJieCameraMove)
self:addNotify(notifyConfig.onXianJieCameraZoom,self.onXianJieCameraZoom)
self:addNotify(notifyConfig.onClickXianJiePlane,self.onClickXianJiePlane)
self:addNotify(notifyConfig.on_money_changed,function(...)self:onMoneyChanged(...)end)
self.environmentPanel:setChildScrollViewInit(0.5,true,function(...)self:onEnvironmentItemClick(...)end,nil)
end


function UIMysteryEnterWin:onHide()
self.info=nil
UIManager:showWindow("UITaskListWin")


notifySystem:removelistener(notifyConfig.swipe,self.on_swipe)
notifySystem:removelistener(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)
end


function UIMysteryEnterWin:__delete()
self:unbindComponents()
notifySystem:removelistener(notifyConfig.swipe,self.on_swipe)
notifySystem:removelistener(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)
_this=nil
end




function UIMysteryEnterWin:onShow(argtable,afterOnloaded)
if not argtable then
return
end

notifySystem:listenNotify(notifyConfig.swipe,self.on_swipe)
notifySystem:listenNotify(notifyConfig.onClickEmptyInWorld,self.onClickEmptyInWorld)

self.fbid=argtable.id
self.closeBtn:setActive(argtable.closeBg==true)

self:refreshConfigWin()

local data=MysteryModel:getFBInfoData(self.fbid)
if data and data[1]~=nil then
self:refreshWin(data)
self.waitToRefresh=false
else

MysteryController.send_4_3(self.fbid)
self.waitToRefresh=true
end



self:refreshAimList()
self:refreshEnvironmentList()




end

function UIMysteryEnterWin:onCloseBtn()
local sceneType=MysteryModel:get_mystery_sence_type(self.fbid)
if sceneType==MysterySenceType.XianJieResPoint then
xianjieController:closeWin("UIMysteryEnterWin")
else
worldController:resetRightView()
end
end

function UIMysteryEnterWin.on_swipe()
if worldController:isInWorld()and not MysteryModel:is_enter_Mystery()then
worldController:resetRightView()
end
end

function UIMysteryEnterWin.onClickEmptyInWorld()
if worldController:isInWorld()and not MysteryModel:is_enter_Mystery()then

AudioManager.playCloseUI()
worldController:resetRightView()
end
end

function UIMysteryEnterWin.onXianJieCameraMove()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end

function UIMysteryEnterWin.onXianJieCameraZoom()
if _this==nil or not _this.isVisible then return end
xianjieController:closeWin3()
end

function UIMysteryEnterWin.onClickXianJiePlane(gridX,gridZ,worldX,worldZ)
if _this==nil or not _this.isVisible then return end
_this:onCloseBtn()
end

function UIMysteryEnterWin:refreshConfigWin()
local cfg_fb=cfg_secretscenefubenconfig_get(self.fbid)
self.cfg_fb=cfg_fb
local moneyList={}
local moneyMap={}
local data=MysteryModel:get_mysteryFB_list_data_fbid(self.fbid)
if cfg_fb and data then
local difficulty_text_color=cfg_secretscenebaseconfig_get(1).fb_quality
local fb_color=cfg_fb.color
local color_cfg=difficulty_text_color[fb_color]
self.effect:setChildShowEffect(colorEffect[fb_color],true)
self.colorTitle:setCSImageSprite(abName,colorBg[fb_color])
local mysteryPanelCfg=cfgHelper.get1(cfg_secretsceneuishowconfig_get,cfg_fb.uiOpen)
if mysteryPanelCfg.nandu then
self.fbTitleTxt:setText(cfg_fb.name)
else
self.fbTitleTxt:setText(FMT.fmt("{0}({1})",cfg_fb.name,color_cfg[1]))
end
if cfg_fb.useResEnter then
for i,v in ipairs(cfg_fb.useResEnter)do
table.insert(moneyList,v[1])
moneyMap[v[1]]=i
end
end
end
self.moneyList=moneyList
self.moneyMap=moneyMap
self:initMoneyBar(moneyList)
end

function UIMysteryEnterWin:refreshWin(info,needWait)
if info then
self.fbid=info[1]
self.info=info
end

self.needItemsFlag=info[17]==1

if not needWait then
self.waitToRefresh=false
end


UIManager:hideWindow("UITaskListWin")



local percent=info[2]
MysteryModel.selectFBid=self.fbid
local cfg_fb=cfg_secretscenefubenconfig_get(self.fbid)
self.cfg_fb=cfg_fb
local data=MysteryModel:get_mysteryFB_list_data_fbid(self.fbid)
if cfg_fb and data then
self.progressTxt:setText(FMT.fmt("探索进度{0}%",percent))
local cost=cfg_fb.useResEnter
if cost then
self.cost=type(cost[1])=="number"and cost or cost[1]
end
end

local lv=MysteryModel:get_mysteryFB_ndLevel(self.fbid)or 1
local rewards,detail=MysteryModel:getShowAwards(self.fbid,lv)
self.detail=detail
self.detailBtn:setActive(next(self.detail)~=nil)
local JJName=UIDiscipleModel.getJJNameCommon(lv,3)
self.strengthTxt:setText(FMT.fmt("推荐平均境界： <color=#fd8950>{0}</color>",JJName))

if rewards then
self.rewards:setChildLayoutGroupCreateItems(#rewards)
local items=self.rewards:getChildLayoutGroupGridList()
for i=0,items.Count-1 do
local item=items[i]
local data=rewards[i+1]
if data[2]==-1 then
data.itemCount=-1
elseif data[2]==-2 then
data.itemCount=-2
elseif data[2]==1 then
data.countText=''
end
local cfg=itemsConfig.getConfig(data[1])
data.stage=cfg.stage
widgetHelper.setNormalRewardItem(item,0,data)
end
else
self.rewards:setChildLayoutGroupCreateItems(0)
end

self.taskstate=MysteryModel:have_mystery_task(self.fbid)
self.marchstate=MysteryModel:have_mystery_march(self.fbid)
if self.taskstate or self.marchstate then
self.enterTxt:setText("继续探索")



self.closeTxt:setText("撤离秘境")


self.costPanel:setActive(false)
self.quitButton:setActive(true)
else
self.quitButton:setActive(MysteryModel:is_show_close(self.fbid)or false)

self.enterTxt:setText("开始探索")
self.closeTxt:setText("关闭秘境")

self.costPanel:setActive(self.cost~=nil and self.needItemsFlag)
if self.cost and self.needItemsFlag then
self.costImage:setImageIcon(iconHelper.getIconName(self.cost[1]),false)
self.costTxt:setText(moneyModel.checkEnoughMoney(self.cost[1],self.cost[2])and FMT.fmt("<color=#76d81e>{0}</color>",self.cost[2])or FMT.fmt("<color=#c82c2c>{0}</color>",self.cost[2]))
end
end
self:refreshAimList()
self:refreshEnvironmentList()
end


function UIMysteryEnterWin:OnEnable()

end


function UIMysteryEnterWin:OnDisable()

end

function UIMysteryEnterWin:refreshEnvironmentList()
local environmentEffect=self.info and self.info[14]or{}
if next(environmentEffect)then
self.environmentEffect=environmentEffect
self.environmentTxt:setText("环境效果：")
self.environmentPanel:setActive(true)
self.environmentPanel:setChildScrollViewCreateGrids(#environmentEffect,#environmentEffect)

local grids=self.environmentPanel:getChildScrollViewItemWidgets()
local count=grids.Count

for i=1,count do
local cfg=cfgHelper.getSSlawRule(environmentEffect[i].param_1)
local item=grids[i-1]
if cfg then

item:SetChildText(1,cfg.name)
item:SetChildButtonClick(0,function()
self:onEnvironmentItemClick(item,cfg)
end)
end
end
self.strengthTxt:setChildAnchoredPosition(Vector3.New(-14.7,208,0))
else
self.strengthTxt:setChildAnchoredPosition(Vector3.New(-14.7,178,0))
self.environmentTxt:setText('')
self.environmentPanel:setActive(false)
end
end

function UIMysteryEnterWin:onEnvironmentItemClick(item,cfg)
if cfg then
UIManager:showWindow("UIMysteryEnvironmentWin",{item=item,node='bottom',config=cfg})
end
end

function UIMysteryEnterWin:refreshAimList()
local targetData=self.info and self.info[8]
local progress=self.info and self.info[2]or 0
if targetData then
local targetDesc=cfgHelper.get2(cfg_secretscenefubenconfig_get,self.fbid,"targetDesc")
local targetList={}
for i,v in ipairs(targetDesc)do
if not v.isHide then
table.insert(targetList,{desc=v,oriIndex=i})
end
end

self.aim2Panel:setChildScrollViewCreateGrids(#targetList,#targetData)

local grids=self.aim2Panel:getChildScrollViewItemWidgets()
local count=grids.Count
self.aimGrids=grids
for i=1,count do
local t=targetList[i]
local index=t.oriIndex
local descCfg=t.desc
local target=targetData[index]

local item=grids[i-1]


if target then
if not(target.param_1==0 and target.param_2==0 and target.param_3==0 and target.param_4==0)then
if progress>=100 then
item:SetChildProgress(2,target.param_2,target.param_2)
item:SetChildText(3,FMT.fmt("{0}/{1}",target.param_2,target.param_2))
else
item:SetChildProgress(2,target.param_1,target.param_2)
item:SetChildText(3,FMT.fmt("{0}/{1}",target.param_1,target.param_2))
end

else
if progress>=100 then
item:SetChildProgress(2,1,1)
item:SetChildText(3,"1/1")
else
item:SetChildProgress(2,target.finishStatus,1)
item:SetChildText(3,FMT.fmt("{0}/1",target.finishStatus))
end
end
else
item:SetChildActive(-1,false)
end
if descCfg then
local desc=descCfg[1]
item:SetChildText(4,desc)

local iconIndex=descCfg[2]or 1
if target then
local targetConfig=cfg_secretscenefubenaimconfig_get(target.targetId)
item:SetChildCSImageIcon(0,targetConfig.icon[iconIndex],true)
end
end
end
end

end

function UIMysteryEnterWin:setModel()
local random_dis=UIDiscipleModel:getRandomDiscipleData()
self.dis_guid=random_dis.discipleguid
local image=UIDiscipleModel:getDiscipleOutsideModelInfo(self.dis_guid)
if image then
self.model:setChildUIModelShowTarget(image.body,1,image.componets,eAnimationID.stand)
end
end

function UIMysteryEnterWin.onScrollChanged()
if _this and _this.aimGrids then
local count=_this.aimGrids.Count
if count>3 then
local np=_this.winlua:GetChildScrollRectNormalizedPosition(_this.aim2Panel:getID(),true)
if np<=0.15 then
_this.rightJianTou:setActive(true)
_this.leftJianTou:setActive(false)
elseif np>=0.85 then
_this.rightJianTou:setActive(false)
_this.leftJianTou:setActive(true)
else
_this.rightJianTou:setActive(true)
_this.leftJianTou:setActive(true)
end
else
_this.rightJianTou:setActive(false)
_this.leftJianTou:setActive(false)
end
end
end


function UIMysteryEnterWin:selectDiscipleCallBack(guidList,zhenfaId)

MysteryController.select_dizi_and_skill(MysteryModel.selectFBid,guidList,nil,zhenfaId)

timeEventController.delayDo(0.5,function()
fightController:closeSelectStage(false)
end)





local sceneType=MysteryModel:get_mystery_sence_type(self.fbid)
if sceneType==MysterySenceType.XianJieResPoint then
xianjieController:markResPointMysteryJson(self.fbid,guidList)
end
end



























function UIMysteryEnterWin:onEnterButton_ori(fbid)
local cfg_fb=cfg_secretscenefubenconfig_get(fbid)
local mysteryPanelCfg=cfgHelper.get1(cfg_secretsceneuishowconfig_get,cfg_fb.uiOpen)
if mysteryPanelCfg.skillPanel then
local sysid=SYSTEM_DEFINE.eMiJingSkill
if systemModel.isOpen(sysid)then
UIFullFightPrepareControl:showWindow("UIMysterySkillSelectWin",{fbid})
end
end
end

function UIMysteryEnterWin:onEnterButton()
if self.waitToRefresh then

return
end
local fbid=self.fbid
if fbid then
local cfg_fb=cfg_secretscenefubenconfig_get(fbid)
local posData=MysteryModel:get_mysteryFB_unit(fbid)
local world,x,z=nil
if cfg_fb.practice==MysterySenceType.World and not MysteryController.isPassMysteryAreaCheck then
if not posData then
error(FMT.fmt("找不到对应秘境单位{0}",fbid))
return
end
world=posData[1]
x=posData[2]
z=posData[3]
local pos,block=worldPositionConfig:getPosition(posData[1],{posData[2],posData[3]})
local cState=worldBlockModel:getBlockState(tonumber(posData[1]),block)
if cState~=worldBlockModel.BLOCKSTATE.OPEN then
local blockCfg=cfgHelper.get2(cfg_worldblockconfig_get,posData[1],block)
if blockCfg then
UIManager.error(FMT.fmt("{0}未解锁",blockCfg.name))
end
return
end
elseif cfg_fb.practice==MysterySenceType.ResPoint then
local resPoint,guid,subIdx=worldResPointDataModel:findMysteryData(fbid)
if resPoint then
world=resPoint.world
local position,flip=worldResPointDataModel:getSubPointPosition(guid,subIdx)
x=position.x
z=position.z
end
end
if self.taskstate then
worldController:resetRightView()
local zhenFaId=MysteryModel:get_mysteryFB_zhenFa(fbid)
MysteryModel:set_select_zhenFa(zhenFaId)
MysteryController:enterMysteryFB(fbid)
elseif self.marchstate then
local zhenFaId=MysteryModel:get_mysteryFB_zhenFa(fbid)
MysteryModel:set_select_zhenFa(zhenFaId)
MysteryController:enterMysteryFB(fbid)
self:onCloseBtn()
else
if self.cost and self.needItemsFlag and not moneyModel.checkEnoughMoney(self.cost[1],self.cost[2])then
UIManager.error(FMT.fmt("{0}不足",moneyModel.getMoneyName(self.cost[1])))
gainControl:showGainWin(self.cost[1])
else
local jj=MysteryModel:get_mysteryFB_ndLevel(fbid)or 1
local ret,errType=downAssetManager:needDownLoadMiJing(fbid)
if ret then
return
end
local selectDiscipleCallBack=function(guidList,zhenfaId)

MysteryController.select_dizi_and_skill(MysteryModel.selectFBid,guidList,nil,zhenfaId)

timeEventController.delayDo(0.5,function()
fightController:closeSelectStage(false)
end)

local sceneType=MysteryModel:get_mystery_sence_type(fbid)
if sceneType==MysterySenceType.XianJieResPoint then
xianjieController:markResPointMysteryJson(fbid,guidList)
end
end
local cancelCB=function()
local sceneType=MysteryModel:get_mystery_sence_type(fbid)
if sceneType~=MysterySenceType.XianJieResPoint then
worldController:resetLeftView()
worldController:displayUI(true)
worldController:displayHUD(true)
worldController:displaySymbol(true)
UIManager:closeWindow("UIMysterySkillSelectWin")
else
xianjieController:openWinEx("UIMysteryEnterWin",{id=fbid})
end
end
local winArgs=
{
enterCallBack=selectDiscipleCallBack,
enterTxt="秘境",
cancelCallBack=cancelCB,
fightCompareJingJie=jj,
fightCompareTips="该秘境里的敌人实力强大，是否确认？",
catCatMiJing=cfg_fb.teamFight~=nil and fbid or nil,
npcList=cfg_fb.tmpNPC,
forceAutoSelect=cfg_fb.forceAutoSelect,
}
if cfg_fb.practice==MysterySenceType.XianJieResPoint then
UIManager:closeWindow(self.__name)

fightController.showPrepareWin(fightPreSelectModel.fightType.mystery,winArgs,function()
local mysteryPanelCfg=cfgHelper.get1(cfg_secretsceneuishowconfig_get,cfg_fb.uiOpen)
if mysteryPanelCfg.skillPanel then
local sysid=SYSTEM_DEFINE.eMiJingSkill
if systemModel.isOpen(sysid)then
UIFullFightPrepareControl:showWindow("UIMysterySkillSelectWin",{fbid})
end
end
end)
return
end

local preCB=function()
worldController:changeLeftView()
worldController:displayUI(false)
worldController:displayHUD(false)
worldController:displaySymbol(false)
worldController:resetRightView()

fightController.showPrepareWin(fightPreSelectModel.fightType.mystery,winArgs,function()
local mysteryPanelCfg=cfgHelper.get1(cfg_secretsceneuishowconfig_get,cfg_fb.uiOpen)
if mysteryPanelCfg.skillPanel then
local sysid=SYSTEM_DEFINE.eMiJingSkill
if systemModel.isOpen(sysid)then
UIFullFightPrepareControl:showWindow("UIMysterySkillSelectWin",{fbid})
end
end
end)
end

if worldModel:isSameWorld(world)then
if self.cost then
local tipsStr=FMT.fmt("剩余{0}不足{1}，是否继续执行？",itemsConfig.getItemName(self.cost[1]),self.cost[2])
moneyPlanModel:checkHandle(self.cost[1],self.cost[2],preCB,tipsStr)
else
preCB()
end
else
local worldName=cfgHelper.get2(cfg_worldconfig_get,world,'name')
local showdata=
{
type='UIDialouge',
title='提示',
content=FMT.fmt('确认前往<color=#18a736>{0}</color>？',worldName),
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function()
local position=worldPositionConfig:getPosition(world,{x,z})
local args={lookAt=position}
mainControl:enterWorld({world,args},function()
if cfg_fb.practice==MysterySenceType.ResPoint then
local resPoint,guid,subIdx=worldResPointDataModel:findMysteryData(fbid)
if resPoint then
local unitKey=worldResPointBaseModel:convertUnitKey(guid,subIdx)
local unitData=worldController:getUnit(unitKey)
if unitData then
worldController.onClickUnit(unitData.LuaData)
else

end
end
else
preCB()
end
end)
end,
showclosebtn=false,
}
self.comfirmDialogEnter=UIDialogManager.newDialog(showdata)
self.comfirmDialogEnter:show()

end


end
end


end
end


function UIMysteryEnterWin:onQuitButton()
if self.waitToRefresh then

return
end



local state1=MysteryModel:have_mystery_task(self.fbid)
local state2=MysteryModel:have_mystery_march(self.fbid)
if state1 or state2 then



















local showdata=
{
type='UIDialougeHighest',
title='提示',
content='撤离后可再派遣弟子进入，是否确定？',
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function(...)
MysteryController.send_4_4(self.fbid)
if state1 then
worldController:resetRightView()
else
self:onCloseBtn()
end

end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()


else



local data=MysteryModel:get_mysteryFB_list_data_fbid(self.fbid)
local percent=self.info and self.info[2]or data.percent
if percent<100 then
local showdata=
{
type='UIDialougeHighest',
title='提示',
content='是否确认关闭秘境？',
oktext='确定',
canceltext='取消',
allowclickBG='false',
okcallback=function(...)
MysteryController.send_4_5(self.fbid)
if worldController:isInWorld()then
worldController:resetRightView()
end
end,
showclosebtn=false,
}
self.comfirmDialog=UIDialogManager.newDialog(showdata)
self.comfirmDialog:show()
else
MysteryController.send_4_5(self.fbid)
if worldController:isInWorld()then
worldController:resetRightView()
end
end

end



end

function UIMysteryEnterWin:onDetailBtn()
if not self.detail then
return
end
UIManager:showWindow("UIDetailDropWin",{detail=self.detail})
end

function UIMysteryEnterWin:initMoneyBar(moneyList)
if webGLHelper:isRunMiniGame()then
self.moneybar:setChildAnchoredPosition3D(Vector3.New(-200,0,0))
end
if moneyList==nil then moneyList={}end
for i,v in ipairs(self.moneyBars)do
local wb=v:getChildWidgetBase()
local mType=moneyList[i]
if mType then
v:setActive(true)
local icon=iconHelper.getMoneyIconName(mType)

wb:SetChildIcon(0,icon,false)
if mType~=eMoneyType.mtLingPai then
wb:SetChildButtonClickWithID(2,function()
if mType==eMoneyType.mtXianYu then
UIFullRechargeController:showRechargeWindow()
else
gainControl:showGainWin(mType)
end
end,i)
else
wb:SetChildButtonClickWithID(2,function()
moneySystem:showBuyTips(mType)
end,i)
end
wb:SetChildText(1,moneyModel.getMoneyDesc1(mType))
else
v:setActive(false)
end
end
end

function UIMysteryEnterWin:onMoneyChanged(moneytype)
if self.moneyMap and self.moneyMap[moneytype]then
local index=self.moneyMap[moneytype]
local wb=self.moneyBars[index]:getChildWidgetBase()
wb:SetChildText(1,moneyModel.getMoneyDesc1(moneytype))

if self.cost and self.needItemsFlag then
self.costImage:setImageIcon(iconHelper.getIconName(self.cost[1]),false)
self.costTxt:setText(moneyModel.checkEnoughMoney(self.cost[1],self.cost[2])and FMT.fmt("<color=#76d81e>{0}</color>",self.cost[2])or FMT.fmt("<color=#c82c2c>{0}</color>",self.cost[2]))
end
end
end

function UIMysteryEnterWin:onMoneyBars_1()
end
function UIMysteryEnterWin:onMoneyBars_2()
end
function UIMysteryEnterWin:onMoneyBars_3()
end
