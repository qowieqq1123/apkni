







def_class("UIDiscipleTianMingWin",UIWindowBase)









function UIDiscipleTianMingWin:bindComponents()

self.chongGridNotLayout=UIObject.get(self,0)
self.cifuGrid=UIObject.get(self,1)
self.costObj=UIObject.get(self,2)
self.daoyan=UIObject.get(self,3)
self.daoyanBtn=UIButton.get(self,4)
self.daoyanbtnEffect=UIObject.get(self,5)
self.daoyanbtnIcon=UIObject.get(self,6)
self.daoyanHuoGrid=UIObject.get(self,7)
self.daoyanLock=UIObject.get(self,8)
self.daoyanLvText=UIText.get(self,9)
self.daoyanReddot=UIObject.get(self,10)
self.daoyanUnlockEffect=UIObject.get(self,11)
self.effDY=UIObject.get(self,12)
self.effDYDi=UIObject.get(self,13)
self.fullTipsTxt=UIText.get(self,14)
self.huoGrid=UIObject.get(self,15)
self.jjRateText=UIText.get(self,16)
self.mDY=UIObject.get(self,17)
self.moneyDesc=UIText.get(self,18)
self.moneyIcon=UIImage.get(self,19)
self.moneyObj=UIButton.get(self,20)
self.rongdaoButton=UIButton.get(self,21)
self.rongdaoReddot=UIObject.get(self,22)
self.root=UIObject.get(self,23)
self.submitButton=UIButton.get(self,24)
self.submitReddot=UIObject.get(self,25)
self.tianming=UIObject.get(self,26)
self.tianmingBtn=UIButton.get(self,27)
self.tianmingLvText=UIText.get(self,28)
self.TMReset=UIButton.get(self,29)
self.upJJRateObj=UIObject.get(self,30)
self.upJJRateTxt=UIText.get(self,31)
self.upObj=UIObject.get(self,32)
self.tianmingTitlePanel=UIObject.get(self,33)
self.chongGrid=UIObject.get(self,34)
self.bgImage=UIImage.get(self,35)
self.bgTop=UIImage.get(self,36)
self.bgBottom=UIImage.get(self,37)
self.jjRatePanel=UIObject.get(self,38)
self.upJJRateBg=UIImage.get(self,39)
self.costTitleBg=UIObject.get(self,40)
self.costTitleText=UIText.get(self,41)
self.jjRateTitle=UIObject.get(self,42)

self.daoyanBtn:setButtonClick(function()self:onDaoyanBtn()end)

self.moneyObj:setButtonClick(function()self:onMoneyObj()end)

self.rongdaoButton:setButtonClick(function()self:onRongdaoButton()end)

self.submitButton:setButtonClick(function()self:onSubmitButton()end)

self.tianmingBtn:setButtonClick(function()self:onTianmingBtn()end)

self.TMReset:setButtonClick(function()self:onTMReset()end)



end


function UIDiscipleTianMingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.chongGridNotLayout);self.chongGridNotLayout=nil;
_UIObject_release(self.cifuGrid);self.cifuGrid=nil;
_UIObject_release(self.costObj);self.costObj=nil;
_UIObject_release(self.daoyan);self.daoyan=nil;
_UIObject_release(self.daoyanBtn);self.daoyanBtn=nil;
_UIObject_release(self.daoyanbtnEffect);self.daoyanbtnEffect=nil;
_UIObject_release(self.daoyanbtnIcon);self.daoyanbtnIcon=nil;
_UIObject_release(self.daoyanHuoGrid);self.daoyanHuoGrid=nil;
_UIObject_release(self.daoyanLock);self.daoyanLock=nil;
_UIObject_release(self.daoyanLvText);self.daoyanLvText=nil;
_UIObject_release(self.daoyanReddot);self.daoyanReddot=nil;
_UIObject_release(self.daoyanUnlockEffect);self.daoyanUnlockEffect=nil;
_UIObject_release(self.effDY);self.effDY=nil;
_UIObject_release(self.effDYDi);self.effDYDi=nil;
_UIObject_release(self.fullTipsTxt);self.fullTipsTxt=nil;
_UIObject_release(self.huoGrid);self.huoGrid=nil;
_UIObject_release(self.jjRateText);self.jjRateText=nil;
_UIObject_release(self.mDY);self.mDY=nil;
_UIObject_release(self.moneyDesc);self.moneyDesc=nil;
_UIObject_release(self.moneyIcon);self.moneyIcon=nil;
_UIObject_release(self.moneyObj);self.moneyObj=nil;
_UIObject_release(self.rongdaoButton);self.rongdaoButton=nil;
_UIObject_release(self.rongdaoReddot);self.rongdaoReddot=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.submitButton);self.submitButton=nil;
_UIObject_release(self.submitReddot);self.submitReddot=nil;
_UIObject_release(self.tianming);self.tianming=nil;
_UIObject_release(self.tianmingBtn);self.tianmingBtn=nil;
_UIObject_release(self.tianmingLvText);self.tianmingLvText=nil;
_UIObject_release(self.TMReset);self.TMReset=nil;
_UIObject_release(self.upJJRateObj);self.upJJRateObj=nil;
_UIObject_release(self.upJJRateTxt);self.upJJRateTxt=nil;
_UIObject_release(self.upObj);self.upObj=nil;
_UIObject_release(self.tianmingTitlePanel);self.tianmingTitlePanel=nil;
_UIObject_release(self.chongGrid);self.chongGrid=nil;
_UIObject_release(self.bgImage);self.bgImage=nil;
_UIObject_release(self.bgTop);self.bgTop=nil;
_UIObject_release(self.bgBottom);self.bgBottom=nil;
_UIObject_release(self.jjRatePanel);self.jjRatePanel=nil;
_UIObject_release(self.upJJRateBg);self.upJJRateBg=nil;
_UIObject_release(self.costTitleBg);self.costTitleBg=nil;
_UIObject_release(self.costTitleText);self.costTitleText=nil;
_UIObject_release(self.jjRateTitle);self.jjRateTitle=nil;
end
















