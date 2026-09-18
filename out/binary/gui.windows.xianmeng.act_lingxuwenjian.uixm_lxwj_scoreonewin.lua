







def_class("UIXM_LXWJ_ScoreOneWin",UIWindowBase)









function UIXM_LXWJ_ScoreOneWin:bindComponents()

self.root=UIObject.get(self,0)
self.rankGridPanel=UIObject.get(self,1)



end


function UIXM_LXWJ_ScoreOneWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.rankGridPanel);self.rankGridPanel=nil;
end
















local _this=nil


function UIXM_LXWJ_ScoreOneWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_LXWJ_ScoreOneWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_LXWJ_ScoreOneWin:onHide()

end




function UIXM_LXWJ_ScoreOneWin:onShow(argtable,afterOnloaded)
self.parentWin=argtable.parentWin

self:inteView()
end

function UIXM_LXWJ_ScoreOneWin:inteView()
self.myData=UIManager:invokeUIMethod(self.parentWin,'getMyData')
local isshow=self.myData.isshow
self.root:setActive(isshow)
if isshow then
self:refreshView()
end
end

function UIXM_LXWJ_ScoreOneWin:refreshView()
local data=self.myData
local ourList=data.ourList
if#ourList>1 then
table.sort(ourList,function(a,b)
return a.scoreRank<b.scoreRank
end)
end
local enemyList=data.enemyList
if#enemyList>1 then
table.sort(enemyList,function(a,b)
return a.scoreRank<b.scoreRank
end)
end
local num=math.max(#ourList,#enemyList)
local max=lingxuwenjianModel:getMaxAttackTimes()
local func=function(i)
if _this==nil then return end
local item=_this.rankGridPanel:getChildLayoutGroupGridItem(i-1)

local leftdata=ourList[i]
local leftshow=leftdata~=nil
item:SetChildActive(0,leftshow)
if leftshow then
local leftItem=item:GetChildWidgetBase(0)

local rank=leftdata.scoreRank2
leftItem:SetChildText(0,tostring(rank))

leftItem:SetChildText(1,leftdata.actorname)

leftItem:SetChildText(2,FMT.fmt('{0}%',leftdata.atkRate*100))

leftItem:SetChildText(3,leftdata.score)

local cur=leftdata.atkNum
local lerp=max-cur
leftItem:SetChildLayoutGroupCreateItems(4,max,function(i_)
if _this==nil then return end
local item=leftItem:GetChildLayoutGroupGridItem(4,i_-1)
local has=i_<=lerp
local icon=has==true and'icon_xmgjian_1'or'icon_xmgjian_2'
item:SetChildCSImageSprite(-1,globalABLookup.lingxuwenjianicons,icon)
end)

local showSign=rank==1 and leftdata.score>0
leftItem:SetChildActive(5,showSign)

local showMy=leftdata.ismy==true
leftItem:SetChildActive(6,showMy)
end

local rightdata=enemyList[i]
local rightshow=rightdata~=nil
item:SetChildActive(1,rightshow)
if rightshow then
local rightItem=item:GetChildWidgetBase(1)

local rank=rightdata.scoreRank2
rightItem:SetChildText(0,tostring(rank))

rightItem:SetChildText(1,rightdata.actorname)

rightItem:SetChildText(2,FMT.fmt('{0}%',rightdata.atkRate*100))

rightItem:SetChildText(3,rightdata.score)

local cur=rightdata.atkNum
local lerp=max-cur
rightItem:SetChildLayoutGroupCreateItems(4,max,function(i_)
if _this==nil then return end
local item=rightItem:GetChildLayoutGroupGridItem(4,i_-1)
local has=i_<=lerp
local icon=has==true and'icon_xmgjian_1'or'icon_xmgjian_2'
item:SetChildCSImageSprite(-1,globalABLookup.lingxuwenjianicons,icon)
end)

local showSign=rank==1 and rightdata.score>0
rightItem:SetChildActive(5,showSign)
end
end
self.rankGridPanel:setChildLayoutGroupCreateItems(num,func)
end
