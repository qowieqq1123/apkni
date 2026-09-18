









worldHUDFamily=simple_class(worldHUDBase)
worldHUDFamily.name="worldHUDFamily"

function worldHUDFamily:onCreate()
worldHUDBase.onCreate(self)
end

function worldHUDFamily:onUpdate()
self.cmp:SetChildButtonClick(0,function()
worldController.onClickUnit(self.data)
end)
self.cmp:SetChildButtonClick(6,function()
worldController.onClickUnit(self.data)
end)
local guid=self.data[2]
local jiazuName=worldXiuZhenJiaZuModel:getFamilyName(guid)
self.cmp:SetChildText(1,jiazuName)

local familyData=worldXiuZhenJiaZuModel:getFamilyDataByGuid(guid)
local state=familyData.state
local jinzhuzhong=worldXiuZhenJiaZuModel:isJinZhuZhong(guid)
self.cmp:SetChildActive(2,jinzhuzhong or state~=familyState.neutral)
self.cmp:SetChildActive(4,jinzhuzhong)

if jinzhuzhong then
self.cmp:SetProgressBarAniWithTwoParams(4,0,100)
local jinzhutime=cfgHelper.get2(cfg_xiuzhenfamilybasicconfig_get,worldModel.world,'jinzhutime')
self.cmp:SetProgressBarAniWithThreeParams(4,100,100,jinzhutime)
self.cmp:SetProgressBarAniUpdateAction(4,function(x,y)
local rate=math.ceil(x*100)
self.cmp:SetChildText(5,FMT.fmt('{0}%',rate))
end)
self.cmp:SetChildText(3,"")
else
if state~=familyState.neutral then
local stateStr=''
if state==familyState.player then
stateStr=FMT.fmt('附庸：<color=#fd8950>{0}</color>',UISettingModel:getZMName())
self.cmp:SetChildText(3,stateStr)
else
stateStr='附庸：<color=#fd8950>系统宗门</color>'
end
self.cmp:SetChildText(3,stateStr)
end
end

self.cmp:SetChildActive(6,familyData.firstRewardFlag~=0)
if familyData.firstRewardFlag~=0 then
if self.data.tweener then
self.data.tweener:Rewind()
self.data.tweener:Kill()
self.data.tweener=nil
end


self.cmp:SetChildRotation(6,0,0,0)
local tweener=self.cmp:SetChildDOPunchRotation(6,Vector3(0,0,15),2,6,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.data.tweener=tweener
end
end
