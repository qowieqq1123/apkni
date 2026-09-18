







def_class("UIXM_LXWJ_ScoreTwoWin",UIWindowBase)









function UIXM_LXWJ_ScoreTwoWin:bindComponents()

self.root=UIObject.get(self,0)
self.rankGridPanel=UIObject.get(self,1)



end


function UIXM_LXWJ_ScoreTwoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.rankGridPanel);self.rankGridPanel=nil;
end
















local _this=nil


function UIXM_LXWJ_ScoreTwoWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_LXWJ_ScoreTwoWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_LXWJ_ScoreTwoWin:onHide()

end




function UIXM_LXWJ_ScoreTwoWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin

self:inteView()
end

function UIXM_LXWJ_ScoreTwoWin:inteView()
self.myData=UIManager:invokeUIMethod(self.parentWin,'getMyData')
local isshow=self.myData.isshow
self.root:setActive(isshow)
if isshow then
self:refreshView()
end
end

function UIXM_LXWJ_ScoreTwoWin:refreshView()
local data=self.myData
local ourList=data.ourList
if#ourList>1 then
table.sort(ourList,function(a,b)
return a.defRank<b.defRank
end)
end
local enemyList=data.enemyList
if#enemyList>1 then
table.sort(enemyList,function(a,b)
return a.defRank<b.defRank
end)
end
local num=math.max(#ourList,#enemyList)
local max_atk_num=lingxuwenjianModel:getMaxAttackTimes()
local func=function(i)
if _this==nil then return end
local item=_this.rankGridPanel:getChildLayoutGroupGridItem(i-1)

local leftdata=ourList[i]
local leftshow=leftdata~=nil
item:SetChildActive(0,leftshow)
if leftshow then
local leftItem=item:GetChildWidgetBase(0)

local rank=leftdata.defRank
leftItem:SetChildText(0,tostring(rank))

leftItem:SetChildText(1,leftdata.actorname)

leftItem:SetChildText(2,FMT.fmt('{0}%',leftdata.defRate*100))

leftItem:SetChildText(3,leftdata.defSuccessNum)

local showSign=rank==1 and leftdata.defSuccessNum>0
leftItem:SetChildActive(4,showSign)

local showMy=leftdata.ismy==true
leftItem:SetChildActive(5,showMy)
end

local rightdata=enemyList[i]
local rightshow=rightdata~=nil
item:SetChildActive(1,rightshow)
if rightshow then
local rightItem=item:GetChildWidgetBase(1)

local rank=rightdata.defRank
rightItem:SetChildText(0,tostring(rank))

rightItem:SetChildText(1,rightdata.actorname)

rightItem:SetChildText(2,FMT.fmt('{0}%',rightdata.defRate*100))

rightItem:SetChildText(3,rightdata.defSuccessNum)

local showSign=rank==1 and rightdata.defSuccessNum>0
rightItem:SetChildActive(4,showSign)
end
end
self.rankGridPanel:setChildLayoutGroupCreateItems(num,func)
end
