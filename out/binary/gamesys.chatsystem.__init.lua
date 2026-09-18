




require'lua.gamesys/chatSystem/chatConfig'


local src='lua.gamesys/chatSystem/struct/chatStructBase'
require(src)
refSrcConfig['chatStructBase']=src

local src='lua.gamesys/chatSystem/struct/chatStruct'
require(src)
refSrcConfig['chatStruct']=src

local src='lua.gamesys/chatSystem/struct/chatSystemStruct'
require(src)
refSrcConfig['chatSystemStruct']=src

local src='lua.gamesys/chatSystem/struct/chatActorInfo'
require(src)


local src='lua.gamesys/chatSystem/holder/chatHolder'
require(src)
refSrcConfig['chatHolder']=src

local src='lua.gamesys/chatSystem/holder/chatMainHolder'
require(src)
refSrcConfig['chatMainHolder']=src



local src='lua.gamesys/chatSystem/handler/chatSimpleHandler'
require(src)
refSrcConfig['chatSimpleHandler']=src

local src='lua.gamesys/chatSystem/handler/chatSystemHandler'
require(src)
refSrcConfig['chatSystemHandler']=src

local src='lua.gamesys/chatSystem/handler/chatMessageHandler'
require(src)
refSrcConfig['chatMessageHandler']=src

local src='lua.gamesys/chatSystem/handler/chatPrivateMessageHandler'
require(src)
refSrcConfig['chatPrivateMessageHandler']=src

local src='lua.gamesys/chatSystem/handler/chatMessageMainHandler'
require(src)
refSrcConfig['chatMessageMainHandler']=src






require'lua.gamesys/chatSystem/helper/chatCommonHelper'
require'lua.gamesys/chatSystem/helper/chatLinkHelper'
require'lua.gamesys/chatSystem/helper/chatEmotHelper'
require'lua.gamesys/chatSystem/helper/chatVoiceHelper'
require'lua.gamesys/chatSystem/helper/chatActivityHelper'

require'lua.gamesys/chatSystem/chatEmotModel'
require'lua.gamesys/chatSystem/chatModel'
require'lua.gamesys/chatSystem/chatRecentModel'
require'lua.gamesys/chatSystem/chatFriendModel'

require'lua.gamesys/chatSystem/chatGGModel'

require'lua.gamesys/chatSystem/chatMesgFilterControl'

require'lua.gamesys/chatSystem/chatControl'

require'lua.gamesys/chatSystem/chatControl'

require'lua.gamesys/chatSystem/chatControl'
require'lua.gamesys/chatSystem/chatControl_win'
require'lua.gamesys/chatSystem/chatControl_msg'
require'lua.gamesys/chatSystem/chatControl_func'
require'lua.gamesys/chatSystem/chatControl_handle'
require'lua.gamesys/chatSystem/chatControl_jianwen'
require'lua.gamesys/chatSystem/chatControl_share'
require'lua.gamesys/chatSystem/chatControl_reddot'
require'lua.gamesys/chatSystem/chatControl_refresh'

require'lua.gamesys/chatSystem/chatCacheControl'

require'lua.gamesys/chatSystem/chatProtocolControl'

require'lua.gamesys/chatSystem/chatEmotControl'

require'lua.gamesys/chatSystem/chatGGControl'

require'lua.gamesys/chatSystem/chatSignControl'
require'lua.gamesys/chatSystem/chatSignModel'
