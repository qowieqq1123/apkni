







def_class("UITaiXuCangRewardWin",UIWindowBase)









function UITaiXuCangRewardWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.ScrollView=UIObject.get(self,1)
self.time=UIText.get(self,2)
self.tips=UIText.get(self,3)
self.title=UIText.get(self,4)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UITaiXuCangRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.time);self.time=nil;
_UIObject_release(self.tips);self.tips=nil;
_UIObject_release(self.title);self.title=nil;
end



















function UITaiXuCangRewardWin:onLoaded(...)
self:bindComponents()
end


function UITaiXuCangRewardWin:__delete()
self:unbindComponents()
end




function UITaiXuCangRewardWin:onShow(argtable,afterOnloaded)
local dropId=argtable
local leftTime=TaiXuCangModel:getLeftTime()

self.title:setText("仙宫军备")
self.tips:setText("太虚仓中的传送阵每经一段时日便可获得仙宫运送的军备资源，这些资源将保存在太虚仓中，请及时收取")

if leftTime>=0 then
self.time:setText(FMT.fmt("距下一次军备运送：<color=#fd8950>{0}</color>",timeHelper.format_time_stamp2(leftTime)))
self:startLeftTimer()
else
self.time:setText("军备储量已满")
end

local rwcfg=cfgHelper.get1(cfg_awardconfig_get,dropId)
local rewards=rwcfg.showItems
local len=#rewards
self.ScrollView:setChildScrollViewCreateGrids(len,math.min(len,5))
local grids=self.ScrollView:getChildScrollViewItemWidgets()
local count=grids.Count-1
for i=0,count do
local item=grids[i]
local rwdata=rewards[i+1]
local prop=itemsComponentHelper.getCommonFillData({itemid=rwdata[1]},{showname=false,itemcount=rwdata[2]>1 and rwdata[2]or"",showCountBG=rwdata[2]>1,showStageBg=true,range=rwdata.range})
prop[PropIndex(DataPropKey.eWidgetActive,11)]=rwdata[2]==-1
item:SetBaseItemClickEvent(0,function(...)
itemsComponentHelper.onItemClick(...)
end)
item:SetChildPropData(0,prop)
if rwdata[4]then
item:SetChildText(1,FMT.fmt("<color=#f36666>{0}%</color>",rwdata[4]or 0))
end
end
end


function UITaiXuCangRewardWin:startLeftTimer()
self.timerid=self:setTimer(1,-1,function()
local leftTime=TaiXuCangModel:getLeftTime()
if leftTime>=0 then
self.time:setText(FMT.fmt("距下一次军备运送：<color=#fd8950>{0}</color>",timeHelper.format_time_stamp2(leftTime)))
else
self.time:setText("军备储量已满")
if self.timeid then
self:stopTimerByID(self.timeid)
self.timerid=nil
end
end
end)
end


function UITaiXuCangRewardWin:onHide()

end





function UITaiXuCangRewardWin:onCloseBtn()
self:closeSelf()
end

