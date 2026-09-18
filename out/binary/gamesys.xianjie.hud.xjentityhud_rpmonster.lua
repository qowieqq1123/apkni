









local xjEntityHud_RPMonster={}

local dropStrong={25,50}
local dropInterval=0.25
local dropDuration=1
local dropWait=0.5
local dropBezierCurvePoints={Vector3.New(-50,0,0),Vector3.New(0,-15,0),Vector3.New(50,0,0)}

local _widgetChildren={
lvBg=0,
lv=1,
source_1=2,
drops=3,
timeBg=4,
timeTx=5,
source_2_main=6,
source_2_sub=7,
xbimg=8,
source_2_faction=9,
}


function xjEntityHud_RPMonster:onInit()
self.dataGuid=self.data.guid
local data=xianjieModel:getResPointData(self.dataGuid)
local cfg=data:getCfg()
self.needFollow=true

local uiOffset=cfg.uiOffset
local tagOffset=cfg.tagOffset
if uiOffset then
self.uiOffset={}
table.insert(self.uiOffset,Vector2(uiOffset[1],uiOffset[2]))
table.insert(self.uiOffset,Vector2.zero)
table.insert(self.uiOffset,Vector2.zero)
end
if tagOffset then
self.tagOffset={}
table.insert(self.tagOffset,Vector3(tagOffset[1],tagOffset[2],tagOffset[3]))
table.insert(self.tagOffset,Vector3.up*-1.5)
table.insert(self.tagOffset,Vector3.zero)
end
end


function xjEntityHud_RPMonster:onCreateWidget(widget)
local data=xianjieModel:getResPointData(self.dataGuid)
if data.feign then
widget:SetChildActive(_widgetChildren.source_1,false)
widget:SetChildActive(_widgetChildren.source_2_main,false)
widget:SetChildActive(_widgetChildren.source_2_sub,false)
else
local cfg=data:getCfg()
local showLv=xianjieModel:excuteResPointResourceHandle(data.source.srctype,"getHUDInfo")
widget:SetChildActive(_widgetChildren.source_1,data.source.srctype==xjResPointSourceType.ePlot or data.source.srctype==xjResPointSourceType.eMoJie)
if data.source.srctype==xjResPointSourceType.eTask then
local taskcfg=taskModel:getTaskConfig(data.source.taskid)
if taskcfg.xianjietype then
local faction=taskModel:getXJFactionByTaskFlag(taskcfg.xianjietype)
if faction then
widget:SetChildActive(_widgetChildren.source_2_main,false)
widget:SetChildActive(_widgetChildren.source_2_sub,false)
widget:SetChildActive(_widgetChildren.source_2_faction,true)

local spName=cfgHelper.get2(cfg_xianjieforceconfig_get,faction,"factionTaskFlagIcon")
widget:SetChildCSImageSprite(_widgetChildren.source_2_faction,globalABLookup.xiangong,spName)
else
widget:SetChildActive(_widgetChildren.source_2_main,taskcfg.tasklineid==taskModel.lineMain)
widget:SetChildActive(_widgetChildren.source_2_sub,taskcfg.tasklineid~=taskModel.lineMain)
widget:SetChildActive(_widgetChildren.source_2_faction,false)
end
else
widget:SetChildActive(_widgetChildren.source_2_main,taskcfg.tasklineid==taskModel.lineMain)
widget:SetChildActive(_widgetChildren.source_2_sub,taskcfg.tasklineid~=taskModel.lineMain)
widget:SetChildActive(_widgetChildren.source_2_faction,false)
end
else
widget:SetChildActive(_widgetChildren.source_2_main,false)
widget:SetChildActive(_widgetChildren.source_2_sub,false)
widget:SetChildActive(_widgetChildren.source_2_faction,false)
end
if showLv then
widget:SetChildCSImageSprite(_widgetChildren.lvBg,globalABLookup.xjhudicons,xjMonsterHUDBg[cfg.type])
widget:SetChildText(_widgetChildren.lv,FMT.fmt('{0}阶',cfg.stage))
widget:SetChildButtonClick(_widgetChildren.lvBg,function()
xianjieController:onClickResPoint(self.dataGuid)
end)
else
widget:SetChildCSImageIcon(_widgetChildren.lvBg,"",false)
widget:SetChildText(_widgetChildren.lv,"")
end
end
widget:SetChildActive(_widgetChildren.xbimg,false)
self:changeMonsterXianBangImg(true)

widget:SetChildActive(_widgetChildren.timeBg,data.endTime>0)
end


function xjEntityHud_RPMonster:onRemoveWidget(widget)
widget:SetChildLayoutGroupClearAllItems(_widgetChildren.drops)
widget:SetChildActive(_widgetChildren.xbimg,false)
if self.dropTweeners then
for i,v in ipairs(self.dropTweeners)do
if v:IsActive()then
v:Kill(true)
end
end
self.dropTweeners=nil
end
end


function xjEntityHud_RPMonster:onDelete()

end

function xjEntityHud_RPMonster:onUpdate()
local data=xianjieModel:getResPointData(self.dataGuid)
local widget=self:getWidget()
if widget and data and data.endTime>0 then
local nowTime=timeHelper.getServerShortTime()
local least=math.max(data.endTime-nowTime,0)
local timeStr=FMT.fmt("{0}<color=#76D81E>后消失</color>",timeHelper.format_time_stamp3(least))
widget:SetChildText(_widgetChildren.timeTx,timeStr)
end
end

function xjEntityHud_RPMonster:refreshInfo()
local widget=self:getWidget()
if widget then
self:onCreateWidget(widget)
end
end

function xjEntityHud_RPMonster:doDropAnim(rewards,callback)
if rewards==nil or#rewards<=0 then
if callback then
callback()
end
return
end
local widget=self:getWidget()
local num=#rewards
widget:SetChildLayoutGroupCreateItems(_widgetChildren.drops,num)
self.dropTweeners={}
for i,v in ipairs(rewards)do
local itemId=v.itemid
local itemCfg=itemsConfig.getConfig(itemId)
local itemCmp=widget:GetChildLayoutGroupGridItem(_widgetChildren.drops,i-1)
itemCmp:SetChildIcon(0,iconHelper.getIconName(itemId),true)
local sequence=Lua.SequenceProxy.New()
sequence:AppendInterval(dropInterval*(i-1))
local strong=math.random(dropStrong[1],dropStrong[2])
local point=mathHelper.getPoint_OnBezierCurvePoint(dropBezierCurvePoints,i/(num+1))
local tf=CS.UIHelper.GetRectTransform(itemCmp.gameObject)
local tweenerJump=Lua.DOTweenProxyExtensions.DOLocalJump(tf,point,strong,1,dropDuration,false)
sequence:Append(tweenerJump)
sequence:AppendInterval(dropWait*(num-i))
local tweenerFade=itemCmp:SetChildImageDOColor(0,Color.clear,1,i==num and callback or nil)
sequence:Append(tweenerFade)
table.insert(self.dropTweeners,sequence)
end
end


function xjEntityHud_RPMonster:changeMonsterXianBangImg(flag)
local data=xianjieModel:getResPointData(self.dataGuid)
if data and data.source and data.source.srctype==xjResPointSourceType.eXianBangTask then
local widget=self:getWidget()
if flag and widget then
widget:SetChildActive(_widgetChildren.xbimg,true)
end
end
end

return xjEntityHud_RPMonster