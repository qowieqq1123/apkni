







def_class("UIDiscipleGongFaResultWin",UIWindowBase)









function UIDiscipleGongFaResultWin:bindComponents()

self.ButtonQuit=UIButton.get(self,0)
self.list=UIObject.get(self,1)
self.Background2=UIButton.get(self,2)

self.ButtonQuit:setButtonClick(function()self:onButtonQuit()end)

self.Background2:setButtonClick(function()self:onBackground2()end)



end


function UIDiscipleGongFaResultWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.ButtonQuit);self.ButtonQuit=nil;
_UIObject_release(self.list);self.list=nil;
_UIObject_release(self.Background2);self.Background2=nil;
end














local childKid={
root=-1,
frame=0,
icon=1,
name=2,
level=3,
}

local itemKid={
frame=0,
name=1,
show=2,
job=3,
list=4,
spDzFlag=5,
}
local _this=nil




function UIDiscipleGongFaResultWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIDiscipleGongFaResultWin:__delete()
self:unbindComponents()
_this=nil

end




function UIDiscipleGongFaResultWin:onShow(argtable,afterOnloaded)
self.callback=argtable.callback
self.datas=argtable.datas

self.info={}
for i,v in pairs(self.datas)do
table.insert(self.info,i)
end
self.dataCnt=#self.info
self.list:setChildLayoutGroupCreateItems(self.dataCnt)
for i,v in ipairs(self.info)do
self:initItem(i,v,self.datas[v])
end


end


function UIDiscipleGongFaResultWin:onHide()

end



function UIDiscipleGongFaResultWin:onButtonQuit()


self:onCloseHandle()
end

function UIDiscipleGongFaResultWin:onBackground2()
self:onCloseHandle()
end

function UIDiscipleGongFaResultWin:onCloseHandle()
local cb=self.callback
self:closeSelf()
if cb then
cb()
end
end

function UIDiscipleGongFaResultWin:initItem(index,guid,datas)
local item=self.list:getChildLayoutGroupGridItem(index-1)

local color=UIDiscipleModel:getDiscipleColor(guid)
item:SetChildCSImageSprite(itemKid.frame,globalABLookup.diciplecolorframe,discipleColorToFrame2[color])

local jobicon=UIDiscipleModel:getJobIconNameX(guid)
item:SetChildCSImageSprite(itemKid.job,globalABLookup.global,jobicon)

local isSpDz=UIDiscipleModel:isSPDiscipleEx(guid)
item:SetChildActive(itemKid.spDzFlag,isSpDz)

item:SetChildText(itemKid.name,UIDiscipleModel:getDiscipleName(guid))

local scale=0.65
comHelper.setChildModelRawImage(item,guid,itemKid.show,0,eHeadCenterType.eHead)




local dataCnt=#datas
item:SetChildLayoutGroupCreateItems(itemKid.list,dataCnt)
for i=1,dataCnt do
UIDiscipleGongFaResultWin:initChild(item,i,datas[i],guid)
end
end

function UIDiscipleGongFaResultWin:initChild(item,index,data,guid)
local gfID=data[1]
local oldValue=data[2]
local newValue=data[3]
local childItem=item:GetChildLayoutGroupGridItem(itemKid.list,index-1)
local gfCfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)
childItem:SetChildCSImageSprite(childKid.frame,globalABLookup.cangjingge,UIGongFaModel:getGFColorKuangIcon(gfCfg.color))
childItem:SetChildIcon(childKid.icon,iconHelper.getGongFaIcon(gfCfg.icon),false)
childItem:SetChildText(childKid.name,gfCfg.name)
childItem:SetChildText(childKid.level,FMT.fmt("等级：{0}",newValue))
childItem:SetChildButtonClick(childKid.root,function()
UIManager:showWindow('UIGongFaTipsTwoWin',{guid=guid,gfID=gfID,gfLevel=newValue})
end)
end





























