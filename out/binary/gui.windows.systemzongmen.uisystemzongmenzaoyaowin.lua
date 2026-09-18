







def_class("UISystemZongMenZaoYaoWin",UIWindowBase)









function UISystemZongMenZaoYaoWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.helpBtn=UIButton.get(self,1)
self.sourceRoot=UIObject.get(self,2)
self.wait=UIObject.get(self,3)
self.targetRoot=UIObject.get(self,4)
self.ready=UIObject.get(self,5)
self.working=UIObject.get(self,6)
self.selectBtn=UIButton.get(self,7)
self.targetSwitchBtn=UIButton.get(self,8)
self.zyBtn=UIButton.get(self,9)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.helpBtn:setButtonClick(function()self:onHelpBtn()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)

self.targetSwitchBtn:setButtonClick(function()self:onTargetSwitchBtn()end)

self.zyBtn:setButtonClick(function()self:onZyBtn()end)



end


function UISystemZongMenZaoYaoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.helpBtn);self.helpBtn=nil;
_UIObject_release(self.sourceRoot);self.sourceRoot=nil;
_UIObject_release(self.wait);self.wait=nil;
_UIObject_release(self.targetRoot);self.targetRoot=nil;
_UIObject_release(self.ready);self.ready=nil;
_UIObject_release(self.working);self.working=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
_UIObject_release(self.targetSwitchBtn);self.targetSwitchBtn=nil;
_UIObject_release(self.zyBtn);self.zyBtn=nil;
end
















local _this=nil
local _dzCmp={
name=0,
jj=1,
ml=2,
model=3,
}
local _readyCmp={
rate=0,
least=1,
costIcon=2,
costTx=3,
}
local _workingCmp={
workProgress=0,
wordBg=1,
wordTx=2,
}



function UISystemZongMenZaoYaoWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onSystemZMDetailInfo,self.onSystemZMDetailInfo)
notifySystem:listenNotify(notifyConfig.onSystemZMDiscipleChange,self.onSystemZMDiscipleChange)
notifySystem:listenNotify(notifyConfig.onSystemZMFunctionNumChange,self.onSystemZMFunctionNumChange)

self.targetWidget=self.targetRoot:getWidgetBase()
self.sourceWidget=self.sourceRoot:getWidgetBase()
self.readyWidget=self.ready:getWidgetBase()
self.workingWidget=self.working:getWidgetBase()

self.workingWidget:SetProgressBarAniFinishAction(_workingCmp.workProgress,function()self:onProgressBarFinishAction()end)
self.readyWidget:SetChildIcon(_readyCmp.costIcon,moneyModel.getIconNameEx(eMoneyType.mtLingShi),false)
end


function UISystemZongMenZaoYaoWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.onSystemZMDetailInfo,self.onSystemZMDetailInfo)
notifySystem:removelistener(notifyConfig.onSystemZMDiscipleChange,self.onSystemZMDiscipleChange)
end




function UISystemZongMenZaoYaoWin:onShow(argtable,afterOnloaded)
self.serial=argtable.serial
self.infoData=systemZongMenModel:getInfoData(self.serial)
self.target=nil
self.maxNum=cfgHelper.get3(cfg_syssectbaseconfig_get,1,"zaoyao","day_num")
self:setSource()
self:setView(1)

self.detailData=systemZongMenModel:getDetailPartInfo(self.serial,systemZongMenDetailDataPart.eDZList)
end


function UISystemZongMenZaoYaoWin:onHide()

end



function UISystemZongMenZaoYaoWin:onTargetSwitchBtn()
if self.page==2 then
self:onSelectBtn()
end
end

function UISystemZongMenZaoYaoWin:onHelpBtn()
local d={}
d.mode=3
d.title="造谣"
d.name='systemZongMen_zaoyao_%d'
UIManager:showWindow('UIRuleWin',d)
end


function UISystemZongMenZaoYaoWin:onCloseBtn()
self:closeSelf()
end


function UISystemZongMenZaoYaoWin:onSelectBtn()
if not systemZongMenModel:checkDetailPartInfo(self.serial,systemZongMenDetailDataPart.eDZList)then
return UIManager.error("没有系统宗门弟子数据")
end
local list={}
if self.detailData.num>0 then
for i,v in ipairs(self.detailData.discipleList)do
if v.pos~=eZongMenPostType.eZhangMen then
table.insert(list,{netData={net=v}})
end
end
end
local args={
sortList=eDiscipleSortType:getSystemZongMenList2(),
defaultSort=eDiscipleSortType.eJingJieSort,
dataList=list,
current=self.target and self.target.discipleguid or nil,
callback=function(data)
self.target=data
self:setTarget()
self:setView(2)
end,
}
UIFullSystemZongMenControl:showWindow("UISystemZongMenZaoYaoSelectWin",args)
end


function UISystemZongMenZaoYaoWin:onZyBtn()
if moneyModel.checkEnoughMoney(eMoneyType.mtLingShi,self.cost)then
local curr=systemZongMenModel:getGlobalNum(systemZongMenFuncType.eZaoYao)
if curr<self.maxNum then
self:setView(3)
else
UIManager.error("剩余次数不足")
end
else
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(eMoneyType.mtLingShi)))
end
end

