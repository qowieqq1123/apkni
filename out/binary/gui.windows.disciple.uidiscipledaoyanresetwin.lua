







def_class("UIDiscipleDaoYanResetWin",UIWindowBase)









function UIDiscipleDaoYanResetWin:bindComponents()

self.CancelBtn=UIButton.get(self,0)
self.cancelTxt=UIText.get(self,1)
self.closeButton=UIButton.get(self,2)
self.Content=UIObject.get(self,3)
self.ContinueBtn=UIButton.get(self,4)
self.costTips=UILinkImageText.get(self,5)
self.desc=UIText.get(self,6)
self.resetTxt=UIText.get(self,7)
self.ScrollView=UIObject.get(self,8)

self.CancelBtn:setButtonClick(function()self:onCancelBtn()end)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIDiscipleDaoYanResetWin")end)

self.ContinueBtn:setButtonClick(function()self:onContinueBtn()end)



end


function UIDiscipleDaoYanResetWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.CancelBtn);self.CancelBtn=nil;
_UIObject_release(self.cancelTxt);self.cancelTxt=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.Content);self.Content=nil;
_UIObject_release(self.ContinueBtn);self.ContinueBtn=nil;
_UIObject_release(self.costTips);self.costTips=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.resetTxt);self.resetTxt=nil;
_UIObject_release(self.ScrollView);self.ScrollView=nil;
end



















function UIDiscipleDaoYanResetWin:onLoaded(...)
self:bindComponents()

local _onDiscipleDaoYanLvReset=function()
self:onCloseButton()
end
self:addNotify(notifyConfig.onDiscipleDaoYanLvReset,_onDiscipleDaoYanLvReset)
end


function UIDiscipleDaoYanResetWin:__delete()
self:unbindComponents()
end




function UIDiscipleDaoYanResetWin:onShow(argtable,afterOnloaded)

self.cost=argtable.resetCost

self.content=argtable.content
self.cancelBtnTxt=argtable.cancelBtnTxt or"取消"
self.resetBtnTxt=argtable.resetBtnTxt or"重置"
self.tips=argtable.tips

self.cancelCallBack=argtable.cancelCallBack
self.resetCallBack=argtable.resetCallBack

self.desc:setText(self.content)
self.cancelTxt:setText(self.cancelBtnTxt)
self.resetTxt:setText(self.resetBtnTxt)
self.costTips:setText(self.tips)

self.resetRewardList=argtable.resetRewardList

self:freshInfo()
end


function UIDiscipleDaoYanResetWin:onHide()

end


function UIDiscipleDaoYanResetWin:freshInfo()
if self.resetRewardList then

local propData={}
for i,v in ipairs(self.resetRewardList)do
local num=v.itemcount
table.insert(propData,itemsComponentHelper.getCommonFillData({itemid=v.itemid,itemcount=num},{showname=false,showcount=num>1,showCountBG=num>1,showStageBg=true}))
end

local propDataCnt=#propData
if propDataCnt>0 then
self.gridAnim=true
end
self.propData=propData
local cnt=propDataCnt

self.ScrollView:setChildScrollViewDelayCreateGrids(propDataCnt,12,0.1,1,false,false,function(id,item)
if id+1>=propDataCnt then
self.gridAnim=nil
end
self:refreshItem(id,item,propData)
end)

if cnt<=6 then
self.winlua:SetChildSizeDelta(self.Content:getID(),cnt*90-8,82)
self.Content:setAnchors(0.5,0.5,0.5,0.5)
else
self.winlua:SetChildSizeDelta(self.Content:getID(),532,172)
end
end
end

function UIDiscipleDaoYanResetWin:refreshItem(id,item,propData)
item:SetChildPropData(0,propData[id+1])
item:SetChildCanvasGroupDOFade(1,1,0.1)
item:SetBaseItemClickEvent(0,itemsComponentHelper.onItemClick)
end


function UIDiscipleDaoYanResetWin:onHide()

end





function UIDiscipleDaoYanResetWin:onContinueBtn()
local func=function()
if self.resetCallBack then
self.resetCallBack()
end
end
if self.cost then
itemsModel:useItemlist(self.cost,func,WARNING_TYPE.eWarning)
else
func()
end
end

function UIDiscipleDaoYanResetWin:onCancelBtn()
if self.cancelCallBack then
self.cancelCallBack()
end
self:onCloseButton()
end

function UIDiscipleDaoYanResetWin:onCloseButton()
self:closeSelf()
end
