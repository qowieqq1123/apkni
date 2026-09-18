







def_class("UISystemZongMenTaYinWin",UIWindowBase)









function UISystemZongMenTaYinWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.dzModel=UIObject.get(self,1)
self.helpBtn=UIButton.get(self,2)
self.jjTx=UIText.get(self,3)
self.chTx=UIText.get(self,4)
self.ready=UIObject.get(self,5)
self.working=UIObject.get(self,6)
self.rate=UIText.get(self,7)
self.tyBtn=UIButton.get(self,8)
self.least=UIText.get(self,9)
self.workProgress=UIProgressBarAni.get(self,10)
self.costIcon=UIImage.get(self,11)
self.costTx=UIText.get(self,12)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.tyBtn:setButtonClick(function()self:onTyBtn()end)



end


function UISystemZongMenTaYinWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.dzModel);self.dzModel=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.jjTx);self.jjTx=nil;
_UIObject_release(self.chTx);self.chTx=nil;
_UIObject_release(self.ready);self.ready=nil;
_UIObject_release(self.working);self.working=nil;
_UIObject_release(self.rate);self.rate=nil;
_UIObject_release(self.tyBtn);self.tyBtn=nil;
_UIObject_release(self.least);self.least=nil;
_UIObject_release(self.workProgress);self.workProgress=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costTx);self.costTx=nil;
end
















local _this=nil




function UISystemZongMenTaYinWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onSystemZMDetailInfo,self.onSystemZMDetailInfo)
notifySystem:listenNotify(notifyConfig.onSystemZMDiscipleChange,self.onSystemZMDiscipleChange)
self.workProgress:setFinishAction(function(...)self:onProgressBarFinishAction(...)end)
end


function UISystemZongMenTaYinWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.onSystemZMDetailInfo,self.onSystemZMDetailInfo)
notifySystem:removelistener(notifyConfig.onSystemZMDiscipleChange,self.onSystemZMDiscipleChange)
end




function UISystemZongMenTaYinWin:onShow(argtable,afterOnloaded)
self.serial=argtable.serial
self.infoData=systemZongMenModel:getInfoData(self.serial)
self.maxNum=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"tayin","day_num")
self.costIcon:setIcon(moneyModel.getIconNameEx(eMoneyType.mtLingShi),false)
self:setDisciple()
self.detailData=systemZongMenModel:getDetailPartInfo(self.serial,systemZongMenDetailDataPart.eCangJingGe)
if self.detailData then
self:setViewReady()
else
self.ready:setActive(false)
self.working:setActive(false)
end
end


function UISystemZongMenTaYinWin:onHide()

end




function UISystemZongMenTaYinWin:onCloseBtn()
self:closeSelf()
end


function UISystemZongMenTaYinWin:onHelpBtn()
local d={}
d.mode=3
d.title="规则介绍"
d.name='systemZongMen_tayin_%d'
UIManager:showWindow('UIRuleWin',d)
end


function UISystemZongMenTaYinWin:onTyBtn()
if moneyModel.checkEnoughMoney(eMoneyType.mtLingShi,self.cost)then
if self.detailData.ty_num<self.maxNum then
self:setViewStart()
else
UIManager.error("剩余次数不足")
end
else
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(eMoneyType.mtLingShi)))
end
end

function UISystemZongMenTaYinWin:setDisciple()
local discipleData=UIDiscipleModel:getDiscipleData(self.infoData.disciple_guid)
local nameStr=discipleData.disciplename

local jjStr=FMT.fmt("<color=#D3B97A>境界：</color>{0}",UIDiscipleModel:getJJNameEx(discipleData.jingjielv))
self.jjTx:setText(jjStr)
local mlStr=FMT.fmt("<color=#D3B97A>聪慧：</color>{0}",discipleData.attrList[DISCIPLE_BASE_ATTR_TYPE.eCongHui])
self.chTx:setText(mlStr)

local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(discipleData)
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo,1)
local modelCmp=self.dzModel:getID()
self.winlua:SetChildUIModelShowTarget(modelCmp,modelParams.body,modelParams.scale,modelParams.componets,eAnimationID.stand,false,false,0)
self.winlua:SetChildUIModelShowFlipX(modelCmp,true)
end

function UISystemZongMenTaYinWin:setViewReady()
self.page=1
self.ready:setActive(true)
self.working:setActive(false)
self.jjTx:setActive(true)
self.chTx:setActive(true)
self.helpBtn:setActive(true)
self.closeBtn:setActive(true)
self:setRate()
self:setLeast()

self.cost=systemZongMenModel:calculateTaYinCost(self.infoData.level)
self.costTx:setText(self.cost)

local modelCmp=self.dzModel:getID()
self.winlua:SetChildAnchoredPos(modelCmp,90,102)
self.winlua:SetChildModelAnimationState(self.dzModel:getID(),eAnimationID.stand)
end

function UISystemZongMenTaYinWin:setViewStart()
self.page=2
self.ready:setActive(false)
self.working:setActive(true)
self.jjTx:setActive(false)
self.chTx:setActive(false)
self.helpBtn:setActive(false)
self.closeBtn:setActive(false)
self.workProgress:animateThreeParams(0,1,0)
self.workProgress:animateThreeParams(3,3,3)

local modelCmp=self.dzModel:getID()
self.winlua:SetChildDOTweenAnimation_DOPlay(modelCmp,nil,0,3)
self.winlua:SetChildModelAnimationState(modelCmp,eAnimationID.run)
end

function UISystemZongMenTaYinWin:setLeast()
self.least:setText(FMT.fmt('剩余次数：{0}',self.maxNum-self.detailData.ty_num))
end

function UISystemZongMenTaYinWin:setRate()
local source=UIDiscipleModel:getDiscipleData(self.infoData.disciple_guid)
local rateVal=systemZongMenModel:calculateTaYinRate(self.infoData.id,source)
self.rate:setText(FMT.fmt('成功率：<color=#549327>{0}%</color>',math.floor(rateVal*10000)/100))
end

function UISystemZongMenTaYinWin:onProgressBarFinishAction(value,value1)


self.page=3
local modelCmp=self.dzModel:getID()
self.winlua:SetChildModelAnimationState(modelCmp,eAnimationID.stand)
if moneyModel.checkEnoughMoney(eMoneyType.mtLingShi,self.cost)then
if self.detailData.ty_num<self.maxNum then
systemZongMenController:req_rubbing(self.serial)
else
UIManager.error("剩余次数不足")
self:setViewReady()
end
else
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(eMoneyType.mtLingShi)))
self:setViewReady()
end
end

function UISystemZongMenTaYinWin.onSystemZMDetailInfo(partType,serial)
if _this.serial==serial and partType==systemZongMenDetailDataPart.eCangJingGe then
if _this.detailData then
_this.detailData=systemZongMenModel:getDetailPartInfo(serial,partType)
if _this.page==1 then
_this:setRate()
_this:setLeast()


end
end
end
end

function UISystemZongMenTaYinWin.onSystemZMDiscipleChange(serial,discipleGuid,oldGuid)
if _this.serial==serial then
if discipleGuid>int64.zero then
_this:setDisciple()
if _this.page==1 then
_this:setRate()
end
else
_this:closeSelf()
end
end
end





