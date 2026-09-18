







def_class("UIMysteryRuleBagWin",UIWindowBase)









function UIMysteryRuleBagWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.ListPanel=UIObject.get(self,1)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,2)
self.desc=UIText.get(self,3)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UIMysteryRuleBagWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.ListPanel);self.ListPanel=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
_UIObject_release(self.desc);self.desc=nil;
end



















local ItemCmpIndex=
{
name=0,
desc=1,
skill=2,
icon=3,
quality=4,
frame=5,
root=6,
zhuanshu=7,
}


local listCols=7
local listRows=3


function UIMysteryRuleBagWin:onLoaded(...)
self:bindComponents()
local _onClickItemCallback=function(...)
self:onClickItemCallback(...)
end
self.ListPanel:setChildScrollViewInit(-1,true,_onClickItemCallback,nil)

end


function UIMysteryRuleBagWin:__delete()
self:unbindComponents()
end




function UIMysteryRuleBagWin:onShow(argtable,afterOnloaded)
if argtable then
self.closeCB=argtable.closeCB
end
self:updateData()
self:refreshUI()
end



function UIMysteryRuleBagWin:updateData()

self.list={}

self.bagData=MysteryModel:get_rule_bag_sort_data()
local environmentList=mysteryEnvironmentEffectModel:get_environment()
self.bagDataLen=#self.bagData
for i,v in ipairs(self.bagData)do
if not environmentList[v.id]then
local ruleCfg=cfgHelper.getSSlawRule(v.id)
local level=v.level
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
local frameImg=iconHelper.getRuleQualityIcon(quality)
self.list[#self.list+1]=
{
name=FMT.fmt("<color=#{0}>{1}</color>",color_cfg[2],name),
desc=desc,
skill=false,
image=image,
quality=FMT.fmt("<color=#{0}>{1}</color>",color_cfg[2],color_cfg[1]),
frame=frameImg,
id=v.id,
level=level,
zhuanshuImg=ruleCfg.zhuanshuImg,
}
end
end

self.pSkillDataLen=0
















local remainItems=listRows*listCols-#self.list
for i=1,remainItems do
self.list[#self.list+1]=
{
name="",
desc="",
skill=false,
image=nil,
quality="",
frame='frame_fazekapaibeimian',
}
end
end



function UIMysteryRuleBagWin:refreshUI()
self:refreshList()
end

function UIMysteryRuleBagWin:refreshList()


local moveY={0,15,20,25,20,15,0}

local rotateZ={4.5,3,1.5,0,-1.5,-3,-4.5}
self.ListPanel:setChildScrollViewCreateGrids(#self.list,listCols)
local grids=self.ListPanel:getChildScrollViewItemWidgets()
for i,v in ipairs(self.list)do
local item=grids[i-1]
if item then
item:SetChildText(ItemCmpIndex.name,v.name)
item:SetChildText(ItemCmpIndex.desc,v.desc)
item:SetChildActive(ItemCmpIndex.skill,v.skill)
item:SetChildCSImageIcon(ItemCmpIndex.icon,v.image,false)
item:SetChildCSImageIcon(ItemCmpIndex.frame,v.frame,false)
if v.image then
item:SetChildIconColor(ItemCmpIndex.frame,Color(1,1,1,1))
else
item:SetChildIconColor(ItemCmpIndex.frame,Color(1,1,1,0.5))
end



local index=(i-1)%listCols+1
item:SetChildLocalPosition(ItemCmpIndex.root,Vector3(0,moveY[index],0))
item:SetChildRotation(ItemCmpIndex.root,0,0,rotateZ[index])


if v.zhuanshuImg then
item:SetChildActive(ItemCmpIndex.zhuanshu,true)
item:SetChildIcon(ItemCmpIndex.zhuanshu,FMT.fmt('image_zhuan_shu_faze_{0}',v.zhuanshuImg),true)
else
item:SetChildActive(ItemCmpIndex.zhuanshu,false)
end
end
end
end













































function UIMysteryRuleBagWin:onClickItemCallback(clickCount,id)
id=id+1
if self.list[id]then
local ruleId=self.list[id].id
local level=self.list[id].level
if ruleId then
UIFullMysteryMainControl:showWindow("UIMysteryRuleViewWin",{id=ruleId,level=level})
end



end
end


function UIMysteryRuleBagWin:OnEnable()

end


function UIMysteryRuleBagWin:OnDisable()

end

function UIMysteryRuleBagWin:onCloseBtn()
if self.closeCB then
self.closeCB()
end
self:closeSelf()
end


