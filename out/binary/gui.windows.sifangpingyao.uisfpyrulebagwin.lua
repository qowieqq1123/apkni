







def_class("UISFPYRuleBagWin",UIWindowBase)









function UISFPYRuleBagWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.ListPanel=UIObject.get(self,1)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,2)
self.desc=UIText.get(self,3)
self.fztitlle=UIText.get(self,4)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISFPYRuleBagWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.ListPanel);self.ListPanel=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.fztitlle);self.fztitlle=nil;
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
fznumbg=8,
fznum=9,
}


local listCols=7
local listRows=3
local ab_name="ui/windows/sifangpingyao/sifangpingyao_atlas_pak.ab"


function UISFPYRuleBagWin:onLoaded(...)
self:bindComponents()
local _onClickItemCallback=function(...)
self:onClickItemCallback(...)
end
self.ListPanel:setChildScrollViewInit(-1,true,_onClickItemCallback,nil)

end


function UISFPYRuleBagWin:__delete()
self:unbindComponents()
end




function UISFPYRuleBagWin:onShow(argtable,afterOnloaded)
if argtable then
self.closeCB=argtable.closeCB
self.parentwin=argtable.parentwin
self.changefa=argtable.changefa
if self.changefa then
self.fztitlle:setText("选择法则")
else
self.fztitlle:setText("法则背包")
end
end
local demons_id=SiFangPingYaoModel:getMapIdex()
self.debufflist=cfg_foursideskilldemonsconfig_get(demons_id).debufflist
self:updateData()
self:refreshUI()
end



function UISFPYRuleBagWin:updateData()
self.list={}
self.bagData=self:get_rule_bag_sort_data()


self.bagDataLen=#self.bagData
for i,v in ipairs(self.bagData)do
local ruleCfg=cfgHelper.getSSlawRule(v.param_1)
local level=v.param_2
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
name2=name,
desc=desc,
skill=false,
image=image,
quality=FMT.fmt("<color=#{0}>{1}</color>",color_cfg[2],color_cfg[1]),
frame=frameImg,
id=v.param_1,
level=level,
zhuanshuImg=ruleCfg.zhuanshuImg,
fznum=v.param_4 or 0
}
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
fznum=0,
}
end
end


function UISFPYRuleBagWin:get_rule_bag_sort_data()
local sortList={}
local allfz_list=SiFangPingYaoModel:getBagFZ_list()

if allfz_list and next(allfz_list)then
sortList=table.weakCopy(allfz_list)
for k,v in ipairs(sortList)do
local flag=self.debufflist[v.param_1]
local stage=flag and 0 or 1
local weight=stage*100000000+v.param_2*10000000+v.param_1
v.weight=weight
end
table.sort(sortList,function(a,b)
return a.weight>b.weight
end)
end
return sortList
end




function UISFPYRuleBagWin:refreshUI()
self:refreshList()
end

function UISFPYRuleBagWin:refreshList()


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

if self.debufflist[v.id]then

item:SetChildCSImageSprite(ItemCmpIndex.frame,ab_name,"frame_fazefumian1")
item:SetChildText(ItemCmpIndex.name,FMT.fmt("<color=#22201f>{0}</color>",v.name2))
end

if v.image then
item:SetChildIconColor(ItemCmpIndex.frame,Color(1,1,1,1))
else
item:SetChildIconColor(ItemCmpIndex.frame,Color(1,1,1,0.5))
end

local isnum=v.fznum
if isnum==0 then
item:SetChildActive(ItemCmpIndex.fznumbg,false)
else
item:SetChildActive(ItemCmpIndex.fznumbg,true)
item:SetChildText(ItemCmpIndex.fznum,isnum)
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



function UISFPYRuleBagWin:onClickItemCallback(clickCount,id)

id=id+1
if self.list[id]then
local ruleId=self.list[id].id
local level=self.list[id].level
local fznum=self.list[id].fznum
if ruleId then
if self.parentwin then
self.parentwin:showWindow("UISFPYRuleViewWin",{id=ruleId,level=level,changefa=self.changefa,fznum=fznum})
else
self:showWindow("UISFPYRuleViewWin",{id=ruleId,level=level,changefa=false,fznum=fznum})
end
end
end
end


function UISFPYRuleBagWin:OnEnable()

end


function UISFPYRuleBagWin:OnDisable()

end

function UISFPYRuleBagWin:onCloseBtn()
if self.changefa then
if self.closeCB then
self.closeCB()
end
self:closeSelf()
else
if self.closeCB then
self.closeCB()
end
self:closeSelf()
end
end
