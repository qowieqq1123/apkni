







def_class("UISystemZongMenVassalRewardWin",UIWindowBase)









function UISystemZongMenVassalRewardWin:bindComponents()

self.background=UIButton.get(self,0)
self.arrow=UIObject.get(self,1)
self.root=UIObject.get(self,2)
self.ScrollView=UIObject.get(self,3)
self.infoList=UIObject.get(self,4)

self.background:setButtonClick(function()self:onBackground()end)



end


function UISystemZongMenVassalRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.arrow);self.arrow=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
_UIObject_release(self.infoList);self.infoList=nil;
end















local _this=nil
local _itemCmp={
name=0,
button=1,
}



function UISystemZongMenVassalRewardWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onSystemZMInit,self.onSystemZMInit)
self:addNotify(notifyConfig.onSystemZMVassalRewardChange,self.onSystemZMVassalRewardChange)
end


function UISystemZongMenVassalRewardWin:__delete()
self:unbindComponents()
_this=nil
end




function UISystemZongMenVassalRewardWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin
self.arrow:setChildAnchoredPosition(argtable.arrow)
self:refreshView()
end


function UISystemZongMenVassalRewardWin:onHide()

end





function UISystemZongMenVassalRewardWin:onBackground()
if self.parentWin then
self.parentWin:closeWindow(self.__name)
else
UIManager:closeWindow(self.__name)
end
end

function UISystemZongMenVassalRewardWin:refreshView()
local infoList=systemZongMenModel:getInfoList()
local dataList={}
for i,v in ipairs(infoList)do
if v.sg_reward_num>0 then
table.insert(dataList,v)
end
end
if#dataList>0 then
self.infoList:setChildLayoutGroupCreateItems(#dataList,function(index)
local item=self.infoList:getChildLayoutGroupGridItem(index-1)
local infoData=dataList[index]
local nameStr=systemZongMenModel:getNameStr(infoData.id,infoData.nameIdx)
item:SetChildText(_itemCmp.name,nameStr)
item:SetChildButtonClick(_itemCmp.button,function()
if infoData.sg_reward_num>0 then
systemZongMenController:req_reward_vassal(1,{infoData.serial})
end
end)
end)
local height=Mathf.Clamp(7.5+#dataList*102.5,0,500)
self.root:setChildSizeDelta(422,height)
self.ScrollView:setChildScrollRectEnable(height>=500)
else
self:onBackground()
end
end

function UISystemZongMenVassalRewardWin.onSystemZMInit()
_this:refreshView()
end

function UISystemZongMenVassalRewardWin.onSystemZMVassalRewardChange(serial,oldNum,newNum)
if oldNum>0 and newNum<=0 then
_this:refreshView()
elseif oldNum<=0 and newNum>0 then
_this:refreshView()
end
end