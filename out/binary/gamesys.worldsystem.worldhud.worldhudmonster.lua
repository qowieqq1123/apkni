









worldHUDMonster=simple_class(worldHUDBase)
worldHUDMonster.name="worldHUDMonster"

local dropStrong={25,50}
local dropInterval=0.25
local dropFade=1
local dropDuration=1
local dropWait=0.5

local dropBezierCurvePoints={Vector3.New(-50,0,0),Vector3.New(0,-15,0),Vector3.New(50,0)}

local childCmp={
nameTx=0,
nameBg=1,
fightImg=2,
emotTx=3,
emotBg=4,
dropRoot=5,
headRoot=6,
this=7,
}

function worldHUDMonster:onCreate()
if not self.dropTweeners then self.dropTweeners={}end
local monster=worldMonsterModel:get_monster_by_posId(self.data[2])
if monster==nil then

end
local cfg=cfgHelper.get1(cfg_worldmonstergroupconfig_get,monster.worldMonsterId)
local mCfg=cfgHelper.get1(cfg_monstergroup_get,cfg.monsterGroupId)
self.cmp:SetChildButtonClick(childCmp.fightImg,function()
worldController.onClickUnit(self.data)
end)



local entity=worldController:getUnitModelEntity(self.key)
local camera=worldController:getCameraTransform()
local modelSetting=worldController:getUnitModelSetting(self.key)
local flipX=worldController:getUnitModelFlip(self.key)
if entity and camera and modelSetting.body then
local flipX=worldController:getUnitModelFlip(self.key)
local dbCfg=cfgHelper.get1(cfg_dbbodyconfig_get,modelSetting.body)
local lOffset=dbCfg.headPos and Vector3.New(dbCfg.headPos[1],dbCfg.headPos[2])or Vector3.zero
lOffset=lOffset*modelSetting.scale
lOffset.x=lOffset.x*(flipX and-1 or 1)
self.cmp:SetChildFollowPointUI(childCmp.headRoot,camera.gameObject,childCmp.this,entity.transform,Vector3.zero,lOffset)
end

self.cmp:SetChildActive(childCmp.nameBg,cfg.hudlevel==true)
if cfg.hudlevel then
local name
if mCfg then
name=worldHUDModel:getMonsterHUDNameBg(mCfg.monType)
else
loggerUtil.logErrFMT("怪物组表没有对应id{0}",cfg.monsterGroupId)
end
self.cmp:SetChildCSImageSprite(childCmp.nameBg,"ui/windows/world/sharedtextures/dashijie_component_altas.ab",name)
local level=mCfg.levelUp and monster.level or mCfg.level
local lvStr=FMT.fmt("【{0}】",UIDiscipleModel.getJJNameCommon(level,3))
local nameColor=worldHUDModel:getMonsterHUDNameColor(mCfg.monType)
if nameColor then
lvStr=FMT.cfmt(nameColor,lvStr)
end
self.cmp:SetChildOutlineEnabled(childCmp.nameTx,name==nil)
self.cmp:SetChildText(childCmp.nameTx,lvStr)




end

self.cmp:SetChildActive(childCmp.emotBg,false)
self.cmp:SetChildText(childCmp.emotTx,"")
self.cmp:SetChildActive(childCmp.fightImg,false)
self:clearDrop()
worldHUDBase.onCreate(self)
end

function worldHUDMonster:onDestory()
self:hideEmot()
self:clearDrop()
end

function worldHUDMonster:onUpdate()
















































end

function worldHUDMonster:showEmot(emot,cd,callback)
self.cmp:SetChildActive(childCmp.fightImg,false)
self.cmp:SetChildActive(childCmp.emotBg,true)
self.cmp:SetChildText(childCmp.emotTx,chatEmotHelper.decodeEmot(emot))
if self.emotTimer then
self.emotTimer:cancel()
self.emotTimer=nil
end
if cd then
self.emotTimer=timer.new()
self.emotTimer:start(cd,function()
self:hideEmot()
if callback then
callback()
end
end,1)
end
end

function worldHUDMonster:hideEmot()
self.cmp:SetChildActive(childCmp.emotBg,false)
self.cmp:SetChildText(childCmp.emotTx,"")
if self.emotTimer then
self.emotTimer:cancel()
self.emotTimer=nil
end
end

function worldHUDMonster:dropItem(num,rewards,effect,effecLimitColor,callback)
self.cmp:SetChildLayoutGroupCreateItems(childCmp.dropRoot,num)

self:delayDropCallback(num,callback)
for i,v in ipairs(rewards or{})do
local itemId=v.itemid
local itemNum=v.num
local itemCfg=itemsConfig.getConfig(itemId)

UIManager.rewardInfo(itemsModel.getIconName(v),FMT.fmt('X{0}',itemNum))

local itemColor=itemCfg.color
local itemCmp=self.cmp:GetChildLayoutGroupGridItem(childCmp.dropRoot,i-1)
itemCmp:SetChildIcon(1,itemsModel.getIconName(v),false)





local sequence=Lua.SequenceProxy.New()
sequence:AppendInterval(dropInterval*(i-1))
local strong=math.random(dropStrong[1],dropStrong[2])
local point=mathHelper.getPoint_OnBezierCurvePoint(dropBezierCurvePoints,i/(num+1))
local tf=CS.UIHelper.GetRectTransform(itemCmp.gameObject)
local tweenerJump=Lua.DOTweenProxyExtensions.DOLocalJump(tf,point,strong,1,dropDuration,false)
sequence:Append(tweenerJump)
sequence:AppendInterval(dropWait*(num-i))
local tweenerFade=itemCmp:SetChildImageDOColor(1,Color.clear,dropFade,nil)
sequence:Append(tweenerFade)
table.insert(self.dropTweeners,sequence)
end
end

function worldHUDMonster:delayDropCallback(num,callback)
if callback then
self.dropTimer=timer.new()
local dropCallback=function()
self:killDropCallback()
callback()
end
self.dropTimer:start(self:getDropTime(num),dropCallback,1)
end
end

function worldHUDMonster:killDropCallback()
if self.dropTimer then
self.dropTimer:cancel()
self.dropTimer=nil
end
end

function worldHUDMonster:getDropTime(num)
return(num-1)*dropInterval+dropDuration+dropFade
end

function worldHUDMonster:clearDrop()
for i,v in ipairs(self.dropTweeners)do
if v:IsActive()then
v:Kill(true)
end
end
self.dropTweeners={}
self.cmp:SetChildLayoutGroupClearAllItems(childCmp.dropRoot)
self:killDropCallback()
end
