







def_class("UIMoreActorInterButtonWin",UIWindowBase)









function UIMoreActorInterButtonWin:bindComponents()

self.buttonGridPanel=UIObject.get(self,0)
self.frameBack=UIObject.get(self,1)



end


function UIMoreActorInterButtonWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.buttonGridPanel);self.buttonGridPanel=nil;
_UIObject_release(self.frameBack);self.frameBack=nil;
end
















local buttonMaxNum=4
local itemHeight=78
local itemSpaceY=12
local itemOffy=30


function UIMoreActorInterButtonWin:onLoaded(...)
self:bindComponents()
end


function UIMoreActorInterButtonWin:__delete()
self:unbindComponents()
end


function UIMoreActorInterButtonWin:onHide()

end




function UIMoreActorInterButtonWin:onShow(argtable,afterOnloaded)
self.actorid=argtable.actorid
self.buttonDatas=argtable.buttonDatas
self.fromType=argtable.fromType or actorInterFromType.eCommon
self.serverid=argtable.serverid

self:updateBtns()
end

function UIMoreActorInterButtonWin:refreshBtns(buttonDatas)
self.buttonDatas=buttonDatas
self:updateBtns()
end

function UIMoreActorInterButtonWin:updateBtns()
local num=#self.buttonDatas
local func=function(index)
local item=self.buttonGridPanel:getChildLayoutGroupGridItem(index-1)
self:refreshButtonItem(item,index)
end
self.buttonGridPanel:setChildLayoutGroupCreateItems(num,func)

local row
if num>=buttonMaxNum then
row=buttonMaxNum
else
row=num%buttonMaxNum
end
local sizeX=self.winlua:GetChildSizeDeltaX(self.frameBack:getID())
local sizeY=row*itemHeight+(row-1)*itemSpaceY+itemOffy
self.frameBack:setChildSizeDelta(sizeX,sizeY)
end

function UIMoreActorInterButtonWin:refreshButtonItem(item,index)
local btncfg=self.buttonDatas[index]


local enable=actorInterButtonHelper.checkEnable(btncfg.id,self.actorid,self.fromType)
item:SetChildButtonEnable(0,enable,not enable)


item:SetChildButtonClick(0,function()
self:onButtonItemClick(index)
end)

item:SetChildActive(2,false)

local name=btncfg.name
item:SetChildText(1,name)
end

function UIMoreActorInterButtonWin:onButtonItemClick(index)
local btncfg=self.buttonDatas[index]

actorInterButtonHelper.buttonJump(btncfg.id,self.actorid,self.fromType,self.serverid)
end