local _this=nil
local lineLookup={
{'image_dztmxiantiao_a1','image_dztmxiantiao_a2'},
{'image_dztmxiantiao_b1','image_dztmxiantiao_b2'},
{'image_dztmxiantiao_c1','image_dztmxiantiao_c12'},
{'image_dztmxiantiao_c1','image_dztmxiantiao_c12'},
{'image_dztmxiantiao_b1','image_dztmxiantiao_b2'},
{'image_dztmxiantiao_a1','image_dztmxiantiao_a2'},
}
local effectLookup={
{{10134,255,-4,-1},{10137,-255,-4,1}},
{{10135,260,-4,-1},{10138,-260,-4,1}},
{{10136,260,0,-1},{10139,-255,0,1}},
{{10136,-260,0,1},{10139,255,0,-1}},
{{10135,-260,-4,1},{10138,260,-4,-1}},
{{10134,-255,-4,1},{10137,255,-4,-1}},
}

local _bgModelIds={6188,6189,6190}


function UIDiscipleTianMingWin:onLoaded(...)
_this=self
self:bindComponents()
self.isgetbtn=false
notifySystem:listenNotify(notifyConfig.onDiscipleTianMingLvChange,self.onDiscipleTianMingLvChange)
notifySystem:listenNotify(notifyConfig.onDiscipleDaoYanLvChange,self.onDiscipleDaoYanLvChange)
notifySystem:listenNotify(notifyConfig.onDiscipleTianMingCiFuChange,self.onDiscipleTianMingCiFuChange)

self.on_money_changed=function(mtype,last,curr)
if mtype==self.checkType then
self:refreshInfo(dzTianMingTabType.eTianMing)
self.checkType=nil
end
end

notifySystem:listenNotify(notifyConfig.on_money_changed,self.on_money_changed)

local _onDiscipleDaoYanLvReset=function()
self:initInfo()
self:refreshInfo()
end
self:addNotify(notifyConfig.onDiscipleDaoYanLvReset,_onDiscipleDaoYanLvReset)
end


function UIDiscipleTianMingWin:__delete()
_this=nil
self:unbindComponents()

notifySystem:removelistener(notifyConfig.onDiscipleTianMingLvChange,self.onDiscipleTianMingLvChange)
notifySystem:removelistener(notifyConfig.onDiscipleDaoYanLvChange,self.onDiscipleDaoYanLvChange)
notifySystem:removelistener(notifyConfig.onDiscipleTianMingCiFuChange,self.onDiscipleTianMingCiFuChange)

notifySystem:removelistener(notifyConfig.on_money_changed,self.on_money_changed)
end


function UIDiscipleTianMingWin:onHide()

end

function UIDiscipleTianMingWin.onDiscipleTianMingLvChange(dis_guid,oldtmlv,tmlv)
if _this==nil then return end

if not mathHelper.compareInt64(dis_guid,_this.disciple_guid)then
return
end

_this:initInfo()

local cur_floor=UIDiscipleModel.getTianMingLevelFloor(tmlv)
local old_floor=UIDiscipleModel.getTianMingLevelFloor(oldtmlv)
if cur_floor~=old_floor then
local idx=cur_floor+1
_this:refreshTMFireItem(nil,idx,true)
_this:refreshInfo(dzTianMingTabType.eTianMing)
else
_this:refreshInfo(dzTianMingTabType.eTianMing)
end

local cifuopen=UIDiscipleModel:checkTiamMingCiFuOpen(dis_guid)
if cifuopen then
_this:refreshCiFuInfo()
end
end

function UIDiscipleTianMingWin.onDiscipleDaoYanLvChange(dis_guid,olddylv,dylv)
if _this==nil then return end

if not mathHelper.compareInt64(dis_guid,_this.disciple_guid)then
return
end

_this:initInfo()

local cur_chong=UIDiscipleModel.getDaoYanLevelFloor(dylv)
_this:refreshDYFireItem(nil,cur_chong)
_this:refreshInfo(dzTianMingTabType.eDaoYan)
end

function UIDiscipleTianMingWin.onDiscipleTianMingCiFuChange(dis_guid)
if _this==nil then return end

if not mathHelper.compareInt64(dis_guid,_this.disciple_guid)then
return
end

_this:refreshCiFuInfo()
end




function UIDiscipleTianMingWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid
self.showType=UIDiscipleModel:getDiscipleType(self.disciple_guid)

