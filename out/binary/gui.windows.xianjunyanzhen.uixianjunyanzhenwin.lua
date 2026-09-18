







def_class("UIXianJunYanZhenWin",UIWindowBase)









function UIXianJunYanZhenWin:bindComponents()

self.attrStateBtn=UIButton.get(self,0)
self.attrStateReddot=UIObject.get(self,1)
self.bgEffect=UIObject.get(self,2)
self.bgModel=UIObject.get(self,3)
self.btnRoot=UIObject.get(self,4)
self.buffPanel=UIObject.get(self,5)
self.buffRectBtn=UIButton.get(self,6)
self.buffScrollView=UIObject.get(self,7)
self.closeBtn=UIButton.get(self,8)
self.closetitle=UIText.get(self,9)
self.conditionScrollView=UIObject.get(self,10)
self.cxtzBtn=UIButton.get(self,11)
self.jdModel=UIButton.get(self,12)
self.jiluBtn=UIButton.get(self,13)
self.levelbg=UIObject.get(self,14)
self.levelBtn=UIButton.get(self,15)
self.levelJt=UIObject.get(self,16)
self.levelRectBtn=UIButton.get(self,17)
self.levelScrollView=UIObject.get(self,18)
self.leveltitle=UIText.get(self,19)
self.levelViewport=UIObject.get(self,20)
self.loseNewbie=UIButton.get(self,21)
self.mainPanel=UIObject.get(self,22)
self.marchLineContent=UIObject.get(self,23)
self.marchShipContent=UIObject.get(self,24)
self.mNext=UIObject.get(self,25)
self.monsterContent=UIObject.get(self,26)
self.newBuffTips=UIObject.get(self,27)
self.nextBtn=UIButton.get(self,28)
self.notBuff=UIText.get(self,29)
self.notNext=UIObject.get(self,30)
self.rewardBg=UIObject.get(self,31)
self.rewardBtn=UIButton.get(self,32)
self.rewardReddot=UIObject.get(self,33)
self.rewardScrollView=UIObject.get(self,34)
self.ruleBtn=UIButton.get(self,35)
self.speSlot=UIObject.get(self,36)
self.starCount=UIText.get(self,37)
self.starRewardBtn=UIButton.get(self,38)
self.starRewardReddot=UIObject.get(self,39)
self.starScrollView=UIObject.get(self,40)
self.titleClick=UIButton.get(self,41)
self.zmEffect=UIObject.get(self,42)
self.zmModel=UIObject.get(self,43)

self.attrStateBtn:setButtonClick(function()self:onAttrStateBtn()end)

self.buffRectBtn:setButtonClick(function()self:onBuffRectBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.cxtzBtn:setButtonClick(function()self:onCxtzBtn()end)

self.jdModel:setButtonClick(function()self:onJdModel()end)

self.jiluBtn:setButtonClick(function()self:onJiluBtn()end)

self.levelBtn:setButtonClick(function()self:onLevelBtn()end)

self.levelRectBtn:setButtonClick(function()self:onLevelRectBtn()end)

self.loseNewbie:setButtonClick(function()self:onLoseNewbie()end)

self.nextBtn:setButtonClick(function()self:onNextBtn()end)

self.rewardBtn:setButtonClick(function()self:onRewardBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)

self.starRewardBtn:setButtonClick(function()self:onStarRewardBtn()end)

self.titleClick:setButtonClick(function()self:onTitleClick()end)



end


function UIXianJunYanZhenWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.attrStateBtn);self.attrStateBtn=nil;
_UIObject_release(self.attrStateReddot);self.attrStateReddot=nil;
_UIObject_release(self.bgEffect);self.bgEffect=nil;
_UIObject_release(self.bgModel);self.bgModel=nil;
_UIObject_release(self.btnRoot);self.btnRoot=nil;
_UIObject_release(self.buffPanel);self.buffPanel=nil;
_UIObject_release(self.buffRectBtn);self.buffRectBtn=nil;
_UIObject_release(self.buffScrollView);self.buffScrollView=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.closetitle);self.closetitle=nil;
_UIObject_release(self.conditionScrollView);self.conditionScrollView=nil;
_UIObject_release(self.cxtzBtn);self.cxtzBtn=nil;
_UIObject_release(self.jdModel);self.jdModel=nil;
_UIObject_release(self.jiluBtn);self.jiluBtn=nil;
_UIObject_release(self.levelbg);self.levelbg=nil;
_UIObject_release(self.levelBtn);self.levelBtn=nil;
_UIObject_release(self.levelJt);self.levelJt=nil;
_UIObject_release(self.levelRectBtn);self.levelRectBtn=nil;
_UIObject_release(self.levelScrollView);self.levelScrollView=nil;
_UIObject_release(self.leveltitle);self.leveltitle=nil;
_UIObject_release(self.levelViewport);self.levelViewport=nil;
_UIObject_release(self.loseNewbie);self.loseNewbie=nil;
_UIObject_release(self.mainPanel);self.mainPanel=nil;
_UIObject_release(self.marchLineContent);self.marchLineContent=nil;
_UIObject_release(self.marchShipContent);self.marchShipContent=nil;
_UIObject_release(self.mNext);self.mNext=nil;
_UIObject_release(self.monsterContent);self.monsterContent=nil;
_UIObject_release(self.newBuffTips);self.newBuffTips=nil;
_UIObject_release(self.nextBtn);self.nextBtn=nil;
_UIObject_release(self.notBuff);self.notBuff=nil;
_UIObject_release(self.notNext);self.notNext=nil;
_UIObject_release(self.rewardBg);self.rewardBg=nil;
_UIObject_release(self.rewardBtn);self.rewardBtn=nil;
_UIObject_release(self.rewardReddot);self.rewardReddot=nil;
_UIObject_release(self.rewardScrollView);self.rewardScrollView=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.speSlot);self.speSlot=nil;
_UIObject_release(self.starCount);self.starCount=nil;
_UIObject_release(self.starRewardBtn);self.starRewardBtn=nil;
_UIObject_release(self.starRewardReddot);self.starRewardReddot=nil;
_UIObject_release(self.starScrollView);self.starScrollView=nil;
_UIObject_release(self.titleClick);self.titleClick=nil;
_UIObject_release(self.zmEffect);self.zmEffect=nil;
_UIObject_release(self.zmModel);self.zmModel=nil;
end
















local _this




function UIXianJunYanZhenWin:onLoaded(...)
self:bindComponents()
_this=self
self.passportId=cfgHelper.getdef(cfg_xianjunyanzhengxconfig,"passport")
self.passport_guid=UITYTongXingZhengModel:findGuidByTXZId(self.passportId)

self:addNotify(notifyConfig.onTYTXZRewardChange,self.onTYTXZRewardChange)

self.selectGxIdx=nil
self.isShowGxScrollView=false
self.initCreateGxScrollView=false
self.fightAnimLookup={}
self.tweenLookup={}
end


