







def_class("UIFightBuffStateReport",UIWindowBase)









function UIFightBuffStateReport:bindComponents()

self.noLeftList=UIObject.get(self,0)
self.bgButton=UIButton.get(self,1)
self.closeBtn=UIButton.get(self,2)
self.leftInfo=UIObject.get(self,3)
self.noRightList=UIObject.get(self,4)
self.rightInfo=UIObject.get(self,5)

self.bgButton:setButtonClick(function()self:onBgButton()end)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIFightBuffStateReport:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.noLeftList);self.noLeftList=nil;
_UIObject_release(self.bgButton);self.bgButton=nil;
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.leftInfo);self.leftInfo=nil;
_UIObject_release(self.noRightList);self.noRightList=nil;
_UIObject_release(self.rightInfo);self.rightInfo=nil;
end


















local _iconAb="ui/sharedtextures/uiglobalspriteatlas_1.ab"
local _iconBg={
[1]="image_gwtouxiangpjk_5",
[2]="image_gwtouxiangpjk_4",
[3]="image_gwtouxiangpjk_3",
[4]="image_gwtouxiangpjk_6",
[5]="image_gwtouxiangpjk_2",
}

local _iconMBg={
[monType.LittleMonster]="image_gwtouxiangpjk_2",
[monType.EliteMonster]="image_gwtouxiangpjk_3",
[monType.Boss]="image_gwtouxiangpjk_5",
[monType.GodAnimal]="image_gwtouxiangpjk_7",
}


function UIFightBuffStateReport:onLoaded(...)
self:bindComponents()
self.listInfoCmp=
{
[1]={self.leftInfo,self.noLeftList},
[2]={self.rightInfo,self.noRightList}
}
end


function UIFightBuffStateReport:__delete()
self:unbindComponents()
if self.delay then
self:stopTimerByID(self.delay)
end
if self.battle then
local acc=self.battle:getAccMulti()
self.battle:setAccMulti(acc)
else
Time.timeScale=1
end
end




function UIFightBuffStateReport:onShow(argtable,afterOnloaded)
self.battle=argtable.battle
self:flushData(argtable.battle)
self.delay=self:setTimer(0.5,1,function()
Time.timeScale=0
end)
end


function UIFightBuffStateReport:onHide()

end


function UIFightBuffStateReport:flushData(battle)
local leftData={}
local rightData={}

if battle~=nil then
for i=1,10 do
local ent=battle:getEntity(i)
if ent~=nil then
local hp=ent:getAttribute(entityAttr.hp)
if hp>0 then
local buffs=ent:getAllBuff()
local buffList={}
local buffStateList={}
local count=0
for i,v in pairs(buffs)do
local cfg=v.cfg
if cfg then
local stateType=cfg.stateType
if stateType then
local lastBuff=buffStateList[stateType]
if(not lastBuff)or(lastBuff and lastBuff.buff.round<v.round)then
local sortId=cfg.effectType==0 and 100000+v.id or v.id
if cfg.icon~=0 then
local icon=iconHelper.getBuffIcon(cfg.icon)


table.insert(buffList,{buff=v,sortId=sortId,str=cfg.showWinDesc or"",icon=icon})
count=count+1
end
end
end
end
end






if ent:isLeft()then
if count>0 then
table.sort(buffList,self.compareBuff)
table.insert(leftData,{ent=ent,buffCount=count,buffList=buffList})
end
else
if count>0 then
table.sort(buffList,self.compareBuff)
table.insert(rightData,{ent=ent,buffCount=count,buffList=buffList})
end
end
end
end
end
end
self:flushListData(leftData,1,battle)
self:flushListData(rightData,2,battle)
end

function UIFightBuffStateReport.compareBuff(a,b)
return a.sortId<b.sortId
end

function UIFightBuffStateReport:flushListData(listData,arrowType,battle)
local listCmp=self.listInfoCmp[arrowType][1]
local noList=self.listInfoCmp[arrowType][2]
local curRound,totalRound=0,0
if battle then
curRound,totalRound=battle:getRoundIndexInfo()
end
if next(listData)then
local height=0
local num=#listData
listCmp:setChildLayoutGroupCreateItems(num)
local gridlist=listCmp:getChildLayoutGroupGridList()
for i=1,num do
local item=gridlist[i-1]
local entity=listData[i].ent
local buffCount=listData[i].buffCount
local buffList=listData[i].buffList

if entity then
local image=entity:getImageInfo()
if image then
if entity.typo==fightEntityType.diZi then
local modelParams=UIDiscipleModel:getDiscipleInsideModelInfoByData(image)
comHelper.setChildModelRawImageEx(0,item,modelParams,eHeadCenterType.eHead)

comHelper.setChildModelHeadIconBGByColor(item,3,image.color)
end
else
if entity.typo==fightEntityType.monster then
local mCfg=cfgHelper.get1(cfg_monsterconfig_get,entity:getMonsterID())
if mCfg.color then
comHelper.setChildModelHeadIconBGByColor(item,3,mCfg.color)
else
item:SetChildCSImageSprite(3,_iconAb,_iconMBg[mCfg.monType])
end

comHelper.setChildModelRawImage_monster(item,entity:getMonsterID(),0,0,eHeadCenterType.eHead)
end
end

item:SetChildLayoutGroupCreateItems(1,buffCount)
local height1=buffCount*30+30
if buffCount<=2 then
height1=105
end
item:SetChildSizeDelta(2,290,height1)
height=height+height1
local buffGridList=item:GetChildLayoutGroupGridList(1)
for i=1,buffCount do
local buffGrid=buffGridList[i-1]
local buffData=buffList[i]
local buff=buffData.buff
local str=buffData.str
local icon=buffData.icon
if buffGrid then
buffGrid:SetChildIcon(0,icon,false)

local round=buff.round
buffGrid:SetChildText(2,buff.layer>1 and buff.layer or"")
if round==-1 then
buffGrid:SetChildText(1,FMT.fmt("<color=#efb150>{0}</color>回合{1}",totalRound-curRound+1,str))
else
buffGrid:SetChildText(1,FMT.fmt("<color=#efb150>{0}</color>回合{1}",round,str))
end

end
end
end
end
noList:setActive(false)
listCmp:setChildSizeDelta(290,height)
else
noList:setActive(true)
end
end







function UIFightBuffStateReport:onCloseBtn()
UIManager:invokeUIMethod("UIFightMainTop","onCloseStateBtn")
self:closeSelf()
end

function UIFightBuffStateReport:onBgButton()
UIManager:invokeUIMethod("UIFightMainTop","onCloseStateBtn")
self:closeSelf()
end