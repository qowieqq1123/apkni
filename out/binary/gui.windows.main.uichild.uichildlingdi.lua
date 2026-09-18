




UIChildLingDi=simple_class(UIChildObject)

local defaultIcon='button_zjmlingdi_1'
local selectIcon='button_zjmlingdi_2'
local _this

function UIChildLingDi:onLoaded()

end

function UIChildLingDi:onShow(isInit)
if isInit then
_this=self
reddotClassManager.register_event(REDDIT_TYPE.eXianMengBase,self.refreshReddot)

notifySystem:listenNotify(notifyConfig.onYingXianGe_XMHZChange,self.refreshYuanZhu)
notifySystem:listenNotify(notifyConfig.onFeiShengTaiHelpFinish,self.refreshYuanZhu)
notifySystem:listenNotify(notifyConfig.onZongMengLevelChange,self.refreshYuanZhu)
end
local abname=mainConfig.getBundleName()


local iconname=defaultIcon
local selectIconName=selectIcon
self:setChildCSImageSprite(0,abname,iconname)
self:setChildCSImageSprite(6,abname,selectIconName)
self:setChildActive(6,false)
self:setChildButtonClick(1,function()self:OnButtonClick()end,true)
local isreddot=reddotClassManager.get_reddot(REDDIT_TYPE.eXianMengBase)


self:setChildActive(2,isreddot)
self:refreshReddotView(isreddot)
self:doPunchRotation(isreddot)

self:setChildActive(3,false)


self:refreshYuanZhuView()
end

function UIChildLingDi:OnButtonClick()
local btnList={
MAIN_BTNS_TYPE.eSubXM,
MAIN_BTNS_TYPE.eSubXJBaoLei,

MAIN_BTNS_TYPE.eSubLingShouFeng,
}

local widget=self:getWidgetBase()
local posVector2=widget:GetChildScreenPointToLocalPointRectangle(-1)
local pos={posVector2.x,posVector2.y+55}
local closeCallback=function()
if not _this then return end
_this:setYuanZhuBtnHideFlag(false)
_this:setChildActive(6,false)
end

UIManager:showWindow("UIMainSubEnterPanelWin",{btnList=btnList,pos=pos,closeCallback=closeCallback})
self:setYuanZhuBtnHideFlag(true)
self:setChildActive(6,true)
end

function UIChildLingDi:OnYuanZhuButtonClick()
if self.yxgHuZhuNum and self.yxgHuZhuNum>0 then
xianjieController:reqHelpAll()
end

if self.fstHuZhuNum and self.fstHuZhuNum>0 then
FeiShengTaiController:SendHelpXMPeople(0)
FeiShengTaiController:SendXMHelp_feisheng()
end
end

function UIChildLingDi:release()
reddotClassManager.unregister_event(REDDIT_TYPE.eXianMengBase,self.refreshReddot)
notifySystem:removelistener(notifyConfig.onYingXianGe_XMHZChange,self.refreshYuanZhu)
notifySystem:removelistener(notifyConfig.onFeiShengTaiHelpFinish,self.refreshYuanZhu)
notifySystem:removelistener(notifyConfig.onZongMengLevelChange,self.refreshYuanZhu)

self:setChildActive(2,false)
self:doPunchRotation(false)

self:setChildActive(3,false)

self:setChildActive(4,false)

self:setChildActive(6,false)
_this=nil
end

function UIChildLingDi.refreshReddot(class,sub_typo,last_flag,flag)
if _this==nil then return end
_this:setChildActive(2,flag)
_this:refreshReddotView(flag)
_this:doPunchRotation(flag)
end

function UIChildLingDi:refreshReddotView(isreddot)
if not isreddot then return end
local reddotImg='image_daojutishikuang_1'
local pos=self.widget:GetChildAnchoredPosition(2)
local pos_y=-30
self.widget:SetChildAnchoredPos(2,pos.x,pos_y)
self:setChildCSImageSprite(2,mainConfig.getBundleName(),reddotImg)
end

function UIChildLingDi:doPunchRotation(isreddot)
if webGLHelper:isHidePunchAni()then return end
if isreddot then
if self.reddotTweener==nil then
self:setChildRotation(2,0,0,0)
local tweener=self:setChildDOPunchRotation(2,Vector3(0,0,15),2,2,1)
tweener:SetEase(_Ease.Linear)
tweener:SetLoops(-1,_LoopType.Restart)
self.reddotTweener=tweener
end
else
if self.reddotTweener~=nil then
self.reddotTweener:Complete()
self.reddotTweener:Kill()
self.reddotTweener=nil
self:setChildRotation(2,0,0,0)
end
end
end

function UIChildLingDi.refreshYuanZhu()
if _this==nil then return end
_this:refreshYuanZhuView()
end

function UIChildLingDi:refreshYuanZhuView()
local isHideYZBtn=self.isHideYZBtn or false
local isXM=zongmenControl:isMountid(mapIdType.xianmeng)
self.yxgHuZhuNum=self:getYinXianGeHuZhuNum()
self.fstHuZhuNum=self:getFeiShengTaieHuZhuNum()

local num=self.yxgHuZhuNum+self.fstHuZhuNum
local isShow=not isXM and num>0 and not isHideYZBtn
self:setChildActive(4,isShow)
if isShow then
self:setChildButtonClick(4,function()self:OnYuanZhuButtonClick()end,true)
self:setText(5,num)
end
end

function UIChildLingDi:setYuanZhuBtnHideFlag(isHide)
self.isHideYZBtn=isHide or nil
return self:refreshYuanZhuView()
end


function UIChildLingDi:getYinXianGeHuZhuNum()
local isOpen=YingXianGeModel:checkOpen()
local num=0
if isOpen then
num=xianjieModel:getHuZhuNum()
end
return num
end

function UIChildLingDi:getFeiShengTaieHuZhuNum()
local num=0

local lv=zongmenModel:getBuildingLevel(mapIdType.xianmeng,SLG_SYSTEM_TYPE.eXianWuLou)
local member_reduce_conf=cfgHelper.get2(cfg_feishengjctjbasicconfig_get,1,'member_reduce_conf')
local needlv=member_reduce_conf[2]
local zmlv=zongmenModel:getLevel()
if lv>0 and needlv<zmlv then
num=FeiShengTaiModel:getCanHelpCount()
end
return num
end