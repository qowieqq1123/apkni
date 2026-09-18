







def_class("UIXianMengPostSetInfoWin",UIWindowBase)









function UIXianMengPostSetInfoWin:bindComponents()

self.postBtn=UIButton.get(self,0)
self.leaveBtn=UIButton.get(self,1)
self.closeButton=UIButton.get(self,2)
self.hideToggle=UIToggleButton.get(self,3)
self.none=UIObject.get(self,4)
self.titleText=UIText.get(self,5)
self.contect=UIObject.get(self,6)

self.postBtn:setButtonClick(function()self:onPostBtn()end)

self.leaveBtn:setButtonClick(function()self:onLeaveBtn()end)

self.closeButton:setButtonClick(function()UIManager:closeWindow("UIXianMengPostSetInfoWin")end)



end


function UIXianMengPostSetInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.postBtn);self.postBtn=nil;
_UIObject_release(self.leaveBtn);self.leaveBtn=nil;
_UIObject_release(self.closeButton);self.closeButton=nil;
_UIObject_release(self.hideToggle);self.hideToggle=nil;
_UIObject_release(self.none);self.none=nil;
_UIObject_release(self.titleText);self.titleText=nil;
_UIObject_release(self.contect);self.contect=nil;
end















local _this=nil
local _itemKid={
root=-1,
select=0,
head=1,
name=2,
post=3,
sign=4,
fight=5,
dynamic=6,
state=7,
}



function UIXianMengPostSetInfoWin:onLoaded(...)
self:bindComponents()
_this=self

self.hideFlag=false
self.hideToggle:setToggle(self.hideFlag)
local func=function(...)
if _this==nil then return end
_this:onHideToggleChange(...)
end
self.hideToggle:setToggleChange(func)

self.selected=nil
self.sActor=nil
end


function UIXianMengPostSetInfoWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianMengPostSetInfoWin:onShow(argtable,afterOnloaded)
self.target=argtable.target
self.owner=argtable.owner
self.current=argtable.current
self.callback1=argtable.callback1
self.callback2=argtable.callback2

self.titleText:setText(FMT.fmt("委任{0}",xianmengModel.getXMPostName(self.target,false)))

local list=xianmengModel:getXMMemberList()
self.members={}
local curr=nil
for i,v in ipairs(list)do
if v.actorid~=playerModel:getActorID()then
if v.actorid==self.current then
curr=v
elseif self.target==GUILD_POST_TYPE.gpAllyLeader or(self.target~=v.pos and v.pos>self.owner)then
table.insert(self.members,v)
end
end
end
table.sort(self.members,self.sortMembers)
if curr then
table.insert(self.members,1,curr)
end
self.civilian={}
for i,v in ipairs(self.members)do
if v.pos==GUILD_POST_TYPE.gpCivilian then
table.insert(self.civilian,v)
end
end
self:refrershList()





end


function UIXianMengPostSetInfoWin:onHide()

end





function UIXianMengPostSetInfoWin:onPostBtn()
if self.selected then
if self.callback1 then
self.callback1(self.sActor,self.target,self.current)
end

else
UIManager.info("暂无成员可委任职位")
end
end


function UIXianMengPostSetInfoWin:onLeaveBtn()
if self.callback2 then
self.callback2(self.current)
end

end

function UIXianMengPostSetInfoWin:onClickItem(index)
if self.selected==index then return end

if self.selected then
local item=self.contect:getChildLayoutGroupGridItem(self.selected-1)
item:SetChildActive(_itemKid.select,false)

if self.members[self.selected].actorid==self.current then
self.leaveBtn:setActive(false)
end
end

self.selected=index

local showlist=self.hideFlag and self.civilian or self.members
self.sActor=showlist[self.selected].actorid

if self.selected then
local item=self.contect:getChildLayoutGroupGridItem(self.selected-1)
item:SetChildActive(_itemKid.select,true)

if self.sActor==self.current then
self.leaveBtn:setActive(true)
end
end
end

function UIXianMengPostSetInfoWin.sortMembers(a,b)



if a.pos~=b.pos then
return a.pos<b.pos
else
return a.fight>b.fight
end
end

function UIXianMengPostSetInfoWin:onHideToggleChange(name,isOn,data)
self.hideFlag=isOn
userActorSetting.flushVal('XianMengPostInfoHide',isOn,true)
self:refrershList()
end

function UIXianMengPostSetInfoWin:refrershList()
local showlist=self.hideFlag and self.civilian or self.members
self.selected=nil
for i,v in ipairs(showlist)do
if v.actorid==self.sActor then
self.selected=i
break
end
end
if self.selected==nil then
self.sActor=nil
self.leaveBtn:setActive(false)
end
self.contect:setChildLayoutGroupCreateItems(#showlist,function(index)
local item=self.contect:getChildLayoutGroupGridItem(index-1)
local data=showlist[index]
playerController:setHeadIcon(item,_itemKid.head,{iconInfo=data.iconInfo})
item:SetChildText(_itemKid.name,data.actorname)
item:SetChildText(_itemKid.post,xianmengModel.getXMPostName(data.pos,true))
item:SetChildText(_itemKid.fight,tostring(data.fight))
item:SetChildText(_itemKid.dynamic,data.weekscore)
item:SetChildActive(_itemKid.sign,self.current==data.actorid)
item:SetChildActive(_itemKid.select,self.sActor==data.actorid)
local state_str
if data.online==0 then
state_str='<color=#549327>在线</color>'
else
local cur=gameUtilityModel.getServerShortTime()
local lerp=cur-data.online
state_str=timeHelper.format_time_stamp14(lerp)
end
item:SetChildText(_itemKid.state,state_str)
item:SetChildButtonClick(_itemKid.root,function()
self:onClickItem(index)
end)
end)

self.none:setActive(#showlist<=0)

if self.selected==nil and#showlist>0 then
self:onClickItem(1)
end
end