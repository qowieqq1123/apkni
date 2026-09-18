









local xjEntity_XMBiaoJi={}


function xjEntity_XMBiaoJi:onInit()
self.BJkeyId=self.data.keyId
self.BJkeys={self.data.bj_x,self.data.bj_y,self.data.bj_sceneidx}
self.BJcbId=self.data.bj_cbid or-22
self.BJiconId=self.data.bj_iconid or 1
self.BJcontent=self.data.bj_content or"暂无数据显示"

local data=xianjieModel:getZBDataBykeyId(self.BJkeyId)
self.pos=data:getWorldPos_1()
self.size=data:getWorldSize()

local tbarry=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'biaojiicons')or{}
self.xjicontype=tbarry[self.BJiconId][3]or 901
self.data.xjicontype=self.xjicontype

self.ent_name='仙盟标记'
end


function xjEntity_XMBiaoJi:onCreateWidget(widget)

if widget then




















widget:SetChildActive(1,true)
local cfg=cfgHelper.get(cfg_fairylandclientbuildconfig_get,self.BJcbId)
local cfg_clientParam=cfg.clientParam or{}
local modelPos=cfg_clientParam.modelPos or{0,0,0}
local effectOne=cfg_clientParam.effectOne or{pos={0,0,0},scale={4,4,0}}
local effectTwo=cfg_clientParam.effectTwo or{pos={0,0,0},scale={4,4,0}}
widget:SetChildLocalPosition(0,Vector3(modelPos[1],modelPos[2],modelPos[3]))
local entCfg=cfgHelper.get1(cfg_xianjieentityconfig_get,self.entityType)
local tbarry=cfgHelper.get2(cfg_fairylandbaseconfig_get,1,'biaojiicons')or{}
local iconid=self.BJiconId



self:playSpriteAnimation(widget,3,tbarry[iconid][2][2],Vector3.New(effectOne.pos[1],effectOne.pos[2],effectOne.pos[3]),Vector3.New(effectOne.scale[1],effectOne.scale[2],0),'Entity',entCfg.sortOrder)
self:playSpriteAnimation(widget,4,tbarry[iconid][2][1],Vector3.New(effectTwo.pos[1],effectTwo.pos[2],effectTwo.pos[3]),Vector3.New(effectTwo.scale[1],effectTwo.scale[2],0),'Entity',entCfg.sortOrder-1)
end
end


function xjEntity_XMBiaoJi:onRemoveWidget(widget)


if widget then
self:stopSpriteAnimation(widget,3)
end
end


function xjEntity_XMBiaoJi:onSelectHandle(widget,isSelect)

end

function xjEntity_XMBiaoJi:onMyClick(boxParams)

end

function xjEntity_XMBiaoJi:refreshInfo()
local hud=self:getHud()
if hud and hud.refreshInfo then
hud:refreshInfo()
end
end


return xjEntity_XMBiaoJi
