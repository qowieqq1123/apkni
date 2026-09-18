







def_class("UIXYRewardSubWin_TanSuo",UIWindowBase)









function UIXYRewardSubWin_TanSuo:bindComponents()

self.ScrollView=UIScrollView.get(self,0)
self.LoopScrollView=UILoopListView.new(self,1)

self.LoopScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)


end


function UIXYRewardSubWin_TanSuo:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ScrollView);self.ScrollView=nil;
self.LoopScrollView:deleteSelf();self.LoopScrollView=nil;
end















local abName="ui/windows/xingyu/xingyu_atlas_pak.ab"



function UIXYRewardSubWin_TanSuo:onLoaded(...)
self:bindComponents()
self.ScrollView:setClickAction(itemsComponentHelper.onItemClick)
end


function UIXYRewardSubWin_TanSuo:__delete()
self:unbindComponents()
end




function UIXYRewardSubWin_TanSuo:onShow(argtable,afterOnloaded)

local xyId=argtable.xyId
if self.xyId==xyId then
return
end
self.xyId=xyId






































local datalist={}
local prefabnameList={}
local col=11
local xyCfg=XingYuModel:getXingYuConfig(xyId)

local tsZYRewards=table.deepCopy(xyCfg.tsZYRewards)
local lookup={}
for i,v in ipairs(tsZYRewards)do
if lookup[v[1]]then
lookup[v[1]]=lookup[v[1]]+v[2]
else
lookup[v[1]]=v[2]
end
end
tsZYRewards={}
for k,v in pairs(lookup)do
local color=itemsConfig.getItemColor(k)
table.insert(tsZYRewards,{k,v,color})
end
table.sort(tsZYRewards,function(a,b)
return a[3]>b[3]
end)

local row=math.ceil(#tsZYRewards/col)
for _r=1,row do
local rewardItemTemp={}
rewardItemTemp.titleName=_r==1 and"image_xyjl_zy"or nil


table.insert(prefabnameList,"rewardItem")

local _rewardList={}
for _c=1,col do
local index=(_r-1)*col+_c
local rewardData=tsZYRewards[index]
if rewardData then
table.insert(_rewardList,rewardData)
end
end
rewardItemTemp.rewardList=_rewardList
table.insert(datalist,rewardItemTemp)
end


local tsOtherRewards=table.deepCopy(xyCfg.tsOtherRewards)
lookup={}
for i,v in ipairs(tsOtherRewards)do
if lookup[v[1]]then
lookup[v[1]]=lookup[v[1]]+v[2]
else
lookup[v[1]]=v[2]
end
end
tsOtherRewards={}
for k,v in pairs(lookup)do
local color=itemsConfig.getItemColor(k)
table.insert(tsOtherRewards,{k,v,color})
end
table.sort(tsOtherRewards,function(a,b)
return a[3]>b[3]
end)

local row=math.ceil(#tsOtherRewards/col)
for _r=1,row do
local rewardItemTemp={}
rewardItemTemp.titleName=_r==1 and"image_xyjl_qt"or nil


table.insert(prefabnameList,"rewardItem")
local _rewardList={}
for _c=1,col do
local index=(_r-1)*col+_c
local rewardData=tsOtherRewards[index]
if rewardData then
table.insert(_rewardList,rewardData)
end
end
rewardItemTemp.rewardList=_rewardList
table.insert(datalist,rewardItemTemp)
end
if#datalist>0 then
self.LoopScrollView:initDataEx(prefabnameList,datalist)
else
self.LoopScrollView:initData(nil,nil,0)
end
end


function UIXYRewardSubWin_TanSuo:onHide()

end

function UIXYRewardSubWin_TanSuo:onFreshAction(index,widget,data)
if data.titleName then
widget:SetChildActive(1,true)
widget:SetChildCSImageSprite(1,abName,data.titleName)
else
widget:SetChildActive(1,false)
end
self:SetChildLayoutGroup(widget,data.rewardList,0)
end

function UIXYRewardSubWin_TanSuo:SetChildLayoutGroup(widget,list,cmpIndex)
widget:SetChildLayoutGroupCreateItems(cmpIndex,#list,function(index)
local item=widget:GetChildLayoutGroupGridItem(cmpIndex,index-1)
local rewardData=list[index]
local itemId=rewardData[1]
local itemNum=rewardData[2]
local showCountBG=itemNum>1
local countStr=showCountBG and mathHelper.formatNumber(itemNum)or""


local fillData=itemsComponentHelper.getCommonFillData({itemid=itemId},{showname=false,itemcount=countStr,showCountBG=showCountBG,showStageBg=true})
if itemsConfig.isMoney(itemId)then
fillData[PropIndex(DataPropKey.eWidgetActive,9)]=false
end
item:SetChildPropData(-1,fillData)
item:SetBaseItemClickEvent(-1,itemsComponentHelper.onItemClickEx)
if itemNum==-1 then
item:SetChildActive(13,true)
item:SetChildCSImageSprite(13,"ui/windows/xianjie/xianjiemain_atlas_pak.ab","image_hailiang")
else
item:SetChildActive(13,false)
end
end)
end

function UIXYRewardSubWin_TanSuo:onStartAction()
end



