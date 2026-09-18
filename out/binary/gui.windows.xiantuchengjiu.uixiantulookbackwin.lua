







def_class("UIXianTuLookBackWin",UIWindowBase)









function UIXianTuLookBackWin:bindComponents()

self.background=UIButton.get(self,0)
self.root=UIObject.get(self,1)
self.pool=UIGameobjectClone.new(self,2)
self.content=UIObject.get(self,3)
self.list=UIObject.get(self,4)
self.closeBtn=UIButton.get(self,5)
self.scrollView=UIObject.get(self,6)
self.model=UIObject.get(self,7)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIXianTuLookBackWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.root);self.root=nil;
self.pool:deleteSelf();self.pool=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.list);self.list=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.model);self.model=nil;
end















local _this=nil
local _child={
[1]={"UIXianTuLookBackItem1",150},
[2]={"UIXianTuLookBackItem2",233},
[3]={"UIXianTuLookBackItem3",150},
}
local _width=1052
local _spacing=30
local _leftPad=15
local _rightPad=15



function UIXianTuLookBackWin:onLoaded(...)
self:bindComponents()
_this=self
local _beginDrag=function(index,pos)
self:beginDrag(pos)
end
local _onDrag=function(index,pos)
self:onDrag(pos)
end
local _endDrag=function(index,pos)
self:endDrag(pos)
end
self.winlua:SetChildUIDragEvent(self.scrollView:getID(),0,_beginDrag,_endDrag,_onDrag)

self.inited=false
self.root:setChildUIModelShowTarget(4220,1,{},eAnimationID.enter,false,false,0,function()
self:delayDo(0.36,function()
self.content:setActive(true)
self.inited=true
self:refreshModel()
end)
end)

xiantuchengjiuController.send_30_5()
end


function UIXianTuLookBackWin:__delete()
self.pool:recycleAll()
xiantuchengjiuModel:cleanLookBacks()
self:unbindComponents()
_this=nil
end




function UIXianTuLookBackWin:onShow(argtable,afterOnloaded)

end


function UIXianTuLookBackWin:onHide()

end




function UIXianTuLookBackWin:onBackground()
UIFullXianTuChengJiuControl:closeWindow("UIXianTuLookBackWin")
end


function UIXianTuLookBackWin:onCloseBtn()
UIFullXianTuChengJiuControl:closeWindow("UIXianTuLookBackWin")
end

function UIXianTuLookBackWin:refreshModel()
local temp=UIDiscipleModel:getDiscipleByZongMenPost(eZongMenPostType.eZhangMen)or{}
local firstData=temp[1]or UIDiscipleModel:findSrcTypeDisciple(discipleSrcType.ePlot1)

local modelParams=UIDiscipleModel:getDiscipleOutsideModelInfo(firstData.discipleguid,false,1)
self.model:setChildUIModelShowTarget(modelParams.body,modelParams.scale,modelParams.componets,eAnimationID.stand,false,false,0)
self.model:setChildUIModelShowFlipX(true)
end

function UIXianTuLookBackWin:refreshList()
self.pool:recycleAll()
local datas=xiantuchengjiuModel:getLookBacks()
local parentIdx=self.list:getID()
local w=nil
for i,v in ipairs(datas)do
local typo=v.type
local child=_child[typo]
local name=child[1]
self.pool:createObject(name,parentIdx,i,v,true)
if w then
w=w+child[2]+_spacing
else
w=child[2]
end
end
if w and w>_width then
self.list:setAnchors(1,0.5,1,0.5)
end
end

function UIXianTuLookBackWin:beginDrag(pos)
if self.inited then
self.model:setChildModelAnimationState(eAnimationID.run)
end
end

function UIXianTuLookBackWin:onDrag(pos)
end

function UIXianTuLookBackWin:endDrag(pos)
if self.inited then
self.model:setChildModelAnimationState(eAnimationID.stand)
end
end