function UISystemZongMenZaoYaoWin:onProgressBarFinishAction()
if moneyModel.checkEnoughMoney(eMoneyType.mtLingShi,self.cost)then
local curr=systemZongMenModel:getGlobalNum(systemZongMenFuncType.eZaoYao)
if curr<self.maxNum then
systemZongMenController:req_rumor(self.serial,self.target.discipleguid)
else
UIManager.error("剩余次数不足")
end
else
UIManager.error(FMT.fmt("{0}不足",itemsConfig.getItemName(eMoneyType.mtLingShi)))
end
self:setView(2)
end

function UISystemZongMenZaoYaoWin:setDisciple(widget,discipleData,side)
local nameStr=discipleData.disciplename
widget:SetChildText(_dzCmp.name,nameStr)
local jjStr=FMT.fmt("<color=#7D3B17>境界：</color>{0}",UIDiscipleModel:getJJNameEx(discipleData.jingjielv))
widget:SetChildText(_dzCmp.jj,jjStr)
local mlStr=FMT.fmt("<color=#7D3B17>魅力：</color>{0}",discipleData.attrList[DISCIPLE_BASE_ATTR_TYPE.eMeiLi])
widget:SetChildText(_dzCmp.ml,mlStr)

local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(discipleData)
if side then
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfoByData(imageInfo,1)
widget:SetChildUIModelShowTarget(_dzCmp.model,modelParams.body,modelParams.scale,modelParams.componets,eAnimationID.stand)
widget:SetChildUIModelShowFlipX(_dzCmp.model,true)
else
widget:SetChildUIModelRemoveTarget(_dzCmp.model)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(imageInfo)
widget:SetChildUIModelShowTarget(_dzCmp.model,modelParams.body,0.5,modelParams.componets,eAnimationID.stand,false,false)
end
end


function UISystemZongMenZaoYaoWin:setView(page)
self.page=page

self.wait:setActive(page==1)
self.targetRoot:setActive(page>=2)
self.ready:setActive(page==2)
self.working:setActive(page==3)

if page==2 then
self:setView2()
elseif page==3 then
self:setView3()
end
end

function UISystemZongMenZaoYaoWin:setView2()
self:setRate()
self:setLeast()
self:setCost()
end

function UISystemZongMenZaoYaoWin:setView3()
self.workingWidget:SetProgressBarAni(_workingCmp.workProgress,0)
self.workingWidget:SetProgressBarAniWithThreeParams(_workingCmp.workProgress,3,3,3)

local discipleData=UIDiscipleModel:getDiscipleData(self.infoData.disciple_guid)
local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(discipleData)
local words=cfgHelper.get2(cfg_disciplevocationbuildspeakconfig_get,imageInfo.job,"systemzm_zy_source")
words=words[math.random(1,#words)]
self.workingWidget:SetChildText(_workingCmp.wordTx,words)
self.workingWidget:ForceLayoutRect(_workingCmp.wordBg)
end

function UISystemZongMenZaoYaoWin:setSource()
local discipleData=UIDiscipleModel:getDiscipleData(self.infoData.disciple_guid)
self:setDisciple(self.sourceWidget,discipleData,true)
end

function UISystemZongMenZaoYaoWin:setTarget()
self:setDisciple(self.targetWidget,self.target,false)
end

function UISystemZongMenZaoYaoWin:setRate()
local source=UIDiscipleModel:getDiscipleData(self.infoData.disciple_guid)
local rateVal=systemZongMenModel:calculateZaoYaoRate(self.infoData.id,source,self.target)
self.readyWidget:SetChildText(_readyCmp.rate,FMT.fmt('成功率：{0}%',math.floor(rateVal*10000)/100))
end

function UISystemZongMenZaoYaoWin:setLeast()
local curr=systemZongMenModel:getGlobalNum(systemZongMenFuncType.eZaoYao)
self.readyWidget:SetChildText(_readyCmp.least,FMT.fmt('剩余次数：{0}',self.maxNum-curr))
end

function UISystemZongMenZaoYaoWin:setCost()
self.cost=systemZongMenModel:calculateZaoYaoCost(self.target.jingjielv)
self.readyWidget:SetChildText(_readyCmp.costTx,self.cost)
end

function UISystemZongMenZaoYaoWin.onSystemZMDetailInfo(partType,serial)
if _this.serial==serial and partType==systemZongMenDetailDataPart.eDZList then
if _this.detailData then
_this.detailData=systemZongMenModel:getDetailPartInfo(serial,partType)
if _this.page==2 then
_this:setRate()
_this:setLeast()
end
end
end
end

function UISystemZongMenZaoYaoWin.onSystemZMDiscipleChange(serial,discipleGuid,oldGuid)
if _this.serial==serial then
if discipleGuid>int64.zero then
_this:setSource()
if _this.page==2 then
_this:setRate()
end
else
_this:closeSelf()
UIManager:closeWindow("UISystemZongMenZaoYaoSelectWin")
end
end
end

function UISystemZongMenZaoYaoWin.onSystemZMFunctionNumChange(funcType,serial)
if funcType==systemZongMenFuncType.eZaoYao then
_this:setLeast()
end
end