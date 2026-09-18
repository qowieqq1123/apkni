







def_class("UIMoGongZhengDuoAct_rankBgWin",UIWindowBase)









function UIMoGongZhengDuoAct_rankBgWin:bindComponents()

self.back=UIObject.get(self,0)
self.dropItem=UIObject.get(self,1)
self.effect=UIObject.get(self,2)
self.menuGridPanel=UIObject.get(self,3)
self.rewardPreviewBtn=UIButton.get(self,4)
self.root=UIObject.get(self,5)
self.ruleBtn=UIButton.get(self,6)
self.titleTxt=UIText.get(self,7)

self.rewardPreviewBtn:setButtonClick(function()self:onRewardPreviewBtn()end)

self.ruleBtn:setButtonClick(function()self:onRuleBtn()end)



end


function UIMoGongZhengDuoAct_rankBgWin:unbindComponents()
local _UIObject_release=UIObject.release
_UIObject_release(self.back);self.back=nil;
_UIObject_release(self.dropItem);self.dropItem=nil;
_UIObject_release(self.effect);self.effect=nil;
_UIObject_release(self.menuGridPanel);self.menuGridPanel=nil;
_UIObject_release(self.rewardPreviewBtn);self.rewardPreviewBtn=nil;
_UIObject_release(self.root);self.root=nil;
_UIObject_release(self.ruleBtn);self.ruleBtn=nil;
_UIObject_release(self.titleTxt);self.titleTxt=nil;
end


















local pageConfig=
{

















[1]={
page=1,
win='UIMoGongZhengDuoAct_rankPersonWin',
name='个人\n战绩',
checkReddot=function()
return false
end,
ruleFmt="mgzd_rank_rule_gr_%d",
},
[2]={
page=2,
win='UIMoGongZhengDuoAct_rankXMWin',
name='仙盟\n战绩',
checkReddot=function()
return false
end,
ruleFmt="mgzd_rank_rule_xm_%d",
},
[3]={
page=3,
win='UIMoGongZhengDuoAct_rankZhanYunWin',
name='个人\n战陨',
checkReddot=function()
return false
end,
ruleFmt="mgzd_rank_rule_xy_%d",
},
}
local _this=nil
local menu_slot_name='button_dytab'


function UIMoGongZhengDuoAct_rankBgWin:onLoaded(...)
self:bindComponents()
_this=self
self.winList={}
self:addNotify(notifyConfig.onEnterXianJieBt,self.onEnterXianJieBt)
end


function UIMoGongZhengDuoAct_rankBgWin:__delete()
self:unbindComponents()
_this=nil
self.winList=nil
end




function UIMoGongZhengDuoAct_rankBgWin:onShow(argtable,afterOnloaded)
self.level=JiuYuZhengFengModel:getData_rank_level()or 0
self.selectLevel=self.level
local page=1
local isHideSettlement=false
if argtable then
if argtable.page then
page=argtable.page
end
if argtable.extraArgs then
self.extraArgs=argtable.extraArgs
end
if argtable.isHideSettlement~=nil then
isHideSettlement=argtable.isHideSettlement
end


end
self.showPageCfgList={}
self.pageLookup={}
for i,v in ipairs(pageConfig)do
local isShow=true
local checkShowFunc=v.checkShowFunc
if v.isSettlementWin and isHideSettlement then
isShow=false
else
if checkShowFunc then
isShow=checkShowFunc()
end
end

if isShow then
local idx=#self.showPageCfgList+1
self.showPageCfgList[idx]=v
self.pageLookup[v.page]=idx
end
end
local idx=self.pageLookup[page]
if afterOnloaded then
local cnt=#self.showPageCfgList
self.menuGridPanel:setChildLayoutGroupCreateItems(cnt)
local grids=self.menuGridPanel:getChildLayoutGroupGridList()
for i=1,cnt do
local item=grids[i-1]
local cfg=self.showPageCfgList[i]
item:SetChildText(1,cfg.name)
local isSelected=i==idx
local func=function()
if _this==nil then return end
if isSelected then
item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,isSelected and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end
end
item:SetChildUIModelShowTarget(2,2017,1,{},eAnimationID.common_window_enter,false,false,0,func)
self:refreshMenuItemSelect(item,i,isSelected)
self:refreshMenuItemReddot(item,i)
item:SetChildButtonClick(0,function()
if _this==nil then return end
_this:onMenuItemClick(i)
end)
end
end

