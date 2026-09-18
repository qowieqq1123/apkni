









local xjEntityHud_RPCollectible={}

local dropStrong={25,50}
local dropInterval=0.25
local dropDuration=1
local dropWait=0.5
local dropBezierCurvePoints={Vector3.New(-50,0,0),Vector3.New(0,-15,0),Vector3.New(50,0,0)}


function xjEntityHud_RPCollectible:onInit()
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
end
if tagOffset then
self.tagOffset={}
table.insert(self.tagOffset,Vector3(tagOffset[1],tagOffset[2],tagOffset[3]))
table.insert(self.tagOffset,Vector3.zero)
end
end


function xjEntityHud_RPCollectible:onCreateWidget(widget)
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)
self:changeCollXianBangImg(false)
end


function xjEntityHud_RPCollectible:onRemoveWidget(widget)
widget:SetChildLayoutGroupClearAllItems(0)
widget:SetChildActive(1,false)
widget:SetChildActive(2,false)

if self.dropTweeners then
for i,v in ipairs(self.dropTweeners)do
if v:IsActive()then

v:Kill()
end
end
self.dropTweeners=nil
end
end


function xjEntityHud_RPCollectible:onDelete()

end

function xjEntityHud_RPCollectible:changeCollXianBangImg(flag)
local data=xianjieModel:getResPointData(self.dataGuid)
if data and data.source and data.source.srctype==xjResPointSourceType.eXianBangTask then
local widget=self:getWidget()









widget:SetChildActive(1,true)
widget:SetChildActive(2,false)

local march=xianjieModel:getResPointMarch(data.rpGuid)
if march then
local teamHandle=march:getTeamHandle()
if teamHandle then
local state,times,lerp=teamHandle:getTeamState()
if lerp and lerp>0 and state==xjMarchTeamStateType.eBattle then
widget:SetChildActive(1,false)
widget:SetChildActive(2,true)
end
end
end
end
end

function xjEntityHud_RPCollectible:doDropAnim(rewards,callback)
if rewards==nil or#rewards<=0 then
if callback then
callback()
end
return
end
local widget=self:getWidget()
local num=#rewards
widget:SetChildLayoutGroupCreateItems(0,num)
self.dropTweeners={}
for i,v in ipairs(rewards)do
local itemId=v[1]
local itemCfg=itemsConfig.getConfig(itemId)
local itemCmp=widget:GetChildLayoutGroupGridItem(0,i-1)
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

return xjEntityHud_RPCollectible