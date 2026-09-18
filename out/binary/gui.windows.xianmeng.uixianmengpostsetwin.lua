







def_class("UIXianMengPostSetWin",UIWindowBase)









function UIXianMengPostSetWin:bindComponents()

self.content=UIObject.get(self,0)
self.postLine_1=UIObject.get(self,1)
self.postLine_2=UIObject.get(self,2)
self.postLine_3=UIObject.get(self,3)
self.postLine_4=UIObject.get(self,4)
self.postTx=UIText.get(self,5)
self.ruleBtn=UIButton.get(self,6)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)
self.postLine={
self.postLine_1,
self.postLine_2,
self.postLine_3,
self.postLine_4,
}



end


function UIXianMengPostSetWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.postLine_1);self.postLine_1=nil;
_UIObject_release(self.postLine_2);self.postLine_2=nil;
_UIObject_release(self.postLine_3);self.postLine_3=nil;
_UIObject_release(self.postLine_4);self.postLine_4=nil;
_UIObject_release(self.postTx);self.postTx=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
self.postLine=nil;
end
















local _this=nil
local _itemKid={
headBg=0,
head=1,

name=3,
post=4,
flag=5,
}

local _lineNum=5



function UIXianMengPostSetWin:onLoaded(...)
self:bindComponents()
_this=self

self.items={}
for index,obj in ipairs(self.postLine)do
self.items[index]=obj:getWidgetBase()
end

end


function UIXianMengPostSetWin:__delete()
self:unbindComponents()
_this=nil
end




function UIXianMengPostSetWin:onShow(argtable,afterOnloaded)
local cfg=cfg_guildpositionconfig()
local list=xianmengModel:getXMMemberList()
self.members={}
self.posts={}
self.level=xianmengModel:getXMMemberPost(playerModel:getActorID())
self.operat=xianmengModel.checkPostPrivile(self.level,GUILD_PRIVILE_TYPE.gptChangePos)

for i,v in ipairs(list)do
if v.pos~=GUILD_POST_TYPE.gpCivilian then
if not self.members[v.pos]then
self.members[v.pos]={}
end
table.insert(self.members[v.pos],v)
end
end

for i,v in ipairs(cfg)do
if i~=GUILD_POST_TYPE.gpCivilian then
if v.max>_lineNum then
local line=mathHelper.safe_ceil(v.max/_lineNum)
for j=1,line,1 do
local max=j~=line and _lineNum or v.max-(j-1)*_lineNum
table.insert(self.posts,{i,max,j})
end
else
table.insert(self.posts,{i,v.max,1})
end
end
end
table.sort(self.posts,function(a,b)
return a[1]<b[1]
end)



for idx1,item in ipairs(self.items)do

local post=self.posts[idx1][1]
local num=self.posts[idx1][2]
local lineIdx=self.posts[idx1][3]
item:SetChildLayoutGroupCreateItems(-1,num,function(idx2)
local slot=item:GetChildLayoutGroupGridItem(-1,idx2-1)
local realIndex=(lineIdx-1)*_lineNum+idx2
slot:SetChildButtonClick(_itemKid.headBg,function()
self:onClickItem(post,realIndex)
end)
slot:SetChildButtonClick(_itemKid.flag,function()
self:onClickItem(post,realIndex)
end)
self:refreshItem(slot,post,realIndex)


if blueDiamondModel:isHasBlueDiamond()then
if idx1==1 then
slot:SetChildLocalPosX(_itemKid.flag,-100)
else
slot:SetChildLocalPosX(_itemKid.flag,-25)
end
end
end)
end


local pos=xianmengModel:getXMMemberPost(playerModel:getActorID())
self.postTx:setText(FMT.fmt("<color=#7D3B17>我的职位: </color>{0}",xianmengModel.getXMPostName(pos,true)))
end


function UIXianMengPostSetWin:onHide()

end




function UIXianMengPostSetWin:onRuleBtn()
local d={}
d.title='职位权限'
d.mode=3
d.name='xianmengpostpower_help_%d'
UIManager:showWindow('UIRuleWin',d)
end

