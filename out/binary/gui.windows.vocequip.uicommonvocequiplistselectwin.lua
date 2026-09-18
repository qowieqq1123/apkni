







def_class("UICommonVocEquipListSelectWin",UIWindowBase)









function UICommonVocEquipListSelectWin:bindComponents()

self.background=UIButton.get(self,0)
self.checkBtn=UIButton.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.descImg1=UIImage.get(self,3)
self.descImg2=UIImage.get(self,4)
self.jobIcon=UIImage.get(self,5)
self.love=UIObject.get(self,6)
self.model=UIObject.get(self,7)
self.scrollView=UIObject.get(self,8)
self.selectBtn=UIButton.get(self,9)

self.background:setButtonClick(function()self:onBackground()end)

self.checkBtn:setButtonClick(function()self:onCheckBtn()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)

self.selectBtn:setButtonClick(function()self:onSelectBtn()end)



end


function UICommonVocEquipListSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.checkBtn);self.checkBtn=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.descImg1);self.descImg1=nil;
_UIObject_release(self.descImg2);self.descImg2=nil;
_UIObject_release(self.jobIcon);self.jobIcon=nil;
_UIObject_release(self.love);self.love=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.selectBtn);self.selectBtn=nil;
end















local _this=nil
local _itemCmp={
root=-1,
item=0,
job=2,
love=1,
getted=3,
select=4,
button=5,
lock=6,
lockTx=7,
}
local _abName="ui/windows/vocequip/vocequipselect_atlas_pak.ab"



function UICommonVocEquipListSelectWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onNewDay,self.onNewDay)
end


function UICommonVocEquipListSelectWin:__delete()
self:unbindComponents()
_this=nil
end




function UICommonVocEquipListSelectWin:onShow(argtable,afterOnloaded)
self.configs=argtable.configs
self.current=argtable.current
self.callback=argtable.callback

if self.current and self.current<=0 then
self.current=nil
end
self.select=self.current or 1

self:refreshList()
self:refreshPanel()
end


function UICommonVocEquipListSelectWin:onHide()

end




function UICommonVocEquipListSelectWin:onCheckBtn()
local itemId=self.configs[self.select][1]
tipsManager.showTips({itemid=itemId})
end


function UICommonVocEquipListSelectWin:onCloseBtn()
self:closeSelf()
end

function UICommonVocEquipListSelectWin:onBackground()
self:onCloseBtn()
end


function UICommonVocEquipListSelectWin:onSelectBtn()
if self.select~=self.current then
self.callback(self.select)
else
UIManager.info("已选择该项")
end
end

function UICommonVocEquipListSelectWin:refreshList()
self.scrollView:setChildScrollViewCreateGrids(#self.configs,1)
local grids=self.scrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local item=grids[i-1]
self:refreshItem(item,i)
end
end

function UICommonVocEquipListSelectWin:refreshItem(widget,index)
local data=self.configs[index]
local itemId=data[1]
local day=data[2]
local itemCfg=itemsConfig.getConfig(itemId)
local count=vocEquipModel:getEquipsCountByItemid(itemId)+itemsModel.getCount(itemId)
local openDay=timeHelper.getServerOpenDay()
local delay=day and openDay-day or 0
local vocCfg=cfgHelper.get1(cfg_disciplevocationconfig_get,itemCfg.type1)
local dataConf={itemid=itemId,itemcount="",showCountBG=false,showname=true,showStage=false}
local dataProp=itemsComponentHelper.getCommonFillDataSmall(dataConf)
widget:SetChildPropData(_itemCmp.item,dataProp)
widget:SetChildCSImageSprite(_itemCmp.job,_abName,vocCfg.icon4)
widget:SetChildActive(_itemCmp.love,self.current==index)
widget:SetChildActive(_itemCmp.getted,count>0)
widget:SetChildActive(_itemCmp.select,self.select==index)
widget:SetChildActive(_itemCmp.lock,delay<0)
widget:SetChildText(_itemCmp.lockTx,FMT.fmt("{0}天后解锁",delay))
widget:SetChildButtonClick(_itemCmp.button,function()
self:onClickItem(index)
end)
end

function UICommonVocEquipListSelectWin:onClickItem(index)
if self.select~=index then
local grids=self.scrollView:getChildScrollViewItemWidgets()

if self.select then
local widget=grids[self.select-1]
widget:SetChildActive(_itemCmp.select,false)
end

self.select=index

local widget=grids[self.select-1]
widget:SetChildActive(_itemCmp.select,true)

self:refreshPanel()
end
end

function UICommonVocEquipListSelectWin:refreshPanel()
local itemId=self.configs[self.select][1]
local itemCfg=itemsConfig.getConfig(itemId)
local vocCfg=cfgHelper.get1(cfg_disciplevocationconfig_get,itemCfg.type1)
local modelParams=itemCfg.model
if modelParams then
local modelID=modelParams.model
local defsize=cfgHelper.get2(cfg_dbbodyconfig_get,modelID,'scales')or{}
local size=modelParams.scale or defsize[1]or 1
local componnets=modelParams.cmp or{}
local animationID=modelParams.ani or 0

self.model:setChildUIModelEnableInitUISpinePara(false,true)
self.winlua:SetChildUIModelShowTarget(self.model:getID(),modelID,size,componnets,animationID)
end
self.love:setActive(self.select==self.current)
self.descImg1:setSprite(_abName,vocCfg.descImage1)
self.descImg2:setSprite(_abName,vocCfg.descImage2)
self.jobIcon:setSprite(globalABLookup.global,vocCfg.icon)
end

function UICommonVocEquipListSelectWin.onNewDay()
local grids=_this.scrollView:getChildScrollViewItemWidgets()
for i=1,grids.Count do
local widget=grids[i-1]
local data=_this.configs[index]
local day=data[2]
local openDay=timeHelper.getServerOpenDay()
local delay=day and openDay-day or 0
widget:SetChildActive(_itemCmp.lock,delay<0)
widget:SetChildText(_itemCmp.lockTx,FMT.fmt("{0}天后解锁",delay))
end
end