







def_class("UIFightPrepareTianMoRuQinTeXingWin",UIWindowBase)









function UIFightPrepareTianMoRuQinTeXingWin:bindComponents()

self.skillList=UIObject.get(self,0)
self.background=UIImage.get(self,1)
self.tips=UIText.get(self,2)



end


function UIFightPrepareTianMoRuQinTeXingWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.skillList);self.skillList=nil;
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.tips);self.tips=nil;
end















local _this=nil
local _itemCmp={
icon=0,
sign=1,
lvText=2,
click=3,
lv=4,
lock=5,
awake=6,
}



function UIFightPrepareTianMoRuQinTeXingWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIFightPrepareTianMoRuQinTeXingWin:__delete()
self:unbindComponents()
_this=nil
end










function UIFightPrepareTianMoRuQinTeXingWin:onShow(argtable,afterOnloaded)
local tipsStr=argtable.title
self.tips:setText(tipsStr or"")

self.skillList:setChildLayoutGroupCreateItems(#argtable.data,function(index)
local item=self.skillList:getChildLayoutGroupGridItem(index-1)
local data=argtable.data[index]
local dataType=data[1]
local dataParam=data[2]
local handleName=FMT.fmt("setItem{0}",dataType)
self[handleName](self,index,item,dataParam)
end)
end


function UIFightPrepareTianMoRuQinTeXingWin:onHide()

end



function UIFightPrepareTianMoRuQinTeXingWin:setItem1(index,item,param)
local skillID=param[1]
local skillLv=param[2]
local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillID)
local iconName=iconHelper.getSkillIcon(skillCfg.icon)
item:SetChildIcon(_itemCmp.icon,iconName,false)
local is_bd=skillModel.isSkillBD(skillCfg.skillType)
item:SetChildActive(_itemCmp.sign,is_bd)
item:SetChildButtonClick(_itemCmp.click,function()
local x=-90
local y=-150-(index-1)*110
local args={
name=skillCfg.name,
icon=iconName,
desc=skillModel:getSkillDesc(skillID,skillLv),
bottomLeft=is_bd and{globalABLookup.global,"icon_jnbeidong"}or nil,
rootPoint={
anchorsMin=Vector2.one,
anchorsMax=Vector2.one,
pivot=Vector2.one,
anchoredPosition=Vector2.New(x,y)
}
}
UIManager:showWindow('UISimpleTeXingTipsWin',args)
end)
end

function UIFightPrepareTianMoRuQinTeXingWin:setItem2(index,item,param)
local fazeID=param[1]
local fazeLv=param[2]
local fazeCfg=cfgHelper.getSSlawRule(fazeID)
local desc=fazeCfg.descparm and string.format(fazeCfg.desc,unpack(fazeCfg.descparm[fazeLv]))or fazeCfg.desc
item:SetChildIcon(_itemCmp.icon,fazeCfg.image,false)
item:SetChildButtonClick(_itemCmp.click,function()
local x=-87
local y=-140-(index-1)*83
local args={
name=fazeCfg.name,
icon=fazeCfg.image,
desc=desc,
bottomLeft=nil,
rootPoint={
anchorsMin=Vector2.one,
anchorsMax=Vector2.one,
pivot=Vector2.one,
anchoredPosition=Vector2.New(x,y)
}
}
UIManager:showWindow('UISimpleTeXingTipsWin',args)
end)
end