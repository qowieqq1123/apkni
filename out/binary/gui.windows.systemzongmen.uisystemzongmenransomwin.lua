







def_class("UISystemZongMenRansomWin",UIWindowBase)









function UISystemZongMenRansomWin:bindComponents()

self.foreBtn=UIButton.get(self,0)
self.modelImage=UIObject.get(self,1)
self.posTx=UIText.get(self,2)
self.jjTx=UIText.get(self,3)
self.noBtn=UIButton.get(self,4)
self.yesBtn=UIButton.get(self,5)
self.modelObj=UIObject.get(self,6)
self.costIcon=UIImage.get(self,7)
self.costNum=UIText.get(self,8)
self.talkDesc=UIText.get(self,9)
self.infoBg=UIObject.get(self,10)
self.chooseGrid=UIObject.get(self,11)
self.nameTx=UIText.get(self,12)
self.qipaoTx=UILinkImageText.get(self,13)

self.foreBtn:setButtonClick(function()self:onForeBtn()end)

self.noBtn:setButtonClick(function()self:onNoBtn()end)

self.yesBtn:setButtonClick(function()self:onYesBtn()end)



end


function UISystemZongMenRansomWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.foreBtn);self.foreBtn=nil;
_UIObject_release(self.modelImage);self.modelImage=nil;
_UIObject_release(self.posTx);self.posTx=nil;
_UIObject_release(self.jjTx);self.jjTx=nil;
_UIObject_release(self.noBtn);self.noBtn=nil;
_UIObject_release(self.yesBtn);self.yesBtn=nil;
_UIObject_release(self.modelObj);self.modelObj=nil;
_UIObject_release(self.costIcon);self.costIcon=nil;
_UIObject_release(self.costNum);self.costNum=nil;
_UIObject_release(self.talkDesc);self.talkDesc=nil;
_UIObject_release(self.infoBg);self.infoBg=nil;
_UIObject_release(self.chooseGrid);self.chooseGrid=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
_UIObject_release(self.qipaoTx);self.qipaoTx=nil;
end
















local _this=nil
local mType=eMoneyType.mtLingShi



function UISystemZongMenRansomWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onSystemZMDetailInfo,self.onSystemZMDetailInfo)
notifySystem:listenNotify(notifyConfig.onDiscipleJJChange,self.onDiscipleJJChange)
notifySystem:listenNotify(notifyConfig.onSystemZMDiscipleChange,self.onSystemZMDiscipleChange)
notifySystem:listenNotify(notifyConfig.on_money_changed,self.onMoneyChanged)
end


function UISystemZongMenRansomWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.onSystemZMDetailInfo,self.onSystemZMDetailInfo)
notifySystem:removelistener(notifyConfig.onDiscipleJJChange,self.onDiscipleJJChange)
notifySystem:removelistener(notifyConfig.onSystemZMDiscipleChange,self.onSystemZMDiscipleChange)
notifySystem:removelistener(notifyConfig.on_money_changed,self.onMoneyChanged)
end




function UISystemZongMenRansomWin:onShow(argtable,afterOnloaded)
self.serial=argtable.serial
self.infoData=systemZongMenModel:getInfoData(self.serial)
if self.infoData then
if systemZongMenModel:checkDetailPartInfo(self.serial,systemZongMenDetailDataPart.eDZList)then
self:refreshElder()
else
systemZongMenController:req_detailInfo(systemZongMenDetailDataPart.eDZList,self.serial)
end
self.costIcon:setIcon(moneyModel.getIconNameEx(eMoneyType.mtLingShi),false)
self:refreshCost()
self:refreshDesc(1)

UIManager:closeWindow("UISystemZongMenZaoYaoWin")
UIManager:closeWindow("UISystemZongMenZaoYaoSelectWin")
else
self:closeSelf()
end
end


function UISystemZongMenRansomWin:onHide()

end




function UISystemZongMenRansomWin:onYesBtn()
if moneyModel.checkEnoughMoney(eMoneyType.mtLingShi,self.cost)then
systemZongMenController:req_ransom(self.serial)
self:refreshDesc(2)
else
UIManager.error("货币不足")
end
end


function UISystemZongMenRansomWin:onNoBtn()

self:refreshDesc(3)
end

function UISystemZongMenRansomWin:onForeBtn()
self:closeSelf()
end

function UISystemZongMenRansomWin.onSystemZMDetailInfo(partType,serial)
if _this.infoData and _this.serial==serial and partType==systemZongMenDetailDataPart.eDZList then
_this:refreshElder()
end
end

function UISystemZongMenRansomWin.onDiscipleJJChange(dzguid,oldlv,newlv)
if _this.infoData and mathHelper.compareInt64(dzguid,_this.infoData.disciple_guid)then
_this:refreshCost()
end
end

function UISystemZongMenRansomWin.onSystemZMDiscipleChange(serial,newGuid,oldGuid)
if _this.serial==serial then
if newGuid then
if UIDiscipleModel:checkDiscipleState2(newGuid,DISCIPLE_STATE_TYPE.eBeiBu)then
_this:refreshCost()
elseif _this.state==1 then
_this:closeSelf()
end
elseif _this.state==1 then
_this:closeSelf()
end
end
end

function UISystemZongMenRansomWin:refreshElder()
self.detailInfo=systemZongMenModel:getDetailPartInfo(self.serial,systemZongMenDetailDataPart.eDZList)
local temp={}
for i,v in ipairs(self.detailInfo.discipleList)do
if v.pos==eZongMenPostType.eZhenYu then
temp[1]=v
break
elseif v.pos==eZongMenPostType.eZhangMen then
temp[2]=v
end
end




local elder=temp[1]or temp[2]
local elderImage=UIDiscipleModel.calculationDiscipleImageBase(elder)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(elderImage)
comHelper.setChildInSideModelEx(self.modelImage,modelParams,0.7,nil,0,0,false,false)
self.posTx:setText(eZongMenPostType.getName(elder.pos))
self.jjTx:setText(FMT.fmt("境界：{0}",UIDiscipleModel:getJJNameEx(elder.jingjielv)))
self.nameTx:setText(elder.disciplename)

self.qipaoTx:setText(chatEmotHelper.decodeEmot("#3"))
end

function UISystemZongMenRansomWin:refreshCost()
local jjLv=UIDiscipleModel:getDiscipleJJLevel(self.infoData.disciple_guid)
local cfg=cfgHelper.get2(cfg_syssectbaseconfig_get,1,"shuhui")
self.cost=nil
for i,v in ipairs(cfg)do
if jjLv<=v[1]then
self.cost=v[2]
else
break
end
end
if not self.cost then
self.cost=cfg[#cfg][2]
end
self:refreshCostImp()
end

function UISystemZongMenRansomWin:refreshDesc(index)
self.state=index
local cfg=cfgHelper.get1(cfg_syssectconfig_get,self.infoData.id)
self.talkDesc:setText(cfg.ransomDesc[index])
self.foreBtn:setActive(index~=1)
self.chooseGrid:setActive(index==1)
end

function UISystemZongMenRansomWin:refreshCostImp()
local check=moneyModel.checkEnoughMoney(mType,self.cost)
local costStr=check and self.cost or FMT.cfmt(FONT_COLOR.eRedColor,self.cost)
self.costNum:setText(costStr)
end

function UISystemZongMenRansomWin.onMoneyChanged(moneyType,oldVal,newVal)
if moneyType==mType then
_this:refreshCostImp()
end
end