function UIXianMengPostSetWin:refreshItem(item,post,index)

local data=self.members[post]and self.members[post][index]or nil

item:SetChildText(_itemKid.post,xianmengModel.getXMPostName(post,true))
if data then
item:SetChildText(_itemKid.name,data.actorname)
playerController:setHeadIcon(item,_itemKid.head,{iconInfo=data.iconInfo})
if self.operat then
item:SetChildActive(_itemKid.flag,self.level<post or self.level==GUILD_POST_TYPE.gpAllyLeader)
else
item:SetChildActive(_itemKid.flag,false)
end
else
item:SetChildText(_itemKid.name,"虚位以待")
playerController:setHeadIcon(item,_itemKid.head,nil)
item:SetChildActive(_itemKid.flag,false)
end
end

function UIXianMengPostSetWin:onClickItem(post,index)
local data=self.members[post]and self.members[post][index]or nil
if self.operat and(self.level<post or self.level==GUILD_POST_TYPE.gpAllyLeader)then
local args={
target=post,
owner=self.level,
current=data and data.actorid or nil,
callback1=function(actorid1,p,actorid2)
if p==GUILD_POST_TYPE.gpAllyLeader then
local name=xianmengModel:getXMMemberName(actorid1)
local showdata=
{
type='UIDialouge',
title='转让盟主',
content=FMT.fmt("是否将盟主职位转让给玩家<color=#549327>{0}</color>",name),
oktext='确定',
canceltext='取消',
allowclickBG='false',
useTimeCount=true,
timeCount=3,
okcallback=function(...)
xianmengController:reqChangeXMPost(actorid1,GUILD_POST_TYPE.gpAllyLeader)
UIManager:closeWindow("UIXianMengPostSetInfoWin")
end,
showclosebtn=false,
}
local comfirmDialog=UIDialogManager.newDialog(showdata)
comfirmDialog:show()

return
end
if actorid2 then
if xianmengModel:getXMMemberPost(actorid1)~=GUILD_POST_TYPE.gpCivilian then

xianmengController:reqPostRechange(actorid1,actorid2)
else
xianmengController:reqChangeXMPost(actorid2,GUILD_POST_TYPE.gpCivilian)
xianmengController:reqChangeXMPost(actorid1,p)
end
else
xianmengController:reqChangeXMPost(actorid1,p)
end
UIManager:closeWindow("UIXianMengPostSetInfoWin")
end,
callback2=function(actorid2)
if actorid2 then
xianmengController:reqChangeXMPost(actorid2,GUILD_POST_TYPE.gpCivilian)
end
UIManager:closeWindow("UIXianMengPostSetInfoWin")
end,
}
self:showWindow('UIXianMengPostSetInfoWin',args)
else
if data and data.actorid~=playerModel:getActorID()then
otherPlayerController:openOtherPlayerInfoWin(data.actorid,nil,actorInterFromType.eXianMeng)
elseif not self.operat then
local cfg=cfg_guildpositionconfig()
local postNames={}
for i,v in ipairs(cfg)do
if i<post and xianmengModel.checkPostPrivile(i,GUILD_PRIVILE_TYPE.gptChangePos)then
table.insert(postNames,v.name)
end
end
if#postNames>0 then
local str=nil
for i,v in ipairs(postNames)do
if str==nil then
str=v
else
str=FMT.fmt("{0}、{1}",str,v)
end
end
UIManager.error(FMT.fmt("只有{0}才可任命{1}",str,xianmengModel.getXMPostName(post)))
end
end
end
end

local _getPostIndex=function(psots,index,Post)
local idx1=0
local min=0
local max=0
local line=0
for pIndex,post in ipairs(psots)do
if post[1]==Post then
line=post[3]
local mmax=post[2]
min=(line-1)*_lineNum+1
max=line*_lineNum
if index>=min and index<=max then
idx1=pIndex
min=1
max=Mathf.Min(max,mmax)
break
end
end
end
return idx1,min,max,line
end

function UIXianMengPostSetWin:refreshView(actorid,newPost,oldPost)

local items=self.items

