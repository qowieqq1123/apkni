







def_class("UISFPYreFightWin",UIWindowBase)









function UISFPYreFightWin:bindComponents()

self.closebutton=UIButton.get(self,0)
self.desc=UIText.get(self,1)
self.rankFirstList=UIObject.get(self,2)
self.quxiaobtn=UIButton.get(self,3)
self.quedingbtn=UIButton.get(self,4)
self.fztitlle=UIText.get(self,5)
self.fztips=UIObject.get(self,6)
self.imgbtn=UIObject.get(self,7)
self.rankFirstPanel=UIObject.get(self,8)
self.fzGrid=UIObject.get(self,9)

self.closebutton:setButtonClick(function()self:onClosebutton()end)

self.quxiaobtn:setButtonClick(function()self:onQuxiaobtn()end)

self.quedingbtn:setButtonClick(function()self:onQuedingbtn()end)



end


function UISFPYreFightWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closebutton);self.closebutton=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.rankFirstList);self.rankFirstList=nil;
_UIObject_release(self.quxiaobtn);self.quxiaobtn=nil;
_UIObject_release(self.quedingbtn);self.quedingbtn=nil;
_UIObject_release(self.fztitlle);self.fztitlle=nil;
_UIObject_release(self.fztips);self.fztips=nil;
_UIObject_release(self.imgbtn);self.imgbtn=nil;
_UIObject_release(self.rankFirstPanel);self.rankFirstPanel=nil;
_UIObject_release(self.fzGrid);self.fzGrid=nil;
end
















local _this
local ab_name="ui/windows/sifangpingyao/sifangpingyao_atlas_pak.ab"



function UISFPYreFightWin:onLoaded(...)
self:bindComponents()
self.selectidx=1
self.selectid=1
_this=self
end


function UISFPYreFightWin:__delete()
self:unbindComponents()
_this=nil
end




function UISFPYreFightWin:onShow(argtable,afterOnloaded)
self.isCheli=false
if argtable then
self.flag=argtable.flag
self.chapter_id=argtable.chapter_id
self.rechallenge=argtable.rechallenge
self.parentwin=argtable.parentwin
self.iscanClose=argtable.iscanClose
if self.iscanClose then
self.imgbtn:setActive(true)
end
local demons_id=SiFangPingYaoModel:getMapIdex()
self.debufflist=cfg_foursideskilldemonsconfig_get(demons_id).debufflist

local record_boss_affinity=SiFangPingYaoModel:getSLrecord()


if self.flag==1 then
self.isCheli=true
self.fztitlle:setText("撤离队伍")
if self.chapter_id<=1 then
local str=FMT.fmt("下次进入将回到<color=#7d3b17>当前章节</color>起点重新挑战，妖王情绪值回至<color=#7d3b17>初始值</color>，\n同时<color=#7d3b17>失去</color>当前章节已获得的法则")
self.desc:setText(str)
else
local strname=record_boss_affinity<=0 and"怒气值"or"亲和值"
local str=FMT.fmt("下次进入将回到<color=#7d3b17>当前章节</color>起点重新挑战，妖王<color=#7d3b17>{0}</color>回至<color=#7d3b17>{1}</color>，\n同时<color=#7d3b17>失去</color>当前章节已获得的法则",strname,math.abs(record_boss_affinity))
self.desc:setText(str)
end
self:refreahFaZe()


elseif self.flag==2 then
self.fztitlle:setText("重新挑战")
if self.chapter_id<=1 then

self.quxiaobtn:setActive(false)
self.winlua:SetChildLocalPosX(self.quedingbtn:getID(),0)
local str=FMT.fmt("即将回到<color=#7d3b17>当前章节</color>起点重新挑战，妖王情绪值回至<color=#7d3b17>初始值</color>，\n同时<color=#7d3b17>失去</color>当前章节已获得的法则")
self.desc:setText(str)
else
if self.rechallenge==1 then
local str=FMT.fmt("是否回到<color=#7d3b17>第一章节</color>起点重新挑战，妖王情绪值回至<color=#7d3b17>初始值</color>，\n同时<color=#7d3b17>失去</color>所有已获得的法则")
self.desc:setText(str)
else
local strname=record_boss_affinity<=0 and"怒气值"or"亲和值"
local str=FMT.fmt("是否回到<color=#7d3b17>当前章节</color>起点重新挑战，妖王<color=#7d3b17>{0}</color>回至<color=#7d3b17>{1}</color>，\n同时<color=#7d3b17>失去</color>当前章节已获得的法则",strname,math.abs(record_boss_affinity))
self.desc:setText(str)
end
end
self:refreahFaZe()


