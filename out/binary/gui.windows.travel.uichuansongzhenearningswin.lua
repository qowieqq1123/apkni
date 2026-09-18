







def_class("UIChuanSongZhenEarningsWin",UIWindowBase)









function UIChuanSongZhenEarningsWin:bindComponents()

self.background=UIButton.get(self,0)
self.closeBtn=UIButton.get(self,1)
self.worldList=UIObject.get(self,2)

self.background:setButtonClick(function()self:onBackground()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIChuanSongZhenEarningsWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.background);self.background=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.worldList);self.worldList=nil;
end















local _this=nil
local _worldCmp={
root=-1,
nameTx=0,
arrowBtn=1,
mask=2,
grid=3,
infoProgress=4,
infoIcon1=5,
infoIcon2=6,
infoNum=7,
title=8,
}
local _blockCmp={
root=-1,
icon=0,
lock=1,
desc=2,
jumpBtn=3,
}
local _tweenDuration=0.2



function UIChuanSongZhenEarningsWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UIChuanSongZhenEarningsWin:__delete()
self:closeAllTweener()
self:unbindComponents()
_this=nil
end




function UIChuanSongZhenEarningsWin:onShow(argtable,afterOnloaded)
self.worlds=argtable.list
self.blocks={}
for i,v in ipairs(self.worlds)do
local temp={}
local blockCfg=cfgHelper.get1(cfg_worldblocktransportconfig_get,v)
for j,w in pairs(blockCfg)do
table.insert(temp,j)
end
table.sort(temp)
self.blocks[v]=temp
end
self.expanded={}
self.tweener={}
self.heights={}
self.worldList:setChildLayoutGroupCreateItems(#self.worlds,function(index)
self:initWorldItem(index)
end)
self.winlua:ForceLayoutRect(self.worldList:getID())
end


function UIChuanSongZhenEarningsWin:onHide()

end





function UIChuanSongZhenEarningsWin:onBackground()
self:closeSelf()
end



function UIChuanSongZhenEarningsWin:onCloseBtn()
self:closeSelf()
end

function UIChuanSongZhenEarningsWin:onClickJump(index1,index2)
local world=self.worlds[index1]
local blocks=self.blocks[world]
local block=blocks[index2]
local unitKey=chuanSongZhenModel:convertUnitKey(world,block)
worldController:enterWorld(world,{clickUnit=unitKey})
UIFullChuanSongZhenControl:closeUI()
self:closeSelf()
end





function UIChuanSongZhenEarningsWin:initWorldItem(index)
local item=self.worldList:getChildLayoutGroupGridItem(index-1)
local world=self.worlds[index]
local worldCfg=cfgHelper.get1(cfg_worldconfig_get,world)
local portCfg=cfgHelper.get1(cfg_worldtransportconfig_get,world)
local count=chuanSongZhenModel:countFlagBit(world)
local blocks=self.blocks[world]
local blockCnt=#blocks
local complete=count>=blockCnt


local stateColor=complete and'FF631D'or'573D2F'
local stateStr=complete and"已激活"or"未激活"
item:SetChildText(_worldCmp.nameTx,FMT.fmt("{0}<color=#{1}>（{2}）</color>",worldCfg.name,stateColor,stateStr))

item:SetChildButtonClick(_worldCmp.title,function()self:onClickArrow(index)end)

self.expanded[index]=true
item:SetChildLayoutGroupCreateItems(_worldCmp.grid,blockCnt,function(idx)
local col=idx%2
local row=math.floor((idx-1)/2)
local x=col==1 and 8 or 535
local y=-(42+row*102+row*8)
local bItem=item:GetChildLayoutGroupGridItem(_worldCmp.grid,idx-1)
bItem:SetChildAnchoredPos(_blockCmp.root,x,y)
local block=blocks[idx]
local open=worldBlockModel:checkBlockState(world,block,eWorldBlockState.OPEN)
bItem:SetChildButtonClick(_blockCmp.jumpBtn,function()
self:onClickJump(index,idx)
end)
if open then
local blockCfg=cfgHelper.get2(cfg_worldblocktransportconfig_get,world,block)
local repaired=chuanSongZhenModel:getFlagBit(world,block)
bItem:SetChildCSImageIcon(_blockCmp.icon,repaired and blockCfg.icon[2]or blockCfg.icon[1],true)
bItem:SetChildActive(_blockCmp.lock,false)
bItem:SetChildActive(_blockCmp.jumpBtn,true)
local descStr=repaired and"<color=#874E1F>{0}</color><color=#549327>【已修复】</color>\n游历时获得的{1}+{2}%"or"{0}<color=#65615F>（未修复）\n游历时获得的{1}+{2}%</color>"
local itemid,value
for i,v in pairs(blockCfg.money)do
itemid=i
value=v
break
end
descStr=FMT.fmt(descStr,blockCfg.name,itemsConfig.getItemName(itemid),value)
bItem:SetChildText(_blockCmp.desc,descStr)
else
bItem:SetChildCSImageIcon(_blockCmp.icon,"",false)
bItem:SetChildActive(_blockCmp.lock,true)
bItem:SetChildActive(_blockCmp.jumpBtn,false)
local blockCfg=cfgHelper.get2(cfg_worldblocktransportconfig_get,world,block)
local descStr=FMT.fmt("<color=#874E1F>未解锁{0}</color>",blockCfg.name)
bItem:SetChildText(_blockCmp.desc,descStr)
end
end)
local row=math.ceil(#blocks/2)
local height=row>0 and(row*102+(row-1)*8+50)or 50
self.heights[index]=height
item:SetChildSizeDelta(_worldCmp.grid,1060,height)
item:SetChildSizeDelta(_worldCmp.mask,1060,height)
local progressColor=complete and"509025"or"673F2E"
local numColor=complete and"C8631F"or"625E5B"
item:SetChildText(_worldCmp.infoProgress,FMT.fmt("<color=#{2}>（{0}/{1}）</color>",count,blockCnt,progressColor))
item:SetChildActive(_worldCmp.infoIcon1,complete)
item:SetChildActive(_worldCmp.infoIcon2,not complete)
item:SetChildText(_worldCmp.infoNum,FMT.fmt("<color=#{1}>游历时获得的所有奖励数量+{0}%</color>",portCfg.bonus,numColor))
end

function UIChuanSongZhenEarningsWin:onClickArrow(index)
local tweener=self.tweener[index]
if not tweener or not tweener:IsActive()then
local temp=not self.expanded[index]
local item=self.worldList:getChildLayoutGroupGridItem(index-1)
local rotateValue=temp and-90 or 90
local heightValue=temp and self.heights[index]or 0
local sequence=Lua.SequenceProxy.New()
local tweener1=item:SetChildDORotate(_worldCmp.arrowBtn,Vector3.forward*rotateValue,_tweenDuration,DG.Tweening.RotateMode.Fast)
local tweener2=item:SetChildDOSizeDelta(_worldCmp.mask,Vector2.New(1060,heightValue),_tweenDuration)
sequence:Append(tweener1)
sequence:Join(tweener2)
self.expanded[index]=temp
self.tweener[index]=sequence
end
end

function UIChuanSongZhenEarningsWin:closeAllTweener()
for i,v in pairs(self.tweener)do
if v:IsActive()then
v:Kill()
end
end
self.tweener={}
end