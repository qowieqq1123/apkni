







def_class("UIFuBaoQuickMakeWin",UIWindowBase)









function UIFuBaoQuickMakeWin:bindComponents()

self.rwScrollView=UIObject.get(self,0)
self.selectCntSlider=UIObject.get(self,1)
self.subBtn=UIButton.get(self,2)
self.addBtn=UIButton.get(self,3)
self.maxBtn=UIButton.get(self,4)
self.quickBtn=UIButton.get(self,5)
self.levelText=UIText.get(self,6)
self.handleImg=UIObject.get(self,7)
self.selectCntText=UIText.get(self,8)

self.subBtn:setButtonClick(function()self:onSubBtn()end)

self.addBtn:setButtonClick(function()self:onAddBtn()end)

self.maxBtn:setButtonClick(function()self:onMaxBtn()end)

self.quickBtn:setButtonClick(function()self:onQuickBtn()end)



end


function UIFuBaoQuickMakeWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.rwScrollView);self.rwScrollView=nil;
_UIObject_release(self.selectCntSlider);self.selectCntSlider=nil;
_UIObject_release(self.subBtn);self.subBtn=nil;
_UIObject_release(self.addBtn);self.addBtn=nil;
_UIObject_release(self.maxBtn);self.maxBtn=nil;
_UIObject_release(self.quickBtn);self.quickBtn=nil;
_UIObject_release(self.levelText);self.levelText=nil;
_UIObject_release(self.handleImg);self.handleImg=nil;
_UIObject_release(self.selectCntText);self.selectCntText=nil;
end



















function UIFuBaoQuickMakeWin:onLoaded(...)
self:bindComponents()
local longPressFunc=function(...)
self:onLongPressBtn(...)
end
self.winlua:SetChildLongPress(self.subBtn:getID(),1,longPressFunc,nil)
self.winlua:SetChildLongPress(self.addBtn:getID(),2,longPressFunc,nil)

self.rwScrollView:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIFuBaoQuickMakeWin:__delete()
self:unbindComponents()
end




function UIFuBaoQuickMakeWin:onShow(argtable,afterOnloaded)
self.sfId=argtable[1]
self.ubdId=argtable[2]
self.level=argtable[3]
self.config=argtable[4]
self.pData=argtable.pData
self.bdData=zongmenModel:getBuildingData(self.ubdId)
zongmenModel:countManufacturePercent(self.bdData)
local percent=self.bdData.pcreatesubpercent or 0
self.maxCnt=UIFuLuFangModel:getMaxLianZhiCount(self.config,percent)
self.selectCnt=1
local minCnt=1
local maxCnt=self.maxCnt
if self.maxCnt<=1 then
minCnt=0
self.selectCnt=1
maxCnt=1
end

self:refreshMaterials()
self.winlua:SetChildImageRaycast(self.handleImg:getID(),maxCnt>1)
self.winlua:SetChildImageRaycast(self.subBtn:getID(),maxCnt>1)
self.winlua:SetChildImageRaycast(self.addBtn:getID(),maxCnt>1)
self.winlua:SetChildImageRaycast(self.maxBtn:getID(),maxCnt>1)
self.winlua:SetChildSliderInit(self.selectCntSlider:getID(),self.selectCnt,minCnt,maxCnt,function(...)
self:onSliderChange(...)
end)
local levelStr=cfgHelper.get2(cfg_fubaoratingconfig_get,self.level,'name')
self.levelText:setText(FMT.fmt('{0}的当前评级为{1}',self.config.name,FMT.cfmt(self.level,levelStr)))
end


function UIFuBaoQuickMakeWin:onHide()

end

function UIFuBaoQuickMakeWin:refreshMaterials()
local costs=self.config.cost

self.rwScrollView:setChildScrollViewCreateGrids(#costs,0)
local grids=self.rwScrollView:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local cost=costs[i]
local needCount=cost[2]*self.selectCnt
widgetHelper.setNormalRewardItem(item,0,{cost[1],needCount})
end

























end

function UIFuBaoQuickMakeWin:refreshMaterialsCnt()



















self:refreshMaterials()
end

function UIFuBaoQuickMakeWin:onSliderChange(value)
self.selectCnt=value
self.selectCntText:setText(value)
self:refreshMaterialsCnt()
end

function UIFuBaoQuickMakeWin:onLongPressBtn(id)
if id==1 then
if self.selectCnt<=1 then
return
end
self.selectCnt=self.selectCnt-1
else
if self.selectCnt>=self.maxCnt then
return
end
self.selectCnt=self.selectCnt+1
end
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end



function UIFuBaoQuickMakeWin:onQuickBtn()
local bdData=zongmenModel:getBuildingData(self.ubdId)
local dzId=bdData.dizi_id
local state=UIDiscipleModel:getDiscipleState(dzId)
if state==DISCIPLE_STATE_TYPE.eChuiWei then
UIManager.error('弟子已垂危，不堪重负')
return
end
local config=self.config





local percent=self.pData[1]or 0
if not UIFuLuFangModel:checkCanMake(config.cost,true,self.selectCnt,percent)then
return
end
UIFullFuLuFangControl:reqMakeFuLu(self.sfId,self.ubdId,config.id,self.level,self.selectCnt)
self:onClickClose()
end

function UIFuBaoQuickMakeWin:onMaxBtn()
self.selectCnt=self.maxCnt
self.winlua:SetChildSliderValue(self.selectCntSlider:getID(),self.selectCnt)
end

function UIFuBaoQuickMakeWin:onSubBtn()
end

function UIFuBaoQuickMakeWin:onAddBtn()
end

function UIFuBaoQuickMakeWin:onClickClose()
self:closeSelf()
end