elseif self.flag==3 then
self.fztitlle:setText("重新挑战")
if self.chapter_id<=1 then
local str=FMT.fmt("是否回到<color=#7d3b17>当前章节</color>起点重新挑战，妖王情绪值回至<color=#7d3b17>初始值</color>，\n同时<color=#7d3b17>失去</color>当前章节已获得的法则")
self.desc:setText(str)
else
if self.rechallenge==1 then
local str=FMT.fmt("是否回到<color=#7d3b17>第一章节</color>起点重新挑战，妖王情绪值回至<color=#7d3b17>初始值</color>，\n同时<color=#7d3b17>失去</color>所有已获得的法则")
self.desc:setText(str)
else
local strname=record_boss_affinity<=0 and"怒气值"or"亲和值"
local str=FMT.fmt("是否回到<color=#7d3b17>当前章节</color>起点重新挑战，妖王<color=#7d3b17>{0}</color>回至<color=#7d3b17>{1}</color>，\n同时<color=#7d3b17>失去</color>当前章节已获得的法则",strname,math.abs(record_boss_affinity))
self.desc:setText(str)
end
end
self:refreahFaZe()
end

end
end


function UISFPYreFightWin:onHide()

end




function UISFPYreFightWin:onClosebutton()

end

function UISFPYreFightWin:onQuxiaobtn()
UIManager:closeWindow("UISFPYreFightWin")
end


function UISFPYreFightWin:onQuedingbtn()
if self.isCheli then
SiFangPingYaoController.send_34_63(1)

else

if self.rechallenge then
local flag=self.rechallenge


SiFangPingYaoController.send_34_62(flag)
end
end
end



function UISFPYreFightWin:refreahFaZe()
self.rankFirstList:setActive(false)
self.fzGrid:setActive(false)

self.bagData=self:get_rule_bag_sort_data()
if self.bagData and#self.bagData>0 then
if#self.bagData<5 then
self.fzGrid:setActive(true)
local len=#self.bagData
self.winlua:SetChildLayoutGroupCreateItems(self.fzGrid:getID(),len)
local grids=_this.winlua:GetChildLayoutGroupGridList(self.fzGrid:getID())
for i=1,len do
local item=grids[i-1]
local data=self.bagData[i]
local ruleId=data.param_1
local ruleCfg=cfgHelper.getSSlawRule(ruleId)
if ruleCfg then
local image=ruleCfg.image
local name=ruleCfg.name
local quality=data.param_2
local qualityDesc=cfg_secretscenebaseconfig_get(1).rule_quality
local desc=ruleCfg.desc
local attrdesc=ruleCfg.attrdesc
local descparm=ruleCfg.descparm
if descparm and descparm[data.param_2]and next(descparm[data.param_2])then
desc=string.format(desc,unpack(descparm[data.param_2]))
if attrdesc then
attrdesc=string.format(attrdesc,unpack(descparm[data.param_2]))
end
end
local color_cfg=qualityDesc[quality]
item:SetChildText(2,FMT.fmt("<color=#{0}>{1}</color>",color_cfg[2],name))
item:SetChildIcon(3,image,false)
item:SetChildText(4,desc)

local frameImg=iconHelper.getRuleQualityIcon(quality)
item:SetChildIcon(1,frameImg,false)

if self.debufflist[ruleId]then

item:SetChildCSImageSprite(1,ab_name,"frame_fazefumian1")
item:SetChildText(2,FMT.fmt("<color=#22201f>{0}</color>",name))
end

