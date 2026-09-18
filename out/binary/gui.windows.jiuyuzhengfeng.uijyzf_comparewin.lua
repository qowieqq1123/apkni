







def_class("UIJYZF_CompareWin",UIWindowBase)









function UIJYZF_CompareWin:bindComponents()

self.compareScrollView=UILoopListView.new(self,0)
self.leftRoot=UIObject.get(self,1)
self.rightRoot=UIObject.get(self,2)
self.closeBtn=UIButton.get(self,3)
self.root=UIObject.get(self,4)

self.compareScrollView:bindLoopListView(function(...)
self:onFreshAction(...)
end,function(...)
self:onStartAction(...)
end)
self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIJYZF_CompareWin:unbindComponents()
local _UIObject_release=UIObject.release
self.compareScrollView:deleteSelf();self.compareScrollView=nil;
_UIObject_release(self.leftRoot);self.leftRoot=nil;
_UIObject_release(self.rightRoot);self.rightRoot=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.root);self.root=nil;
end















local rankItemIndex={
name=0,
rank=1,
num=2,
}

local compareItemIndex={
bg=0,
name=1,
leftNum=2,
rightNum=3,
leftFlag=4,
rightFlag=5,
}



function UIJYZF_CompareWin:onLoaded(...)
self:bindComponents()
self:delayDo(0.5,function()
if not self or self.isClose then
return
end
self.root:setChildCanvasGroupDOFade(1,0.5)
end)
self.requestCrossNameCallBack=function()
if self and not self.isClose then
self:CrossNameCallBack()
end
end
loginRequestUpdate:registerRequest(REQUEST_TYPE.eRequestCross,self.requestCrossNameCallBack)
end


function UIJYZF_CompareWin:__delete()
loginRequestUpdate:unregisterRequest(REQUEST_TYPE.eRequestCross,self.requestCrossNameCallBack)
self:unbindComponents()
end




function UIJYZF_CompareWin:onShow(argtable,afterOnloaded)
self.argtable=argtable
local leftRankInfo=argtable.leftRankInfo
local rightRankInfo=argtable.rightRankInfo
local leftWidget=self.leftRoot:getWidgetBase()
local rightWidget=self.rightRoot:getWidgetBase()
self:setRankInfo(leftWidget,leftRankInfo)
self:setRankInfo(rightWidget,rightRankInfo)
local cfg=cfg_xianyulevelscorecconfig()
local list={}
local leftCrossId=leftRankInfo.crossId
local rightCrossId=rightRankInfo.crossId
for i,v in pairs(cfg)do
local temp={}
temp.id=v.id
temp.name=v.name
temp.leftScore=JiuYuZhengFengModel:getScore(leftCrossId,v.id)
temp.rightScore=JiuYuZhengFengModel:getScore(rightCrossId,v.id)
if v.showType and v.showType==1 then
if temp.leftScore>0 or temp.rightScore>0 then
table.insert(list,temp)
end
else
table.insert(list,temp)
end
end
table.sort(list,function(a,b)
return a.id<b.id
end)
self.compareScrollView:initData("compareItem",list,#list)

end


function UIJYZF_CompareWin:onHide()

end

function UIJYZF_CompareWin:setRankInfo(widget,info)
local rank=info.rank
local crossId=info.crossId
local score=info.score
widget:SetChildText(rankItemIndex.name,loginModel:getCrossZoneName(crossId))
widget:SetChildText(rankItemIndex.rank,rank==-1 and"--"or rank)
widget:SetChildText(rankItemIndex.num,score)
end

function UIJYZF_CompareWin:onFreshAction(index,widget,data)
widget:SetChildText(compareItemIndex.name,data.name)
local leftFlag=data.leftScore>data.rightScore
local rightFlag=data.leftScore<data.rightScore
widget:SetChildActive(compareItemIndex.leftFlag,leftFlag)
widget:SetChildActive(compareItemIndex.rightFlag,leftFlag)

widget:SetChildText(compareItemIndex.leftNum,FMT.fmt("<color=#{0}>{1}</color>",leftFlag and"ca631d"or"161412",data.leftScore))
widget:SetChildText(compareItemIndex.rightNum,FMT.fmt("<color=#{0}>{1}</color>",rightFlag and"ca631d"or"161412",data.rightScore))
end

function UIJYZF_CompareWin:onStartAction(index,widget,data)
end

function UIJYZF_CompareWin:CrossNameCallBack()

local leftRankInfo=self.argtable.leftRankInfo
local rightRankInfo=self.argtable.rightRankInfo
local leftWidget=self.leftRoot:getWidgetBase()
local rightWidget=self.rightRoot:getWidgetBase()
self:setRankInfo(leftWidget,leftRankInfo)
self:setRankInfo(rightWidget,rightRankInfo)
end






function UIJYZF_CompareWin:onCloseBtn()
self:closeSelf()
end

