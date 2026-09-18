







def_class("UITeXingTipsListWin",UIWindowBase)









function UITeXingTipsListWin:bindComponents()

self.clicker=UIButton.get(self,0)
self.root=UIObject.get(self,2)
self.scrollView=UIObject.get(self,3)
self.skillList=UIObject.get(self,4)

self.clicker:setButtonClick(function()self:onClicker()end)



end


function UITeXingTipsListWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.clicker);self.clicker=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.scrollView);self.scrollView=nil;
_UIObject_release(self.skillList);self.skillList=nil;
end















local skillItemCmpIndex={
skillIcon=0,
skillSign=1,
skillName=2,
skillWuXing=3,
skillDesc=4,
descExGrid=5,
}




function UITeXingTipsListWin:onLoaded(...)
self:bindComponents()
end


function UITeXingTipsListWin:__delete()
self:unbindComponents()
end




function UITeXingTipsListWin:onShow(argtable,afterOnloaded)
local skillParamList=argtable and argtable.skillParamList or{}
local pos=argtable and argtable.pos or{0,0}
self.root:setChildAnchoredPos(pos[1]or 0,pos[2]or 0)

if skillParamList and next(skillParamList)then
local skillCount=#skillParamList
self.skillList:setChildLayoutGroupCreateItems(skillCount)
local grids=self.skillList:getChildLayoutGroupGridList()
for i=1,grids.Count do
local skillItem=grids[i-1]
local skillParam=skillParamList[i]
local skillId=skillParam[1]
local skillLv=skillParam[2]or 1

local skillCfg=cfgHelper.get1(cfg_skillconfig_get,skillId)
if skillCfg then
skillItem:SetChildActive(-1,true)

skillItem:SetChildIcon(skillItemCmpIndex.skillIcon,iconHelper.getSkillIcon(skillCfg.icon),false)

skillItem:SetChildText(skillItemCmpIndex.skillName,skillCfg.name)

local isbd=skillModel.isSkillBD(skillCfg.skillType)
skillItem:SetChildActive(skillItemCmpIndex.skillSign,isbd)


local skillYuanSu=skillCfg.skillYuanSu
local showYuanSu=skillYuanSu~=nil
skillItem:SetChildActive(skillItemCmpIndex.skillWuXing,showYuanSu)
if showYuanSu then
local yuansu_str=FMT.fmt("[{0}系]",ELEMENT_TYPE.getName(skillYuanSu))
skillItem:SetChildText(skillItemCmpIndex.skillWuXing,yuansu_str)
end


skillItem:SetChildText(skillItemCmpIndex.skillDesc,skillModel:getSkillDesc(skillId,skillLv))

local descExList=skillModel:getSkillDescEx(skillId,skillLv)
local descExNum=0
if descExList~=nil then
descExNum=#descExList
end
local showDescEx=descExNum>0
skillItem:SetChildActive(skillItemCmpIndex.descExGrid,showDescEx)
if showDescEx then
skillItem:SetChildLayoutGroupCreateItems(skillItemCmpIndex.descExGrid,descExNum)
local descExGrid=skillItem:GetChildLayoutGroupGridList(skillItemCmpIndex.descExGrid)
for i=1,descExNum do
local descItem=descExGrid[i-1]
local txt=descExList[i]
descItem:SetChildText(0,txt)
descItem:SetChildActive(-1,true)
end
end
else
skillItem:SetChildActive(-1,false)
end
end
end
end


function UITeXingTipsListWin:onHide()

end





function UITeXingTipsListWin:onClicker()
self:closeSelf()
end