if argtable and argtable.extraArgs and argtable.extraArgs.isAutoOpen then
local effectId=22624
self.effect:setChildShowEffect(effectId,true)
self.root:setActive(false)
self:delayDo(2,function()
self.root:setActive(true)
self:onMenuItemClick(idx)
end)
else
self:onMenuItemClick(idx)
end

if self.level>0 then
self:showWindow("UIXingYu_JYZFLevelDropDownWin",{
parent=self,
item=self.dropItem:getWidgetBase(),
node='bottom',
})
end
end


function UIMoGongZhengDuoAct_rankBgWin:onHide()

end

function UIMoGongZhengDuoAct_rankBgWin:refreshMenuItemSelect(item,idx,flag)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end

if flag then
item:SetChildModelAnimationState(2,eAnimationID.common_window_dianji)
end
item:SetChildUIModelShowSlotAttachment(2,menu_slot_name,flag and FMT.fmt("{0}_{1}",menu_slot_name,2)or FMT.fmt("{0}_{1}",menu_slot_name,1))
end

function UIMoGongZhengDuoAct_rankBgWin:refreshMenuItemReddot(item,idx)
if item==nil then
item=self.menuGridPanel:getChildLayoutGroupGridItem(idx-1)
end
local cfg=self.showPageCfgList[idx]
local isReddot=cfg.checkReddot()
item:SetChildActive(3,isReddot)


end

function UIMoGongZhengDuoAct_rankBgWin:refreshMenuReddot(page)
local idx=self.pageLookup[page]
self:refreshMenuItemReddot(nil,idx)
end

function UIMoGongZhengDuoAct_rankBgWin:refreshAllMenuReddot()
for page,idx in pairs(self.pageLookup)do
self:refreshMenuItemReddot(nil,idx)
end
end

function UIMoGongZhengDuoAct_rankBgWin:onMenuItemClick(idx)
local cfg=self.showPageCfgList[idx]
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

function UIMoGongZhengDuoAct_rankBgWin:refreshMenuPage()
local idx=self.pageLookup[self.curPage]
local cfg=self.showPageCfgList[idx]
local win=cfg.win
if self.pagewin~=win and self.pagewin~=nil then
self:hideWindow(self.pagewin)
end
if win~=nil and win~=''then
self.winList[win]=true
self.pagewin=win
local args=self.extraArgs or{}
args.parentWin='UIMoGongZhengDuoAct_rankBgWin'
args.page=self.curPage
args.level=self.selectLevel
self:showWindow(win,args)
end
end


function UIMoGongZhengDuoAct_rankBgWin.onEnterXianJieBt()
if not _this then return end

_this:onClickClose()
end



function UIMoGongZhengDuoAct_rankBgWin:onClickClose()
self:closeSelf()
end


function UIMoGongZhengDuoAct_rankBgWin:changeExtraArgs(newArgs)
self.extraArgs=newArgs
end


function UIMoGongZhengDuoAct_rankBgWin:onChangeLevel(level)
self.selectLevel=level
local idx=self.pageLookup[self.curPage]
local cfg=self.showPageCfgList[idx]
local win=cfg.win

UIManager:invokeUIMethod(win,'onChangeLevel',self.selectLevel)
end

function UIMoGongZhengDuoAct_rankBgWin:onRuleBtn()
local idx=self.pageLookup[self.curPage]
local cfg=self.showPageCfgList[idx]
local d={}
d.title='说明 '
d.mode=3
d.name=cfg.ruleFmt
UIManager:showWindow('UIRuleWin',d)
end

function UIMoGongZhengDuoAct_rankBgWin:onRewardPreviewBtn()
UIManager:closeWindow('UIXingYu_JYZFLevelDropDownWin')
local level=self.selectLevel
self:closeSelf()
UIManager:showWindow('UIMoJieMGZDRankRewardListWin',{level=level})
end