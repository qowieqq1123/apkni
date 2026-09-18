







def_class("UIGongFaForgetWin",UIWindowBase)









function UIGongFaForgetWin:bindComponents()

self.gfItem=UIObject.get(self,0)
self.tipsText=UIText.get(self,1)
self.descText=UIText.get(self,2)



end


function UIGongFaForgetWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.gfItem);self.gfItem=nil;
_UIObject_release(self.tipsText);self.tipsText=nil;
_UIObject_release(self.descText);self.descText=nil;
end

















function UIGongFaForgetWin:onLoaded(...)
self:bindComponents()
end


function UIGongFaForgetWin:__delete()
self:unbindComponents()
end


function UIGongFaForgetWin:onHide()

end




function UIGongFaForgetWin:onShow(argtable,afterOnloaded)
self.disciple_guid=argtable.guid
self.gfID=argtable.gfID

self.discipleGFNetData=UIDiscipleModel:getDiscipleGFData(self.disciple_guid,self.gfID)

self:refreshView()
end

function UIGongFaForgetWin:refreshView()

local gfName=cfgHelper.get2(cfg_disciplegongfaconfig_get,self.gfID,'name')
local tips_str=FMT.fmt('确定让弟子遗忘“<color=#c82c2c>{0}</color>”吗',gfName)
self.tipsText:setText(tips_str)


local gfItemWidget=self.gfItem:getChildWidgetBase()
local cfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,self.gfID)
local colorIcon=UIGongFaModel:getGFColorKuangIcon(cfg.color)
gfItemWidget:SetChildCSImageSprite(0,globalABLookup.cangjingge,colorIcon)
gfItemWidget:SetChildIcon(1,iconHelper.getGongFaIcon(cfg.icon),false)
gfItemWidget:SetChildText(2,cfg.name)

local gfLv=self.discipleGFNetData.param_2
local lv_str=UIGongFaModel:getGFLeverlStr(gfLv)
gfItemWidget:SetChildText(3,lv_str)

local elements=UIGongFaModel:getGFElements(self.gfID)
local elementid=elements[1]
local elementIcon=ELEMENT_TYPE.getIcon(elementid)
gfItemWidget:SetChildCSImageSprite(4,globalABLookup.global,elementIcon)
gfItemWidget:SetChildText(5,ELEMENT_TYPE.getNameGF(elementid))


local back=UIGongFaModel:getDZForgetPoint(self.disciple_guid,self.gfID,gfLv)
local desc_str=FMT.fmt('遗忘可获得传道点数：{0}',back)
self.descText:setText(desc_str)
end

function UIGongFaForgetWin:onForgetClick()
UIGongFaController:reqDiscipleForget(self.disciple_guid,self.gfID)
self:closeSelf()
end