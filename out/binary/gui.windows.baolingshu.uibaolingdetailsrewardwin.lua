







def_class("UIBaoLingDetailsRewardWin",UIWindowBase)









function UIBaoLingDetailsRewardWin:bindComponents()

self.rewards=UIObject.get(self,0)
self.xuyuanCntText=UIText.get(self,1)



end


function UIBaoLingDetailsRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rewards);self.rewards=nil;
_UIObject_release(self.xuyuanCntText);self.xuyuanCntText=nil;
end



















function UIBaoLingDetailsRewardWin:onLoaded(...)
self:bindComponents()
end


function UIBaoLingDetailsRewardWin:__delete()
self:unbindComponents()
end




function UIBaoLingDetailsRewardWin:onShow(argtable,afterOnloaded)
self.showType=argtable and argtable.showType or 1
if self.showType==1 then

local configId=baoLingShuModel:getConfId()
self.config=cfgHelper.get1(cfg_baolingtreeconfig_get,configId)
self.data=baoLingShuModel:get_baolingshu_data(configId)
elseif self.showType==2 then

self.config=cfgHelper.get1(cfg_wishtreeconfig_get,1)
self.data=qiYuanShuModel:get_qiyuanshu_data()
if argtable.qysId then
self.actId=argtable.qysId
else
self.actId=qiYuanShuModel:getQiYuanShuId()
end
end
if afterOnloaded then
self:flushInfo(argtable)
end
end


function UIBaoLingDetailsRewardWin:onHide()

end

function UIBaoLingDetailsRewardWin:flushInfo(argtable)
local cjType=argtable.cjType
local allConfig
if self.showType==1 then
allConfig=cfgHelper.get1(cfg_baolingtreeshowrewardconfig_get,cjType)
elseif self.showType==2 then

local actId=self.actId
allConfig=cfgHelper.get1(cfg_wishtreeshowrewardconfig_get,actId)
end
local list={}
for i,v in ipairs(allConfig)do
if v.rewards~=nil then
table.insert(list,v)
else
if v.isPickUpShow and cjType==1 then
local isInPickUpNow=baoLingShuModel:checkIsInPickUpNow()
if isInPickUpNow then
local gbList=baoLingShuModel:getPickUpShowGBList()or{}
local showList={}
for i,v in ipairs(gbList)do
local gbItemId=v[1]
table.insert(showList,gbItemId)
end
local cfg={
cjtype=v.cjtype,
sortid=v.sortid,
typeName=v.typeName,
rewards={{1,999,showList}},
isPickUpShow=v.isPickUpShow,
gubaoColor=v.gubaoColor,
}
table.insert(list,cfg)
end
end
end
end
table.sort(list,function(a,b)
return a.sortid<b.sortid
end)

self.rewards:setChildLayoutGroupCreateItems(#list)
local widgets=self.rewards:getChildLayoutGroupGridList()
for i=0,widgets.Count-1 do
local widget=widgets[i]
local config=list[i+1]
local titleName=config.typeName
if config.gubaoColor then
local colorlookup=cfgHelper.get2(cfg_gubaobaseconfig_get,1,'colorNames')
if colorlookup[config.gubaoColor]then
titleName=FMT.cfmt(config.gubaoColor,colorlookup[config.gubaoColor])
end
end
widget:SetChildText(2,titleName)
local rewards
if self.showType==1 then
rewards=baoLingShuModel:getShowDatas(config.rewards)
elseif self.showType==2 then
rewards=qiYuanShuModel:getShowDatas(config.rewards)
end
local showRewards=rewards[3]
widget:SetChildLayoutGroupCreateItems(1,#showRewards)

local items=widget:GetChildLayoutGroupGridList(1)
for j=0,items.Count-1 do
local item=items[j]
item:SetChildActive(1,true)

local itemid=showRewards[j+1]
local conf={itemid=itemid,showCountBG=false,showStage=true,name=''}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
local itemWidget=item:GetChildWidgetBase(0)
itemsComponentHelper.setUIBaseItemSmallSign(itemWidget,conf)
item:SetBaseItemClickEvent(0,self.onClickItem)
end
widget:SetChildActive(0,true)
end

local comp=self.rewards:getCommonComponent('ContentSizeFitter')
self:delayDo(0.01,function(...)
comp.enabled=true
self:delayDo(0.01,function(...)
self.rewards:setChildAnchoredPosition(Vector3(0,0,0))
end)
end)


local todayNum
if self.showType==1 then
todayNum=self.data[5]
elseif self.showType==2 then
todayNum=self.data and self.data.todayNum or 0
end

local moneylimit_str=FMT.fmt('今日已许愿: <color=#ca631dff>{0}/{1}</color>次',todayNum,self.config.numLimit)
self.xuyuanCntText:setText(moneylimit_str)
end



function UIBaoLingDetailsRewardWin.onClickItem(itemid,index,itemguid,attach)
if itemid==-1 then
return
end
if itemsConfig.isGubao(itemid)then
gubaoController:gubaoShowTips(itemid)
return
end
itemsComponentHelper.onItemClick(itemid,index,itemguid,attach)
end