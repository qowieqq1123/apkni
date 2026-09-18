







def_class("UISystemZongMenZYFailureWin2",UIWindowBase)









function UISystemZongMenZYFailureWin2:bindComponents()

self.afterTx_1=UIText.get(self,0)
self.afterTx_2=UIText.get(self,1)
self.background=UIButton.get(self,2)
self.cage_1=UIObject.get(self,3)
self.disModel=UIObject.get(self,4)
self.beforeTx_1=UIText.get(self,5)
self.beforeTx_2=UIText.get(self,6)
self.cage_2=UIObject.get(self,7)
self.negotiateBtn=UIButton.get(self,8)
self.icon_2=UIObject.get(self,9)
self.icon_1=UIObject.get(self,10)
self.tipsTx=UIText.get(self,11)
self.speGrid=UIObject.get(self,12)

self.background:setButtonClick(function()self:onBackground()end)

self.negotiateBtn:setButtonClick(function()self:onNegotiateBtn()end)
self.afterTx={
self.afterTx_1,
self.afterTx_2,
}
self.cage={
self.cage_1,
self.cage_2,
}
self.beforeTx={
self.beforeTx_1,
self.beforeTx_2,
}
self.icon={
self.icon_1,
self.icon_2,
}



end


function UISystemZongMenZYFailureWin2:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.afterTx_1);self.afterTx_1=nil;
_UIObject_release(self.afterTx_2);self.afterTx_2=nil;
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.cage_1);self.cage_1=nil;
_UIObject_release(self.disModel);self.disModel=nil;
_UIObject_release(self.beforeTx_1);self.beforeTx_1=nil;
_UIObject_release(self.beforeTx_2);self.beforeTx_2=nil;
_UIObject_release(self.cage_2);self.cage_2=nil;
_UIObject_release(self.negotiateBtn);self.negotiateBtn=nil;
_UIObject_release(self.icon_2);self.icon_2=nil;
_UIObject_release(self.icon_1);self.icon_1=nil;
_UIObject_release(self.tipsTx);self.tipsTx=nil;
_UIObject_release(self.speGrid);self.speGrid=nil;
self.afterTx=nil;
self.cage=nil;
self.beforeTx=nil;
self.icon=nil;
end
















local _this=nil




function UISystemZongMenZYFailureWin2:onLoaded(...)
self:bindComponents()
_this=self
end


function UISystemZongMenZYFailureWin2:__delete()
self:unbindComponents()
_this=nil
end




function UISystemZongMenZYFailureWin2:onShow(argtable,afterOnloaded)
self.callback=argtable.callback
self.disciple=argtable.disciple
self.attrs=argtable.attrs
self.special=argtable.special
self.result=argtable.result
self.serial=argtable.serial


local cmp=self.disModel:getID()
local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(self.disciple)
self.winlua:SetChildUIModelShowTarget(cmp,modelParams.body,0.8,modelParams.componets,eAnimationID.stand)
self.winlua:SetChildUIModelShowFlipX(cmp,true)

for i,v in ipairs(self.beforeTx)do
local attrData=self.attrs[i]
v:setActive(attrData~=nil)
if attrData then
local beforeStr=FMT.fmt("{0}{1}",attrData[1],attrData[2])
v:setText(beforeStr)
local av=self.afterTx[i]
if av then
local afterStr=FMT.fmt("{0}",attrData[3])
av:setText(afterStr)
end
end
end

local gridId=self.speGrid:getID()
self.winlua:SetChildLayoutGroupCreateItems(gridId,#self.special,function(idx)
local speitem=self.winlua:GetChildLayoutGroupGridItem(gridId,idx-1)
local spedata=self.special[idx]
local specfg=UIDiscipleModel:getSpecialityConfig(spedata[1],spedata[2])
UIDiscipleModel.refreshSpecialityItemExx(speitem,specfg)
speitem:SetChildButtonClick(1,function()
self:onSpecialClick(speitem,self.disciple,specfg)
end)
end)

local catch=self.result==systemZongMenResultType.eCapture
self.negotiateBtn:setActive(catch)
for i,v in ipairs(self.cage)do
v:setActive(catch)
end
self.icon_1:setActive(not catch)
self.icon_2:setActive(catch)
self.tipsTx:setActive(not catch)

UIManager:closeWindow("UISystemZongMenZaoYaoWin")
UIManager:closeWindow("UISystemZongMenZaoYaoSelectWin")
UIManager:closeWindow("UISystemZongMenTaYinWin")
UIManager:closeWindow("UISystemZongMenTaYinWin1")
end


function UISystemZongMenZYFailureWin2:onHide()

end




function UISystemZongMenZYFailureWin2:onBackground()
if self.callback then
self.callback()
else
self:closeSelf()
end
end


function UISystemZongMenZYFailureWin2:onNegotiateBtn()
UIFullSystemZongMenControl:showWindow("UISystemZongMenRansomWin",{serial=self.serial})
self:onBackground()
end

function UISystemZongMenZYFailureWin2:onSpecialClick(speitem,discipleguid,cfg)
if _this==nil then return end
UIFullSystemZongMenControl:showWindow('UISpecialityWin',{item=speitem,node='bottom',guid=discipleguid,config=cfg})
end