if self.members[oldPost]then
local index=nil
local count=#self.members[oldPost]
for i=1,count do
local v=self.members[oldPost][i]
if v.actorid==actorid then
index=i
break
end
end

if index then
table.remove(self.members[oldPost],index)

local idx1,min,max,line=_getPostIndex(self.posts,index,oldPost)

if idx1~=0 then
local slotRoot=items[idx1]
for i=min,max do
local item=slotRoot:GetChildLayoutGroupGridItem(-1,i-1)
local rindex=(line-1)*_lineNum+i
self:refreshItem(item,oldPost,rindex)
end
end
end
end

if newPost~=GUILD_POST_TYPE.gpCivilian then
if not self.members[newPost]then
self.members[newPost]={}
end
table.insert(self.members[newPost],xianmengModel:getXMMemberData(actorid))
local len=#self.members[newPost]
local idx1,min,max,line=_getPostIndex(self.posts,len,newPost)

local slotRoot=items[idx1]
local rindex=len-(line-1)*_lineNum
local item=slotRoot:GetChildLayoutGroupGridItem(-1,rindex-1)
self:refreshItem(item,newPost,len)
end

if actorid==playerModel:getActorID()and self.level~=newPost then
self.level=newPost
self.operat=xianmengModel.checkPostPrivile(self.level,GUILD_PRIVILE_TYPE.gptChangePos)

for i=1,#items do
local slotRoot=items[i]
local post=self.posts[i][1]
local line=self.posts[i][3]
local slots=slotRoot:GetChildLayoutGroupGridList(-1)
for j=1,slots.Count do
local slot=slots[j-1]
local rIndex=(line-1)*_lineNum+j
local data=self.members[post]and self.members[post][rIndex]or nil
if data then
if self.operat then
slot:SetChildActive(_itemKid.flag,self.level<post or self.level==GUILD_POST_TYPE.gpAllyLeader)
else
slot:SetChildActive(_itemKid.flag,false)
end
else
slot:SetChildActive(_itemKid.flag,false)
end
end
end
end


self:closeWindow('UIXianMengPostSetInfoWin')
end

function UIXianMengPostSetWin:refreshView2(actor1,actor2,newPost1,newPost2)

local items=self.items
local myActorid=playerModel:getActorID()

if self.members[newPost1]then
local index=nil
local count=#self.members[newPost1]
for i=1,count do
local v=self.members[newPost1][i]
if v.actorid==actor2 then
index=i
break
end
end

if index then
table.remove(self.members[newPost1],index)
end
end

if self.members[newPost2]then
local index=nil
local count=#self.members[newPost2]
for i=1,count do
local v=self.members[newPost2][i]
if v.actorid==actor1 then
index=i
break
end
end

if index then
table.remove(self.members[newPost2],index)
end
end

if newPost1~=GUILD_POST_TYPE.gpCivilian then
if not self.members[newPost1]then
self.members[newPost1]={}
end
table.insert(self.members[newPost1],xianmengModel:getXMMemberData(actor1))
end

if newPost2~=GUILD_POST_TYPE.gpCivilian then
if not self.members[newPost2]then
self.members[newPost2]={}
end
table.insert(self.members[newPost2],xianmengModel:getXMMemberData(actor2))
end

if actor1==myActorid and self.level~=newPost1 then
self.level=newPost1
self.operat=xianmengModel.checkPostPrivile(self.level,GUILD_PRIVILE_TYPE.gptChangePos)
elseif actor2==myActorid and self.level~=newPost2 then
self.level=newPost2
self.operat=xianmengModel.checkPostPrivile(self.level,GUILD_PRIVILE_TYPE.gptChangePos)
end

for i=1,#items do
local slotRoot=items[i]
local post=self.posts[i][1]
local line=self.posts[i][3]
local slots=slotRoot:GetChildLayoutGroupGridList(-1)
for j=1,slots.Count do
local slot=slots[j-1]
local realIndex=(line-1)*_lineNum+j
self:refreshItem(slot,post,realIndex)
end
end

self:closeWindow('UIXianMengPostSetInfoWin')
end
