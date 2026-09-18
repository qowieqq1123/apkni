







def_class("UIRoadTipsWin",UIWindowBase)









function UIRoadTipsWin:bindComponents()

self.oneObj=UIObject.get(self,0)
self.twoObj=UIObject.get(self,1)
self.threeObj=UIObject.get(self,2)
self.tipstxt=UIText.get(self,3)
self.spinebg=UIObject.get(self,4)
self.leftmovebtn=UIObject.get(self,5)
self.rightmovebtn=UIObject.get(self,6)
self.scrollview=UIObject.get(self,7)
self.content=UIObject.get(self,8)



end


function UIRoadTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.oneObj);self.oneObj=nil;
_UIObject_release(self.twoObj);self.twoObj=nil;
_UIObject_release(self.threeObj);self.threeObj=nil;
_UIObject_release(self.tipstxt);self.tipstxt=nil;
_UIObject_release(self.spinebg);self.spinebg=nil;
_UIObject_release(self.leftmovebtn);self.leftmovebtn=nil;
_UIObject_release(self.rightmovebtn);self.rightmovebtn=nil;
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.content);self.content=nil;
end


















local maskSizeList={35,65,95,125}
local life=1
local _this=nil


function UIRoadTipsWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIRoadTipsWin:__delete()
_this=nil
self:unbindComponents()
end


function UIRoadTipsWin:onHide()

end




function UIRoadTipsWin:onShow(argtable,afterOnloaded)
self.isMoveRight=false

self.scrollview:setChildCanvasGroupDOFade(0,0,nil)
self.spinebg:setChildUIModelShowTarget(4086,1,{},0,false,false,0.3,function()
self:delayDo(0.3,function()
if _this==nil then return end




_this.scrollview:setChildCanvasGroupDOFade(1,0.2,function()
_this:initView()
_this:delayBegin1()
_this:delayBegin2()
end)
end)


end)
end

function UIRoadTipsWin:initView()

self:freshBtns();
local models=cfgHelper.get2(cfg_monijybuildconfig_get,SLG_SYSTEM_TYPE.eCangJingGe,'model')
local modelID=models[1]

self.tipstxt:setText(cfgHelper.getlang('build_road_tips_5'))

local oneWidget=self.oneObj:getChildWidgetBase()
oneWidget:SetChildText(0,cfgHelper.getlang('build_road_tips_1'))
oneWidget:SetChildText(1,FMT.fmt("1.{0}",cfgHelper.getlang('build_road_tips_2')))
oneWidget:SetChildUIModelShowTarget(2,modelID,0.25,nil,eAnimationID.bd_stand)

local twoWidget=self.twoObj:getChildWidgetBase()
twoWidget:SetChildText(0,cfgHelper.getlang('build_road_tips_3'))
twoWidget:SetChildText(1,FMT.fmt("2.{0}",cfgHelper.getlang('build_road_tips_4')))
twoWidget:SetChildUIModelShowTarget(2,modelID,0.25,nil,eAnimationID.bd_stand)

local threeWidget=self.threeObj:getChildWidgetBase()
threeWidget:SetChildText(0,cfgHelper.getlang('build_road_tips_6'))
threeWidget:SetChildText(1,FMT.fmt("3.{0}",cfgHelper.getlang('build_road_tips_7')))
threeWidget:SetChildUIModelShowTarget(2,modelID,0.25,nil,eAnimationID.bd_stand)
end


function UIRoadTipsWin:beginAnim1()
local twoWidget=self.twoObj:getChildWidgetBase()


local idx=1
twoWidget:SetChildSizeDelta(3,maskSizeList[idx],200)
local func=function()
idx=idx+1
twoWidget:SetChildSizeDelta(3,maskSizeList[idx],200)
end
self.maskTimer=1 self:setTimer(life/3-0.1,3,func)

twoWidget:SetChildLocalPos(4,5,-42,0)
twoWidget:SetChildDOLocalMove(4,Vector3(104,9,0),life,nil)

twoWidget:SetChildLocalPos(5,27,-85,0)
local func2=function()
if _this==nil then return end
self:delayBegin1()
end
twoWidget:SetChildDOLocalMove(5,Vector3(127,-30,0),life,func2)
end

function UIRoadTipsWin:delayBegin1()
local func=function()
if _this==nil then return end
self:beginAnim1()
end
self:delayDo(1,func)
end



function UIRoadTipsWin:beginAnim2()
local threeWidget=self.threeObj:getChildWidgetBase()



threeWidget:SetChildActive(4,false)
threeWidget:SetChildActive(5,false)
threeWidget:SetChildLocalPos(2,0,-18,0)

local func=function()
if _this==nil then return end
self:beginAnim2_part1()
end
self:delayDo(0.2,func)
end

function UIRoadTipsWin:beginAnim2_part1()
local threeWidget=self.threeObj:getChildWidgetBase()


threeWidget:SetChildActive(5,true)
threeWidget:SetChildIconFillAmount(6,0)
threeWidget:SetChildImageDOFillAmount(6,1,1,function()
threeWidget:SetChildActive(5,false)

local func1=function()

threeWidget:SetChildActive(4,true)
threeWidget:SetChildLocalPos(4,0,130,0)

local func2=function()
if _this==nil then return end
self:beginAnim2_part2()
end
self:delayDo(0.5,func2)
end
threeWidget:SetChildDOLocalMoveY(2,10,0.15,func1)
end)

threeWidget:SetChildActive(7,true)
threeWidget:SetChildLocalPos(7,0,-18,0)

end

function UIRoadTipsWin:beginAnim2_part2()
local threeWidget=self.threeObj:getChildWidgetBase()

threeWidget:SetChildDOLocalMove(4,Vector3(5,96,0),1,nil)

local func=function()
if _this==nil then return end
threeWidget:SetChildActive(4,false)

local fun2=function()
if _this==nil then return end
threeWidget:SetChildActive(7,false)

self:beginAnim2_part3()
end
threeWidget:SetChildDOLocalMoveY(2,-52,0.15,fun2)
end
threeWidget:SetChildDOLocalMove(2,Vector3(5,-24,0),1,func)

threeWidget:SetChildDOLocalMove(7,Vector3(5,-52,0),1,nil)
end

function UIRoadTipsWin:beginAnim2_part3()
local threeWidget=self.threeObj:getChildWidgetBase()


self:delayBegin2()
end

function UIRoadTipsWin:delayBegin2()
local func=function()
if _this==nil then return end
self:beginAnim2()
end
self:delayDo(2,func)
end




function UIRoadTipsWin:onClickLeftBtn()
self.leftmovebtn:setActive(false);
self.content:setChildDOLocalMoveX(0,0.3,function()
self.isMoveRight=not self.isMoveRight
self:freshBtns()
end)
end

function UIRoadTipsWin:onClickRightBtn()
self.rightmovebtn:setActive(false)
self.content:setChildDOLocalMoveX(-400,0.3,function()
self.isMoveRight=not self.isMoveRight
self:freshBtns()
end)
end

function UIRoadTipsWin:freshBtns()
self.leftmovebtn:setActive(self.isMoveRight);
self.rightmovebtn:setActive(not self.isMoveRight)
end

