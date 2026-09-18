







def_class("UIGongFaPageRewardWin",UIWindowBase)









function UIGongFaPageRewardWin:bindComponents()

self.root=UIObject.get(self,0)
self.gongfaBG=UIImage.get(self,1)
self.gongfa2BG=UIImage.get(self,2)
self.gongfaNameTxt=UIText.get(self,3)
self.successEffect=UIObject.get(self,4)
self.titleTxt=UIText.get(self,5)
self.goodsCreater=UIObject.get(self,6)
self.gongfaIcon=UIImage.get(self,7)
self.gongfa2Icon=UIImage.get(self,8)



end


function UIGongFaPageRewardWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.gongfaBG);self.gongfaBG=nil;
_UIObject_release(self.gongfa2BG);self.gongfa2BG=nil;
_UIObject_release(self.gongfaNameTxt);self.gongfaNameTxt=nil;
_UIObject_release(self.successEffect);self.successEffect=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
_UIObject_release(self.goodsCreater);self.goodsCreater=nil;
_UIObject_release(self.gongfaIcon);self.gongfaIcon=nil;
_UIObject_release(self.gongfa2Icon);self.gongfa2Icon=nil;
end
















local iconFrameLookup={
'image_gongfapzs_1','image_gongfapzs_2','image_gongfapzs_3','image_gongfapzs_4','image_gongfapzs_5',
}

local iconFrameLookup2={
'image_gongfapz_1','image_gongfapz_2','image_gongfapz_3','image_gongfapz_4','image_gongfapz_5',
}





function UIGongFaPageRewardWin:onLoaded(...)
self:bindComponents()

local canvasPos=self:getChildCanvas(-1)
self.canvasPos=canvasPos

self:setChildCanvas(-1,canvasPos[1],canvasPos[2]+2)

end


function UIGongFaPageRewardWin:__delete()
self.successEffect:setChildShowEffect(10010,false)
self:unbindComponents()
end


function UIGongFaPageRewardWin:onHide()

end




function UIGongFaPageRewardWin:onShow(argtable,afterOnloaded)
local gfID=argtable.gfID
local gfCfg=cfgHelper.get1(cfg_disciplegongfaconfig_get,gfID)
local pieces=argtable.pieces
local piecesLookup={}
local rewardlist={}
local name_str
local name_str2
for i,v in ipairs(pieces)do
piecesLookup[v]=true
local reward=nil
if v==0 then
reward=gfCfg.reward
name_str=gfCfg.name
else
reward=gfCfg.piece[v][2]
local piece_name=itemsModel.getName(gfCfg.piece[v][1])
if name_str2==nil then
name_str2=piece_name
else
name_str2=FMT.fmt('{0}\n{1}',name_str2,piece_name)
end
end
if reward then
for i2,v2 in ipairs(reward)do
table.insert(rewardlist,v2)
end
end
end
if name_str==nil then
name_str=name_str2
end
local isAll=piecesLookup[0]==true


local canvasPos=self.canvasPos
self.successEffect:setChildShowEffectEx(10010,canvasPos[1],canvasPos[2]+3,true)

AudioManager.playAudio(622)

local titleName
if isAll then
titleName='功法篇章收集完成'
else
titleName='获得新功法篇章'
end
self.titleTxt:setText(titleName)

local abName=globalABLookup.gongfatipsicons
self.gongfaBG:setActive(not isAll)
self.gongfa2BG:setActive(isAll)
if isAll then
local iconName=iconFrameLookup2[gfCfg.color]
self.gongfa2BG:setSprite(abName,iconName)
self.gongfa2Icon:setImageIcon(iconHelper.getGongFaIcon(gfCfg.icon),true)
else
local iconName=iconFrameLookup[gfCfg.color]
self.gongfaBG:setSprite(abName,iconName)
self.gongfaIcon:setImageIcon(iconHelper.getGongFaIcon(gfCfg.icon),true)
end

self.gongfaNameTxt:setText(name_str)

local num=#rewardlist
self.goodsCreater:setChildLayoutGroupCreateItems(num)
local grid=self.goodsCreater:getChildLayoutGroupGridList()
local c=grid.Count
for i=1,c do
local data=rewardlist[i]
local item=grid[i-1]
local itemID=data[1]
local num=data[2]
local str=tostring(num)
local itemConfig=itemsConfig.getConfig(itemID)
local showCountBG=true
local conf={itemid=itemID,itemcount=str,showname=false,showCountBG=showCountBG,showStage=true}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)self:onGoodItemClick(TIPS_MOVE_POS.eRight,...)end)
end
end

function UIGongFaPageRewardWin:onGoodItemClick(pos,itemid,index,itemguid,attach)
if itemid~=-1 then
tipsManager.showTips({itemid=itemid,itemguid=itemguid,move=pos})
end
end