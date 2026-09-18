







def_class("UILianDanPreviewWin",UIWindowBase)









function UILianDanPreviewWin:bindComponents()

self.liandanVal=UILinkImageText.get(self,0)
self.ScrollView1=UIScrollView.get(self,1)
self.Text=UILinkImageText.get(self,2)
self.ScrollView2=UIScrollView.get(self,3)



end


function UILianDanPreviewWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.liandanVal);self.liandanVal=nil;
_UIObject_release(self.ScrollView1);self.ScrollView1=nil;
_UIObject_release(self.Text);self.Text=nil;
_UIObject_release(self.ScrollView2);self.ScrollView2=nil;
end


















local itemDanList={17311,17312,17313,17314,17315,17316,17317,17318,17319}

function UILianDanPreviewWin:onLoaded(...)
self:bindComponents()
self.subType=SUB_ACTIVITY_TYPE.eLianDanDaHui

end


function UILianDanPreviewWin:__delete()
self:unbindComponents()
end




function UILianDanPreviewWin:onShow(argtable,afterOnloaded)

local actid=argtable.actid
local act2id=argtable.act2id
local config=activitiesModel:getSubActivityConfig(self.subType,act2id)
local previewConfig=config.daodanPreview
local daodanShow=config.daodanShow
local daodanSoul=config.soul

local daodanConfig=previewConfig[1]
local itemConfig=previewConfig[2]
local getMoneyType=config.money
local iconname=iconHelper.getIconName(getMoneyType)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,32)

local count=#daodanConfig
self.ScrollView1:setChildScrollViewCreateGrids(count,3)
local grids=self.ScrollView1:getChildScrollViewItemWidgets()
local count=grids.Count
for i=0,count-1 do
local index=i+1
local item=grids[i]
local daodanId=daodanConfig[index]
local soul=daodanSoul[daodanId]
local dCfg=daodanShow[daodanId]

local iconName=iconHelper.getItemIconName(dCfg.icon)
local conf=
{
iconName=iconName,

color=dCfg.color,


}
local prop=itemsComponentHelper.getCommonSpecialFillData(conf)

item:SetChildPropData(0,prop)
item:SetChildText(1,dCfg.name)
item:SetChildText(2,FMT.fmt("回收：{0}<color=#ca631d>{1}</color>",iconStr,soul))
item:SetBaseItemClickEvent(0,function()
tipsManager.showTips({itemid=itemDanList[dCfg.stage]})
end)
end

local items=itemConfig
if items then
local propData={}
for i,v in ipairs(items)do
table.insert(propData,itemsComponentHelper.getCommonFillData({itemid=v},{showname=true,nomalname=true,showcount=false}))
end
local propDataCnt=#propData
self.ScrollView2:setChildLayoutGroupCreateItems(propDataCnt,function(index)
local item=self.ScrollView2:getChildLayoutGroupGridItem(index-1)
local prop=propData[index]
item:SetBaseItemClickEvent(0,self.onClickItem)
item:SetChildPropData(0,prop)
end)
self.ScrollView2:freshGridsNum(propDataCnt,math.ceil(propDataCnt/7),7,false)
self.ScrollView2:initPropData(propData)
self.ScrollView2:setChildSizeDelta(1005,math.ceil(propDataCnt/7)*120+10)
end

end

function UILianDanPreviewWin.onClickItem(itemid,index,itemguid,attach)
itemsComponentHelper.onItemClickEx(itemid,index,itemguid,attach)
end

function UILianDanPreviewWin:onHide()

end