self.oldTabSelect=nil
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
self.isOpenDaoYan=UIDiscipleModel:checkOpenDaoYan(netData)
self.isFirstDY=UIDiscipleModel:getIsFirstEnterDaoYan()
local canShowUnlockDaoYan=UIDiscipleModel:getIsCanShowUnlockDaoYanTips(self.disciple_guid)
if self.isFirstDY or canShowUnlockDaoYan then
self.tabSelect=dzTianMingTabType.eTianMing
else
self.tabSelect=self.isOpenDaoYan and dzTianMingTabType.eDaoYan or dzTianMingTabType.eTianMing
end

self.isInitAllTMFire=false
self.isInitAllDYFire=false

self:initInfo()
self:refreshInfo()
self:refreshCiFuInfo()
self:isShowTmResetBtn()

local isUnlockDY=UIDiscipleModel:getDiscipleDaoYanUnLockReddot(self.disciple_guid)
if isUnlockDY then
self:onUnlockDY(self.disciple_guid)
end
end

function UIDiscipleTianMingWin:onUnlockDY(dis_guid)
if dis_guid~=self.disciple_guid then
return
end
self.winlua:SetChildShowEffect(self.daoyanUnlockEffect:getID(),20692,true)
self:refreshDaoYanBtn(true)
self:delayDo(1.5,function()
if not _this then return end
UIManager:showWindow("UIDiscipleDaoYanUnlockWin",{discipleGuid=dis_guid})
end)
end

function UIDiscipleTianMingWin:onChangeDisciple(dis_guid)
self:onShow({guid=dis_guid})
end

function UIDiscipleTianMingWin:initInfo()
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
self.tmlv=UIDiscipleModel:getTianMingLevelEx(netData)
self.dylv=UIDiscipleModel:getDaoYanLevelEx(netData)
local dzId=netData.id
self.layoutCfg=cfgHelper.get(cfg_discipletianminglayoutconfig_get,dzId)
if not self.layoutCfg then

self.layoutCfg=cfgHelper.get(cfg_discipletianminglayoutconfig_get,-1)
end
end

function UIDiscipleTianMingWin:refreshInfo(refreshTabType,isTab)

if refreshTabType and self.tabSelect~=refreshTabType then
return
end

if self.tabSelect==dzTianMingTabType.eTianMing then
self.mDY:setChildUIModelRemoveTarget()
self:refreshTianMingPanel()
self:refreshAllTMFire()
else
self:refreshDaoYanPanel()
self:refreshAllDYFire()
end
if isTab then
local animTime=0.3
local panel1,panel2
self:stopTweener()
if self.tabSelect==dzTianMingTabType.eDaoYan then
panel1=self.tianming
panel2=self.daoyan
else
panel1=self.daoyan
panel2=self.tianming
end
panel1:setActive(true)
panel1:setChildCanvasGroupAlpha(1)
local cavasGroup1=panel1:getCommonComponent('CanvasGroup')

panel2:setActive(true)
panel2:setChildCanvasGroupAlpha(0)
local cavasGroup2=panel2:getCommonComponent('CanvasGroup')

self.isTweener=true
self:refreshAllEffect()
self.tweener1=_DOTweenProxy.DOFade(cavasGroup1,0,animTime)
self.tweener1:SetDelay(0.2)
self.tweener1:OnComplete(function()
panel1:setActive(false)
end)
self.tweener2=_DOTweenProxy.DOFade(cavasGroup2,1,animTime)
self.tweener2:SetDelay(0.2)
self.tweener2:OnComplete(function()
self.isTweener=false
self:refreshAllEffect()
end)
elseif not self.oldTabSelect or self.oldTabSelect~=self.tabSelect then
self:stopTweener()
self.tianming:setChildCanvasGroupAlpha(1)
self.daoyan:setChildCanvasGroupAlpha(1)
self.tianming:setActive(self.tabSelect==dzTianMingTabType.eTianMing)
self.daoyan:setActive(self.tabSelect==dzTianMingTabType.eDaoYan)
end
self.oldTabSelect=self.tabSelect
end

function UIDiscipleTianMingWin:stopTweener()
if self.tweener1 then
self.tweener1:Kill(false)
self.tweener1=nil
end
if self.tweener2 then
self.tweener2:Kill(false)
self.tweener2=nil
end
self.isTweener=false
self:refreshAllEffect()
end


function UIDiscipleTianMingWin:refreshTianMingPanel()
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local layoutCfg=self.layoutCfg


local bgImageCfg=layoutCfg.bgImage
local bgImageAb=bgImageCfg[1]
local bgImageName=bgImageCfg[2]
self.bgImage:setSprite(bgImageAb,bgImageName)


local bgTopParam=layoutCfg.bgTopParams
local isShowBgTop=bgTopParam~=nil
self.bgTop:setActive(isShowBgTop)
if isShowBgTop then
local img=bgTopParam.img
local bgTopImageAb=img[1]
local bgTopImageName=img[2]
self.bgTop:setSprite(bgTopImageAb,bgTopImageName)
local offset=bgTopParam.offset
self.bgTop:setChildAnchoredPos(offset[1],offset[2])
end


local tmlvShowParams=layoutCfg.tmTitleParams
local tmlv=self.tmlv
local lv_str=UIDiscipleModel.getTianMingLevelDesc(tmlv,1)
local strColor=tmlvShowParams.color
if strColor then
lv_str=FMT.cfmt2(strColor,lv_str)
end
self.tianmingLvText:setText(lv_str)
local tmlvTextOffset=tmlvShowParams.offset or{0,0}
self.tianmingTitlePanel:setChildAnchoredPos(tmlvTextOffset[1],tmlvTextOffset[2])


