




UIChildXianmeng=simple_class(UIChildObject)

local defaultIcon='button_zjmxianmeng'
local mapIcon={
[mapIdType.xianmeng]='button_zjmzongmenqh',
}
local _this

function UIChildXianmeng:onLoaded()

end

function UIChildXianmeng:onShow(isInit)
if isInit then
_this=self
reddotClassManager.register_event(REDDIT_TYPE.eXianMengBase,self.refreshReddot)

notifySystem:listenNotify(notifyConfig.onYingXianGe_XMHZChange,self.refreshYuanZhu)
notifySystem:listenNotify(notifyConfig.onFeiShengTaiHelpFinish,self.refreshYuanZhu)
notifySystem:listenNotify(notifyConfig.onZongMengLevelChange,self.refreshYuanZhu)

end
local abname=mainConfig.getBundleName()
local mapId=zongmenModel:getMountainId()
local iconname=mapIcon[mapId]or defaultIcon
self:setChildCSImageSprite(0,abname,iconname)
self:setChildButtonClick(1,function()self:OnButtonClick()end,true)
local isreddot=reddotClassManager.get_reddot(REDDIT_TYPE.eXianMengBase)
self:setChildActive(2,isreddot)
self:refreshReddotView(isreddot)
self:doPunchRotation(isreddot)

self:setChildActive(3,true)
self:setChildCSImageSprite(3,abname,'button_zhujiemian_2')

self:refreshYuanZhuView()
end

function UIChildXianmeng:OnButtonClick()
if not xianmengModel:checkInit()then



return
end
if mainControl:isSceneType(eSceneType.eZongmen)or mainControl:isSceneType(eSceneType.eXianJie)then
if zongmenControl:isMountid(mapIdType.xianmeng)then
xianmengController:leaveXianMengMap()
else
if xianmengModel:hasXM()then
xianmengController:enterXianMengMap()
else
xianmengController:openJoinWin()
end
end
end
end

function UIChildXianmeng:OnYuanZhuButtonClick()
if self.yxgHuZhuNum and self.yxgHuZhuNum>0 then
xianjieController:reqHelpAll()
end

if self.fstHuZhuNum and self.fstHuZhuNum>0 then
FeiShengTaiController:SendHelpXMPeople(0)
FeiShengTaiController:SendXMHelp_feisheng()
end
end

function UIChildXianmeng:release()
reddotClassManager.unregister_event(REDDIT_TYPE.eXianMengBase,self.refreshReddot)
notifySystem:removelistener(notifyConfig.onYingXianGe_XMHZChange,self.refreshYuanZhu)
notifySystem:removelistener(notifyConfig.onFeiShengTaiHelpFinish,self.refreshYuanZhu)
notifySystem:removelistener(notifyConfig.onZongMengLevelChange,self.refreshYuanZhu)
self:setChildActive(2,false)
self:doPunchRotation(false)

self:setChildActive(3,false)

self:setChildActive(4,false)
_this=nil
end

function UIChildXianmeng.refreshReddot(class,sub_typo,last_flag,flag)
if _this==nil then return end
_this:setChildActive(2,flag)
_this:refreshReddotView(flag)
_this:doPunchRotation(flag)
end

function UIChildXianmeng:refreshReddotView(isreddot)
if not isreddot then return end
local reddotImg='image_daojutishikuang_1'
local pos=self.widget:GetChildAnchoredPosition(2)
local pos_y=-30
self.widget:SetChildAnchoredPos(2,pos.x,pos_y)
self:setChildCSImageSprite(2,mainConfig.getBundleName(),reddotImg)
end

function UIChildXianmeng:doPunchRotation(isreddot)
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

function UIChildXianmeng.refreshYuanZhu()
if _this==nil then return end
_this:refreshYuanZhuView()
end

function UIChildXianmeng:refreshYuanZhuView()
local isXM=zongmenControl:isMountid(mapIdType.xianmeng)

self.yxgHuZhuNum=self:getYinXianGeHuZhuNum()
self.fstHuZhuNum=self:getFeiShengTaieHuZhuNum()


local num=self.yxgHuZhuNum+self.fstHuZhuNum

local isShow=not isXM and num>0
self:setChildActive(4,isShow)
if isShow then
self:setChildButtonClick(4,function()
self:OnYuanZhuButtonClick()
end,true)
self:setText(5,num)
end
end

function UIChildXianmeng:getYinXianGeHuZhuNum()
local isOpen=YingXianGeModel:checkOpen()
local num=0
if isOpen then
num=xianjieModel:getHuZhuNum()
end
return num
end

function UIChildXianmeng:getFeiShengTaieHuZhuNum()
local num=0

local lv=zongmenModel:getBuildingLevel(mapIdType.xianmeng,SLG_SYSTEM_TYPE.eXianWuLou)
local member_reduce_conf=cfgHelper.get2(cfg_feishengjctjbasicconfig_get,1,'member_reduce_conf')
local needlv=member_reduce_conf[2]
local zmlv=zongmenModel:getLevel()
if lv>0 and needlv<=zmlv then
num=FeiShengTaiModel:getCanHelpCount()
end
return num
end
