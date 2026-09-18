







def_class("UIMysteryPortalWin",UIWindowBase)









function UIMysteryPortalWin:bindComponents()

self.modelBg=UIObject.get(self,0)
self.GridRoot=UIObject.get(self,1)
self.model=UIObject.get(self,2)
self.desc=UIText.get(self,3)



end


function UIMysteryPortalWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.modelBg);self.modelBg=nil;
_UIObject_release(self.GridRoot);self.GridRoot=nil;
_UIObject_release(self.model);self.model=nil;
_UIObject_release(self.desc);self.desc=nil;
end


















local abname="ui/windows/mystery/weekactity_atlas_pak.ab"
local colorName=
{
"a0d2f8","bc9fff","ff9f9f"
}
local colorEffect=
{
nil,10284,10285
}


function UIMysteryPortalWin:onLoaded(...)
self:bindComponents()

self.modelBg:setChildUIModelShowTarget(4074,1,{},eAnimationID.stand,false,false,0,nil)
end


function UIMysteryPortalWin:__delete()
self:unbindComponents()
end




function UIMysteryPortalWin:onShow(argtable,afterOnloaded)
local entity=argtable.entity

local fbid=MysteryModel:get_cur_fbid()

local lv=MysteryModel:get_mysteryFB_ndLevel(fbid)or 1

local cfg=mysterySelectGridModel:get_config(entity.id)

local chType=cfg.chType

local chParam=cfg.chParam
local showParam=cfg.showParam
local rewardId=cfg.showReward






self.GridRoot:setChildLayoutGroupCreateItems(#chParam,function(index)
local item=self.GridRoot:getChildLayoutGroupGridItem(index-1)
local config=showParam[index]
item:SetChildButtonClick(0,function(...)
self:onClickItem(index,config,entity)
end)

local name=config[1]
local icon=config[2]

local color=config[3]

item:SetChildIcon(0,icon,true)
item:SetChildText(1,FMT.fmt("<color=#{0}>{1}</color>",colorName[color],name))

local reward=rewardId[index]
local rLen=#reward

item:SetChildScrollViewCreateGrids(3,#reward,1)
local gridList=item:GetChildScrollViewItemWidgets(3)
for i=1,rLen do
local grid=gridList[i-1]
if grid then
local r=reward[i]
local itemid=r[1]
local count=r[2]
local conf={itemid=itemid,itemcount=count>1 and count or"",showCountBG=count>1,showname=false,range=r.range}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
grid:SetChildActive(-1,true)
grid:SetChildPropData(2,prop)
grid:SetBaseItemClickEvent(2,function(...)
self:onClickBaseItem(...)
end)
grid:SetChildActive(3,count==-1)
end
end
item:SetChildCSImageSprite(4,abname,FMT.fmt("image_shanggunanduui_{0}",color))
local effect=colorEffect[color]
if effect then
item:SetChildShowEffect(5,effect,true)
end
end)

local discipleOutsideInfo=mysteryPlayerModel:get_player_model_info()
if discipleOutsideInfo then
self.model:setChildUIModelShowTarget(discipleOutsideInfo.body,1,discipleOutsideInfo.componets,eAnimationID.stand,false)
self.model:setChildUIModelShowFlipX(true)
end
self.desc:setText(cfg.desc)
end

function UIMysteryPortalWin:onClickItem(index,config,entity)
local contentStr="选择难度后本周内无法变更，是否确认？"
local show_data={
type='UIDialouge',
title='提示',
content=contentStr,
oktext='确定',
canceltext='取消',
okcallback=function()
mysterySelectGridController.send_4_71(entity.pos.x,entity.pos.y,entity.data.guid,index)
self:closeSelf()
end
}
local dialog=UIDialogManager.newDialog(show_data)
dialog:show()
end

function UIMysteryPortalWin:onClickBaseItem(itemid,index,guid,attach)

if itemid==-1 then
return
end
tipsManager.showTips({itemid=itemid,itemguid=guid})
end


function UIMysteryPortalWin:onHide()

end



