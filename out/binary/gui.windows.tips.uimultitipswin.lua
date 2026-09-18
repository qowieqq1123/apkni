







def_class("UIMultiTipsWin",UIWindowBase)









function UIMultiTipsWin:bindComponents()

self.bg=UIButton.get(self,0)
self.creater=UIGameobjectClone.new(self,1)
self.createrExt=UIGameobjectClone.new(self,2)
self.nodeTips_1=UIObject.get(self,3)
self.nodeTips_2=UIObject.get(self,4)
self.nodeTips_3=UIObject.get(self,5)
self.nodeTips_4=UIObject.get(self,6)
self.nodeTips_5=UIObject.get(self,7)
self.nodeTips_6=UIObject.get(self,8)
self.nodeExt_1=UIObject.get(self,9)
self.nodeExt_2=UIObject.get(self,10)
self.nodeExt_3=UIObject.get(self,11)
self.root=UIObject.get(self,12)

self.bg:setButtonClick(function()self:onBg()end)
self.nodeTips={
self.nodeTips_1,
self.nodeTips_2,
self.nodeTips_3,
self.nodeTips_4,
self.nodeTips_5,
self.nodeTips_6,
}
self.nodeExt={
self.nodeExt_1,
self.nodeExt_2,
self.nodeExt_3,
}



end


function UIMultiTipsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.bg);self.bg=nil;
self.creater:deleteSelf();self.creater=nil;
self.createrExt:deleteSelf();self.createrExt=nil;
_UIObject_release(self.nodeTips_1);self.nodeTips_1=nil;
_UIObject_release(self.nodeTips_2);self.nodeTips_2=nil;
_UIObject_release(self.nodeTips_3);self.nodeTips_3=nil;
_UIObject_release(self.nodeTips_4);self.nodeTips_4=nil;
_UIObject_release(self.nodeTips_5);self.nodeTips_5=nil;
_UIObject_release(self.nodeTips_6);self.nodeTips_6=nil;
_UIObject_release(self.nodeExt_1);self.nodeExt_1=nil;
_UIObject_release(self.nodeExt_2);self.nodeExt_2=nil;
_UIObject_release(self.nodeExt_3);self.nodeExt_3=nil;
_UIObject_release(self.root);self.root=nil;
self.nodeTips=nil;
self.nodeExt=nil;
end

















local _movePosX={
[1]={0},
[2]={-350,350},
[3]={-420,0,420},
}


function UIMultiTipsWin:onLoaded(...)
self:bindComponents()
end

function UIMultiTipsWin:__delete()
self:unbindComponents()
end

function UIMultiTipsWin:onShow(argtable,afterOnloaded)
local tipsList=argtable.tipsList
local extList=argtable.extList
self:showTips(tipsList)
self:showExt(extList)
self.widget:SetChildDOTweenAnimation_DOPlay(self.root:getID(),1,0,3)
self.widget:SetChildDOTweenAnimation_DOPlay(self.root:getID(),2,0,3)
end

function UIMultiTipsWin:onHide()

end





function UIMultiTipsWin:onBg()
self:closeSelf()
end


function UIMultiTipsWin:showTips(tipsList)
local len=#tipsList
local outConfig={}
local posTable=_movePosX[len]
local posY=tipsList.posY
for i,v in ipairs(tipsList)do
local nodeIdx=self.nodeTips[i]:getID()
posY=v.posY or posY
local data=v
local args={
argtable=data,
}
outConfig[#outConfig+1]=
{
name='UITipsItem',
parentIdx=nodeIdx,
args=args,
}
self.winlua:SetChildLocalPosX(nodeIdx,posTable[i])
if posY then
self.winlua:SetChildLocalPosY(nodeIdx,posY)
end
end
self.creater:createObjectList(outConfig)
end

function UIMultiTipsWin:showExt(extList)
if extList==nil or#extList==0 then return end
local outConfig={}
for i,args in ipairs(extList)do
local childType=args.childType
local data=args.argtable
local childCfg=tipsConfig.getTipsChildConfig(childType)
local name=childCfg.src
local nodeidx=self.nodeExt[i]:getID()
local args={
argtable=data,
}
outConfig[#outConfig+1]=
{
name=name,
parentIdx=nodeidx,
args=args,
}
end
self.createrExt:createObjectList(outConfig)
end