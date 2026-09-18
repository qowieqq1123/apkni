







def_class("UISiFangPingYaoExtraWin",UIWindowBase)









function UISiFangPingYaoExtraWin:bindComponents()

self.arrow1=UIObject.get(self,0)
self.skillDescTxt=UIText.get(self,1)
self.skillIcon=UIImage.get(self,2)
self.diziitem1=UIObject.get(self,3)
self.bjbtnimg=UIObject.get(self,4)
self.content=UIText.get(self,5)
self.tiptxtbtn=UIButton.get(self,6)
self.arrow2=UIObject.get(self,7)
self.arrowbtn=UIButton.get(self,8)
self.faZeList=UIObject.get(self,9)
self.fazeMask=UIButton.get(self,10)

self.tiptxtbtn:setButtonClick(function()self:onTiptxtbtn()end)

self.arrowbtn:setButtonClick(function()self:onArrowbtn()end)

self.fazeMask:setButtonClick(function()self:onFazeMask()end)



end


function UISiFangPingYaoExtraWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.arrow1);self.arrow1=nil;
_UIObject_release(self.skillDescTxt);self.skillDescTxt=nil;
_UIObject_release(self.skillIcon);self.skillIcon=nil;
_UIObject_release(self.diziitem1);self.diziitem1=nil;
_UIObject_release(self.bjbtnimg);self.bjbtnimg=nil;
_UIObject_release(self.content);self.content=nil;
_UIObject_release(self.tiptxtbtn);self.tiptxtbtn=nil;
_UIObject_release(self.arrow2);self.arrow2=nil;
_UIObject_release(self.arrowbtn);self.arrowbtn=nil;
_UIObject_release(self.faZeList);self.faZeList=nil;
_UIObject_release(self.fazeMask);self.fazeMask=nil;
end

















local _this



function UISiFangPingYaoExtraWin:onLoaded(...)
self:bindComponents()
_this=self
end


function UISiFangPingYaoExtraWin:__delete()
self:unbindComponents()
_this=nil
end




function UISiFangPingYaoExtraWin:onShow(argtable,afterOnloaded)
if argtable then


self.bjbtnimg:setChildCanvasGroupAlpha(0)
self.tiptxtbtn:setActive(false)

local demons_id=argtable.demons_id
local chapter_id=SiFangPingYaoModel:getZhangjieIdex()
if chapter_id==0 then
chapter_id=1
end
self.demons_id=demons_id
self.chapter_id=chapter_id
self.speciallist={}

local yg_cfg=cfg_foursideskilldemonsconfig_get(demons_id)
local ygzj_cfg=cfg_foursideskilldemonschapterconfig_get(demons_id)[chapter_id]


local faze_list=ygzj_cfg.faze_list2
local fazeData=faze_list[1]or{}
self:showfazeSkill(fazeData)


local specialdizi=yg_cfg.specialdzid
if specialdizi then
local widget=_this.diziitem1:getChildWidgetBase()
local dizidata=UIDiscipleModel:getDiscipleDataByDiziId(specialdizi[1])
local imageInfo=dizidata.imageInfo
comHelper.setChildModelHeadIconBGByColor(widget,0,imageInfo.color)
comHelper.setChildModelRawImageByDiziId(widget,specialdizi[1],1,0,eHeadCenterType.eHead)
widget:SetChildButtonClick(7,function()

self.tiptxtbtn:setActive(true)

self.bjbtnimg:setChildCanvasGroupDOFade(1,0.35,nil)
end)

self.content:setText(specialdizi[2])
end
end
end


function UISiFangPingYaoExtraWin:onTiptxtbtn()


self.bjbtnimg:setChildCanvasGroupAlpha(0)
self.tiptxtbtn:setActive(false)
end


function UISiFangPingYaoExtraWin:onHide()

end


function UISiFangPingYaoExtraWin:onSkillItem()
end


function UISiFangPingYaoExtraWin:onTippanel()
self.tippanel:setActive(false)
end



function UISiFangPingYaoExtraWin:showfazeSkill(fazeData)
local txParam=fazeData
local fazeID=txParam[1]
local fazeCfg=cfgHelper.getSSlawRule(fazeID)
local icon=fazeCfg.image
self.skillIcon:setImageIcon(icon,false)
end


function UISiFangPingYaoExtraWin:onArrowbtn()
self.arrow1:setActive(false)
self.arrow2:setActive(true)
self:showEntGroupList()
end


function UISiFangPingYaoExtraWin:getShangZhendizi(speciallist)
_this.speciallist=speciallist

end


function UISiFangPingYaoExtraWin:showEntGroupList()
self.faZeList:setActive(true)
local ygzj_cfg=cfg_foursideskilldemonschapterconfig_get(self.demons_id)[self.chapter_id]
local faze_list=ygzj_cfg.faze_list


local isjq=false
if self.speciallist then
local specialdziddata=cfg_foursideskilldemonsconfig_get(self.demons_id).specialdzid
local specialdzid=specialdziddata[1]
for k,v in pairs(self.speciallist)do
if v[3]then
local netData=UIDiscipleModel:getDiscipleData(v[3])
local diziid=netData.id
if specialdzid==diziid then
isjq=true
break
end

end
end
end
if isjq then
faze_list=ygzj_cfg.faze_list3
end

self.faZeList:setChildScrollViewCreateGrids(#faze_list,1)
local grids=self.faZeList:getChildScrollViewItemWidgets()
local count=grids.Count
for i=1,count do
local grid=grids[i-1]
local id=faze_list[i][1]
local cfg=cfgHelper.getSSlawRule(id)
grid:SetChildCSImageIcon(1,cfg.image,false)
grid:SetChildText(0,cfg.name)
grid:SetChildText(2,cfg.desc)
end
end


function UISiFangPingYaoExtraWin:onFazeMask()
self.faZeList:setActive(false)
self.arrow1:setActive(true)
self.arrow2:setActive(false)
end
