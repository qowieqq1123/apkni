







def_class("UILianDanResultWin",UIWindowBase)









function UILianDanResultWin:bindComponents()

self.effect=UIObject.get(self,0)
self.FullScreenClose=UIButton.get(self,1)
self.liandanVal=UILinkImageText.get(self,2)
self.ScrollView1=UIScrollView.get(self,3)
self.Text=UILinkImageText.get(self,4)
self.ScrollView2=UIScrollView.get(self,5)
self.Content2=UIObject.get(self,6)
self.Content=UIObject.get(self,7)

self.FullScreenClose:setButtonClick(function()self:onFullScreenClose()end)



end


function UILianDanResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.FullScreenClose);self.FullScreenClose=nil;
_UIObject_release(self.liandanVal);self.liandanVal=nil;
_UIObject_release(self.ScrollView1);self.ScrollView1=nil;
_UIObject_release(self.Text);self.Text=nil;
_UIObject_release(self.ScrollView2);self.ScrollView2=nil;
_UIObject_release(self.Content2);self.Content2=nil;
_UIObject_release(self.Content);self.Content=nil;
end



















local ColorBg="image_danpinjiedw_{0}"
local itemDanList={17311,17312,17313,17314,17315,17316,17317,17318,17319}

function UILianDanResultWin:onLoaded(...)
self:bindComponents()
self.ScrollView2:setChildScrollViewInit(0,true,nil,nil)

self.effect:setChildShowEffect(10010,true)
end


function UILianDanResultWin:__delete()
self.ScrollView1:setChildScrollViewStopGridCreate()
self.ScrollView2:setChildScrollViewStopGridCreate()
self:unbindComponents()
end




function UILianDanResultWin:onShow(argtable,afterOnloaded)
self.subType=SUB_ACTIVITY_TYPE.eLianDanDaHui
local otherItemList=argtable.otherItemList
local effectData=argtable.effectData
local liandanValue=effectData.score
local daodanList=effectData.soulList

local actid=effectData.actid
local act2id=effectData.act2id
local config=activitiesModel:getSubActivityConfig(self.subType,act2id)
local daodanConfig=config.daodanShow
local daodanSoul=config.soul
if daodanList then
local propData={}
local itemList={}
local money=0
for i,v in ipairs(daodanList)do
local dCfg=daodanConfig[v]
local soul=daodanSoul[v]
if dCfg then
local iconName=iconHelper.getItemIconName(dCfg.icon)
local conf=
{
iconName=iconName,

color=dCfg.color,
stageStr=FMT.fmt("{0}纹",mathHelper.numberToChinese(dCfg.stage)),
showStageBg=true,

}
local prop=itemsComponentHelper.getCommonSpecialFillData(conf)
prop[PropIndex(DataPropKey.eWidgetIcon,2)]=FMT.fmt(ColorBg,dCfg.color)
table.insert(propData,prop)
table.insert(itemList,itemDanList[dCfg.stage])
end
if soul then
money=money+soul
end
end
self.itemList=itemList
local propDataCnt=#propData
if propDataCnt>0 then
self.gridAnim1=true
end
local cnt=propDataCnt

self.propData1=propData
self.ScrollView1:setChildScrollViewDelayCreateGrids(propDataCnt,10,0.1,1,false,false,function(id,item)
if id+1>=propDataCnt then
self.gridAnim1=nil
end
self:refreshItem1(id,item,propData,itemList)
end)
if cnt<=10 then
self.winlua:SetChildSizeDelta(self.Content:getID(),cnt*107,100)
self.Content:setAnchors(0.5,1,0.5,0.5)
self.Text:setLocalPosY(-144)
end
local getMoneyType=config.money
local iconname=iconHelper.getIconName(getMoneyType)
local iconStr=chatEmotHelper.getIconEmotMesg(iconname,40)
self.Text:setText(FMT.fmt("回收本次炼制的所有道丹，获得{0}<color=#ca631d>{1}</color>",iconStr,money))

end

self.liandanVal:setText(FMT.fmt("炼丹值：{0}",liandanValue))

local items=otherItemList
if items then
local propData2={}
for i,v in ipairs(items)do
local num=v.num or 0
table.insert(propData2,itemsComponentHelper.getCommonFillData(v,{showname=false,showcount=num>1,itemcount=v.num,showCountBG=num>1,showStageBg=true}))
end
local propDataCnt=#propData2
if propDataCnt>0 then
self.gridAnim2=true
end


self.propData2=propData2
local cnt=propDataCnt

self.ScrollView2:setChildScrollViewDelayCreateGrids(propDataCnt,12,0.1,1,false,false,function(id,item)

if id+1>=propDataCnt then
self.gridAnim2=nil
end
self:refreshItem(id,item,propData2)
end)

if cnt<=12 then
self.winlua:SetChildSizeDelta(self.Content2:getID(),cnt*90+10,100)
self.Content2:setAnchors(0.5,1,0.5,0.5)
end

end


end


function UILianDanResultWin:onHide()

end

function UILianDanResultWin:refreshItem1(id,item,propData,itemList)
item:SetChildPropData(0,propData[id+1])
item:SetChildCanvasGroupDOFade(1,1,0.1)
if id<=19 then
item:SetChildShowEffect(2,10078,true)
end
item:SetChildButtonClick(1,function()
tipsManager.showTips({itemid=itemList[id+1]})
end)
item:SetChildActive(3,true)
end

function UILianDanResultWin:refreshItem(id,item,propData)
item:SetChildPropData(0,propData[id+1])
item:SetChildCanvasGroupDOFade(1,1,0.1)
if id<=23 then
item:SetChildShowEffect(2,10078,true)
end
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
item:SetChildActive(3,false)
end

function UILianDanResultWin:refreshAll()
if self.gridAnim1 or self.gridAnim2 then
if self.propData1 then
local cnt=#self.propData1
if cnt>1 then
self.ScrollView1:setChildScrollViewStopGridCreate()
self.ScrollView1:setChildScrollViewCreateGrids(0,0)
self.ScrollView1:setChildScrollViewCreateGrids(#self.propData1,10)
local grids=self.ScrollView1:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
self:refreshItem1(i-1,item,self.propData1,self.itemList)
end

if#self.propData1<=10 then
self.winlua:SetChildSizeDelta(self.Content:getID(),#self.propData1*107,100)
self.Content:setAnchors(0.5,1,0.5,0.5)
end
end



end
if self.propData2 then
local cnt=#self.propData2
if cnt>1 then
self.ScrollView2:setChildScrollViewStopGridCreate()
self.ScrollView2:setChildScrollViewCreateGrids(0,0)
self.ScrollView2:setChildScrollViewCreateGrids(#self.propData2,12)
local grids=self.ScrollView2:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
self:refreshItem(i-1,item,self.propData2)
end

if cnt<=12 then
self.winlua:SetChildSizeDelta(self.Content2:getID(),cnt*90+10,100)
self.Content2:setAnchors(0.5,1,0.5,0.5)
end
end



end
self.gridAnim1=nil
self.gridAnim2=nil
end
end

function UILianDanResultWin:onCloseWin()
if self.gridAnim1 or self.gridAnim2 then
self:refreshAll()
else
self:closeSelf()
end
end




function UILianDanResultWin:onFullScreenClose()
end

