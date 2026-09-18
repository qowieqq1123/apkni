









gubaoCollectSheetReddot=reddotSheetBase.new({classname='gubaoCollectSheetReddot'})

gubaoCollectSheetReddot.reddot_type=REDDIT_TYPE.eGuBaoCollect

gubaoCollectSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sGuBaoCollect]=
{
catch={
CATCH_TYPE.eMoney,
CATCH_TYPE.eItem,
CATCH_TYPE.eGuBao,
},
func=function(asynch,asynchData)
return gubaoModel:checkCollectPageReddot2(asynch,asynchData)
end,

asynch=true,
},
}



gubaoBaseSheetReddot=reddotSheetBase.new({classname='gubaoBaseSheetReddot'})

gubaoBaseSheetReddot.reddot_type=REDDIT_TYPE.eGuBaoBase

gubaoBaseSheetReddot.reddot_config=
{
[REDDIT_SUB_TYPE.sGuBaoBase]=
{
catch={
CATCH_TYPE.eMoney,
CATCH_TYPE.eItem,
CATCH_TYPE.eGuBao,
},
func=function(asynch,asynchData)
return gubaoModel:checkSystemReddot(asynch,asynchData)
end,

asynch=true,
},
}



gubaoLianHuaSheetReddot=reddotSheetBase.new({classname='gubaoLianHuaSheetReddot',subType_=REDDIT_SUB_TYPE.sGuBaoLianHua})

gubaoLianHuaSheetReddot.reddot_type=REDDIT_TYPE.eGuBaoLianHua

gubaoLianHuaSheetReddot.isDynamic=true

function gubaoLianHuaSheetReddot:onAppStart()
end
function gubaoLianHuaSheetReddot:onPlayerCreate()
end
function gubaoLianHuaSheetReddot:onLeaveState()
self:resetConfig()
end

function gubaoLianHuaSheetReddot.initConfig()
local class=reddotClassManager.get_class(REDDIT_TYPE.eGuBaoLianHua)
if class==nil then return end

if class.reddot_config==nil then
class.reddot_config={}
local configs=cfg_gubaoconfig()
for k,v in pairs(configs)do
local gbid=v.id
local key=gubaoLianHuaSheetReddot:getSubReddotKey(gbid)
class.reddot_config[key]=
{
catch={
CATCH_TYPE.eMoney,
CATCH_TYPE.eItem,
CATCH_TYPE.eGuBao,
},
func=function(catchType,...)
return gubaoModel:checkCanLianHua(gbid)
end,
}
end

reddotClassManager.init_class(class)

class:init_data()
end
end

function gubaoLianHuaSheetReddot:resetConfig()

reddotClassManager.reset_class(self)
self.reddot_config=nil
end



gubaoUpStarSheetReddot=reddotSheetBase.new({classname='gubaoUpStarSheetReddot',subType_=REDDIT_SUB_TYPE.sGuBaoUpStar})

gubaoUpStarSheetReddot.reddot_type=REDDIT_TYPE.eGuBaoUpStar

gubaoUpStarSheetReddot.isDynamic=true

function gubaoUpStarSheetReddot:onAppStart()
end
function gubaoUpStarSheetReddot:onPlayerCreate()
end
function gubaoUpStarSheetReddot:onLeaveState()
self:resetConfig()
end

function gubaoUpStarSheetReddot.initConfig()
local class=reddotClassManager.get_class(REDDIT_TYPE.eGuBaoUpStar)
if class==nil then return end

if class.reddot_config==nil then
class.reddot_config={}
local configs=cfg_gubaoconfig()
for k,v in pairs(configs)do
local gbid=v.id
local key=gubaoUpStarSheetReddot:getSubReddotKey(gbid)
class.reddot_config[key]=
{
catch={
CATCH_TYPE.eItem,
},
func=function(catchType,...)
return gubaoModel:checkCanUpStar(gbid)
end,
}
end

reddotClassManager.init_class(class)

class:init_data()
end
end

function gubaoUpStarSheetReddot:resetConfig()

reddotClassManager.reset_class(self)
self.reddot_config=nil
end



gubaoAwakeSheetReddot=reddotSheetBase.new({classname='gubaoAwakeSheetReddot',subType_=REDDIT_SUB_TYPE.sGuBaoAwake})

gubaoAwakeSheetReddot.reddot_type=REDDIT_TYPE.eGuBaoAwake

gubaoAwakeSheetReddot.isDynamic=true

function gubaoAwakeSheetReddot:onAppStart()
end
function gubaoAwakeSheetReddot:onPlayerCreate()
end
function gubaoAwakeSheetReddot:onLeaveState()
self:resetConfig()
end

function gubaoAwakeSheetReddot:initConfig()
local class=reddotClassManager.get_class(REDDIT_TYPE.eGuBaoAwake)
if class==nil then return end

if class.reddot_config==nil then
class.reddot_config={}
local configs=cfg_gubaoconfig()
for k,v in pairs(configs)do
local gbid=v.id
local key=gubaoAwakeSheetReddot:getSubReddotKey(gbid)
class.reddot_config[key]=
{
catch={
CATCH_TYPE.eItem,
},
func=function(catchType,...)
return gubaoModel:checkCanAwake(gbid)
end,
}
end

reddotClassManager.init_class(class)

class:init_data()
end
end

function gubaoAwakeSheetReddot:resetConfig()

reddotClassManager.reset_class(self)
self.reddot_config=nil
end
