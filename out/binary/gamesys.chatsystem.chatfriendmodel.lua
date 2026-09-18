chatFriendModel={}

function chatFriendModel:getlist()
local friendlist=friendModel.getFriendList()
chatRecentModel.sortAllChatData(friendlist)
return friendlist
end