local chong=UIDiscipleModel.getTianMingLevelChong(tmlv)
local showchong=chong>0
if showchong then
local useChongGridObj=self.chongGrid
local chongOffset=layoutCfg.chongGridOffset
local isIgnoreLayout=false
if chongOffset then
isIgnoreLayout=true
useChongGridObj=self.chongGridNotLayout
end
self.chongGrid:setActive(not isIgnoreLayout)
self.chongGridNotLayout:setActive(isIgnoreLayout)
if isIgnoreLayout then
useChongGridObj:setChildAnchoredPos(chongOffset[1],chongOffset[2])
end
local floor=UIDiscipleModel.getTianMingLevelFloor(tmlv)
local abName,iconName=UIDiscipleModel.getTianMingFloorIcon(floor)
local grids=useChongGridObj:getChildCommonLayoutGroupWidgetList()
for i=1,3 do
local item=grids[i-1]
local isActive=i<=chong
local scale=0.5
if not isActive then
abName=globalABLookup.dizitianmingicons
iconName='image_dztianmingui_2'
scale=1
end
item:SetChildCSImageSprite(0,abName,iconName)
item:SetChildScale(0,Vector3.New(scale,scale,scale))

end
else
self.chongGrid:setActive(false)
self.chongGridNotLayout:setActive(false)
end

local tmcfg=cfgHelper.get1(cfg_discipletianminglevelconfig_get,tmlv)
local next_tmcfg=cfgHelper.get1(cfg_discipletianminglevelconfig_get,tmlv+1)
local isFull=next_tmcfg==nil


local jjRateShowParams=layoutCfg.jjRateShowParams
local ratePanelOffset=jjRateShowParams.offset or{0,0}
self.jjRatePanel:setChildAnchoredPos(ratePanelOffset[1],ratePanelOffset[2])
local rateTextOffset=jjRateShowParams.textOffset or{0,0}
self.jjRateText:setChildAnchoredPos(rateTextOffset[1],rateTextOffset[2])
local rateTitleOffset=jjRateShowParams.titleOffset or{0,0}
self.jjRateTitle:setChildAnchoredPos(rateTitleOffset[1],rateTitleOffset[2])

local rate_str=FMT.fmt('+{0}%',tmcfg.percent)
self.jjRateText:setText(rate_str)
self.upJJRateObj:setActive(not isFull)
if not isFull then
local rateUpOffset=jjRateShowParams.upOffset or{0,0}
self.upJJRateObj:setChildAnchoredPos(rateUpOffset[1],rateUpOffset[2])
local lerp=next_tmcfg.percent-tmcfg.percent
local upTextStr=FMT.fmt('{0}%',lerp)
local upTextSize=jjRateShowParams.upTextSize
if upTextSize then
upTextStr=FMT.fmt("<size={0}>{1}</size>",upTextSize,upTextStr)
end
local isOutLine=jjRateShowParams.upOutLine or false
self.widget:SetChildOutlineEnabled(self.upJJRateTxt:getID(),isOutLine)
self.upJJRateTxt:setText(upTextStr)

local upBgParam=jjRateShowParams.upBg
if upBgParam then
local upBgAb=upBgParam[1]
local upBgImageName=upBgParam[2]
self.upJJRateBg:setSprite(upBgAb,upBgImageName)
end
local upBgSize=jjRateShowParams.upBgSize
if upBgSize then
self.upJJRateBg:setChildSizeDelta(upBgSize[1],upBgSize[2])
end
local upBgOffset=jjRateShowParams.upBgOffset or{0,0}
self.upJJRateBg:setChildAnchoredPos(upBgOffset[1],upBgOffset[2])
end

local isTemp=self.showType==dicipleType.eTemp


local bgBottomParam=layoutCfg.bgButtomParams
local isShowBgBottom=not isFull and bgBottomParam~=nil
self.bgBottom:setActive(isShowBgBottom)
if isShowBgBottom then
local img=bgBottomParam.img
local bgBottomImageAb=img[1]
local bgBottomImageName=img[2]
self.bgBottom:setSprite(bgBottomImageAb,bgBottomImageName)
local offset=bgBottomParam.offset
self.bgBottom:setChildAnchoredPos(offset[1],offset[2])
end


local costShowParams=layoutCfg.costShowParams
local costTitleTextOffset=costShowParams.titleOffset or{0,0}
self.costTitleText:setChildAnchoredPos(costTitleTextOffset[1],costTitleTextOffset[2])
local costTitleTextStr=costShowParams.str
self.costTitleText:setText(costTitleTextStr)
local isShowCostTitleBg=costShowParams.isShowBg or false
self.costTitleBg:setActive(isShowCostTitleBg)
if isShowCostTitleBg then
local bgOffset=costShowParams.bgOffset or{0,0}
self.costTitleBg:setChildAnchoredPos(bgOffset[1],bgOffset[2])
end

self.upObj:setActive(not isFull and not isTemp)
self.fullTipsTxt:setActive(isFull and not isTemp)
if not isFull then
local cost=UIDiscipleModel:getUpTianMingCost(netData)

local costObjWidget=self.costObj:getChildWidgetBase()

