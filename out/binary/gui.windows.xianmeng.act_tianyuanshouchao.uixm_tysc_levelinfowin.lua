







def_class("UIXM_TYSC_LevelInfoWin",UIWindowBase)









function UIXM_TYSC_LevelInfoWin:bindComponents()

self.descTxt=UIText.get(self,0)
self.attrObj=UIObject.get(self,1)
self.tipsTxt=UIText.get(self,2)
self.btnCommit=UIButton.get(self,3)
self.monsterItemPanel=UIObject.get(self,4)
self.attrItemPanel=UIObject.get(self,5)
self.rewardPanel=UIObject.get(self,6)

self.btnCommit:setButtonClick(function()self:onBtnCommit()end)



end


function UIXM_TYSC_LevelInfoWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.descTxt);self.descTxt=nil;
_UIObject_release(self.attrObj);self.attrObj=nil;
_UIObject_release(self.tipsTxt);self.tipsTxt=nil;
_UIObject_release(self.btnCommit);self.btnCommit=nil;
_UIObject_release(self.monsterItemPanel);self.monsterItemPanel=nil;
_UIObject_release(self.attrItemPanel);self.attrItemPanel=nil;
_UIObject_release(self.rewardPanel);self.rewardPanel=nil;
end
















local _this


function UIXM_TYSC_LevelInfoWin:onLoaded(...)
_this=self
self:bindComponents()
end


function UIXM_TYSC_LevelInfoWin:__delete()
_this=nil
self:unbindComponents()
end


function UIXM_TYSC_LevelInfoWin:onHide()

end




function UIXM_TYSC_LevelInfoWin:onShow(argtable,afterOnloaded)
self.level=argtable.level
self.parentWin=argtable.parentWin

local cfg=cfgHelper.get1(cfg_skyshouchaojibieconfig_get,self.level)
local curLevel=xianmengModel:getLevel_TYSC()
local preScore=xianmengModel:getPreScore_TYSC()
local isSelect=curLevel==self.level
local score=cfg.needJiFen
local fix=preScore>=score


self.descTxt:setText(cfg.desc)

local tyJiFen=cfg.tyJiFen
local grids=self.monsterItemPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids.Count do
local data=tyJiFen[i]
local item=grids[i-1]
local name,icon
if i==1 then
name='小怪'
icon='icon_xiaoguai'
else
name='精英'
icon='icon_jingying'
end
local str=FMT.fmt('{0}：<color=#ca631d>{1}分/只</color>',name,data)
item:SetChildText(1,str)
item:SetChildCSImageSprite(0,globalABLookup.tianyuanshouchaoicons,icon)
end

local attrAdd=cfg.attrAdd
local showAttr=attrAdd~=nil
self.attrObj:setActive(showAttr)
if showAttr then
local grids2=self.attrItemPanel:getChildCommonLayoutGroupWidgetList()
for i=1,grids2.Count do
local data=attrAdd[i]
local item=grids2[i-1]
local icon=mysteryEnvironmentEffectModel.getRuleIcon(data[1])
local str=mysteryEnvironmentEffectModel.getRuleDesc(data[1],data[2])
item:SetChildText(1,str)
item:SetChildCSImageIcon(0,icon,true)
end
end

local rewadShow=cfg.rewadShow
local c=#rewadShow
self.rewardPanel:setChildLayoutGroupCreateItems(c)
local grids3=self.rewardPanel:getChildLayoutGroupGridList()
for i=1,c do
local item=grids3[i-1]
local itemid=rewadShow[i]
local conf={itemid=itemid,itemcount='',showCountBG=false,showStage=true,showname=false}
local prop=itemsComponentHelper.getCommonFillDataSmall(conf)
item:SetChildPropData(0,prop)
item:SetBaseItemClickEvent(0,function(...)
if _this==nil then return end
_this:onClickItem(...)
end)
end

local showBtn=fix and not isSelect
self.btnCommit:setActive(showBtn)
self.tipsTxt:setActive(not showBtn)
if not showBtn then
local str
if not fix then
str=FMT.fmt('<color=#C82C2C>需要{0}天渊积分</color>',score)
else
str='已选择该级别'
end
self.tipsTxt:setText(str)
end
end

function UIXM_TYSC_LevelInfoWin:onClickItem(itemId,index,guid,attach)
tipsManager.showTips({itemid=itemId,itemguid=nil,move=TIPS_MOVE_POS.eLeft})
end

function UIXM_TYSC_LevelInfoWin:onBtnCommit()
local cfg=cfgHelper.get1(cfg_skyshouchaojibieconfig_get,self.level)
local curLevel=xianmengModel:getLevel_TYSC()
local preScore=xianmengModel:getPreScore_TYSC()
local isSelect=curLevel==self.level
local score=cfg.needJiFen
local fix=preScore>=score

if not fix or isSelect then
return
end

if not xianmengModel:hasXM()then
UIManager.error(cfgHelper.getlang("haveNotXianMengTips"))
return
end

local myActorid=playerModel:getActorID()
if not xianmengModel.checkActorPost(myActorid,GUILD_POST_TYPE.gpAllyLeader)and
not xianmengModel.checkActorPost(myActorid,GUILD_POST_TYPE.gpViceLeader)then
UIManager.error('盟主或副盟主才可选择')
return
end

xianmengController:send_248_12(self.level)
end

function UIXM_TYSC_LevelInfoWin:rec_select()
self.parentWin:onCloseClick()
end