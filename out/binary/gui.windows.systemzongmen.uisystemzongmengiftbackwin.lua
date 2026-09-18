







def_class("UISystemZongMenGiftBackWin",UIWindowBase)









function UISystemZongMenGiftBackWin:bindComponents()

self.back=UIButton.get(self,0)
self.modelObj=UIObject.get(self,1)
self.modelImage=UIObject.get(self,2)
self.talkDesc=UIText.get(self,3)
self.infoBg=UIObject.get(self,4)
self.posTx=UIText.get(self,5)
self.jjTx=UIText.get(self,6)
self.nameTx=UIText.get(self,7)

self.back:setButtonClick(function()self:onBack()end)



end


function UISystemZongMenGiftBackWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.modelObj);self.modelObj=nil;
_UIObject_release(self.modelImage);self.modelImage=nil;
_UIObject_release(self.talkDesc);self.talkDesc=nil;
_UIObject_release(self.infoBg);self.infoBg=nil;
_UIObject_release(self.posTx);self.posTx=nil;
_UIObject_release(self.jjTx);self.jjTx=nil;
_UIObject_release(self.nameTx);self.nameTx=nil;
end
















local _this=nil




function UISystemZongMenGiftBackWin:onLoaded(...)
self:bindComponents()
_this=self
notifySystem:listenNotify(notifyConfig.onSystemZMDetailInfo,self.onSystemZMDetailInfo)
end


function UISystemZongMenGiftBackWin:__delete()
self:unbindComponents()
_this=nil
notifySystem:removelistener(notifyConfig.onSystemZMDetailInfo,self.onSystemZMDetailInfo)
end




function UISystemZongMenGiftBackWin:onShow(argtable,afterOnloaded)
self.serial=argtable.serial
self.delta=argtable.delta
self.gxNum=argtable.gxNum
self.rewards=argtable.rewards
self.infoData=systemZongMenModel:getInfoData(self.serial)
self.detailInfo=systemZongMenModel:getDetailPartInfo(self.serial,systemZongMenDetailDataPart.eBase)

if self.infoData then
if self.detailInfo then
self:refreshModel()
else
systemZongMenController:req_detailInfo(systemZongMenDetailDataPart.eBase,self.serial)
end
self:refreshContent()
else
self:closeSelf()
end
end


function UISystemZongMenGiftBackWin:onHide()

end




function UISystemZongMenGiftBackWin:onBack()

if not self.handle then
if self.rewards and#self.rewards>0 then
self.handle=true
self:refreshContent()
else
self:closeSelf()
end
else
if self.rewards and#self.rewards>0 then
local list={}
for i,v in ipairs(self.rewards)do
table.insert(list,{itemid=v.param_1,num=v.param_2})
end
local delta=self.delta
showPrizeControl.showWindow(list,function()
if delta>0 then
UIManager.info(FMT.fmt("声望值 +{0}",delta))
elseif delta<0 then
UIManager.info(FMT.fmt("声望值 {0}",delta))
end
end)
else
if delta>0 then
UIManager.info(FMT.fmt("声望值 +{0}",delta))
elseif delta<0 then
UIManager.info(FMT.fmt("声望值 {0}",delta))
end
end
self:closeSelf()
end
end

function UISystemZongMenGiftBackWin:refreshModel()
local elderImage=UIDiscipleModel.calculationDiscipleImage(self.detailInfo.leader_data,self.detailInfo.leader_image)
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(elderImage)
local config=cfgHelper.get1(cfg_syszongmensongliconfig_get,self.infoData.id)
comHelper.setChildInSideModelEx(self.modelImage,modelParams,1,nil,0,0,false,true)
self.jjTx:setText(FMT.fmt("境界：{0}",UIDiscipleModel:getJJNameEx(self.detailInfo.leader_jingjie)))
self.nameTx:setText(self.detailInfo.leader_name)
self.modelImage:setChildUIModelShowFlipX(config.flipX or false)
local temp=config.side and 1 or-1
self.modelObj:setChildAnchoredPos(398*temp,84)
self.infoBg:setChildAnchoredPos(229*temp,157)
end

function UISystemZongMenGiftBackWin:refreshContent()
local cfg=cfgHelper.get1(cfg_syszongmensongliconfig_get,self.infoData.id)
local str=cfg.dialog3
if not self.handle then
str=nil
for i=#cfg.dialog2,1,-1 do
local info=cfg.dialog2[i]
if self.delta>info[1]then
str=info[2]
break
end
end
if not str then
str=cfg.dialog2[1][2]
end
if self.delta~=0 or self.gxNum~=0 then
local deltaStr=self.delta>0 and"声望值+{0}"or"<color=#da0000>声望值{0}</color>"
deltaStr=self.delta~=0 and FMT.fmt(deltaStr,self.delta)or""
local gxStr=self.gxNum>0 and"贡献值+{0}"or"<color=#da0000>贡献值{0}</color>"
gxStr=self.gxNum~=0 and FMT.fmt(gxStr,self.gxNum)or""
local addStr=(self.delta~=0 and self.gxNum~=0)and"<color=#0cad00>（{0}，{1}）</color>"or"<color=#0cad00>（{0}{1}）</color>"
addStr=FMT.fmt(addStr,deltaStr,gxStr)
str=FMT.fmt("{0}{1}",str,addStr)
end
end
self.talkDesc:setText(str)
end

function UISystemZongMenGiftBackWin.onSystemZMDetailInfo(partType,serial)
if _this.infoData and _this.serial==serial and partType==systemZongMenDetailDataPart.eBase then
_this:refreshModel()
end
end