local itemid=cost[1][1]
local itemNum=cost[1][2]
local conf={itemid=itemid,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
costObjWidget:SetChildPropData(0,prop)
costObjWidget:SetBaseItemClickEvent(0,function()
itemsComponentHelper.onItemClickEx(itemid)
end)

local itemConfig=itemsConfig.getConfig(itemid)
costObjWidget:SetChildText(1,itemConfig.name)

local dzID=UIDiscipleModel:getDiscipleIDEx(netData)


local glitemid=liandonModel:CheckDiZiItem_Guanlian(dzID)


local has_itemNum=bagModel.getItemCountById(itemid)
if glitemid then
local has_glitemNum=bagModel.getItemCountById(glitemid)
has_itemNum=has_itemNum+has_glitemNum
end

local num_str=FMT.fmt('{0}/{1}',has_itemNum,itemNum)
if has_itemNum<itemNum then
num_str=toColorString(FONT_COLOR.eRedColor,num_str)
end
costObjWidget:SetChildText(2,num_str)

local moneyType=cost[2][1]
local moneyNum=cost[2][2]
local has_moneyNum=moneyModel.getMoney(moneyType)
local money_str=mathHelper.formatNumber3(moneyNum)
if has_moneyNum<moneyNum then
money_str=toColorString(FONT_COLOR.eRedColor,money_str)
end
self.moneyDesc:setText(money_str)
self.moneyIcon:setImageIcon(iconHelper.getIconName(moneyType),false)

local use_spe_itemNum=0
local isSPdz=UIDiscipleModel:isSPDiscipleEx(self.disciple_guid)
if not isSPdz then
local spe_itemid=UIDiscipleModel:getUpTianMingCost2()
local spe_itemNum=0
if has_itemNum<itemNum and itemid~=spe_itemid then
spe_itemNum=bagModel.getItemCountById(spe_itemid)
use_spe_itemNum=math.min(spe_itemNum,math.abs(has_itemNum-itemNum))
end
end
local num=has_itemNum+use_spe_itemNum
local isReddot=num>=itemNum and has_moneyNum>=moneyNum
self.submitReddot:setActive(isReddot)
end
self:refreshDaoYanBtn()
end

function UIDiscipleTianMingWin:refreshAllTMFire()
if self.isInitAllTMFire then return end
self.isInitAllTMFire=true
local grids=self.huoGrid:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
self:refreshTMFireItem(item,i)

item:SetChildButtonClick(1,function()
self:onTMFireItemClick(i)
end)
end
end
local skillIconIds={30001,30002,30003,30004,30005,30006}

function UIDiscipleTianMingWin:refreshTMFireItem(item,idx,anim)
if item==nil then
item=self.huoGrid:getChildCommonLayoutGroupWidgetItem(idx-1)
end

local layoutCfg=self.layoutCfg
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)

local skillShowParams=layoutCfg.skillParams and layoutCfg.skillParams[idx]
if not skillShowParams then
item:SetChildActive(-1,false)
return
end
item:SetChildActive(-1,true)

local offset=skillShowParams.offset or{0,0}
item:SetChildAnchoredPosition(-1,Vector2(offset[1],offset[2]))
local iconOffset=skillShowParams.iconOffset or{0,0}
item:SetChildAnchoredPosition(1,Vector2(iconOffset[1],iconOffset[2]))
local iconBgOffset=skillShowParams.iconBgOffset or{0,0}
item:SetChildAnchoredPosition(4,Vector2(iconBgOffset[1],iconBgOffset[2]))

local isActive,need_tmlv
local tmId
if idx==6 then
isActive,need_tmlv=UIDiscipleModel.checkTiamMingCiFuPosOpenX(self.tmlv,1)
tmId=0
elseif idx>6 then
isActive,need_tmlv=UIDiscipleModel:checkTianMingFloorActive(self.tmlv,idx-1)
tmId=netData.tmList[idx-1]
else
isActive,need_tmlv=UIDiscipleModel:checkTianMingFloorActive(self.tmlv,idx)
tmId=netData.tmList[idx]
end


local tmCfg=cfgHelper.get1(cfg_discipletianmingconfig_get,tmId)
local jobid=UIDiscipleModel:getDiscipleJob(self.disciple_guid)
local skillIconId=UIDiscipleModel.getTianMingSkillIconId(tmCfg,jobid,netData)

local skillIconName=iconHelper.getSkillIcon(skillIconId)

local iconSize=skillShowParams.iconSize
local isSetNative=true
if iconSize then
item:SetChildSizeDelta(1,iconSize[1],iconSize[2])
isSetNative=false
end
item:SetChildCSImageIcon(1,skillIconName,isSetNative)
item:SetChildImageExGray(1,not isActive)

local iconBgParams=skillShowParams.iconBg
if iconBgParams then
item:SetChildActive(4,true)
local iconBgImageAb=iconBgParams[1]
local iconBgImageName=iconBgParams[2]
item:SetChildCSImageSprite(4,iconBgImageAb,iconBgImageName)
local iconBgSize=skillShowParams.iconBgSize
if iconBgSize then
item:SetChildSizeDelta(4,iconBgSize[1],iconBgSize[2])
end
else
item:SetChildActive(4,false)
end
local pointParam=skillShowParams.pointParam
if pointParam then
item:SetChildActive(5,true)
local pointAbName=pointParam[1]
local pointIconName=pointParam[2]
local pointPosList=pointParam[3]