function UIXianJunYanZhenWin:__delete()
self:unbindComponents()
self:clearAllAnim()
self.isShowGxScrollView=false
self.initCreateGxScrollView=false

XianJunYanZhenModel:saveCurGxId()
_this=nil
end




function UIXianJunYanZhenWin:onShow(argtable,afterOnloaded)
local systemName=systemConfig.getSystemName(SYSTEM_DEFINE.eXianJunYanZhen)
self.closetitle:setText(systemName)

if argtable and argtable.gx_id then
self.selectGxIdx=argtable.gx_id
end
if not self.selectGxIdx then
self.selectGxIdx=XianJunYanZhenModel:getCurGxId()
end
self:refreshMain()
end


function UIXianJunYanZhenWin:onHide()

end

function UIXianJunYanZhenWin:refreshGxId(gx_id)
if self.selectGxIdx==gx_id then
return
end
if self.showNextBtnByGx~=gx_id then
self.showNextBtnByGx=nil
end

local func=function()
if _this.initCreateGxScrollView then
local grids=_this.levelScrollView:getChildScrollViewItemWidgets()
local oldItem=grids[_this.selectGxIdx-1]
oldItem:SetChildActive(0,false)

local item=grids[gx_id-1]
item:SetChildActive(0,true)
end
_this.isShowBuff=false
_this.selectGxIdx=gx_id
_this:showBuffPanel()
_this:refreshMain()
end
UIManager:showWindow("UIFightPrepareLoading",{para=1})
self:delayDo(0.5,function()
func()
end)
end

function UIXianJunYanZhenWin:refreshResetRecv()
UIManager.info("重置成功")
self.isShowBuff=false
self:showBuffPanel()
self:clearAllAnim()
self:refreshMain()
end

function UIXianJunYanZhenWin:refreshCanTzRecv()
local cfg=cfgHelper.get1(cfg_xianjunyanzhengxconfig_get,self.selectGxIdx)
local callback=function()
_this.speSlot:setActive(false)
UIManager:showWindow("UIXianJunYanZhenEffect",{para=10662})
_this:refreshAllMonsterTz()
end
if cfg.spe_cond[5]then
gameplotController:showPlotBoard({groupid=cfg.spe_cond[5],isFullOpen=false,callback=callback})
else
callback()
end
end

function UIXianJunYanZhenWin:refreshMain(isResult)
if not isResult then
self:refreshModel()
self:refreshZM()
self:refreshMonster()
self:refreshNextBtn()
end
self:refreshJDModel()
self:refreshTop()
self:refreshStar(isResult)
self:refreshReward()
self:refreshRewardReddot()
self:refreshStarRewardReddot()
self:refreshBuffReddot(false)
end

function UIXianJunYanZhenWin.onTYTXZRewardChange(tzxGuid)
local txzData=UITYTongXingZhengModel:getDataByGuid(tzxGuid)
if _this.passportId==txzData.txzId then
_this:refreshRewardReddot()
end
end

function UIXianJunYanZhenWin:refreshRewardReddot()
local isReddot=false
if self.passport_guid then
isReddot=UITYTongXingZhengController:checkReddot(self.passport_guid)
end
self.rewardReddot:setActive(isReddot)
end

function UIXianJunYanZhenWin:refreshStarRewardReddot()
local isReddot=XianJunYanZhenModel:isCanAnyPrizeStar()
self.starRewardReddot:setActive(isReddot)
end

function UIXianJunYanZhenWin:refreshBuffReddot(flag)
self.attrStateReddot:setActive(flag)
self.btnReddotIndex=self:doPunchRotation(self.widget,self.attrStateReddot:getID(),self.btnReddotIndex,flag)

if flag then
if not self.hasNewBuffAnim then
self.hasNewBuffAnim=true
self.newBuffTips:setActive(true)
self.newBuffTips:setChildCanvasGroupAlpha(1)
self.newBuffTips:setLocalPosX(-322)
self.newBuffTips:setChildDOAnchorPosX(-44,0.5)

self:delayDo(3,function()
_this.newBuffTips:setChildCanvasGroupDOFade(0,0.5)
end)

self:delayDo(3.5,function()
_this.newBuffTips:setActive(false)
_this.hasNewBuffAnim=false
end)
end
end
end

function UIXianJunYanZhenWin:refreshNextBtn(flag)
if flag then
self.nextBtn:setActive(true)
return
end
local star=XianJunYanZhenModel:getGxStar(self.selectGxIdx)
local maxStar=XianJunYanZhenModel:getGxMaxStar(self.selectGxIdx)
local maxGxId=XianJunYanZhenModel:getMaxGxId()
local gxLen=XianJunYanZhenModel:getGxLen()

self.nextBtn:setActive(maxGxId==self.selectGxIdx and maxStar>0 and self.selectGxIdx<gxLen)
self.notNext:setActive(star>0 and self.selectGxIdx==gxLen)
end

function UIXianJunYanZhenWin:refreshZM()
local modelset=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'modelSet_zm')
local modelId=modelset.model

local sectdress=UISettingModel:getCurSettingId_Type(KUANGE_TYPE.zongmen)
if sectdress then
local settingcfg=UISettingConfig.getCfg(KUANGE_TYPE.zongmen,sectdress)
if settingcfg then
modelId=settingcfg.modelId
end
end
self.zmModel:setChildUIModelShowTarget(modelId,0.3,{},eAnimationID.stand,false,false,0)
end

function UIXianJunYanZhenWin:refreshModel()
local cfg=cfgHelper.get1(cfg_xianjunyanzhengxconfig_get,self.selectGxIdx)
if cfg.bg_model then
if self.bg_model~=cfg.bg_model then
self.bg_model=cfg.bg_model
self.bgModel:setActive(true)
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.bgModel:getID(),false,true,false)
self.bgModel:setChildUIModelShowTarget(cfg.bg_model,1,nil,eAnimationID.stand,false,false,0)
end
else
self.bg_model=nil
self.bgModel:setActive(false)
end

if cfg.bg_effect then
if self.bg_effect~=cfg.bg_effect then
self.bg_effect=cfg.bg_effect
self.bgEffect:setChildShowEffect(0,false)
self.bgEffect:setChildShowEffect(cfg.bg_effect,true)
end
else
self.bg_effect=nil
self.bgEffect:setChildShowEffect(0,false)
end

end

function UIXianJunYanZhenWin:refreshJDModel()
self.jdModel:setActive(false)














end

function UIXianJunYanZhenWin:refreshMonster(isResult)
local w_=1334

local sc=UIManager.defaultCanvas_trans.localScale
local width=UnityEngine.Screen.width/sc.x
if width>1624 then
width=1624
end
local addW=width-w_

local buffLookup={}
local buffList=XianJunYanZhenModel:getBuffList(self.selectGxIdx)
local len=#buffList
if len>0 then
for i=1,len do
local mid=buffList[i][1]
local type=buffList[i][3]
buffLookup[mid]=type or 0
end
end

