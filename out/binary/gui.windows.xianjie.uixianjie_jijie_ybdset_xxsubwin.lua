







def_class("UIXianJie_JiJie_YBDSet_xxSubWin",UIWindowBase)









function UIXianJie_JiJie_YBDSet_xxSubWin:bindComponents()

self.root=UIObject.get(self,0)
self.rewardJoinBtn=UIButton.get(self,1)
self.rewardJoinNotSelect=UIImage.get(self,2)
self.rewardJoinSelect=UIImage.get(self,3)
self.normalXXTypeGroup=UIObject.get(self,4)
self.jieXXTypeGroup=UIObject.get(self,5)
self.mask=UIButton.get(self,6)

self.rewardJoinBtn:setButtonClick(function()self:onRewardJoinBtn()end)

self.mask:setButtonClick(function()self:onMask()end)



end


function UIXianJie_JiJie_YBDSet_xxSubWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.rewardJoinBtn);self.rewardJoinBtn=nil;
_UIObject_release(self.rewardJoinNotSelect);self.rewardJoinNotSelect=nil;
_UIObject_release(self.rewardJoinSelect);self.rewardJoinSelect=nil;
_UIObject_release(self.normalXXTypeGroup);self.normalXXTypeGroup=nil;
_UIObject_release(self.jieXXTypeGroup);self.jieXXTypeGroup=nil;
_UIObject_release(self.mask);self.mask=nil;
end



















function UIXianJie_JiJie_YBDSet_xxSubWin:onLoaded(...)
self:bindComponents()
end


function UIXianJie_JiJie_YBDSet_xxSubWin:__delete()
self:unbindComponents()
end




function UIXianJie_JiJie_YBDSet_xxSubWin:onShow(argtable,afterOnloaded)
local curpos=argtable.pos or Vector2.New(0,0)
local pos=nil
if argtable.posItem then
pos=argtable.posItem:getChildScreenPointToLocalPointRectangle()
elseif argtable.posWidget then
pos=argtable.posWidget:GetChildScreenPointToLocalPointRectangle(-1)
end
if pos then
curpos.x=curpos.x+pos.x
curpos.y=curpos.y+pos.y
end
self.root:setLocalPos(curpos.x,curpos.y,0)