local pointGrids=item:GetChildCommonLayoutGroupWidgetList(5)
for i=1,pointGrids.Count do
local widget=pointGrids[i-1]
local pos=pointPosList[i]
if pos then
widget:SetChildActive(-1,true)
widget:SetChildCSImageSprite(-1,pointAbName,pointIconName)
widget:SetChildAnchoredPosition(-1,Vector2(pos[1],pos[2]))
else
widget:SetChildActive(-1,false)
end
end
else
item:SetChildActive(5,false)
end


local lineParams=layoutCfg.skillLineParams and layoutCfg.skillLineParams[idx]
if lineParams then
item:SetChildActive(0,true)



local lineOffset=lineParams.offset or{0,0}
item:SetChildAnchoredPosition(0,Vector2(lineOffset[1],lineOffset[2]))
local imgParam
local isFlip=lineParams.isFlip
if isActive then
imgParam=lineParams.active
else
imgParam=lineParams.img
end
local lineIconAbName=imgParam[1]
local lineIconName=imgParam[2]
item:SetChildCSImageSprite(0,lineIconAbName,lineIconName)
local scaleX=isFlip and-1 or 1
item:SetChildScale(0,Vector3.New(scaleX,1,1))
else
item:SetChildActive(0,false)
end

self:refreshTMFireEffectItem(item,idx,anim)


end

function UIDiscipleTianMingWin:refreshTMFireEffectItem(item,idx,anim)
if item==nil then
item=self.huoGrid:getChildCommonLayoutGroupWidgetItem(idx-1)
end
local floor=idx-1
local cur_floor=UIDiscipleModel.getTianMingLevelFloor(self.tmlv)
local isActive=floor<=cur_floor

item:SetChildShowEffect(2,0,false)
item:SetChildShowEffect(3,0,false)
local layoutCfg=self.layoutCfg
local effectParams=layoutCfg.skillEffectParams and layoutCfg.skillEffectParams[idx]
if effectParams then








local effectOffset
local effectId
local isFlip
if isActive then
effectOffset=effectParams.activeOffset
effectId=effectParams.active
isFlip=not effectParams.isFlip
else
effectOffset=effectParams.offset
effectId=effectParams.effect
isFlip=effectParams.isFlip or false
end
if not self.isTweener then
item:SetChildShowEffect(2,effectId,true)
end
local scaleX=isFlip and-1 or 1
item:SetChildScale(2,Vector3.New(scaleX,1,1))
item:SetChildAnchoredPosition(2,Vector2(effectOffset[1],effectOffset[2]))

if anim==true then
local effect2Id=effectParams.effect2
if isActive and effect2Id then

item:SetChildShowEffect(3,effect2Id,true)
end
end
end

end
function UIDiscipleTianMingWin:refreshAllEffect()
local grids=self.huoGrid:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
self:refreshTMFireEffectItem(item,i)
end
self.winlua:SetChildShowEffect(self.effDY:getID(),0,false)
self.winlua:SetChildShowEffect(self.effDYDi:getID(),0,false)
if self.isOpenDaoYan then
if not self.isTweener and self.dylv>0 then
local cur_chong=UIDiscipleModel.getDaoYanLevelFloor(self.dylv)
local effId,effId2=UIDiscipleModel:getDiscipleDaoYanDZJYEffectId(cur_chong)
self.winlua:SetChildShowEffect(self.effDY:getID(),effId,true)
self.winlua:SetChildShowEffect(self.effDYDi:getID(),effId2,true)
end

local dyGrids=self.daoyanHuoGrid:getChildCommonLayoutGroupWidgetList()
for i=1,dyGrids.Count do
local item=dyGrids[i-1]
self:refreshDYFireEffectItem(item,i)
end
end
end

function UIDiscipleTianMingWin:refreshDaoYanBtn(flag)
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local isShow=UIDiscipleModel:checkShowDaoYan(netData)
self.daoyanBtn:setActive(isShow)

self.winlua:SetChildShowEffect(self.daoyanbtnEffect:getID(),0,false)
if isShow then
local isOpen=UIDiscipleModel:checkOpenDaoYan(netData)
local canShowUnlockDaoYan=UIDiscipleModel:getIsCanShowUnlockDaoYanTips(self.disciple_guid)
local isShowBtn=isOpen and(not canShowUnlockDaoYan or flag)
self.daoyanLock:setActive(not isShowBtn)
self.daoyanbtnIcon:setActive(isShowBtn)

if isShowBtn then
self.winlua:SetChildShowEffect(self.daoyanbtnEffect:getID(),20688,true)
end


local isReddot=UIDiscipleModel:getDiscipleFirstOpenDaoYanWinReddot(self.disciple_guid)or UIDiscipleModel:getDiscipleDaoYanUpLevelReddot(self.disciple_guid)
self.daoyanReddot:setActive(isReddot)
end
end



function UIDiscipleTianMingWin:refreshDaoYanPanel()
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)


local dylv=self.dylv
local lv_str=UIDiscipleModel.getDaoYanLevelDesc(dylv,1)
self.daoyanLvText:setText(lv_str)

local cur_chong=UIDiscipleModel.getDaoYanLevelFloor(dylv)
local animationIds={eAnimationID.enter,eAnimationID.enter2,eAnimationID.enter3}
self.winlua:SetChildUIModelEnableInitUISpineParaEx(self.mDY:getID(),false,true,false)
self.mDY:setChildUIModelShowTarget(_bgModelIds[cur_chong],0.62,nil,animationIds[cur_chong],false,false,0)

