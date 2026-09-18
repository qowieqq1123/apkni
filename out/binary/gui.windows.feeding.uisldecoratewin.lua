







def_class("UISLDecorateWin",UIWindowBase)









function UISLDecorateWin:bindComponents()

self.scrollview=UIObject.get(self,0)
self.icon=UIImage.get(self,1)
self.name=UIText.get(self,2)
self.desc=UIText.get(self,3)
self.remove=UIButton.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.add=UIObject.get(self,6)
self.decorateGroup=UIObject.get(self,7)

self.remove:setButtonClick(function()self:onRemove()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISLDecorateWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.scrollview);self.scrollview=nil;
_UIObject_release(self.icon);self.icon=nil;
_UIObject_release(self.name);self.name=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.remove);self.remove=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.add);self.add=nil;
_UIObject_release(self.decorateGroup);self.decorateGroup=nil;
end



















function UISLDecorateWin:onLoaded(...)
self:bindComponents()

self.scrollview:setChildScrollViewInit(0.5,true,nil,nil)
end


function UISLDecorateWin:__delete()
self:unbindComponents()
end




function UISLDecorateWin:onShow(argtable,afterOnloaded)
self.bdData=argtable
self.slData=UIShouLanModel:getShouLanData(self.bdData.un_build_id)
self:refresh()

end


function UISLDecorateWin:onHide()

end

function UISLDecorateWin:setInfo()
if self.currSelectIdx then
local itemId=self.datas[self.currSelectIdx]
local cfg=cfgHelper.get(cfg_petdecorateconfig_get,itemId)
self.icon:setIcon(iconHelper.getIconName(itemId),true)
self.name:setText(cfg.name)
self.desc:setText(cfg.desc)
self.remove:setActive(true)
self.add:setActive(false)
else
self.icon:setIcon("",false)
self.name:setText('暂无装饰')
self.desc:setText('')
self.remove:setActive(false)
self.add:setActive(true)
end
end

function UISLDecorateWin:getDatas()
local currId=self.slData.decorate_id
local cfgs=cfg_petdecorateconfig()
local list={}
for k,v in pairs(cfgs)do
local count=bagModel.getItemCountById(k)
if count>0 then

for i=1,count do
table.insert(list,k)
end
end
end

table.sort(list,function(a,b)
return a<b
end)

if currId and currId>0 then
table.insert(list,1,currId)
self.currSelectIdx=1
else
self.currSelectIdx=nil
end

return list
end

function UISLDecorateWin:refresh()

self:refreshDecorateGroup()
self:setInfo()
end











































function UISLDecorateWin:refreshDecorateGroup()
local datas=self:getDatas()
self.datas=datas
local len=#datas
self.decorateGroup:setChildLayoutGroupCreateItems(len,function(i)
local widget=self.decorateGroup:getChildLayoutGroupGridItem(i-1)
local itemId=datas[i]

local cfg=cfgHelper.get(cfg_petdecorateconfig_get,itemId)
if cfg then
widget:SetChildActive(-1,true)

widget:SetChildText(1,cfg.name)
widget:SetChildText(2,cfg.desc)
widget:SetChildButtonClick(3,function()
self:changeDecorate(itemId)
end)
local isSelect=i==self.currSelectIdx

widget:SetChildActive(3,not isSelect)
widget:SetChildActive(4,isSelect)
widget:SetChildActive(5,isSelect)
widget:SetChildActive(6,not isSelect)

local itemWidget=widget:GetChildWidgetBase(0)
local countStr=""
local showCountBG=false
local conf={itemid=itemId,itemcount=countStr,showCountBG=showCountBG,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
itemWidget:SetChildActive(-1,true)
itemWidget:SetChildPropData(0,prop)
else
widget:SetChildActive(-1,false)
end
end)
end


function UISLDecorateWin:changeDecorate(dId)
if self.slData.decorate_id==dId then
local cfg=cfgHelper.get(cfg_petdecorateconfig_get,dId)
local name=cfg.name
UIManager.error(FMT.fmt("当前已放置{0},无法再次放置",name))
return
end
if dId>0 then
local count=bagModel.getItemCountById(dId)
if count<=0 then
local name=itemsConfig.getItemName(dId)
UIManager.error(FMT.fmt('{0}不足',name))
return
end
end
if self.slData.decorate_id>0 then
UIShouLanControl:reqChangeShouLanDecorate(self.bdData.un_build_id,0)
end
UIShouLanControl:reqChangeShouLanDecorate(self.bdData.un_build_id,dId)
end

function UISLDecorateWin:selectDecorateById(id)










return self:refresh()
end




























function UISLDecorateWin:onRemove()
if self.slData.decorate_id>0 then
UIShouLanControl:reqChangeShouLanDecorate(self.bdData.un_build_id,0)
end
end

function UISLDecorateWin:onCloseBtn()
return self:onCloseClick()
end

function UISLDecorateWin:onCloseClick()
self:closeSelf()
end