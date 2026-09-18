







def_class("tipsChildGongFaCollect",UICloneObject)





tipsChildGongFaCollect.abName="ui/windows/tips/child/tipschildgongfacollect.ab"

tipsChildGongFaCollect.assetName="tipsChildGongFaCollect"


function tipsChildGongFaCollect:bindComponents()

self.guanlian=UIObject.get(self,0)
self.guanlianname=UIText.get(self,1)
self.pageGrid=UIObject.get(self,2)
self.title=UIObject.get(self,3)

end


function tipsChildGongFaCollect:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.guanlian);self.guanlian=nil;
_UIObject_release(self.guanlianname);self.guanlianname=nil;
_UIObject_release(self.pageGrid);self.pageGrid=nil;
_UIObject_release(self.title);self.title=nil;
end







function tipsChildGongFaCollect:onLoaded(...)
self:bindComponents()
end


function tipsChildGongFaCollect:__delete()
self:unbindComponents()
end


function tipsChildGongFaCollect:onHide()

end




function tipsChildGongFaCollect:onShow(argtable,afterOnloaded)
local data=argtable.argtable
local childType=argtable.childType
local nodeidx=argtable.nodeidx
local itemid=data.itemid
local itemguid=data.itemguid
local attach=data.attach

local gfID=gongfaLookup:checkGongfaPiece(itemid)
if gfID==nil or UIGongFaModel:isGongFaDefaultActive(gfID)then

self:recycleSelf()
return
end
local glflag=liandonModel:JudeGuanLianGFisActive(gfID)
self.guanlian:setActive(glflag)
self.pageGrid:setActive(not glflag)
if not glflag then
local pieces=cfgHelper.get2(cfg_disciplegongfaconfig_get,gfID,'piece')
local num=#pieces
local pageGrid=self.pageGrid:getChildCommonLayoutGroupWidgetList()

for i=1,3 do
local item=pageGrid[i-1]
local s=i<=num
item:SetChildActive(0,s)
if s then
local active=UIGongFaModel:isPageActiveEx(gfID,i)
local pagename=itemsConfig.getItemName(pieces[i][1])
if active then
pagename=string.format('<color=#76d81e>%s</color>',pagename)
end
item:SetChildText(0,pagename)
item:SetChildActive(1,active)
end
end
else
local glid=liandonModel:CheckGongFa_Guanlian(gfID)
local gfname=cfgHelper.get2(cfg_disciplegongfaconfig_get,glid,'name')
self.guanlianname:setText(string.format("<color=#f36666>已激活异世功法：%s</color>",gfname))
end

end