self.normalXXTypeList={
[1]={
id=1,
name="仙墟(仙)",
},
[2]={
id=2,
name="仙墟(魔)",
},
}
self.jieXXTypeList={}
local cfg=cfg_xianguanxianxutypeconfig()
for i,v in ipairs(cfg)do
local item={
id=v.id,
name=v.namestr,
}
self.jieXXTypeList[#self.jieXXTypeList+1]=item
end

self:refresh(true)
end


function UIXianJie_JiJie_YBDSet_xxSubWin:onHide()

end

function UIXianJie_JiJie_YBDSet_xxSubWin:refresh(isInit)

self:refreshRewardJoinFlag()


self:refreshNormalXXTypePanel(isInit)


self:refreshJieXXTypePanel(isInit)
end

function UIXianJie_JiJie_YBDSet_xxSubWin:refreshRewardJoinFlag()
local ybdData=xianjieModel:getJiJieYBDData()
self.rewardJoinFlag=ybdData and ybdData.rewardJoinFlag or 0
local isNotJoin=self.rewardJoinFlag==1
self.rewardJoinSelect:setActive(isNotJoin)
self.rewardJoinNotSelect:setActive(not isNotJoin)
end

function UIXianJie_JiJie_YBDSet_xxSubWin:refreshNormalXXTypePanel(isInit)
local ybdData=xianjieModel:getJiJieYBDData()
local rejectedNormalXXList=ybdData and ybdData.rejectedXmXXList or{}
if isInit then
self.normalXXTypeGroup:setChildLayoutGroupCreateItems(#self.normalXXTypeList,function(index)
local item=self.normalXXTypeGroup:getChildLayoutGroupGridItem(index-1)
local cfg=self.normalXXTypeList[index]
if cfg then
item:SetChildActive(-1,true)

local name=cfg.name
item:SetChildText(0,name)


local id=cfg.id
local isRejected=rejectedNormalXXList[id]or false
item:SetChildActive(1,not isRejected)


item:SetChildButtonClick(2,function()
return self:onClickNormalXXTypeItem(id)
end)
else
item:SetChildActive(-1,false)
end
end)
else
local grids=self.normalXXTypeGroup:getChildLayoutGroupGridList()
for index=1,grids.Count do
local item=grids[index-1]
local cfg=self.normalXXTypeList[index]
if cfg then

local id=cfg.id
local isRejected=rejectedNormalXXList[id]or false
item:SetChildActive(1,not isRejected)
end
end
end
end

function UIXianJie_JiJie_YBDSet_xxSubWin:refreshJieXXTypePanel(isInit)
local ybdData=xianjieModel:getJiJieYBDData()
local rejectedJieXXList=ybdData and ybdData.rejectedXgXXList or{}
if isInit then
self.jieXXTypeGroup:setChildLayoutGroupCreateItems(#self.jieXXTypeList,function(index)
local item=self.jieXXTypeGroup:getChildLayoutGroupGridItem(index-1)
local cfg=self.jieXXTypeList[index]
if cfg then
item:SetChildActive(-1,true)

local name=cfg.name
item:SetChildText(0,name)


local id=cfg.id
local isRejected=rejectedJieXXList[id]or false
item:SetChildActive(1,not isRejected)


item:SetChildButtonClick(2,function()
return self:onClickJieXXTypeItem(id)
end)
else
item:SetChildActive(-1,false)
end
end)
else
local grids=self.jieXXTypeGroup:getChildLayoutGroupGridList()
for index=1,grids.Count do
local item=grids[index-1]
local cfg=self.jieXXTypeList[index]
if cfg then

local id=cfg.id
local isRejected=rejectedJieXXList[id]or false
item:SetChildActive(1,not isRejected)
end
end
end
end




function UIXianJie_JiJie_YBDSet_xxSubWin:onRewardJoinBtn()

local isNotJoin=self.rewardJoinFlag==1
local newFlag=isNotJoin and 0 or 1

local ybdData=xianjieModel:getJiJieYBDData()
local monsterStage=ybdData and ybdData.pveCnd and ybdData.pveCnd.monsterStage or 3
xianjieController:reqMassYBDSetPveCnd_pveChange(monsterStage,newFlag)
end

function UIXianJie_JiJie_YBDSet_xxSubWin:onMask()
self:closeSelf()
end


function UIXianJie_JiJie_YBDSet_xxSubWin:onClickNormalXXTypeItem(id)
local ybdData=xianjieModel:getJiJieYBDData()
local rejectedNormalXXList=ybdData and ybdData.rejectedXmXXList or{}
local rejectedJieXXList=ybdData and ybdData.rejectedXgXXList or{}
local isRejected=rejectedNormalXXList[id]or false
rejectedNormalXXList[id]=not isRejected
local xmList={}
for id,flag in pairs(rejectedNormalXXList)do
if flag then
xmList[#xmList+1]=id
end
end

local xgList={}
for xgtType,flag in pairs(rejectedJieXXList)do
if flag then
xgList[#xgList+1]=xgtType
end
end
xianjieController:reqMassYBDSetXianXuRejectedList(xmList,xgList)
end

function UIXianJie_JiJie_YBDSet_xxSubWin:onClickJieXXTypeItem(id)
local ybdData=xianjieModel:getJiJieYBDData()
local rejectedNormalXXList=ybdData and ybdData.rejectedXmXXList or{}
local rejectedJieXXList=ybdData and ybdData.rejectedXgXXList or{}
local isRejected=rejectedJieXXList[id]or false
rejectedJieXXList[id]=not isRejected

local xmList={}
for id,flag in pairs(rejectedNormalXXList)do
if flag then
xmList[#xmList+1]=id
end
end

local xgList={}
for xgtType,flag in pairs(rejectedJieXXList)do
if flag then
xgList[#xgList+1]=xgtType
end
end
xianjieController:reqMassYBDSetXianXuRejectedList(xmList,xgList)
end