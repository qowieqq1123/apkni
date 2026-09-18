







def_class("UIServerTransferXianMengMemberWin",UIWindowBase)









function UIServerTransferXianMengMemberWin:bindComponents()

self.actorListPanel=UIObject.get(self,0)



end


function UIServerTransferXianMengMemberWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.actorListPanel);self.actorListPanel=nil;
end



















function UIServerTransferXianMengMemberWin:onLoaded(...)
self:bindComponents()
self.actorListPanel:setChildScrollViewInit(0.5,true,nil,nil)
end


function UIServerTransferXianMengMemberWin:__delete()
self:unbindComponents()
end




function UIServerTransferXianMengMemberWin:onShow(argtable,afterOnloaded)
self.cross_id=argtable.cross_id
self.guildid=argtable.guildid
self.canvasIdx=argtable.canvasIdx
if self.canvasIdx then
self:setCanvasIndex(-1,self.canvasIdx)
end

if self.memberList==nil then
self.memberList=ServerTransferModel:getXianYuGuildMemberDatas(self.guildid)or{}
self:refreshActorListPanel()
end
end

function UIServerTransferXianMengMemberWin:refreshActorListPanel()
local c=#self.memberList
self.actorListPanel:setChildScrollViewCreateGrids(c,1)

local grids=self.actorListPanel:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
self:refreshActorListItem(grids[i-1],i)
end
end

function UIServerTransferXianMengMemberWin:refreshActorListItem(item,index)
if item==nil then
item=self.taskScroller:getChildScrollViewItemWidget(index-1)
end

if item then
local actorData=self.memberList[index]
playerController:setHeadIcon(item,2,{iconInfo=actorData.iconInfo,scale=0.7})

local namestr=actorData.actorname
item:SetChildText(3,namestr)

local postType=actorData.pos
local isleader=postType==GUILD_POST_TYPE.gpAllyLeader
local postName=xianmengModel.getXMPostName(postType,true)
item:SetChildText(7,postName)
item:SetChildActive(8,isleader)

item:SetChildText(4,tostring(actorData.level))

local fightnum=mathHelper.int64_to_number(actorData.fight)
item:SetChildText(5,mathHelper.formatNumber3(fightnum))

item:SetChildText(6,tostring(actorData.dftrankidx))

item:SetChildButtonClick(0,function()
self:onItemClick(index)
end)
end
end

function UIServerTransferXianMengMemberWin:onItemClick(index)
local actorData=self.memberList[index]
otherPlayerController:openOtherPlayerInfoWin(actorData.actorid,nil,nil,{serverid=self.cross_id,canvasIdx=self.canvasIdx})
end