







def_class("UIMysteryWeekEnterWin",UIWindowBase)









function UIMysteryWeekEnterWin:bindComponents()

self.root=UIObject.get(self,0)
self.closeButton2=UIButton.get(self,1)
self.model=UIImage.get(self,2)
self.xuanshangButton=UIButton.get(self,3)
self.helpButton=UIButton.get(self,4)
self.environmentPanel=UIObject.get(self,5)
self.story=UIImage.get(self,6)
self.rewards=UIObject.get(self,7)
self.progressTxt=UIText.get(self,8)
self.closeBtn=UIButton.get(self,9)
self.timerTxt=UIText.get(self,10)
self.colorTitle=UIText.get(self,11)
self.storyBack=UIImage.get(self,12)
self.environmentTxt=UIText.get(self,13)
self.xsReddot=UIObject.get(self,14)
self.effect=UIObject.get(self,15)
self.costImage=UIImage.get(self,16)
self.costTxt=UIText.get(self,17)
self.costPanel=UIObject.get(self,18)
self.enterTxt=UIText.get(self,19)
self.enterButton=UIButton.get(self,20)
self.detailBtn=UIButton.get(self,21)

self.closeButton2:setButtonClick(function()self:onCloseButton2()end)

self.xuanshangButton:setButtonClick(function()self:onXuanshangButton()end)

self.helpButton:setButtonClick(function()self:onHelpButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.enterButton:setButtonClick(function()self:onEnterButton()end)

self.detailBtn:setButtonClick(function()self:onDetailBtn()end)



end


function UIMysteryWeekEnterWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.closeButton2);self.closeButton2=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.xuanshangButton);self.xuanshangButton=nil;
_UIObject_release(self.helpButton);self.helpButton=nil;
_UIObject_release(self.environmentPanel);self.environmentPanel=nil;
_UIObject_release(self.story);self.story=nil;
_UIObject_release(self.rewards);self.rewards=nil;
_UIObject_release(self.progressTxt);self.progressTxt=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.timerTxt);self.timerTxt=nil;
_UIObject_release(self.colorTitle);self.colorTitle=nil;
_UIObject_release(self.storyBack);self.storyBack=nil;
_UIObject_release(self.environmentTxt);self.environmentTxt=nil;
_UIObject_release(self.xsReddot);self.xsReddot=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.costImage);self.costImage=nil;
_UIObject_release(self.costTxt);self.costTxt=nil;
_UIObject_release(self.costPanel);self.costPanel=nil;
_UIObject_release(self.enterTxt);self.enterTxt=nil;
_UIObject_release(self.enterButton);self.enterButton=nil;
_UIObject_release(self.detailBtn);self.detailBtn=nil;
end


















local _this=nil

function UIMysteryWeekEnterWin:onLoaded(...)
self:bindComponents()
_this=self
self.environmentPanel:setChildScrollViewInit(0.5,true,function(...)self:onEnvironmentItemClick(...)end,nil)

self.model:setChildUIModelShowTarget(4073,1,{},eAnimationID.stand,false,false,0,nil)
end


function UIMysteryWeekEnterWin:__delete()
self:unbindComponents()
_this=nil
end




function UIMysteryWeekEnterWin:onShow(argtable,afterOnloaded)
self.callBackArg=argtable
if type(argtable)=="table"then
self.fbid=argtable.fbid
self.returnHeight=argtable.returnHeight
else
self.fbid=argtable
end

self:refreshConfigWin()

local data=MysteryModel:getFBInfoData(self.fbid)
if data and data[1]~=nil then
self:refreshWin(data)
self.waitToRefresh=false
else

MysteryController.send_4_3(self.fbid)
self.waitToRefresh=true
end

self:refreshEnvironmentList()

if self.actTimer==nil then
local func=function()
self:refreshActTimer()
end
self.actTimer=self:setTimer(1,0,func)
self:refreshActTimer()
end

