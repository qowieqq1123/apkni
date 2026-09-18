







def_class("UISubAct_ChiSeJinDi_FaZeBagWin",UIWindowBase)









function UISubAct_ChiSeJinDi_FaZeBagWin:bindComponents()

self.closeBtn=UIButton.get(self,0)
self.desc=UIText.get(self,1)
self.empty=UIObject.get(self,2)
self.listPanel=UIObject.get(self,3)
self.ScrollerScript=UIEnhancedScrollerLua.get(self,4)

self.closeBtn:setButtonClick(function()self:onCloseBtn()end)



end


function UISubAct_ChiSeJinDi_FaZeBagWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.closeBtn);self.closeBtn=nil;
_UIObject_release(self.desc);self.desc=nil;
_UIObject_release(self.empty);self.empty=nil;
_UIObject_release(self.listPanel);self.listPanel=nil;
_UIObject_release(self.ScrollerScript);self.ScrollerScript=nil;
end















local _this=nil

local moveY={0,15,20,25,20,15,0}

local rotateZ={4.5,3,1.5,0,-1.5,-3,-4.5}

local colNum=7

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



function UISubAct_ChiSeJinDi_FaZeBagWin:onLoaded(...)
self:bindComponents()
_this=self

socketManager:addNotify(249,238,self.on_249_238)

local _onClickItemCallback=function(...)
self:onClickItemCallback(...)
end
self.listPanel:setChildScrollViewInit(-1,true,_onClickItemCallback,nil)
end


function UISubAct_ChiSeJinDi_FaZeBagWin:__delete()
self:unbindComponents()
_this=nil

socketManager:removeNotify(249,238,self.on_249_238)
end




function UISubAct_ChiSeJinDi_FaZeBagWin:onShow(argtable,afterOnloaded)

self.actId=argtable.actId
self.subType=argtable.subType
self.subId=argtable.subId
self.parentWin=argtable.parentWin
self.side=argtable.side
self.callback=argtable.callback

self.info=activitiesModel:getSubActInfo(self.actId,self.subType,self.subId)
self.config=activitiesModel:getSubActivityConfig(self.subType,self.subId)
self.copyData=self.info:getCopy()
self.idIdx=self.side*2+1
self.lvIdx=self.side*2+2
self:updateData()
self:refreshView()
end


function UISubAct_ChiSeJinDi_FaZeBagWin:onHide()

end





function UISubAct_ChiSeJinDi_FaZeBagWin:onCloseBtn()
if self.callback then
self.callback()
elseif self.parentWin then
self.parentWin:closeWindow(self.__name)
else
self:closeSelf()
end
end

function UISubAct_ChiSeJinDi_FaZeBagWin:updateData()
if self.side==0 then
self.datas=self.copyData.fazeList
self.copyData:sortFaZeList()
else
self.datas=self.copyData.roundData.fazeList or{}
if#self.datas>1 and not self.copyData.roundData.fazeSorted then
local fazeServer=self.config.faze
table.sort(self.datas,function(a,b)
local levelA=fazeServer[a][4]
local levelB=fazeServer[b][4]
if levelA~=levelB then
return levelA>levelB
else
local cfgA=cfgHelper.getSSlawRule(fazeServer[a][3])
local cfgB=cfgHelper.getSSlawRule(fazeServer[b][3])
return cfgA.id<cfgB.id
end
end)
self.copyData.roundData.fazeSorted=true
end
end
end

function UISubAct_ChiSeJinDi_FaZeBagWin:refreshView()
local len=#self.datas
self.empty:setActive(len<=0)
self.listPanel:setChildScrollViewCreateGrids(len,colNum)
local items=self.listPanel:getChildScrollViewItemWidgets()
local fazeServer=self.config.faze
for i,v in ipairs(self.datas)do
local item=items[i-1]
local serverCfg=fazeServer[v]
local fzId=serverCfg[self.idIdx]
local fzLv=serverCfg[self.lvIdx]
local fzCfg=cfgHelper.getSSlawRule(fzId)
local image=fzCfg.image
local name=fzCfg.name
local quality=fzLv
local zhuanshuImg=fzCfg.zhuanshuImg
local qualityDesc=cfg_secretscenebaseconfig_get(1).rule_quality
local desc=fzCfg.desc
local descparm=fzCfg.descparm
if descparm and descparm[quality]and next(descparm[quality])then
desc=string.format(desc,unpack(descparm[quality]))
end
local color_cfg=qualityDesc[quality]
local frame=iconHelper.getRuleQualityIcon(quality)
item:SetChildText(ItemCmpIndex.name,name)
item:SetChildText(ItemCmpIndex.desc,desc)
item:SetChildActive(ItemCmpIndex.skill,false)
item:SetChildCSImageIcon(ItemCmpIndex.icon,image,true)
item:SetChildCSImageIcon(ItemCmpIndex.frame,frame,false)
if image then
item:SetChildIconColor(ItemCmpIndex.frame,Color(1,1,1,1))
else
item:SetChildIconColor(ItemCmpIndex.frame,Color(1,1,1,0.5))
end


local index=(i-1)%colNum+1
item:SetChildLocalPosition(ItemCmpIndex.root,Vector3(0,moveY[index],0))
item:SetChildRotation(ItemCmpIndex.root,0,0,rotateZ[index])

if zhuanshuImg then
item:SetChildActive(ItemCmpIndex.zhuanshu,true)
item:SetChildIcon(ItemCmpIndex.zhuanshu,FMT.fmt('image_zhuan_shu_faze_{0}',zhuanshuImg),true)
else
item:SetChildActive(ItemCmpIndex.zhuanshu,false)
end
end
end

function UISubAct_ChiSeJinDi_FaZeBagWin:onClickItemCallback(clickCount,index)
index=index+1
local id=self.datas[index]
local serverCfg=self.config.faze[id]
local fzId=serverCfg[self.idIdx]
local fzLv=serverCfg[self.lvIdx]
self:showWindow("UIMysteryRuleViewWin",{id=fzId,level=fzLv})
end

function UISubAct_ChiSeJinDi_FaZeBagWin.on_249_238(actId,subId,idx,len,roundList)
local subType=SUB_ACTIVITY_TYPE.eChiSeJinDi
if _this.info:compare(actId,subType,subId)then
if _this.side==0 then
_this:updateData()
_this:refreshView()
end
end
end