local isnum=data.param_4 or 0
if isnum==0 then
item:SetChildActive(7,false)
else
item:SetChildActive(7,true)
item:SetChildText(8,isnum)
end

if ruleCfg.zhuanshuImg then
item:SetChildActive(9,true)
item:SetChildIcon(9,FMT.fmt('image_zhuan_shu_faze_{0}',ruleCfg.zhuanshuImg),true)
else
item:SetChildActive(9,false)
end

item:SetChildButtonClick(6,function()
if _this==nil then return end
_this:onClickItemCallback(i)
end)
end
end

else
self.rankFirstList:setActive(true)
self.rankFirstList:setChildScrollViewCreateGrids(#self.bagData,#self.bagData)
local grids=self.rankFirstList:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local item=grids[i-1]
local data=self.bagData[i]
local ruleId=data.param_1
local ruleCfg=cfgHelper.getSSlawRule(ruleId)
if ruleCfg then
local image=ruleCfg.image
local name=ruleCfg.name
local quality=data.param_2
local qualityDesc=cfg_secretscenebaseconfig_get(1).rule_quality
local desc=ruleCfg.desc
local attrdesc=ruleCfg.attrdesc
local descparm=ruleCfg.descparm
if descparm and descparm[data.param_2]and next(descparm[data.param_2])then
desc=string.format(desc,unpack(descparm[data.param_2]))
if attrdesc then
attrdesc=string.format(attrdesc,unpack(descparm[data.param_2]))
end
end
local color_cfg=qualityDesc[quality]
item:SetChildText(2,FMT.fmt("<color=#{0}>{1}</color>",color_cfg[2],name))
item:SetChildIcon(3,image,false)
item:SetChildText(4,desc)


local frameImg=iconHelper.getRuleQualityIcon(quality)
item:SetChildIcon(1,frameImg,false)

if self.debufflist[ruleId]then

item:SetChildCSImageSprite(1,ab_name,"frame_fazefumian1")
item:SetChildText(2,FMT.fmt("<color=#22201f>{0}</color>",name))
end

local isnum=data.param_4 or 0
if isnum==0 then
item:SetChildActive(7,false)
else
item:SetChildActive(7,true)
item:SetChildText(8,isnum)
end

if ruleCfg.zhuanshuImg then
item:SetChildActive(9,true)
item:SetChildIcon(9,FMT.fmt('image_zhuan_shu_faze_{0}',ruleCfg.zhuanshuImg),true)
else
item:SetChildActive(9,false)
end


item:SetChildButtonClick(6,function()
if _this==nil then return end
_this:onClickItemCallback(i)
end)
end
end
end
else
self.fztips:setActive(true)
end
end


function UISFPYreFightWin:get_rule_bag_sort_data()
local sortList={}
local allfz_list=SiFangPingYaoModel:getBagFZ_list()
local thislist=table.weakCopy(allfz_list)
local deletFZ={}

if self.flag==1 then
for k,v in ipairs(thislist)do
if v.param_3 and v.param_3>=self.chapter_id then
deletFZ[#deletFZ+1]=v
end
end
elseif self.flag==2 or self.flag==3 then
if self.chapter_id==1 then
for k,v in ipairs(thislist)do
if v.param_3 and v.param_3>=self.chapter_id then
deletFZ[#deletFZ+1]=v
end
end
else
if self.rechallenge==1 then
for k,v in ipairs(thislist)do
if v.param_3 and v.param_3>=self.rechallenge then
deletFZ[#deletFZ+1]=v
end
end
else
for k,v in ipairs(thislist)do
if v.param_3 and v.param_3>=self.chapter_id then
deletFZ[#deletFZ+1]=v
end
end
end
end
end


if deletFZ and next(deletFZ)then
sortList=table.weakCopy(deletFZ)







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


function UISFPYreFightWin:onClickItemCallback(idx)
if self.bagData and self.bagData[idx]then
local data=self.bagData[idx]
local ruleId=data.param_1
local level=data.param_2
local fznum=data.param_4 or 0
if ruleId then
self:showWindow("UISFPYRuleViewWin",{id=ruleId,level=level,changefa=false,fznum=fznum})
end
end
end