self:refreshReddot()
end

function UIMysteryWeekEnterWin:refreshActTimer()

local endTime=timeHelper.convertLongStamp(mysteryWeekActivityModel:getNextMonday5oClock())
local time=timeHelper.getServerLongTime()
local leftTime=endTime-time
if leftTime<=0 then
return
end
self.timerTxt:setText(FMT.fmt("<color=#ca631d>{0}</color>后消失",timeHelper.format_time_stamp3(leftTime)))
end


function UIMysteryWeekEnterWin:onHide()

end
local abName="ui/windows/mystery/weekactity_atlas_pak.ab"
function UIMysteryWeekEnterWin:refreshConfigWin()
local cfg_fb=cfg_secretscenefubenconfig_get(self.fbid)
self.cfg_fb=cfg_fb
self.colorTitle:setText(cfg_fb.name)




local enterImgae=cfg_fb.enterImgae
if enterImgae then
self.model:setChildIcon(FMT.fmt("image_shijian_{0}",enterImgae),true)
end

local storyImg=cfg_fb.storyImg
if storyImg then
self.story:setCSImageSprite(abName,FMT.fmt("image_shangguxiandicc_{0}",storyImg))
end
local storyBackImg=cfg_fb.storyBackImg
if storyBackImg then
self.storyBack:setCSImageSprite(abName,FMT.fmt("image_shangguxiandict_{0}",storyBackImg))
end
end

function UIMysteryWeekEnterWin:refreshWin(info,needWait)
if info then
self.fbid=info[1]
self.info=info
end

self.needItemsFlag=info[17]==1

self.tzFlag=info[18]==1

if not needWait then
self.waitToRefresh=false
end


local percent=info[2]

local cfg_fb=cfg_secretscenefubenconfig_get(self.fbid)
self.cfg_fb=cfg_fb

if cfg_fb then
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
widgetHelper.setNormalRewardItem(item,0,data)
end
else
self.rewards:setChildLayoutGroupCreateItems(0)
end


self.costPanel:setActive(self.cost~=nil and self.needItemsFlag)
if self.cost and self.needItemsFlag then
self.costImage:setImageIcon(iconHelper.getIconName(self.cost[1]),false)
local have=itemsModel.getCount(self.cost[1])
self.costTxt:setText(have>=self.cost[2]and FMT.fmt("<color=#549327>{0}/{1}</color>",mathHelper.formatNumber(have),self.cost[2])or FMT.fmt("<color=#c82c2c>{0}/{1}</color>",mathHelper.formatNumber(have),self.cost[2]))
end
self:refreshEnvironmentList()
local txt=self.tzFlag and"继续探索"or"进入险地"
self.enterTxt:setText(txt)
end

function UIMysteryWeekEnterWin:refreshEnvironmentList()
local environmentEffect=self.info and self.info[14]or{}

if next(environmentEffect)then
self.environmentEffect=environmentEffect


self.environmentPanel:setActive(true)
self.environmentPanel:setChildScrollViewCreateGrids(1,1)

local grids=self.environmentPanel:getChildScrollViewItemWidgets()
local count=grids.Count

for i=1,count do
local cfg=cfgHelper.getSSlawRule(environmentEffect[i].param_1)
local item=grids[i-1]
if cfg then
item:SetChildCSImageIcon(0,cfg.image,false)
item:SetChildButtonClick(0,function()
self:onEnvironmentItemClick(item,cfg)
end)

if i==1 then
local desc=cfg.desc
self.environmentTxt:setText(desc)
end
end
end
else

self.environmentPanel:setActive(false)
end
end


function UIMysteryWeekEnterWin:refreshReddot()
self.xsReddot:setActive(mysteryWeekActivityModel:checkXuanShangReddot())
end

function UIMysteryWeekEnterWin:onEnvironmentItemClick(item,cfg)
if cfg then
UIManager:showWindow("UIMysteryEnvironmentWin",{item=item,node='bottom',config=cfg})
end
end



