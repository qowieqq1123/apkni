







def_class("UIXianJieClickEntityListWin",UIWindowBase)









function UIXianJieClickEntityListWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.entityList=UIObject.get(self,2)
self.entityView=UIObject.get(self,3)
self.root=UIObject.get(self,4)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXianJieClickEntityListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.entityList);self.entityList=nil;
_UIObject_release(self.entityView);self.entityView=nil;
_UIObject_release(self.root);self.root=nil;
end















local _this=nil



function UIXianJieClickEntityListWin:onLoaded(...)
self:bindComponents()
_this=self

self:addNotify(notifyConfig.onXianJieEntityRemove,self.onXianJieEntityRemove)
end


function UIXianJieClickEntityListWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianJieClickEntityListWin:onShow(argtable,afterOnloaded)
self.datas=argtable.clickDatas
self:refreshView()
end


function UIXianJieClickEntityListWin:onHide()

end




function UIXianJieClickEntityListWin:onBackground()
self:onCloseBtn()
end

function UIXianJieClickEntityListWin:onCloseBtn()
self:closeSelf()
end

function UIXianJieClickEntityListWin:refreshView()
self.entityList:setChildLayoutGroupCreateItems(#self.datas,function(index)
local item=self.entityList:getChildLayoutGroupGridItem(index-1)
local clickData=self.datas[index]
local boxParams=clickData.args
local paramsCnt=#boxParams
local ent_key=boxParams[paramsCnt]
local ent=xianjieController:getEntity(ent_key)
item:SetChildButtonClick(-1,function()
self:onClickItem(index)
end)
local stage=ent.stage
local name=ent:getName()or"未知物体"
local nameStr=stage and FMT.fmt("{0}阶 {1}",stage,name)or name
item:SetChildText(0,nameStr)
end)
self.entityView:setChildScrollRectEnable(#self.datas>=3)
end

function UIXianJieClickEntityListWin:onClickItem(index)
local clickData=self.datas[index]
local clickPos=clickData.pos
local boxParams=clickData.args
local paramsCnt=#boxParams
local ent_key=boxParams[paramsCnt]
local entityType=boxParams[paramsCnt-1]
local ent=xianjieController:getEntity(ent_key)
if ent then
local priority=xianjieController:getClickEntityPriorityTypes(entityType)
if priority then
self:onCloseBtn()
ent:onClick(boxParams,clickPos)
else
ent:onClick(boxParams,clickPos)
end
else
UIManager.info("目标已消失")
self:onCloseBtn()
end
end

function UIXianJieClickEntityListWin.onXianJieEntityRemove(key,entityType,data)
local _index=nil
for index,clickData in ipairs(_this.datas)do
local boxParams=clickData.args
local paramsCnt=#boxParams
local ent_key=boxParams[paramsCnt]
if key==ent_key then
_index=index
end
end
table.remove(_this.datas,_index)
if#_this.datas>0 then
_this:refreshView()
else
_this:onCloseBtn()
end
end