self.zmEffect:setChildShowEffect(0,false)
if buffLookup[-1]~=nil then
local isAdd=buffLookup[-1]==1
self.zmEffect:setChildShowEffect(isAdd and 10665 or 10666,true)
end

local isHasBuff=false
self.monsterLookup={}
local cfg=cfgHelper.get1(cfg_xianjunyanzhengxconfig_get,self.selectGxIdx)
local isHasGxSpePlot=self:isHasGxSpePlot()

self.killAnims={}

local monsterLen=#cfg.mon_groub_list
local multi_battle_mon_id=cfg.multi_battle_mon_id or{}
self.monsterContent:setChildLayoutGroupCreateItems(monsterLen)
for i=1,monsterLen do
local monsterItem=self.monsterContent:getChildLayoutGroupGridItem(i-1)
local monster=cfg.mon_groub_list[i]
local monsterId=monster[1]
local dzBuffs=monster[3]
local monsterBuffs=monster[4]

local hasDzBuff=dzBuffs~=nil and next(dzBuffs)~=nil
local hasMonBuff=monsterBuffs~=nil and next(monsterBuffs)~=nil
if hasDzBuff or hasMonBuff then
isHasBuff=true
end

local monsterCfg=cfgHelper.get1(cfg_monstergroup_get,monsterId)
local params=cfg.model_list[i]
if not params then
params={0,0,1,1,0.5}
UIManager.error(FMT.fmt("前端提示：第{0}关第{1}个怪物未配置坐标和缩放",self.selectGxIdx,i))
end
local isMultiBattle=multi_battle_mon_id[i]~=nil
self.monsterLookup[monsterId]=i
monsterItem:SetChildLocalPos(-1,params[1]+addW,params[2],0)

monsterItem:SetChildActive(1,false)

local isKill,hp,maxHp=XianJunYanZhenModel:getIsKill(self.selectGxIdx,i)
monsterItem:SetChildActive(7,not isKill and isMultiBattle)

local usedData=XianJunYanZhenModel:getUsedData(i,self.selectGxIdx)
monsterItem:SetChildActive(4,not isKill and not isHasGxSpePlot and not usedData)

monsterItem:SetChildCanvasGroupAlpha(0,1)
monsterItem:SetChildCanvasGroupAlpha(5,not isKill and 1 or 0)
monsterItem:SetChildShowEffect(6,0,false)
if not isKill and isMultiBattle then
monsterItem:SetChildProgress(7,hp or 0,maxHp or 100)
monsterItem:SetChildProgressText(7,FMT.fmt("{0}%",hp or 0))

if NEWBIE_LUA_FUNC_TYPE["XJYZFirstBossHpFunc"]then
if not newbieModel.isFinish(NEWBIE_LUA_FUNC_TYPE.XJYZFirstBossHpFunc)then
monsterItem:SetChildNewBieComponentId(7,'UIXianJunYanZhenWin.monsterHP_'..i)
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.XJYZFirstBossHpFunc)
end
end
end
local modelParams=comHelper.getMonsterGroupModelParams(monsterId)
if not isKill then
local scale=params[3]or 1

monsterItem:SetChildLocalPos(0,0,0,0)
monsterItem:SetChildUIModelShowTarget(0,modelParams.body,scale,modelParams.componets or defaultT,eAnimationID.stand,false,false,0,nil)
monsterItem:SetChildUIModelShowTarget(5,5600,params[5]or 1,defaultT,eAnimationID.stand,false,false,0,nil)
monsterItem:SetChildUIModelShowTarget(4,4045,1,defaultT,eAnimationID.stand,false,false,0,nil)

local headPos=cfgHelper.get2(cfg_dbbodyconfig_get,modelParams.body,'headPos')or{0,170}
monsterItem:SetChildLocalPos(4,headPos[1]*scale*100,headPos[2]*scale*100,0)

local size=cfgHelper.get2(cfg_dbbodyconfig_get,modelParams.body,'size')or{2.5,2}
monsterItem:SetChildSizeDelta(3,size[1]*scale*100,size[2]*scale*100)
monsterItem:SetChildLocalPos(3,-10,0,0)

local buffScale=params[6]or 1
monsterItem:SetChildScale(6,Vector3.New(buffScale,buffScale,buffScale))
if buffLookup[monsterId]~=nil then
monsterItem:SetChildShowEffect(6,10667,true)
end
else
local scale=params[4]or 1
local anim=isResult and eAnimationID.stand or eAnimationID.enter
monsterItem:SetChildUIModelShowTarget(0,772163,scale,defaultT,anim,false,false,0,nil)
monsterItem:SetChildLocalPos(0,0,20*scale,0)

monsterItem:SetChildSizeDelta(3,140*scale,160*scale)
monsterItem:SetChildLocalPos(3,15*scale,0,0)
end

monsterItem:SetChildButtonClick(3,function(...)
self:setFightTeam(i,monsterCfg.fightVal)
end)
monsterItem:SetChildNewBieComponentId(3,'UIXianJunYanZhenWin.monsterItem_'..i)
end

self.attrStateBtn:setActive(isHasBuff)

self.speSlot:setActive(isHasGxSpePlot)
local spe_widget=self.speSlot:getWidgetBase()
spe_widget:SetChildButtonClick(2,function()
if cfg.spe_cond~=nil then
_this:showGxSpePlot()
else
_this:showGxPlot()
end
end)

if not self.oldMonsterLen or self.oldMonsterLen<monsterLen then
self.oldMonsterLen=monsterLen
self.marchLineContent:setChildLayoutGroupCreateItems(monsterLen)
for i=1,monsterLen do
local item=self.marchLineContent:getChildLayoutGroupGridItem(i-1)
item:SetChildActive(-1,false)
end

self.marchShipContent:setChildLayoutGroupCreateItems(monsterLen)
for i=1,monsterLen do
local item=self.marchShipContent:getChildLayoutGroupGridItem(i-1)
item:SetChildActive(-1,false)
end
end
end

function UIXianJunYanZhenWin:refreshAllMonsterTz()
local cfg=cfgHelper.get1(cfg_xianjunyanzhengxconfig_get,self.selectGxIdx)
local isHasGxSpePlot=self:isHasGxSpePlot()

local monsterLen=#cfg.mon_groub_list
for i=1,monsterLen do
local monsterItem=self.monsterContent:getChildLayoutGroupGridItem(i-1)
local isKill,hp,maxHp=XianJunYanZhenModel:getIsKill(self.selectGxIdx,i)
local usedData=XianJunYanZhenModel:getUsedData(i,self.selectGxIdx)
monsterItem:SetChildActive(4,not isKill and not isHasGxSpePlot and not usedData)
end
end