self.winlua:SetChildShowEffect(self.effDY:getID(),0,false)
self.winlua:SetChildShowEffect(self.effDYDi:getID(),0,false)
if dylv>0 then
local effId,effId2=UIDiscipleModel:getDiscipleDaoYanDZJYEffectId(cur_chong)
self.winlua:SetChildShowEffect(self.effDY:getID(),effId,true)
self.winlua:SetChildShowEffect(self.effDYDi:getID(),effId2,true)
end


local isReddot=UIDiscipleModel:getDiscipleFirstOpenDaoYanWinReddot(self.disciple_guid)or UIDiscipleModel:getDiscipleDaoYanUpLevelReddot(self.disciple_guid)
self.rongdaoReddot:setActive(isReddot)
end

function UIDiscipleTianMingWin:refreshAllDYFire()
if self.isInitAllDYFire then return end
self.isInitAllDYFire=true
local grids=self.daoyanHuoGrid:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
self:refreshDYFireItem(item,i)

item:SetChildButtonClick(1,function()
self:onDYFireItemClick(i)
end)
end
end


function UIDiscipleTianMingWin:refreshDYFireItem(item,idx)
if item==nil then
item=self.daoyanHuoGrid:getChildCommonLayoutGroupWidgetItem(idx-1)
end

local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local skill=UIDiscipleModel:getDaoYanSkillByGuid(self.disciple_guid,idx)
local skillId=skill[1]
local limit=skill[2]
local isActive=self.dylv>=limit

local skillCfg=cfg_skillconfig_get(skillId)
local skillIconName=iconHelper.getSkillIcon(skillCfg.icon)
item:SetChildCSImageIcon(1,skillIconName)
item:SetChildImageExGray(1,not isActive)
item:SetChildActive(3,not isActive)

self:refreshDYFireEffectItem(item,idx)
end

function UIDiscipleTianMingWin:refreshDYFireEffectItem(item,idx)
if item==nil then
item=self.daoyanHuoGrid:getChildCommonLayoutGroupWidgetItem(idx-1)
end
local skill=UIDiscipleModel:getDaoYanSkillByGuid(self.disciple_guid,idx)
local skillId=skill[1]
local limit=skill[2]
local isActive=self.dylv>=limit
local effId=UIDiscipleModel:getDiscipleDaoYanSkillBgEffectId(idx)
item:SetChildShowEffect(2,0,false)
if not self.isTweener then
item:SetChildShowEffect(2,effId,isActive)
end


local jie=UIDiscipleModel.getDaoYanLevelJie(self.dylv,idx)
local showjie=jie>0
item:SetChildActive(0,showjie)
if showjie then
local jieEffId=UIDiscipleModel:getDiscipleDaoYanjieEffectId(idx)
local grids=item:GetChildCommonLayoutGroupWidgetList(0)
for i=1,3 do
local item_jie=grids[i-1]
local isGray=jie<i
item_jie:SetChildShowEffect(0,0,false)
if not self.isTweener then
item_jie:SetChildShowEffect(0,jieEffId,not isGray)
end
item_jie:SetChildActive(1,isGray)
end
end
end


function UIDiscipleTianMingWin:refreshCiFuInfo()
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local allCiFuIDList=UIDiscipleModel:getTianMingCiFuIDEx(netData)
local grids=self.cifuGrid:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local item=grids[i-1]
local cifuID=allCiFuIDList[i]
local isActive,limit_tmlv=UIDiscipleModel.checkTiamMingCiFuPosOpenX(self.tmlv,i)
local has=cifuID~=nil and cifuID~=0

item:SetChildActive(0,isActive)

if isActive then
item:SetChildActive(1,has)
item:SetChildActive(4,not has)
if has then
local cifucfg=cfgHelper.get1(cfg_discipletmcfconfig_get,cifuID)

item:SetChildCSImageIcon(2,iconHelper.getSkillIcon(cifucfg.icon))

item:SetChildText(3,cifucfg.name)
end
else



end

item:SetChildButtonClick(-1,function()
self:onCiFuItemClick(i)
end)
end
end

function UIDiscipleTianMingWin:onTMFireItemClick(idx)
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local tmIndex=idx
local tmID=UIDiscipleModel:getTianMingByIndexEx(netData,tmIndex)

self:showWindow("UIDiscipleTianMingSkillTipsWin",{tmId=tmID,tmLv=netData.tmlv,tmIndex=idx,guid=self.disciple_guid,isNotShowButton=true})
end

function UIDiscipleTianMingWin:onDYFireItemClick(idx)
local skill=UIDiscipleModel:getDaoYanSkillByGuid(self.disciple_guid,idx)
local skillId=skill[1]
local limit=skill[2]
self:showWindow("UIDiscipleDaoYanSkillTipsWin",{skillId=skillId,isActive=self.dylv>=limit,limit=limit,guid=self.disciple_guid,isNotShowButton=true})
end

function UIDiscipleTianMingWin:onCiFuItemClick(idx)
local isActive,limit_tmlv=UIDiscipleModel.checkTiamMingCiFuPosOpenX(self.tmlv,idx,true)
if not isActive then
return
end

UIManager:showWindow('UIDIscipleTianMingCiFuWin',{dis_guid=self.disciple_guid,groupIdx=idx})
end

