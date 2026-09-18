







def_class("UIXingYu_JYZFLevelDropDownWin",UIWindowBase)









function UIXingYu_JYZFLevelDropDownWin:bindComponents()

self.flag=UIObject.get(self,0)
self.layout=UIObject.get(self,1)
self.maskBtn=UIButton.get(self,2)
self.opscrollview=UIObject.get(self,3)
self.option=UIButton.get(self,4)
self.optxt=UIImage.get(self,5)

self.maskBtn:setButtonClick(function()self:onMaskBtn()end)

self.option:setButtonClick(function()self:onOption()end)



end


function UIXingYu_JYZFLevelDropDownWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.flag);self.flag=nil;
_UIObject_release(self.layout);self.layout=nil;
_UIObject_release(self.maskBtn);self.maskBtn=nil;
_UIObject_release(self.opscrollview);self.opscrollview=nil;
_UIObject_release(self.option);self.option=nil;
_UIObject_release(self.optxt);self.optxt=nil;
end
















local _this
local _optionImgList={"button_wdcqui_2","button_wdcqui_02"}




function UIXingYu_JYZFLevelDropDownWin:onLoaded(...)
self:bindComponents()

_this=self

self.isShowOpScrollView=false
end


function UIXingYu_JYZFLevelDropDownWin:__delete()
self:unbindComponents()
end




function UIXingYu_JYZFLevelDropDownWin:onShow(argtable,afterOnloaded)

self.parent=argtable.parent
local item=argtable.item
local move_pos=argtable.node

if item then
self:showPosition(item,move_pos)
end

self.level=JiuYuZhengFengModel:getData_rank_level()or 0
self.levelSIndex=self.level

self.nameList=JiuYuZhengFengModel:getDropDownNameList()

self:refreshOption()

local len=#self.nameList
self.opscrollview:setChildScrollViewInit(0.5,true,self.onChangeOption,nil)
self.opscrollview:setChildScrollViewCreateGrids(len,1)
self.grids=self.opscrollview:getChildScrollViewItemWidgets()

for index=1,len do
local item=self.grids[index-1]
item:SetChildCSImageSprite(0,globalABLookup.jiuyuzhengfeng,self.nameList[index])
item:SetChildActive(1,index==self.level)
end

self.opscrollview:setActive(self.isShowOpScrollView)
local val=self.isShowOpScrollView and 1 or 2
self.option:setCSImageSprite(globalABLookup.wendingcangqiong,_optionImgList[val])
end

function UIXingYu_JYZFLevelDropDownWin:onShowArgRecv(argtable)
self:onShow(argtable)
end

function UIXingYu_JYZFLevelDropDownWin:refreshOption()
self.flag:setActive(self.levelSIndex==self.level)
self.optxt:setCSImageSprite(globalABLookup.jiuyuzhengfeng,self.nameList[self.levelSIndex])
end

function UIXingYu_JYZFLevelDropDownWin.onChangeOption(clickCount,index)

local realIndex=index+1
if _this.levelSIndex==realIndex then _this:onMaskBtn()return end

_this.levelSIndex=realIndex
_this:onMaskBtn()
_this:refreshOption()

if _this.parent and _this.parent['onChangeLevel']then
_this.parent['onChangeLevel'](_this.parent,realIndex)
end
end




function UIXingYu_JYZFLevelDropDownWin:onHide()

end





function UIXingYu_JYZFLevelDropDownWin:onMaskBtn()
self.isShowOpScrollView=false

self.maskBtn:setActive(self.isShowOpScrollView)
self.opscrollview:setActive(self.isShowOpScrollView)

local val=self.isShowOpScrollView and 1 or 2
self.option:setCSImageSprite(globalABLookup.wendingcangqiong,_optionImgList[val])
end

function UIXingYu_JYZFLevelDropDownWin:onOption()
self.isShowOpScrollView=not self.isShowOpScrollView
self.maskBtn:setActive(self.isShowOpScrollView)
self.opscrollview:setActive(self.isShowOpScrollView)

local val=self.isShowOpScrollView and 1 or 2
self.option:setCSImageSprite(globalABLookup.wendingcangqiong,_optionImgList[val])
end




function UIXingYu_JYZFLevelDropDownWin:showPosition(item,move_pos)

local screenPoint=item:GetChildScreenPointToLocalPointRectangle(-1)


























































self.winlua:SetChildLocalPosition(self.layout:getID(),Vector3(screenPoint.x,screenPoint.y,0))
end