function UIXianJunYanZhenWin:showGxPlot()
local cfg=cfgHelper.get1(cfg_xianjunyanzhengxconfig_get,self.selectGxIdx)
local flag=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXJYZPlot,self.selectGxIdx,nil)
if cfg.plot_id~=nil and not flag then
gameplotController:showPlotBoard({isFullOpen=false,groupid=cfg.plot_id,callback=function()
userActorArraySetting.set(ACTOR_SETTING_TYPE.eXJYZPlot,_this.selectGxIdx,1)
userActorArraySetting.flush(ACTOR_SETTING_TYPE.eXJYZPlot)
_this.speSlot:setActive(false)
_this:refreshAllMonsterTz()
end})
return true
end
return false
end

function UIXianJunYanZhenWin:showGxSpePlot()
local canTz=XianJunYanZhenModel:getGxCanTz(self.selectGxIdx)
local cfg=cfgHelper.get1(cfg_xianjunyanzhengxconfig_get,self.selectGxIdx)
if cfg.spe_cond~=nil and not canTz then
local xiushiCond={cfg.spe_cond[2],cfg.spe_cond[3]}
local callback=function(idx,selectindex)
if idx==1 then
XianJunYanZhenController:send_42_3(_this.selectGxIdx)
elseif cfg.spe_cond[6]then
gameplotController:showPlotBoard({groupid=cfg.spe_cond[6],isFullOpen=false})
end
end
gameplotController:showPlotBoard({groupid=cfg.spe_cond[4],isFullOpen=false,callback=callback,xiushiCond=xiushiCond})
return true
end
return false
end

function UIXianJunYanZhenWin:isHasGxSpePlot()
local cfg=cfgHelper.get1(cfg_xianjunyanzhengxconfig_get,self.selectGxIdx)
local flag=userActorArraySetting.get(ACTOR_SETTING_TYPE.eXJYZPlot,self.selectGxIdx,nil)
local canTz=XianJunYanZhenModel:getGxCanTz(self.selectGxIdx)
local isHasSpe=cfg.spe_cond~=nil and not canTz
local isHasPlot=cfg.plot_id~=nil and not flag
return isHasSpe or isHasPlot
end

function UIXianJunYanZhenWin:refreshTop()

local levelTitleInfo=FMT.fmt("第{0}关",self.selectGxIdx)
self.leveltitle:setText(levelTitleInfo)

local totalStar=XianJunYanZhenModel:getTotalStar()
local maxStar=XianJunYanZhenModel:getMaxStar()
local totalStarStr=FMT.fmt("{0}/<color=#f1ce78>{1}星</color>",totalStar,maxStar)
self.starCount:setText(totalStarStr)
end

function UIXianJunYanZhenWin:refreshStar(isResult)
local cfg=cfgHelper.get1(cfg_xianjunyanzhengxconfig_get,self.selectGxIdx)
local max_star=XianJunYanZhenModel:getGxMaxStar(self.selectGxIdx)
local starList=XianJunYanZhenModel:getGxStarList(self.selectGxIdx)
local starLen=#cfg.star_conf+1

self.starScrollView:setChildScrollViewCreateGrids(starLen,starLen)
local starGrids=self.starScrollView:getChildScrollViewItemWidgets()
local starCount=starGrids.Count
for i=1,starCount do
local widget=starGrids[i-1]
widget:SetChildActive(0,max_star<i)
widget:SetChildActive(1,max_star>=i)
end
self.starScrollView:setChildSizeDelta(50*starLen,50)

self.conditionScrollView:setChildScrollViewCreateGrids(starLen,1)
local grids=self.conditionScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local widget=grids[i-1]
local isWc=max_star>=i
if i>1 then
isWc=starList[i-1]~=nil
end

local abname="ui/windows/xianjunyanzhen/xianjunyanzhen_atlas_pak.ab"
widget:SetChildCSImageSprite(0,abname,isWc and"image_xianjunyanzhen_rw02"or"image_xianjunyanzhen_rw01")

local desc,isLock=XianJunYanZhenModel:getDescStr(self.selectGxIdx,cfg.star_conf[i-1],i,isWc)
widget:SetChildActive(1,not isLock)
widget:SetChildActive(3,isLock)
if isLock then
widget:SetChildText(2,FMT.cfmt1(FONT_COLOR.eGrayColor,'{0}',desc))
else
widget:SetChildCSImageSprite(1,globalABLookup.global,isWc and"icon_tydxingxing_1"or"icon_tydxingxing_2")
local color=isWc and FONT_COLOR.eTitle2Color or FONT_COLOR.eGrayWhiteTxtColor
widget:SetChildText(2,FMT.cfmt(color,'{0}',desc))
end
end

if self.initCreateGxScrollView then
local levelGrids=self.levelScrollView:getChildScrollViewItemWidgets()
local widget=levelGrids[self.selectGxIdx-1]
widget:SetChildActive(4,false)
widget:SetChildScrollViewCreateGrids(2,starLen,starLen)
local curStarGrids=widget:GetChildScrollViewItemWidgets(2)
local curStarCount=curStarGrids.Count
for i=1,curStarCount do
local star_widget=curStarGrids[i-1]
star_widget:SetChildActive(0,max_star<i)
star_widget:SetChildActive(1,max_star>=i)
end


if isResult and self.selectGxIdx<levelGrids.Count then
local nextWidget=levelGrids[self.selectGxIdx]
nextWidget:SetChildActive(4,false)
end
end
end

function UIXianJunYanZhenWin:refreshReward()
local cfg=cfgHelper.get1(cfg_xianjunyanzhengxconfig_get,self.selectGxIdx)
local rewardLen=#cfg.pass_reward

local max_star=XianJunYanZhenModel:getGxMaxStar(self.selectGxIdx)
self.rewardScrollView:setChildScrollViewCreateGrids(rewardLen,rewardLen)
local grids=self.rewardScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local widget=grids[i-1]
local reward=cfg.pass_reward[i]
local itemid=reward[1]
local itemCount=reward[2]

local showCountBG=itemCount>1
local countStr=showCountBG and mathHelper.formatNumber(itemCount)or""
local conf={itemid=itemid,itemcount=countStr,showCountBG=showCountBG,showname=false,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
widget:SetChildPropData(0,prop)
widget:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClickEx(...)
end)

widget:SetChildActive(1,max_star>0)
end
end

function UIXianJunYanZhenWin:setFightTeam(mon_groub_idx,monsterFight)
if self.fightAnimLookup[mon_groub_idx]then
UIManager.error("正在挑战中")
return
end

local gx_id=self.selectGxIdx
local isKill=XianJunYanZhenModel:getIsKill(gx_id,mon_groub_idx)
local usedData=XianJunYanZhenModel:getUsedData(mon_groub_idx,gx_id)
if isKill and not usedData then
return
end

local hasPlot=self:showGxPlot()
if hasPlot then
return
end