function UIMysteryWeekEnterWin:onCloseBtn()
self:onCloseButton2()
end

function UIMysteryWeekEnterWin:onCloseButton2()
local fbid=self.fbid
local height=self.returnHeight
if not height then
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,worldModel.world)
if worldCfg then
height=worldCfg.cameraPos[2]
end
else
local range=worldController:getCameraZoomRange()
if range then
height=Mathf.Clamp(height,range[1],range[2])
end
end
if height then
local key=worldModel:convertUnitKey({worldModel.UNITTYPE.MYSTERY,fbid})
worldController:lookAtUnit(key,height,false,nil)
end
self:closeSelf()
end



function UIMysteryWeekEnterWin:onEnterButton()
if self.waitToRefresh then
return
end
local fbid=self.fbid
local cfg_fb=self.cfg_fb
if self.tzFlag then
MysteryController:enterMysteryFB(fbid)
self:closeSelf()
else
local have=itemsModel.getCount(self.cost[1])
if self.cost and self.needItemsFlag and not(have>=self.cost[2])then
UIManager.error(FMT.fmt("{0}不足",itemsModel.getName(self.cost[1])))
gainControl:showGainWin(self.cost[1])
else
local ret,errType=downAssetManager:needDownLoadMiJing(fbid)
if ret then return end
local environmentEffect=self.info and self.info[14]or nil
local environmentlist={}
for i,v in ipairs(environmentEffect)do
table.insert(environmentlist,environmentEffect.param_1)
end
local winArgs=
{
enterCallBack=function(guidList,zhenfaId)


MysteryController.select_dizi_and_skill(fbid,guidList,nil,zhenfaId)

timeEventController.delayDo(0.5,function()
fightController:closeSelectStage(false)
end)
worldController:displayHUD(true)
worldController:displayUI(true)
end,
enterTxt="秘境",
cancelCallBack=self.cancelCallBack,
skipDiscipleInjuryCheck=true,
skipDiscipleStateCheck=true,
statePriorityCheck=false,
isHomeBattle=false,
faZeData=environmentlist,
catCatMiJing=cfg_fb.teamFight~=nil and fbid or nil,
}
fightController.showPrepareWin(fightPreSelectModel.fightType.mystery,winArgs,function()
local mysteryPanelCfg=cfgHelper.get1(cfg_secretsceneuishowconfig_get,cfg_fb.uiOpen)
if mysteryPanelCfg.skillPanel then
local sysid=SYSTEM_DEFINE.eMiJingSkill
if systemModel.isOpen(sysid)then
UIFullFightPrepareControl:showWindow("UIMysterySkillSelectWin",{fbid})
end
end
end)
worldController:displayUI(false)
worldController:displayHUD(false)
worldController:displaySymbol(false)
end
end
end


function UIMysteryWeekEnterWin.cancelCallBack()
worldController:displayUI(true)
worldController:displayHUD(true)
worldController:displaySymbol(true)
UIManager:closeWindow("UIMysterySkillSelectWin")
end


function UIMysteryWeekEnterWin:onQuitButton()

end



function UIMysteryWeekEnterWin:onDetailBtn()
if not self.detail then
return
end
UIManager:showWindow("UIDetailDropWin",{detail=self.detail})
end

function UIMysteryWeekEnterWin:onXuanshangButton()







local args=self.callBackArg
local func=function(args_)

UIManager:showWindow("UIMysteryWeekEnterWin",args_)
end
fullScreenUI.setNextActiveUICallback2(func,args)
UIFullTotalTouZiActivityontrol:showMenuWindow({menuType=TZ_MENU_TYPE.eQJXSRewards},true)
end

function UIMysteryWeekEnterWin:onHelpButton()
UIManager:showWindow('UIRuleWin',{showBlack=true,mode=3,name='ui_mystery_week_rule_%s'})
end