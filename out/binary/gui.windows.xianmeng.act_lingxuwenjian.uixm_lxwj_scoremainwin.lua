







def_class("UIXM_LXWJ_ScoreMainWin",UIWindowBase)









function UIXM_LXWJ_ScoreMainWin:bindComponents()

self.frameSp=UIObject.get(self,0)
self.root=UIObject.get(self,1)
self.battlePanel=UIObject.get(self,2)
self.noItemTipsLeft=UIText.get(self,3)
self.noItemTipsRight=UIText.get(self,4)
self.leftInfoItem=UIObject.get(self,5)
self.rightInfoItem=UIObject.get(self,6)
self.menuGridPanel=UIObject.get(self,7)



end


function UIXM_LXWJ_ScoreMainWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.frameSp);self.frameSp=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.battlePanel);self.battlePanel=nil;
_UIObject_release(self.noItemTipsLeft);self.noItemTipsLeft=nil;
_UIObject_release(self.noItemTipsRight);self.noItemTipsRight=nil;
_UIObject_release(self.leftInfoItem);self.leftInfoItem=nil;
_UIObject_release(self.rightInfoItem);self.rightInfoItem=nil;
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
end
















local pageConfig=
{
[1]={
page=1,
win='UIXM_LXWJ_ScoreOneWin',
name='积分',
},
[2]={
page=2,
win='UIXM_LXWJ_ScoreTwoWin',
name='防守',
},
}
local _this=nil


function UIXM_LXWJ_ScoreMainWin:onLoaded(...)
_this=self
self:bindComponents()
self.winList={}
self.pageLookup={}
for i,v in ipairs(pageConfig)do
self.pageLookup[v.page]=i
end
end


function UIXM_LXWJ_ScoreMainWin:__delete()
_this=nil
self:unbindComponents()
for win,v in pairs(self.winList)do
UIManager:closeWindow(win)
end
self.winList=nil
end


function UIXM_LXWJ_ScoreMainWin:onHide()

end




function UIXM_LXWJ_ScoreMainWin:onShow(argtable,afterOnloaded)
local page=1
if argtable then
if argtable.page then
page=argtable.page
end
end
local idx=self.pageLookup[page]
if afterOnloaded then
local cnt=#pageConfig
self.menuGridPanel:setChildLayoutGroupCreateItems(cnt)
local grids=self.menuGridPanel:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
local cfg=pageConfig[i]
item:SetChildText(1,cfg.name)
local isSelected=i==idx
self:refreshMenuItemSelect(item,i,isSelected)
item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)
end
end
self:refreshView()
self:onMenuItemClick(idx)

if afterOnloaded then
self.root:setChildCanvasGroupAlpha(0)
self.frameSp:setChildUIModelShowTarget(4788,1,{},0,false,false,0,function()
if _this==nil then return end
self.root:setChildCanvasGroupDOFade(1,0.25,nil)
end)
end
end

function UIXM_LXWJ_ScoreMainWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end

local icon
if flag then
icon='button_xmzzhanjiui_1'
else
icon='button_xmzzhanjiui_2'
end
item:SetChildCSImageSprite(0,globalABLookup.lingxuwenjianicons,icon)
end

function UIXM_LXWJ_ScoreMainWin:onMenuItemClick(idx)
local cfg=pageConfig[idx]
if cfg.page==self.curPage then
return
end
local old=self.curPage
self.curPage=cfg.page
if old~=nil then
local idx_=self.pageLookup[old]
self:refreshMenuItemSelect(nil,idx_,false)
end
self:refreshMenuItemSelect(nil,idx,true)
self:refreshMenuPage()
end

function UIXM_LXWJ_ScoreMainWin:refreshMenuPage()
local idx=self.pageLookup[self.curPage]
local cfg=pageConfig[idx]
local win=cfg.win
if self.pagewin~=win and self.pagewin~=nil then
self:hideWindow(self.pagewin)
end
if win~=nil and win~=''then
self.winList[win]=true
self.pagewin=win
local args={}
args.parentWin='UIXM_LXWJ_ScoreMainWin'
args.page=self.curPage
self:showWindow(win,args)
end
end

function UIXM_LXWJ_ScoreMainWin:onClickClose()
self:closeSelf()
end

function UIXM_LXWJ_ScoreMainWin:checkInit()
return self.isInit==true
end

function UIXM_LXWJ_ScoreMainWin:refreshView()
local data=lingxuwenjianModel:getScoreNotesList()
local isshow=data.isshow
self.battlePanel:setActive(isshow)
self.noItemTipsLeft:setActive(not isshow)
self.noItemTipsRight:setActive(not isshow)
if isshow then
local result=data.result

local ourscore=data.ourscore
if ourscore then
local widget=self.leftInfoItem:getWidgetBase()
local image=xianmengModel:getGuildImage()
local abname=globalABLookup.xianmengicons

widget:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(0,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

local xmname=xianmengModel:getXMName()
widget:SetChildText(3,xmname)

local score=ourscore
local abname,icon,name=lingxuwenjianModel:getScoreCfg(score)
widget:SetChildCSImageSprite(4,abname,icon)
local str
local add=data.leftScoreAdd
if add==nil or add==0 then
str=tostring(score)
else
if add>0 then
local s=score-add
str=FMT.fmt('{0}<color=#aae252>+{1}</color>',s,add)
else
local s=score-add
str=FMT.fmt('{0}<color=#f36666>{1}</color>',s,add)
end
end
local score_str=FMT.fmt('{0}({1})',name,str)
widget:SetChildText(5,score_str)

local showResult=result~=nil
widget:SetChildActive(6,showResult)
if showResult then
local abname_,icon_=lingxuwenjianModel:getResultIcon(result,true)
widget:SetChildCSImageSprite(6,abname_,icon_)
end
end


local enemyscore=data.enemyscore
if enemyscore then
local widget=self.rightInfoItem:getWidgetBase()
local image=xianmengModel.splitGuildIcon(data.enemyguildicon)
local abname=globalABLookup.xianmengicons

widget:SetChildCSImageSprite(1,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eIcon,image.icon,'icon'))

widget:SetChildCSImageSprite(0,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eBG,image.bg,'icon'))

widget:SetChildCSImageSprite(2,abname,cfgHelper.get3(cfg_guildiconconfig_get,xianmengIconType.eKuang,image.kuang,'icon'))

local xmname=data.enemyname
widget:SetChildText(3,xmname)

local score=enemyscore
local abname,icon,name=lingxuwenjianModel:getScoreCfg(score)
widget:SetChildCSImageSprite(4,abname,icon)
local str
local add=data.rightScoreAdd

if add==nil or add==0 or score==0 then
str=tostring(score)
else
if add>0 then
local s=score-add
str=FMT.fmt('{0}<color=#aae252>+{1}</color>',s,add)
else
local s=score-add
str=FMT.fmt('{0}<color=#f36666>{1}</color>',s,add)
end
end
local score_str=FMT.fmt('{0}({1})',name,str)
widget:SetChildText(5,score_str)

local showResult=result~=nil
widget:SetChildActive(6,showResult)
if showResult then
local abname_,icon_=lingxuwenjianModel:getResultIcon(result,false)
widget:SetChildCSImageSprite(6,abname_,icon_)
end
end
end
self.myData=table.deepCopy(data)
end

function UIXM_LXWJ_ScoreMainWin:getMyData()
return self.myData
end