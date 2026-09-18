







def_class("UIZhengTaoMoJiangFinishWin",UIWindowBase)









function UIZhengTaoMoJiangFinishWin:bindComponents()

self.background=UIButton.get(self,0)
self.button_1=UIButton.get(self,1)
self.button_2=UIButton.get(self,2)
self.button_3=UIButton.get(self,3)
self.button_4=UIButton.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.effect=UIObject.get(self,6)
self.root=UIObject.get(self,7)
self.spine=UIObject.get(self,8)

self.background:setButtonClick(function()self:onBackground()end)

self.button_1:setButtonClick(function()self:onButton_1()end)

self.button_2:setButtonClick(function()self:onButton_2()end)

self.button_3:setButtonClick(function()self:onButton_3()end)

self.button_4:setButtonClick(function()self:onButton_4()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)
self.button={
self.button_1,
self.button_2,
self.button_3,
self.button_4,
}



end


function UIZhengTaoMoJiangFinishWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.button_1);self.button_1=nil;
_UIObject_release(self.button_2);self.button_2=nil;
_UIObject_release(self.button_3);self.button_3=nil;
_UIObject_release(self.button_4);self.button_4=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.spine);self.spine=nil;
self.button=nil;
end















local _this=nil



function UIZhengTaoMoJiangFinishWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIZhengTaoMoJiangFinishWin:__delete()
self:unbindComponents()
_this=nil
end




function UIZhengTaoMoJiangFinishWin:onShow(argtable,afterOnloaded)
self.seasonType=argtable.seasonType
self.stageIndex=argtable.stageIndex
local params=seasonModel:getStageConfigEx(argtable.seasonType,argtable.stageIndex,"finishWinParam")
self.effect:setChildShowEffect(params[2],true)
self.spine:setChildUIModelShowTarget(params[1],1,defaultT,eAnimationID.enter,false,false,0,function()
self.root:setActive(true)
end)
self.dataList=xianjieModel:getMoJiangSortList(argtable.seasonType,argtable.stageIndex)
xianjieModel:setMoJiangFinishFlag(argtable.seasonType,argtable.stageIndex)
end


function UIZhengTaoMoJiangFinishWin:onHide()

end




function UIZhengTaoMoJiangFinishWin:onBackground()

end

function UIZhengTaoMoJiangFinishWin:onCloseBtn()
self:closeSelf()
end

function UIZhengTaoMoJiangFinishWin:onButton_1()
self:jumpMoJiang(1)
end

function UIZhengTaoMoJiangFinishWin:onButton_2()
self:jumpMoJiang(2)
end

function UIZhengTaoMoJiangFinishWin:onButton_3()
self:jumpMoJiang(3)
end

function UIZhengTaoMoJiangFinishWin:onButton_4()
self:jumpMoJiang(4)
end

function UIZhengTaoMoJiangFinishWin:jumpMoJiang(index)
local data=self.dataList[index]
local build_id=data.id
jumpManager:jump({id=JUMP_TYPE.eMoJiang,args={seasonType=self.seasonType,stageIndex=self.stageIndex,build_id=build_id}})
end