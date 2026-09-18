







def_class("UISFPYRuleSelectWin",UIWindowBase)









function UISFPYRuleSelectWin:bindComponents()

self.close2Button=UIButton.get(self,0)
self.ListPanel=UIObject.get(self,1)
self.descBg=UIObject.get(self,2)
self.chooseButton=UIButton.get(self,3)
self.bagButton=UIButton.get(self,4)
self.desc=UIText.get(self,5)

self.close2Button:setButtonClick(function()self:onClose2Button()end)

self.chooseButton:setButtonClick(function()self:onChooseButton()end)

self.bagButton:setButtonClick(function()self:onBagButton()end)



end


function UISFPYRuleSelectWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.close2Button);self.close2Button=nil;
_UIObject_release(self.ListPanel);self.ListPanel=nil;
_UIObject_release(self.descBg);self.descBg=nil;
_UIObject_release(self.chooseButton);self.chooseButton=nil;
_UIObject_release(self.bagButton);self.bagButton=nil;
_UIObject_release(self.desc);self.desc=nil;
end

















local selectID
local selectIndex
local selectIdx


local ItemCmpIndex=
{
name=0,
desc=1,
select=2,
icon=3,
quality=4,
bg=5,
root=6,
notActive=7,
zhuanshu=8,
}



local movePos=
{
{Vector3(0,0,0)},
{Vector3(0,0,0),Vector3(0,0,0)},
{Vector3(10,-30,0),Vector3(0,0,0),Vector3(-10,-30,0)},
}
local moveStartPos=
{
{Vector3(0,0,0)},
{Vector3(0,0,0),Vector3(0,0,0)},
{Vector3(370,-30,0),Vector3(0,-30,0),Vector3(-370,-30,0)},
}

local rotateZ=
{
{0},
{0,0},
{5,0,-5},
}


function UISFPYRuleSelectWin:onLoaded(...)
self:bindComponents()
end


function UISFPYRuleSelectWin:__delete()
selectID=nil
selectIndex=nil
selectIdx=nil
self.enterType=nil
self.ruleData=nil
self:unbindComponents()
end




function UISFPYRuleSelectWin:onShow(argtable,afterOnloaded)
if argtable then
self.enterType=argtable.enterType
self.ruleData=SiFangPingYaoModel:getSeltFZ_list()

self.args=argtable
self:initRuleList()
if argtable.dontClose then
self.closeButton:setActive(false)
end
end
end

function UISFPYRuleSelectWin:initRuleList()
if self.ruleData then
local length=#self.ruleData
self.ListPanel:setChildLayoutGroupCreateItems(length)
local gridlist=self.ListPanel:getChildLayoutGroupGridList()
local gridNum=gridlist.Count
local pos=self.ListPanel:getChildPosition()
if gridNum>0 then
for i=1,gridNum do
local item=gridlist[i-1]
if item and self.ruleData[i]then
local ruleID=self.ruleData[i].param_1
local level=self.ruleData[i].param_2 or 1
local ruleCfg=cfgHelper.getSSlawRule(ruleID)
local image=ruleCfg.image
local name=ruleCfg.name
local quality=level
local qualityDesc=cfg_secretscenebaseconfig_get(1).rule_quality
local desc=ruleCfg.desc
local descparm=ruleCfg.descparm
if descparm and descparm[level]and next(descparm[level])then
desc=string.format(desc,unpack(descparm[level]))
end
local color_cfg=qualityDesc[quality]
item:SetChildText(ItemCmpIndex.name,FMT.fmt("<color=#{0}>{1}</color>",color_cfg[2],name))
item:SetChildText(ItemCmpIndex.desc,desc)
item:SetChildCSImageIcon(ItemCmpIndex.icon,image,false)

local frameImg=iconHelper.getRuleQualityIcon(quality)
item:SetChildCSImageIcon(ItemCmpIndex.bg,frameImg,false)

item:SetChildButtonClick(ItemCmpIndex.bg,function()
self:onClickItemCallback(1,i-1)
end)


item:SetChildLocalPosition(ItemCmpIndex.root,moveStartPos[length][i])
item:SetChildRotation(ItemCmpIndex.root,0,0,0)
item:SetChildActive(ItemCmpIndex.root,true)
item:SetChildDOLocalMoveY(ItemCmpIndex.root,0,0.25,function()
item:SetChildDOLocalMove(ItemCmpIndex.root,movePos[length][i],0.25,nil)
item:SetChildDORotation(ItemCmpIndex.root,Vector3(0,0,rotateZ[length][i]),0.25)
end)


item:SetChildShowEffect(ItemCmpIndex.select,10027,true)
item:SetChildActive(ItemCmpIndex.select,false)

item:SetChildActive(ItemCmpIndex.notActive,false)

if ruleCfg.zhuanshuImg then
item:SetChildActive(ItemCmpIndex.zhuanshu,true)
item:SetChildIcon(ItemCmpIndex.zhuanshu,FMT.fmt('image_zhuan_shu_faze_{0}',ruleCfg.zhuanshuImg),true)
else
item:SetChildActive(ItemCmpIndex.zhuanshu,false)
end

item:SetChildButtonClick(ItemCmpIndex.notActive,function()
local pos=Vector2.New(60,155)
local cond_str="该法则尚未记录到法则宝典"
UIManager:showWindow('UIConditionTipsOne',{str=cond_str,posWidget=item,pos=pos})
end)
end
end
end
end
end


function UISFPYRuleSelectWin:onChooseButton()
if selectID and selectIdx then

AudioManager.playAudio(545)
SiFangPingYaoController.send_34_53(selectIdx)
UIManager:closeWindow("UISFPYRuleSelectWin")
end
end


function UISFPYRuleSelectWin:onClickItemCallback(clicknum,index)
if self.ruleData then
local oldIndex
if selectIndex~=index then
oldIndex=selectIndex
end
selectIndex=index
selectIdx=index+1
selectID=self.ruleData[index+1].param_1
local grid=self.ListPanel:getChildLayoutGroupGridItem(index)
if grid then
grid:SetChildActive(ItemCmpIndex.select,true)
grid:SetChildScale(ItemCmpIndex.root,Vector3(1.1,1.1,1))
local ruleCfg=cfgHelper.getSSlawRule(selectID)
local level=self.ruleData[index+1].param_2 or 1
if ruleCfg.attrdesc then
local desc=ruleCfg.attrdesc
local descparm=ruleCfg.descparm

if descparm and descparm[level]and next(descparm[level])then
desc=string.format(desc,unpack(descparm[level]))
end
self.descBg:setActive(true)
self.desc:setText(desc)
else
self.descBg:setActive(false)
self.desc:setText("")
end
end
if oldIndex then
grid=self.ListPanel:getChildLayoutGroupGridItem(oldIndex)
if grid then
grid:SetChildActive(ItemCmpIndex.select,false)
grid:SetChildScale(ItemCmpIndex.root,Vector3(1,1,1))
end
end
end
end

function UISFPYRuleSelectWin:onClose2Button()
UIManager:closeWindow("UISFPYRuleSelectWin")
end


function UISFPYRuleSelectWin:OnEnable()

end


function UISFPYRuleSelectWin:OnDisable()

end


function UISFPYRuleSelectWin:onBagButton()
self.ListPanel:setActive(false)
self:showWindow("UISFPYRuleBagWin",{closeCB=function()
if self and not self.isClose then
self.ListPanel:setActive(true)
end
end})
end
