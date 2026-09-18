









worldHUDResPoint_Treasure=simple_class(worldHUDBase)
worldHUDResPoint_Treasure.name="worldHUDResPoint_Treasure"

local dropStrong={25,50}
local dropInterval=0.25
local dropDuration=1
local dropWait=0.5
local dropTweeners={}
local dropBezierCurvePoints={Vector3.New(-50,0,0),Vector3.New(0,-15,0),Vector3.New(50,0)}

function worldHUDResPoint_Treasure:onCreate()
self.cmp:SetChildButtonClick(1,function()
worldController.onClickUnit(self.data)
end)
worldHUDBase.onCreate(self)
end

function worldHUDResPoint_Treasure:onUpdate()

end

function worldHUDResPoint_Treasure:onDestory()
self.cmp:SetChildLayoutGroupClearAllItems(0)

for i,v in ipairs(dropTweeners)do
if v:IsActive()then
v:Kill(true)
end
end
dropTweeners={}
end

function worldHUDResPoint_Treasure:dropItem(num,rewards,effect,effecLimitColor,callback)
self.cmp:SetChildLayoutGroupCreateItems(0,num)
math.randomseed(timeHelper.getServerShortTime())
for i,v in ipairs(rewards or{})do
local itemId=v.param_1
local itemNum=v.param_2
local itemCfg=itemsConfig.getConfig(itemId)
local itemColor=itemCfg.color
local itemCmp=self.cmp:GetChildLayoutGroupGridItem(0,i-1)
itemCmp:SetChildIcon(1,iconHelper.getIconName(itemId),false)





local sequence=Lua.SequenceProxy.New()
sequence:AppendInterval(dropInterval*(i-1))
local strong=math.random(dropStrong[1],dropStrong[2])
local point=mathHelper.getPoint_OnBezierCurvePoint(dropBezierCurvePoints,i/(num+1))
local tf=CS.UIHelper.GetRectTransform(itemCmp.gameObject)
local tweenerJump=Lua.DOTweenProxyExtensions.DOLocalJump(tf,point,strong,1,dropDuration,false)
sequence:Append(tweenerJump)
sequence:AppendInterval(dropWait*(num-i))
local tweenerFade=itemCmp:SetChildImageDOColor(1,Color.clear,1,i==num and callback or nil)
sequence:Append(tweenerFade)
table.insert(dropTweeners,sequence)
end
end