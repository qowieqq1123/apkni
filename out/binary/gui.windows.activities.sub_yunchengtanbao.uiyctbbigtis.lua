







def_class("UIYCTBBigtis",UIWindowBase)









function UIYCTBBigtis:bindComponents()

self.root=UIObject.get(self,0)
self.rewardGrid=UIObject.get(self,1)
self.bx=UIObject.get(self,2)
self.content=UIText.get(self,3)
self.bottom2=UIObject.get(self,4)
self.rewardGrid2=UIObject.get(self,5)



end


function UIYCTBBigtis:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.rewardGrid);self.rewardGrid=nil;
_UIObject_release(self.bx);self.bx=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.bottom2);self.bottom2=nil;
_UIObject_release(self.rewardGrid2);self.rewardGrid2=nil;
end

















local _this
local temps=
{
[1]=3,
[2]=2,
[3]=1,
}


function UIYCTBBigtis:onLoaded(...)
self:bindComponents()
_this=self
self.root:setScale(Vector3.New(1,0,1))
end


function UIYCTBBigtis:__delete()
self:unbindComponents()
_this=nil
end




function UIYCTBBigtis:onShow(argtable,afterOnloaded)
self.actID=argtable.actID
self.subType=argtable.subType
self.subid=argtable.subid
self.parentwin=argtable.parentwin
self.contentstr=argtable.contentstr or""

self.content:setText(self.contentstr)
if argtable.posx and argtable.posy then


end

self.itempos=argtable.itempos




self.root:setChildDOScaleY(1,0.35,nil)

self.flag=argtable.flag
if self.flag==1 then
self.idx=argtable.idx
elseif self.flag==2 then
self.idx=nil
end
if self.flag==1 then
self.bx:setActive(true)
end
self:refreshinfo(self.flag,self.idx)
end


function UIYCTBBigtis:onHide()

end


function UIYCTBBigtis:refreshinfo(flag,idx)
local rewardslist={}
local rewardList={}
if flag==1 then

rewardslist=cfg_cloudcitytreasureactconfig_get(_this.subid).rewardslist
rewardList=rewardslist[temps[idx]][2]or{}
elseif flag==2 then

rewardslist={{10594,1},{10593,2},{10591,3},{10585,4},{10586,5},{10587,6}}
rewardList=rewardslist or{}
end
local len=#rewardList
if len>0 then
local _num=0
if#rewardList>=5 then
_num=5
else
_num=#rewardList
end
local len1=_num
_this.winlua:SetChildLayoutGroupCreateItems(_this.rewardGrid:getID(),len1)
local grids2=_this.winlua:GetChildLayoutGroupGridList(_this.rewardGrid:getID())
for i=1,len1 do
local rewardItem=grids2[i-1]
local itemid=rewardList[i][1]
local itemnum=rewardList[i][2]
if flag==2 then
itemnum=1
end
local gailv=rewardList[i][3]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

local gailvtxt=""
if gailv and flag==1 then
gailvtxt=FMT.fmt('{0}%',gailv)
end
rewardItem:SetChildText(2,gailvtxt)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end

if _num==5 then

local len2=#rewardList-_num
if len2>0 then
if flag==1 then
_this.bottom2:setActive(true)
end
_this.rewardGrid2:setActive(true)
_this.winlua:SetChildLayoutGroupCreateItems(_this.rewardGrid2:getID(),len2)
local grids3=_this.winlua:GetChildLayoutGroupGridList(_this.rewardGrid2:getID())
for i=1,len2 do
local rewardItem=grids3[i-1]
local itemid=rewardList[i+_num][1]
local itemnum=rewardList[i+_num][2]
if flag==2 then
itemnum=1
end
local gailv=rewardList[i+_num][3]
local itemcount,showCountBG
if itemnum>1 then
itemcount=tostring(itemnum)
showCountBG=true
else
itemcount=''
showCountBG=false
end
local conf={itemid=itemid,itemcount=itemcount,showCountBG=showCountBG,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)

local gailvtxt=""
if gailv and flag==1 then
gailvtxt=FMT.fmt('{0}%',gailv)
end
rewardItem:SetChildText(2,gailvtxt)
rewardItem:SetChildPropData(0,prop)
rewardItem:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end
end
end
end
end


function UIYCTBBigtis:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil})
end

function UIYCTBBigtis:onCloseClick()
self:closeSelf()
end