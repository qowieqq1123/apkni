









worldHUDResPoint_Monster=simple_class(worldHUDBase)
worldHUDResPoint_Monster.name="worldHUDResPoint_Monster"

local dropStrong={25,50}
local dropInterval=0.25
local dropFade=1
local dropDuration=1
local dropWait=0.5

local dropBezierCurvePoints={Vector3.New(-50,0,0),Vector3.New(0,-15,0),Vector3.New(50,0)}

local childCmp={
fightImg=0,
emotTx=1,
emotBg=2,
dropRoot=3,
lvBg=4,
lvTx=5,
timeBg=6,
timeTx=7,
headRoot=8,
topRoot=9,
this=10,
}

function worldHUDResPoint_Monster:onCreate()
if not self.dropTweeners then self.dropTweeners={}end



self.cmp:SetChildActive(childCmp.emotBg,false)

self.guid=self.data[2]
self.subIdx=self.data[3]
self.subType=self.data[4]
self.subId=self.data[5]

local entity=worldController:getUnitModelEntity(self.key)
local camera=worldController:getCameraTransform()
local modelSetting=worldController:getUnitModelSetting(self.key)
local flipX=worldController:getUnitModelFlip(self.key)
if entity and camera and modelSetting.body then
local flipX=worldController:getUnitModelFlip(self.key)
local dbCfg=cfgHelper.get1(cfg_dbbodyconfig_get,modelSetting.body)
local headOffset=dbCfg.headPos and Vector3.New(dbCfg.headPos[1],dbCfg.headPos[2],0)or Vector3.zero
headOffset=headOffset*modelSetting.scale
headOffset.x=headOffset.x*(flipX and-1 or 1)
self.cmp:SetChildFollowPointUI(childCmp.headRoot,camera.gameObject,childCmp.this,entity.transform,Vector3.zero,headOffset)




end

if self.subType==eWorldResPointUnitType.Monster then
local cfg=cfgHelper.get1(cfg_worldresbattleconfig_get,self.subId)
self.cmp:SetChildActive(childCmp.lvBg,cfg.hudlevel==true)
if cfg.hudlevel then
local mCfg=cfgHelper.get1(cfg_monstergroup_get,cfg.groupid)
local name=worldHUDModel:getMonsterHUDNameBg(mCfg.monType)
self.cmp:SetChildCSImageSprite(childCmp.lvBg,"ui/windows/world/sharedtextures/dashijie_component_altas.ab",name)

local pointData=worldResPointDataModel:getPointData(self.guid)
local level=mCfg.levelUp and pointData.level or mCfg.level
local lvStr=FMT.fmt("【{0}】",UIDiscipleModel.getJJNameCommon(level,3))
local nameColor=worldHUDModel:getMonsterHUDNameColor(mCfg.monType)
if nameColor then
lvStr=FMT.cfmt(nameColor,lvStr)
end
self.cmp:SetChildOutlineEnabled(childCmp.lvTx,name==nil)
self.cmp:SetChildText(childCmp.lvTx,lvStr)


end
else
self.cmp:SetChildActive(childCmp.lvBg,false)

end
self:clearDrop()
self:startCD()
worldHUDBase.onCreate(self)
end

function worldHUDResPoint_Monster:onDestory()
self:hideEmot()
self:endCD()
self:clearDrop()
end

function worldHUDResPoint_Monster:onUpdate()











































end

function worldHUDResPoint_Monster:showEmot(emot,cd,callback)

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

function worldHUDResPoint_Monster:hideEmot()
self.cmp:SetChildActive(childCmp.emotBg,false)
self.cmp:SetChildText(childCmp.emotTx,"")
if self.emotTimer then
self.emotTimer:cancel()
self.emotTimer=nil
end
end

function worldHUDResPoint_Monster:dropItem(num,rewards,effect,effecLimitColor,callback)
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

function worldHUDResPoint_Monster:delayDropCallback(num,callback)
if callback then
self.dropTimer=timer.new()
local dropCallback=function()
self:killDropCallback()
callback()
end
self.dropTimer:start(self:getDropTime(num),dropCallback,1)
end
end

function worldHUDResPoint_Monster:killDropCallback()
if self.dropTimer then
self.dropTimer:cancel()
self.dropTimer=nil
end
end

function worldHUDResPoint_Monster:getDropTime(num)
return(num-1)*dropInterval+dropDuration+dropFade
end

function worldHUDResPoint_Monster:clearDrop()
for i,v in ipairs(self.dropTweeners)do
if v:IsActive()then
v:Kill(true)
end
end
self.dropTweeners={}
self.cmp:SetChildLayoutGroupClearAllItems(childCmp.dropRoot)
self:killDropCallback()
end

function worldHUDResPoint_Monster:startCD()

self.overTime=worldResPointBaseModel:getOverTime(self.guid)
self:endCD()
if self.overTime then
local cdTime=self.overTime-timeHelper.getServerShortTime()
self.cmp:SetChildActive(childCmp.timeBg,true)
self.cmp:SetChildText(childCmp.timeTx,timeHelper.format_time_stamp(cdTime))
self.cdTimer=timer.new()
self.cdTimer:start(1,function()
cdTime=cdTime-1
self.cmp:SetChildText(childCmp.timeTx,timeHelper.format_time_stamp(cdTime))
if cdTime<=0 then
self.cmp:SetChildActive(childCmp.timeBg,false)
end
end,cdTime)
else
self.cmp:SetChildActive(childCmp.timeBg,false)
end
end

function worldHUDResPoint_Monster:endCD()
if self.cdTimer then
self.cdTimer:cancel()
self.cdTimer=nil
end
end