function UIDiscipleTianMingWin:onMoneyObj()
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local cost=UIDiscipleModel:getUpTianMingCost(netData)
local moneyType=cost[2][1]
itemsComponentHelper.onItemClickEx(moneyType)
end

function UIDiscipleTianMingWin:onSubmitButton()
if not _this.isgetbtn then
local isLDLock=UIDiscipleModel:checkDZClientState(self.disciple_guid,DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock)
if isLDLock then
UIManager.error(UIDiscipleModel:checkDZClientStateDesc(DISCIPLE_CLIENT_STATE_TYPE.eLunDaoDaHuiLock))
return
end

local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local cost=UIDiscipleModel:getUpTianMingCost(netData)
local isSPdz=UIDiscipleModel:isSPDiscipleEx(self.disciple_guid)

local itemid=cost[1][1]
local itemNum=cost[1][2]
local has_itemNum=bagModel.getItemCountById(itemid)
local use_spe_itemNum=0
local has_glitemNum=0
local dzID=UIDiscipleModel:getDiscipleIDEx(netData)

local glitemid=liandonModel:CheckDiZiItem_Guanlian(dzID)
if glitemid then
has_glitemNum=bagModel.getItemCountById(glitemid)
has_itemNum=has_itemNum+has_glitemNum
end

if not isSPdz then
local spe_itemid=UIDiscipleModel:getUpTianMingCost2()
local spe_itemNum=0
if has_itemNum<itemNum and itemid~=spe_itemid then
spe_itemNum=bagModel.getItemCountById(spe_itemid)
use_spe_itemNum=math.min(spe_itemNum,itemNum-has_itemNum)
end
end
local num=has_itemNum+use_spe_itemNum



if num<itemNum then
UIManager.error('道具不足')
gainControl:showGainWin(itemid)
return
end

local moneyType=cost[2][1]

local moneyNum=cost[2][2]
self.checkType=moneyType
local callback=function()
if _this==nil then return end
_this:useTimeItem(itemid,use_spe_itemNum)
end

if has_glitemNum>moneyNum then
has_glitemNum=moneyNum
end
local gllist={}
if glitemid and itemid and has_glitemNum>0 then
gllist[#gllist+1]={liandongZY.dizi,glitemid,itemid,has_glitemNum}
end

if#gllist>0 then
liandonController:send_254_96(#gllist,gllist)
end

local flag=moneySystem:useMoney(moneyType,moneyNum,callback,WARNING_TYPE.eWarning)
if not flag then
return
end
_this.isgetbtn=true
end

if not _this.isgetbtnTimer and _this.isgetbtn==true then
_this.isgetbtnTimer=_this:delayDo(1.1,function()
if _this==nil then return end
_this.isgetbtnTimer=nil
_this.isgetbtn=false
end)
end
end

function UIDiscipleTianMingWin:useTimeItem(itemid,use_spenum)
local guid=self.disciple_guid


local func=function()
UIDiscipleController:reqTianMingLevelup(guid,use_spenum)
end
if use_spenum>0 then
local spe_itemid=UIDiscipleModel:getUpTianMingCost2()
local itemname=itemsConfig.getItemName(spe_itemid)
local itemname2=itemsConfig.getItemName(itemid)
local name=UIDiscipleModel:getDiscipleName(guid)
local desc_str=FMT.fmt('弟子<color=#ca631d>{0}</color>的灵魄不足，是否消耗{1}个{2}转换为{3}？',name,use_spenum,itemname,itemname2)
local args={
desc=desc_str,
itemid=spe_itemid,
itemnum=use_spenum,
itemid2=itemid,
itemnum2=use_spenum,
showCancel=true,
cancelCB=nil,
commitCB=function()
if _this==nil then return end
func()
end,
}
UIManager:showWindow('UICommonUseItem_goodChangeWin',args)
else
func()
end
end


function UIDiscipleTianMingWin:onTMReset()
UIManager:showWindow("UITianMingResetWin",{discipleGuid=self.disciple_guid})
end


function UIDiscipleTianMingWin:isShowTmResetBtn()
local flag=UIDiscipleModel:isSpecialDZEx(self.disciple_guid,discipleconfigFlag.forbidChongSuiTianMing)
self.TMReset:setActive(not flag)
end


function UIDiscipleTianMingWin:onDaoyanBtn()
if self.tabSelect==dzTianMingTabType.eDaoYan or self.isTweener then
return
end
local netData=UIDiscipleModel:getDiscipleData(self.disciple_guid)
local isOpen,tips=UIDiscipleModel:checkOpenDaoYan(netData)
if not isOpen then
self:onRongdaoButton()

return
end
self.tabSelect=dzTianMingTabType.eDaoYan
self:refreshInfo(nil,true)

if self.isFirstDY then
self.isFirstDY=false
UIDiscipleModel:saveFirstEnterDaoYan()
end
end


function UIDiscipleTianMingWin:onTianmingBtn()
if self.tabSelect==dzTianMingTabType.eTianMing or self.isTweener then
return
end
self.tabSelect=dzTianMingTabType.eTianMing
self:refreshInfo(nil,true)
end


function UIDiscipleTianMingWin:onRongdaoButton()
UIManager:showWindow("UIDiscipleDaoYanWin",{discipleGuid=self.disciple_guid})
end

function UIDiscipleTianMingWin:refreshPageWin()
local dis_guid=self.disciple_guid
self:onShow({guid=dis_guid})
end