local func1=function(teamList,soldierList,yzids)
local sendFightClient={gx_id,mon_groub_idx,#yzids,yzids,#soldierList,soldierList}
fightLaunchController:sendFightEx(eBattleLaunch.xianjunyanzhen,teamList,sendFightClient)
UIManager.info("出战成功")
end
local func=function()
UIFullXianJunYanZhenControl:showXJYZYunZhouBuZhenWindowEx({
gx_id=gx_id,
mon_groub_idx=mon_groub_idx,
callback=func1,
isIgnoreCheckFreeTeam=true,
isIgnoreCheckCost=true,
isCheckYBDData=false,
minSoldierNum=1,
isIgnoreYzOccupy=true,
targetFight=monsterFight,
usedSoldierList=XianJunYanZhenModel:getUsedXS(gx_id),
cancelCallBack=function()
end,
})
end
local curGxId=XianJunYanZhenModel:getCurGxId()
local curGxStar=XianJunYanZhenModel:getGxStar(curGxId)
if curGxId~=gx_id and XianJunYanZhenModel:getIsHasGxLog(curGxId)and curGxStar==0 then
local content=FMT.fmt('当前正在挑战<color=#7d3b17>第{0}关</color>，是否放弃<color=#7d3b17>第{0}关</color>挑\n战进度，选择当前关卡挑战？',curGxId,curGxId)
local showdata=
{
type='UIDialouge',
title='提示',
content=content,
oktext='确定',
canceltext='取消',
allowclickBG=true,
okcallback=function()
func()
end,
showclosebtn=false,
}
self.tipsDialog=UIDialogManager.newDialog(showdata)
self.tipsDialog:show()
else
func()
end
end

function UIXianJunYanZhenWin:getDiziList(guidList)
local list={}
for k,v in pairs(guidList)do
if v[1]==fightPreSelectModel.teamEntityType.dizi then
list[k]=v[2]
end
end
return list
end

function UIXianJunYanZhenWin:showBuffPanel()
self.buffPanel:setActive(self.isShowBuff)
self.buffRectBtn:setActive(self.isShowBuff)
if self.isShowBuff then
local buffList=XianJunYanZhenModel:getBuffList(self.selectGxIdx)
local len=#buffList
local isShow=len>0
self.notBuff:setActive(not isShow)
self.buffScrollView:setActive(isShow)
if isShow then
self.buffScrollView:setChildScrollViewCreateGrids(len,1)
local grids=self.buffScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local widget=grids[i-1]
local mid=buffList[i][1]
local desc=buffList[i][2]

widget:SetChildActive(0,mid==-1)
widget:SetChildActive(3,mid~=-1)
widget:SetChildActive(4,mid~=-1)
if mid==-1 then
widget:SetChildUIModelShowTarget(0,772123,0.3,{},eAnimationID.stand,true,false,0)
else
widget:SetChildCSImageSprite(4,globalABLookup.global,"image_gwtouxiangpjk_5")
comHelper.setChildModelRawImage_monsterGroup(widget,mid,3,0,eHeadCenterType.eHead)
end
widget:SetChildText(1,desc)
widget:SetChildActive(2,i>1)
end
local _h=len*85+15
local max=math.min(275,_h)
self.buffPanel:setChildSizeDelta(315,math.max(120,max))
else
self.buffPanel:setChildSizeDelta(315,120)
end
end
end

function UIXianJunYanZhenWin:playFight(args)
if not self.killAnims then
self.killAnims={}
end

local isFrist=args.isFrist
local gx_id=args.gx_id
local mon_groub_idx=args.mon_groub_idx
local oldStarList=args.oldStarList
local cfg=cfgHelper.get1(cfg_xianjunyanzhengxconfig_get,gx_id)
local monster=cfg.mon_groub_list[mon_groub_idx]
local dzBuffs=monster[3]
local monsterBuffs=monster[4]
local buffType=monster[6]

local hasDzBuff=dzBuffs and next(dzBuffs)
local hasMonBuff=monsterBuffs and next(monsterBuffs)

local initPos=self.zmModel:getChildLocalPosition()
local monsterItem=self.monsterContent:getChildLayoutGroupGridItem(mon_groub_idx-1)
local endPos=monsterItem:GetChildLocalPosition(-1)
local isMultiBattle=cfg.multi_battle_mon_id~=nil and cfg.multi_battle_mon_id[mon_groub_idx]~=nil

if not self.fightAnimLookup[mon_groub_idx]then
local lineItem=self.marchLineContent:getChildLayoutGroupGridItem(mon_groub_idx-1)
local shipItem=self.marchShipContent:getChildLayoutGroupGridItem(mon_groub_idx-1)

local fightEndFunc=function(attackCount)
if not _this then return end
local isKill=XianJunYanZhenModel:getIsKill(gx_id,mon_groub_idx)
if isKill then
if hasDzBuff or hasMonBuff then
_this:refreshBuffReddot(true)
end
if hasDzBuff then
_this:showDzAddBuff(buffType)
end
if hasMonBuff then
_this:showMonAddBuff(monsterBuffs)
end
end
_this:refreshStar()

_this:onCreateShipWidget(shipItem,endPos,initPos,isMultiBattle)
_this:onCreateLineWidget(lineItem,endPos,initPos)

_this:refreshMonsterState(mon_groub_idx,isFrist,gx_id,oldStarList)
end
local endFunc=function(idx)
if not _this then return end
lineItem:SetChildActive(-1,false)
shipItem:SetChildActive(-1,false)

_this.fightAnimLookup[idx]=nil
end
local _args={
state=1,
spos=initPos,
epos=endPos,
fightEndFunc=fightEndFunc,
endFunc=endFunc,
}
self.fightAnimLookup[mon_groub_idx]=self:getFightAnimArgs(_args)

shipItem:SetChildActive(-1,true)
self:onCreateShipWidget(shipItem,initPos,endPos,isMultiBattle)

lineItem:SetChildActive(-1,true)
self:onCreateLineWidget(lineItem,initPos,endPos)
end

self:startQuickTimer()
end

function UIXianJunYanZhenWin:refreshMonsterState(i,isFrist,gx_id,oldStarList)
local cfg=cfgHelper.get1(cfg_xianjunyanzhengxconfig_get,gx_id)
local monsterItem=self.monsterContent:getChildLayoutGroupGridItem(i-1)


local multi_battle_mon_id=cfg.multi_battle_mon_id or{}
local isMultiBattle=multi_battle_mon_id[i]~=nil

local isKill,hp,maxHp=XianJunYanZhenModel:getIsKill(gx_id,i)
monsterItem:SetChildActive(7,not isKill and isMultiBattle)
if not isKill and isMultiBattle then
monsterItem:SetChildProgress(7,hp,maxHp)
monsterItem:SetChildProgressText(7,FMT.fmt("{0}%",hp or 0))
end
local params=cfg.model_list[i]
if not params then
params={0,0,1,1,0.5}
end

monsterItem:SetChildActive(1,true)
local usedData=XianJunYanZhenModel:getUsedData(i,self.selectGxIdx)
monsterItem:SetChildActive(4,not isKill and not usedData)
if isKill then
monsterItem:SetChildModelAnimationState(0,eAnimationID.dead,1)
monsterItem:SetChildUIModelShowTarget(1,6051,1,{},eAnimationID.stand,false,false,0,nil)
_this.tweenLookup[i]=monsterItem:SetChildCanvasGroupDOFade(0,0,1,function()
if not _this then return end
if not _this.killAnims[i]then return end
_this.tweenLookup[i]=monsterItem:SetChildCanvasGroupDOFade(5,0,1,function()
_this.tweenLookup[i]=nil
end)
monsterItem:SetChildShowEffect(6,0,false)

_this:setFightResult(isFrist,gx_id,oldStarList)
end)
self:delayDo(2.5,function()
local scale=params[4]or 1
monsterItem:SetChildUIModelShowTarget(0,772163,scale,defaultT,eAnimationID.enter,false,false,0,nil)
monsterItem:SetChildLocalPos(0,0,20*scale,0)
monsterItem:SetChildCanvasGroupAlpha(0,1)

monsterItem:SetChildSizeDelta(3,140*scale,160*scale)
monsterItem:SetChildLocalPos(3,15*scale,0,0)
end)
self:delayDo(3,function()
if not _this then return end
if not _this.killAnims[i]then return end
monsterItem:SetChildActive(1,false)

_this.killAnims[i]=nil
end)
else
monsterItem:SetChildUIModelShowTarget(1,6052,1,{},eAnimationID.stand,false,false,0,nil)
self:delayDo(3,function()
monsterItem:SetChildActive(1,false)
_this.killAnims[i]=nil
end)

if NEWBIE_LUA_FUNC_TYPE["XJYZFirstFightLoseFunc"]then
if not newbieModel.isFinish(NEWBIE_LUA_FUNC_TYPE.XJYZFirstFightLoseFunc)then
_this.loseNewbie:setActive(true)
newbieControl.startNewbie(NEW_BIE_CND_TYPE.eLuaFun,NEWBIE_LUA_FUNC_NAME.XJYZFirstFightLoseFunc)
end
end
end
end

function UIXianJunYanZhenWin:setFightResult(isFrist,gx_id,oldStarList)
if next(self.fightAnimLookup)~=nil then
for mon_groub_idx,v in pairs(self.fightAnimLookup)do
if v.state<3 then
return
end
end
end
local cfg=cfgHelper.get1(cfg_xianjunyanzhengxconfig_get,gx_id)
local star=XianJunYanZhenModel:getGxStar(gx_id)
if star>0 then
self.isHasResult=true

UIManager:showWindow("UIXianJunYanZhenEffect",{para=10664})

self:delayDo(1.8,function()
local conf={}
local rewardLen=#cfg.pass_reward
for i=1,rewardLen do
local itemid=cfg.pass_reward[i][1]
local count=cfg.pass_reward[i][2]
table.insert(conf,{itemid=itemid,num=count})
end

local winArgs={
extraWin="UI_XJYZ_resultWin",
extraParams={
gx_id=gx_id,
rewards=conf,
isFrist=isFrist,
star=star,
oldStarList=oldStarList,
},
isHideFightBtn=true,
callback=function()
UIManager:closeWindow("UICommonVictoryWinTG")
end,
}
if isFrist and gx_id<XianJunYanZhenModel:getGxLen()then
winArgs.btnsInfo={
quitBtnName="退 出",
quitCallBack=function()
UIManager:closeWindow("UICommonVictoryWinTG")
end,
continueBtnName="进入下一关",
continuCallBack=function()
_this:onNextBtn()
end,
btnLocalPosY=-225,
}
end
UIManager:showWindow("UICommonVictoryWinTG",winArgs)

UIManager:invokeUIMethod("UIXianJunYanZhenRecordWin","onCloseBtn")
UIManager:invokeUIMethod("UIXianJunYanZhen_YunZhouPrepareWin","onCloseFunc")
end)

self:delayDo(2,function()
if isFrist then
_this.showNextBtnByGx=gx_id
end
_this:refreshNextBtn(_this.showNextBtnByGx==gx_id and gx_id<XianJunYanZhenModel:getGxLen())
_this:refreshMain(true)

_this.isHasResult=false
end)
end
end

function UIXianJunYanZhenWin:startQuickTimer()
if next(_this.fightAnimLookup)~=nil and not _this.timerRunning then
_this.timerRunning=_this:setTimer(0.016,0,function()
_this:onQuickUpdate()
end)
end
end

function UIXianJunYanZhenWin:onQuickUpdate()
if not _this then return end
for mon_groub_idx,v in pairs(_this.fightAnimLookup)do
v.nowtime=v.nowtime+0.016
local nowtime=v.nowtime
local state=v.state
if state~=4 then
local sPos=v.spos
local ePos=v.epos
local sTime=v.sTime
local eTime=v.eTime
local attackETime=v.attackETime
local backETime=v.backETime

local widget=_this.marchShipContent:getChildLayoutGroupGridItem(mon_groub_idx-1)
if nowtime<eTime then
local rx=ePos.x-sPos.x
local ry=ePos.y-sPos.y
local offX=100
local offY=offX/rx*ry

local ratio=(nowtime-sTime)/(eTime-sTime)

local posX=offX+sPos.x+(rx-offX*3)*ratio
local posY=offY+sPos.y+(ry-offY*3)*ratio
widget:SetChildLocalPos(-1,posX,posY,0)
elseif nowtime<attackETime then
if state<2 then
state=2
_this.fightAnimLookup[mon_groub_idx].state=2

local multi_battle_mon_id=cfgHelper.get2(cfg_xianjunyanzhengxconfig_get,_this.selectGxIdx,"multi_battle_mon_id")
local isMultiBattle=multi_battle_mon_id~=nil and multi_battle_mon_id[mon_groub_idx]~=nil
_this:onCreateShipWidget(widget,sPos,ePos,isMultiBattle,true)

local monsterItem=_this.monsterContent:getChildLayoutGroupGridItem(mon_groub_idx-1)

_this.killAnims[mon_groub_idx]=true
_this:monsterAttackLoop(monsterItem,mon_groub_idx,v.attackCount)
end
elseif nowtime<backETime then
if state<3 then
state=3
_this.fightAnimLookup[mon_groub_idx].state=3

if v.fightEndFunc then
v.fightEndFunc(v.attackCount)
end
end

local rx=sPos.x-ePos.x
local ry=sPos.y-ePos.y
local offX=-100
local offY=offX/rx*ry

local ratio=(nowtime-attackETime)/(backETime-attackETime)

local posX=offX*2+ePos.x+(rx-offX*3)*ratio
local posY=offY*2+ePos.y+(ry-offY*3)*ratio

widget:SetChildLocalPos(-1,posX,posY,0)
elseif state<4 then
state=4
_this.fightAnimLookup[mon_groub_idx].state=4

if v.endFunc then
v.endFunc(mon_groub_idx)
end
end
end
end

_this:stopQuickTimer()
end

function UIXianJunYanZhenWin:stopQuickTimer()
if not next(self.fightAnimLookup)and self.timerRunning then
self:stopTimerByID(self.timerRunning)
self.timerRunning=nil
end
end

function UIXianJunYanZhenWin:monsterAttackLoop(monsterItem,mon_groub_idx,count)
monsterItem:SetChildModelAnimationState(0,eAnimationID.attack1,1,function()
_this:delayDo(0.2,function()
if _this==nil then return end
if not _this.fightAnimLookup[mon_groub_idx]then
return
end
if not _this.fightAnimLookup[mon_groub_idx].state then
return
end
if _this.fightAnimLookup[mon_groub_idx].state~=2 then
return
end
count=count-1
_this.fightAnimLookup[mon_groub_idx].attackCount=count
if count>0 then
_this:monsterAttackLoop(monsterItem,mon_groub_idx,count)
end
end)
end)
end

function UIXianJunYanZhenWin:onCreateLineWidget(widget,spos,epos,isBack)
widget:SetChildLocalPos(-1,spos.x,spos.y,0)
local abname="ui/windows/xianjunyanzhen/sharedtextures/image_xianjunyanzhen_line.ab"
widget:SetChildCSImageSprite(0,abname,"image_xianjunyanzhen_line")
widget:SetChildLocalPos(0,50,50,0)


local angle_deg=mathHelper.getAngleByPos(spos.x,spos.y,epos.x,epos.y)
widget:SetChildRotation(0,0,0,angle_deg-90)

local distance=math.sqrt(math.pow(epos.x-spos.x,2)+math.pow(epos.y-spos.y,2))
widget:SetChildSizeDelta(0,52,math.abs(distance)or 0)

if deviceHelper.getAPILevel()>=70 then
widget:SetChildUVImageScrollSprite(0,1,0,false)
end
end


local angleActionMap=
{
[-4]={eAnimationID.jz_left_enter2stand,true,false,"jz_left_enter2stand"},
[-3]={eAnimationID.jz_leftup_enter2stand,true,false,"jz_leftup_enter2stand"},
[-2]={eAnimationID.jz_up_enter2stand,false,false,"jz_up_enter2stand"},
[-1]={eAnimationID.jz_leftup_enter2stand,false,false,"jz_leftup_enter2stand"},
[0]={eAnimationID.jz_left_enter2stand,false,false,"jz_left_enter2stand"},
[1]={eAnimationID.jz_leftdown_enter2stand,false,false,"jz_leftdown_enter2stand"},
[2]={eAnimationID.jz_up_enter2stand,false,true,"jz_up_enter2stand"},
[3]={eAnimationID.jz_leftdown_enter2stand,true,false,"jz_leftdown_enter2stand"},
[4]={eAnimationID.jz_left_enter2stand,true,false,"jz_left_enter2stand"},
}

function UIXianJunYanZhenWin:onCreateShipWidget(widget,sPos,ePos,isMultiBattle,playAttact)
local stateID,flipX,flipY

local rx=sPos.x-ePos.x
local ry=sPos.y-ePos.y
local radians=math.atan2(ry,rx)
local realAngle=math.deg(radians)
local index=math.floor((realAngle+22.5)/45)
local normalAngle=45*index

stateID,flipX,flipY=xianjieModel.getMarchTeamModelState({x=sPos.x,y=0,z=sPos.y},{x=ePos.x,y=0,z=ePos.y})
widget:SetChildUIModelShowTarget(0,isMultiBattle and 5734 or 5733,0.25,{},stateID,false,false,0)
widget:SetChildUIModelShowFlipX(0,flipX)
widget:SetChildUIModelShowFlipY(0,flipY)
widget:SetChildRotation(0,0,0,realAngle-normalAngle)

widget:SetChildActive(1,playAttact)
if playAttact then
widget:SetChildLocalPos(0,54,54,0)
widget:SetChildLocalPos(1,56,56,0)
widget:SetChildRotation(1,0,0,realAngle-normalAngle)

local actionInfo=angleActionMap[index]
if actionInfo~=nil then
widget:SetChildUIModelShowTarget(1,5752,1,{},actionInfo[1]or 0,false,false,0)
widget:SetChildUIModelShowFlipX(1,actionInfo[2])
widget:SetChildUIModelShowFlipY(0,actionInfo[3])
end
else
widget:SetChildLocalPos(0,50,50,0)
widget:SetChildUIModelRemoveTarget(1)
end
end

function UIXianJunYanZhenWin:getFightAnimArgs(args)
args=args or{}
local attackCount=math.random(2,3)
local endTime=1
local attackTime=attackCount
local attackETime=endTime+attackTime
local backETime=attackETime+1

args.nowtime=0
args.sTime=0
args.eTime=endTime
args.attackETime=attackETime
args.backETime=backETime
args.attackCount=attackCount
return args
end

function UIXianJunYanZhenWin:showDzAddBuff(type)
local isAdd=type==1
self.zmEffect:setChildShowEffect(0,false)
self.zmEffect:setChildShowEffect(isAdd and 10665 or 10666,true)
end

function UIXianJunYanZhenWin:showMonAddBuff(monsterBuffs)
for monid,v in pairs(monsterBuffs)do
local i=self.monsterLookup[monid]
local isKill=XianJunYanZhenModel:getIsKill(self.selectGxIdx,i)
if not isKill or(self.fightAnimLookup[monid]and self.fightAnimLookup[monid].state<2)then

local monsterItem=self.monsterContent:getChildLayoutGroupGridItem(i-1)
monsterItem:SetChildShowEffect(6,0,false)
monsterItem:SetChildShowEffect(6,10667,true)
end
end
end

function UIXianJunYanZhenWin:clearAllAnim()
self.isHasResult=false
for mon_groub_idx,v in pairs(self.fightAnimLookup)do
if v.endFunc then
v.endFunc(mon_groub_idx)
end
end
self.fightAnimLookup={}

for mon_groub_idx,v in ipairs(self.tweenLookup)do
v:Kill()
end
self.tweenLookup={}

self.killAnims={}
self:stopQuickTimer()
self:stopAllTimer()
end

function UIXianJunYanZhenWin:getIsHasAnim()
if self.killAnims and next(self.killAnims)~=nil then
return true
end
if self.fightAnimLookup and next(self.fightAnimLookup)~=nil then
return true
end
if self.isHasResult then
return true
end
return false
end

function UIXianJunYanZhenWin:setShowLevelAnim()
if self.isHasLevelAnim then
return
end
self.isHasLevelAnim=true

if self.isShowGxScrollView then
self.levelbg:setActive(true)
self.levelRectBtn:setActive(true)
self.levelViewport:setActive(true)
self.levelJt:setScale(Vector3(1,-1,1))

local idx=math.max(self.selectGxIdx-3,0)
self.levelScrollView:setChildScrollViewSelectItem(idx,false,false,false)

self.levelScrollView:setChildDOSizeDelta(Vector2(301,318),0.2,function()
if not _this then return end
_this.isHasLevelAnim=false
end)
else
_this.levelJt:setScale(Vector3(1,1,1))

self.levelScrollView:setChildDOSizeDelta(Vector2(301,2),0.2,function()
if not _this then return end
_this.isHasLevelAnim=false

_this.levelbg:setActive(false)
_this.levelRectBtn:setActive(false)
_this.levelViewport:setActive(false)
end)
end
end

function UIXianJunYanZhenWin:doPunchRotation(widget,componentIndex,reddotIndex,isReddot)
if webGLHelper:isHidePunchAni()then return end
if isReddot then
if self.reddotTweenerList==nil then
self.reddotTweenerList={}
end
if not reddotIndex then
reddotIndex=#self.reddotTweenerList+1
end

if self.reddotTweenerList[reddotIndex]==nil then
widget:SetChildRotation(componentIndex,0,0,0)
local tweener=widget:SetChildDOPunchRotation(componentIndex,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweenerList[reddotIndex]={}
self.reddotTweenerList[reddotIndex].tweener=tweener
self.reddotTweenerList[reddotIndex].widget=widget
self.reddotTweenerList[reddotIndex].componentIndex=componentIndex
end

return reddotIndex
else
if self.reddotTweenerList==nil or not next(self.reddotTweenerList)then
return nil
end
if self.reddotTweenerList[reddotIndex]~=nil then
self.reddotTweenerList[reddotIndex].tweener:Complete()
self.reddotTweenerList[reddotIndex].tweener:Kill()
self.reddotTweenerList[reddotIndex]=nil
widget:SetChildRotation(componentIndex,0,0,0)
return nil
end
end
end




function UIXianJunYanZhenWin:onCloseBtn()
UIFullXianJunYanZhenControl:closeUI(true,true)
end



function UIXianJunYanZhenWin:onCxtzBtn()
if self:getIsHasAnim()then
UIManager.error("正在挑战中")
return
end
self:showResetTips()
end



function UIXianJunYanZhenWin:onLoseNewbie()
self:showResetTips()
self.loseNewbie:setActive(false)
end

function UIXianJunYanZhenWin:showResetTips()
local cfg=cfgHelper.get1(cfg_xianjunyanzhengxconfig_get,self.selectGxIdx)
local max_star=XianJunYanZhenModel:getGxMaxStar(self.selectGxIdx)
local starLen=#cfg.star_conf+1
if max_star>=starLen then
UIManager.error("当前关卡已满星，无法重置关卡")
return
end
UIFullXianJunYanZhenControl:showWindow('UIXianJunYanZhenResetTipsWin',{gx_id=self.selectGxIdx})
end



function UIXianJunYanZhenWin:onJiluBtn()
UIFullXianJunYanZhenControl:showWindow('UIXianJunYanZhenRecordWin',{gx_id=self.selectGxIdx})
end



function UIXianJunYanZhenWin:onNextBtn()
if self:getIsHasAnim()then
UIManager.error("正在挑战中")
return
end
local gxLen=XianJunYanZhenModel:getGxLen()
if self.selectGxIdx>=gxLen then

return
end
local curGxIdx=self.selectGxIdx+1
XianJunYanZhenModel:setOpenGx(curGxIdx)

_this:refreshGxId(curGxIdx)
end



function UIXianJunYanZhenWin:onRewardBtn()
if self:getIsHasAnim()then
UIManager.error("正在挑战中")
return
end
if not self.passportId then

return
end
if self.passport_guid then
UITYTongXingZhengController:showXJYZTXZWin(self.passport_guid,self.passportId)
else
loggerUtil.logErrFMT("不存在ID为{0}的通行证GUID",self.passportId)
end
end



function UIXianJunYanZhenWin:onStarRewardBtn()
if self:getIsHasAnim()then
UIManager.error("正在挑战中")
return
end
UIFullXianJunYanZhenControl:showWindow('UIXianJunYanZhenStarRewardsWin')
end



function UIXianJunYanZhenWin:onRuleBtn()
local d={}
d.title='规则'
d.mode=3
d.name='XianJunYanZhen_help_%d'
d.showBlack=true
UIManager:showWindow('UIRuleWin',d)
end



function UIXianJunYanZhenWin:onTitleClick()
self:onLevelBtn()
end



function UIXianJunYanZhenWin:onLevelBtn()
if self:getIsHasAnim()then
UIManager.error("正在挑战中")
return
end
self.isShowGxScrollView=not self.isShowGxScrollView

local maxLevel=XianJunYanZhenModel:getMaxGxId()
if self.isShowGxScrollView then
if not self.initCreateGxScrollView then
self.initCreateGxScrollView=true
local gxLen=XianJunYanZhenModel:getGxLen()
self.levelScrollView:setChildScrollViewCreateGrids(gxLen,1)
local grids=self.levelScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local widget=grids[i-1]

local curCfg=cfgHelper.get1(cfg_xianjunyanzhengxconfig_get,i)
local max_star=XianJunYanZhenModel:getGxMaxStar(curCfg.id)

local isSelect=curCfg.id==_this.selectGxIdx
widget:SetChildActive(0,isSelect)

local isLock=curCfg.id>maxLevel
widget:SetChildActive(4,isLock)

widget:SetChildActive(5,i<gxLen)


local str=FMT.fmt("第{0}关",curCfg.id)
widget:SetChildText(1,str)

local starLen=#curCfg.star_conf+1
widget:SetChildScrollViewCreateGrids(2,starLen,starLen)
local starGrids=widget:GetChildScrollViewItemWidgets(2)
local starCount=starGrids.Count
for index=1,starCount do
local star_widget=starGrids[index-1]
star_widget:SetChildActive(0,max_star<index)
star_widget:SetChildActive(1,max_star>=index)
end


widget:SetChildButtonClick(3,function()
if _this.isHasLevelAnim then
return
end
if _this:getIsHasAnim()then
UIManager.error("正在挑战中")
_this:onLevelRectBtn()
return
end
local curMaxLevel=XianJunYanZhenModel:getMaxGxId()
if curCfg.id>curMaxLevel then
UIManager.error(FMT.fmt("请先通关第{0}关",curMaxLevel))
return
end

_this:refreshGxId(curCfg.id)

_this:onLevelRectBtn()
end)
end
end
end

self:setShowLevelAnim()
end



function UIXianJunYanZhenWin:onLevelRectBtn()
_this.isShowGxScrollView=false
self:setShowLevelAnim()
end



function UIXianJunYanZhenWin:onAttrStateBtn()
self:refreshBuffReddot(false)
self.isShowBuff=not self.isShowBuff
self:showBuffPanel()
end



function UIXianJunYanZhenWin:onBuffRectBtn()
self.isShowBuff=false
self:showBuffPanel()
end



function UIXianJunYanZhenWin:onJdModel()
local star=XianJunYanZhenModel:getGxStar(self.selectGxIdx)
if self:getIsHasAnim()or star==0 then
UIManager.error("击败所有妖魔可收复据点")
end
end
