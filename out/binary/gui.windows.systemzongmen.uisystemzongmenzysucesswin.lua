







def_class("UISystemZongMenZYSucessWin",UIWindowBase)









function UISystemZongMenZYSucessWin:bindComponents()

self.background=UIButton.get(self,0)
self.Content=UIObject.get(self,1)

self.background:setButtonClick(function()self:onBackground()end)



end


function UISystemZongMenZYSucessWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.Content);self.Content=nil;
end
















local _this=nil
local _count=3
local _itemCmp={
dis_back=0,
dis_name=1,
dis_show=2,
infoTx1=3,
infoTx2=4,
infoRoot=5,
}




function UISystemZongMenZYSucessWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISystemZongMenZYSucessWin:__delete()
self:unbindComponents()
_this=nil
end




function UISystemZongMenZYSucessWin:onShow(argtable,afterOnloaded)
self.list=argtable.list
self.callback=argtable.callback
local cmpId=self.Content:getID()
self.winlua:SetChildLayoutGroupCreateItems(cmpId,#self.list,function(idx)
local item=self.winlua:GetChildLayoutGroupGridItem(cmpId,idx-1)
local data=self.list[idx]
local discipleData=data.disciple
local deltaValue=data.value

local imageInfo=UIDiscipleModel:getDiscipleImageInfoEx(discipleData)
local color=imageInfo.color
item:SetChildCSImageSprite(_itemCmp.dis_back,globalABLookup.diciplecolorframe,discipleColorToFrame[color])

item:SetChildText(_itemCmp.dis_name,data.disciple.disciplename)

local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoEx(discipleData)
comHelper.setChildModelRawImageEx(_itemCmp.dis_show,item,modelParams,eHeadCenterType.eHead)

item:SetChildText(_itemCmp.infoTx1,FMT.fmt("忠诚<color=#171311>{0}</color>",discipleData.loyalty))
item:SetChildText(_itemCmp.infoTx2,FMT.fmt("{0}",deltaValue))
item:ForceLayoutRect(_itemCmp.infoRoot)
end)
end


function UISystemZongMenZYSucessWin:onHide()

end




function UISystemZongMenZYSucessWin:onBackground()
if self.callback then
self.callback()
else
self:closeSelf()
end
end

