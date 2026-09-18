







def_class("UIMainXMInfoWin",UIWindowBase)









function UIMainXMInfoWin:bindComponents()

self.root=UIObject.get(self,0)
self.signBGIcon=UIImage.get(self,1)
self.level=UIText.get(self,2)
self.gxnum=UIText.get(self,3)
self.pnum=UIText.get(self,4)
self.name=UIText.get(self,5)
self.gxicon=UIObject.get(self,6)
self.signIcon=UIImage.get(self,7)
self.signKuangIcon=UIImage.get(self,8)
self.btnInfo=UIObject.get(self,9)



end


function UIMainXMInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.signBGIcon);self.signBGIcon=nil;
_UIObject_release(self.level);self.level=nil;
_UIObject_release(self.gxnum);self.gxnum=nil;
_UIObject_release(self.pnum);self.pnum=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.gxicon);self.gxicon=nil;
_UIObject_release(self.signIcon);self.signIcon=nil;
_UIObject_release(self.signKuangIcon);self.signKuangIcon=nil;
_UIObject_release(self.btnInfo);self.btnInfo=nil;
end


















function UIMainXMInfoWin:onLoaded(...)
self:bindComponents()
self:addNotify(notifyConfig.on_money_changed,function(moneytype)
if moneytype==eMoneyType.mtGongXuan then
self.gxnum:setText(moneyModel.getMoney(eMoneyType.mtGongXuan))
end
end)
self.leftSimple=simpleModeControl:getLeftXMSimple()
self:initActorInfo()
end

function UIMainXMInfoWin:__delete()
self:unbindComponents()
end

function UIMainXMInfoWin:onShow(argtable,afterOnloaded)

FeiShengTaiController:SendXMHelp_feisheng()

local info=xianmengModel:getXMDetialData()
local maxNum=xianmengModel.getXMMaxMemberNum(info.guildlevel)
local abname=globalABLookup.xianmengicons
local image=xianmengModel:getGuildImage()
self.name:setText(info.guildname)
self.level:setText(FMT.fmt('{0}级',info.guildlevel))
self.gxicon:setIcon(iconHelper.getIconName(eMoneyType.mtGongXuan),false)
self.gxnum:setText(moneyModel.getMoney(eMoneyType.mtGongXuan))
self.pnum:setText(FMT.fmt('{0}/{1}',info.membernum,maxNum))
self:freshXMSign()
end

function UIMainXMInfoWin:onHide()

end



function UIMainXMInfoWin:onClickBg()
local data=zongmenModel:findBuildingDataByID(mapIdType.xianmeng,SLG_SYSTEM_TYPE.eXianMengDaDian)
if data then
isometricMapSystem:openBuildingWin(data)
end
end

function UIMainXMInfoWin:onClickGX()
gainControl:showGainWin(eMoneyType.mtGongXuan)
end

function UIMainXMInfoWin:freshXMSign()
local image=xianmengModel:getGuildImage()
local abname=globalABLookup.xianmengicons

self.signIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

self.signBGIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

self.signKuangIcon:setSprite(abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))
end


function UIMainXMInfoWin:initActorInfo()
local infoWidget=self.btnInfo:getWidgetBase()

local zmKuFangWidget=infoWidget:GetChildWidgetBase(0)
zmKuFangWidget:SetChildActive(0,self.leftSimple==leftXMSimpleState.kufang)
infoWidget:SetChildButtonClick(0,function()
zmKuFangWidget:SetChildActive(0,true)
self:onZongMenKuFangClick()
end,true)


local zmInfoWidget=infoWidget:GetChildWidgetBase(1)
zmInfoWidget:SetChildActive(0,self.leftSimple==leftXMSimpleState.info)
infoWidget:SetChildButtonClick(1,function()
zmInfoWidget:SetChildActive(0,true)
self:onZongMenInfoClick()
end,true)
local isshow=UIFullXianMengXianWuLouControl:check_showWindowKuFang()
self.btnInfo:setActive(isshow)
end


function UIMainXMInfoWin:onZongMenKuFangClick()
self:changeLeftXMSimple(leftXMSimpleState.kufang)
end


function UIMainXMInfoWin:onZongMenInfoClick()
self:changeLeftXMSimple(leftXMSimpleState.info)
end


function UIMainXMInfoWin:changeLeftXMSimple(state)
if self.leftSimple==state then

self.leftSimple=leftXMSimpleState.hide
else

self.leftSimple=state
end
simpleModeControl:setLeftXMSimple(self.leftSimple)
UIManager:invokeUIMethod('UIMainXMTaskWin','changeRoot')
self:leftPanel_checkKuFangSimple()
self:leftPanel_checkInfoSimple()
end


function UIMainXMInfoWin:leftPanel_checkKuFangSimple()
self.leftSimple=simpleModeControl:getLeftXMSimple()
local infoWidget=self.btnInfo:getWidgetBase()
local zmKuFangWidget=infoWidget:GetChildWidgetBase(0)
zmKuFangWidget:SetChildActive(0,self.leftSimple==leftXMSimpleState.kufang)
end


function UIMainXMInfoWin:leftPanel_checkInfoSimple()
self.leftSimple=simpleModeControl:getLeftXMSimple()
local infoWidget=self.btnInfo:getWidgetBase()
local zmInfoWidget=infoWidget:GetChildWidgetBase(1)
zmInfoWidget:SetChildActive(0,self.leftSimple==leftXMSimpleState.info)
local reddot
if self.leftSimple==leftXMSimpleState.info then
reddot=false
else
reddot=UIManager:invokeUIMethod('UIMainXMTaskWin','freshGXReddot')or false
end
zmInfoWidget:SetChildActive(1,reddot)
end


function UIMainXMInfoWin:freshSimpleBtn()
local isSimple=simpleModeControl:getLeftSimple()==leftSimpleState.hide
if isSimple then
simpleModeControl:setLeftXMSimple(leftXMSimpleState.hide)
else
simpleModeControl:setLeftXMSimple(leftXMSimpleState.info)
end
self:leftPanel_checkKuFangSimple()
self:leftPanel_checkInfoSimple()
end